package lk.jiat.app.ejb.bean;

import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.interceptor.Interceptors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import lk.jiat.app.core.interceptor.Logged;
import lk.jiat.app.core.interceptor.LoggingInterceptor;
import lk.jiat.app.core.mail.SendAccountMail;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.AccountType;
import lk.jiat.app.core.model.ManualTransaction;
import lk.jiat.app.core.provider.MailServiceProvider;
import lk.jiat.app.core.service.AccountService;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.List;

@Logged
@Stateless
public class AccountSessionBean implements AccountService {

    @PersistenceContext
    private EntityManager em;



    @Override
    public void createAccount(Account account) {
        String timestamp = LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        int random = (int)(Math.random() * 1000);
        String accountNumber = String.format("NB%s%03d", timestamp, random);

        account.setAccountNumber(accountNumber);

        em.persist(account);

        MailServiceProvider.getInstance().sendMail(new SendAccountMail(account.getCustomer_email(), accountNumber));
    }

    @Override
    public Account findById(Long id) {

        return em.find(Account.class, id);
    }

    @Override
    public Account findByAccountNumber(String accountNumber) {

        try {
            return em.createNamedQuery("Account.findByAccountNumber", Account.class)
                    .setParameter("accountNumber", accountNumber)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public List<Account> findAllAccount() {
        return em.createNamedQuery("Account.findAll", Account.class)
                .getResultList();
    }

    @Override
    public void updateAccount(Account account) {
        em.merge(account);

    }

    @Override
    public boolean deleteAccount(Long id) {
        return false;
    }

    @Override
    public int countAccountsByTypeForCustomer(String nic, AccountType accountType) {
        Long count = em.createNamedQuery("Account.findNoOfAccounts", Long.class)
                .setParameter("nic", nic)
                .setParameter("type", accountType)
                .getSingleResult();

        return count.intValue();
    }

    @Override
    public Account findByNic(String nic) {
        List<Account> accounts = em.createNamedQuery( "Account.findNIC",Account.class)
                .setParameter("nic", nic)
                .setMaxResults(1)
                .getResultList();

        return accounts.isEmpty() ? null : accounts.get(0);
    }

    @Override
    public void applyInterest(String type) {
        List<Account> accounts = em.createNamedQuery("Account.findByType", Account.class)
                .setParameter("type", AccountType.valueOf(type))
                .getResultList();

        BigDecimal rate;

        if ("SAVINGS".equals(type)) {
            rate = new BigDecimal("0.05"); // 5%
        } else if ("FIXED".equals(type)) {
            rate = new BigDecimal("0.12"); // 12%
        } else {
            return;
        }

        for (Account account : accounts) {
            BigDecimal interest;

            if ("SAVINGS".equals(type)) {
                interest = account.getBalance()
                        .multiply(rate)
                        .divide(BigDecimal.valueOf(365), 2, RoundingMode.HALF_UP);
            } else {
                interest = account.getBalance()
                        .multiply(rate)
                        .divide(BigDecimal.valueOf(12), 2, RoundingMode.HALF_UP);
            }

            BigDecimal newBalance = account.getBalance().add(interest);
            account.setBalance(newBalance);
            account.setUpdatedAt(LocalDateTime.now());

            // Save system deposit to manual_transaction
            ManualTransaction mt = new ManualTransaction();
            mt.setAccountNumber(account.getAccountNumber());
            mt.setTransactionType("DEPOSIT");
            mt.setAmount(interest);
            mt.setTransactionDate(LocalDateTime.now());
            mt.setCustomerName("National Bank");
            mt.setCustomerNic("---");
            mt.setBranch("SYSTEM");

            em.persist(mt);
            em.merge(account);

            System.out.println("Interest added to account: " + account.getAccountNumber()
                    + " | Interest: " + interest
                    + " | New Balance: " + newBalance);
        }

        em.flush(); // Persist all changes
    }


}
