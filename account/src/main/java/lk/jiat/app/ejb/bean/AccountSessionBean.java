package lk.jiat.app.ejb.bean;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import lk.jiat.app.core.mail.SendAccountMail;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.AccountType;
import lk.jiat.app.core.provider.MailServiceProvider;
import lk.jiat.app.core.service.AccountService;

import java.time.LocalDateTime;
import java.util.List;

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
        return List.of();
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

}
