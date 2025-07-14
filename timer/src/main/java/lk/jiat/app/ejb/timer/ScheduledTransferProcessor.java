package lk.jiat.app.ejb.timer;

import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import lk.jiat.app.core.model.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Logger;

@Startup
@Singleton
@TransactionManagement(TransactionManagementType.CONTAINER)
public class ScheduledTransferProcessor {

    private static final Logger logger = Logger.getLogger(ScheduledTransferProcessor.class.getName());

    @PersistenceContext
    private EntityManager em;

    @Schedule(hour = "*", minute = "*/1", second = "0", persistent = false)
    @Transactional
    public void processScheduledTransfers() {
        LocalDateTime now = LocalDateTime.now();

        List<ScheduledTransfer> transfers = em.createNamedQuery("ScheduledTransfer.findAll", ScheduledTransfer.class)
                .setParameter("status", TransferStatus.PENDING)
                .setParameter("now", now)
                .getResultList();

        for (ScheduledTransfer transfer : transfers) {
            try {
                Account from = em.createNamedQuery("Account.findByAccountNumber", Account.class)
                        .setParameter("accountNumber", transfer.getFromAccount())
                        .getSingleResult();

                Account to = em.createNamedQuery("Account.findByAccountNumber", Account.class)
                        .setParameter("accountNumber", transfer.getToAccount())
                        .getSingleResult();


                if (from == null || to == null) {
                    transfer.setStatus(TransferStatus.FAILED);
                    em.merge(transfer);
                    logger.warning("Transfer ID " + transfer.getId() + ": FAILED (account not found)");
                    continue;
                }

                BigDecimal amount = transfer.getAmount();

                if (from.getBalance().compareTo(amount) >= 0) {
                    from.setBalance(from.getBalance().subtract(amount));
                    to.setBalance(to.getBalance().add(amount));

                    transfer.setStatus(TransferStatus.COMPLETED);

                    // Manual Transaction - Withdraw
                    ManualTransaction withdraw = new ManualTransaction();
                    withdraw.setAccountNumber(from.getAccountNumber());
                    withdraw.setAmount(amount);
                    withdraw.setTransactionType("WITHDRAW");
                    withdraw.setTransactionDate(LocalDateTime.now());
                    withdraw.setCustomerName(from.getCustomer_name());
                    withdraw.setCustomerNic(from.getCustomer_nic());
                    withdraw.setBranch("National Bank - Schedule Transaction");
                    em.persist(withdraw);

                    // Manual Transaction - Deposit
                    ManualTransaction deposit = new ManualTransaction();
                    deposit.setAccountNumber(to.getAccountNumber());
                    deposit.setAmount(amount);
                    deposit.setTransactionType("DEPOSIT");
                    deposit.setTransactionDate(LocalDateTime.now());
                    deposit.setCustomerName(to.getCustomer_name());
                    deposit.setCustomerNic(to.getCustomer_nic());
                    deposit.setBranch("National Bank - Schedule Transaction");
                    em.persist(deposit);

                    em.merge(from);
                    em.merge(to);
                    em.merge(transfer);

                    logger.info("Transfer ID " + transfer.getId() + ": COMPLETED");
                } else {
                    transfer.setStatus(TransferStatus.FAILED);
                    em.merge(transfer);
                    logger.warning("Transfer ID " + transfer.getId() + ": FAILED (insufficient balance)");
                }

            } catch (Exception e) {
                transfer.setStatus(TransferStatus.FAILED);
                em.merge(transfer);
                logger.severe("Transfer ID " + transfer.getId() + ": FAILED due to exception: " + e.getMessage());
                e.printStackTrace();
            }
        }

        em.flush();
    }
}
