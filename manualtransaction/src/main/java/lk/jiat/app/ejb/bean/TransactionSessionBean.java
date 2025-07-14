package lk.jiat.app.ejb.bean;

import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Singleton;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.app.core.interceptor.Logged;
import lk.jiat.app.core.model.ManualTransaction;
import lk.jiat.app.core.service.ManualTransferService;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Logged
@Singleton
public class TransactionSessionBean  implements ManualTransferService {

    @PersistenceContext
    private EntityManager em;



    @Override
    public void createTransaction(ManualTransaction manualTransaction) {
        em.persist(manualTransaction);
    }

    @Override
    public List<ManualTransaction> getTransactionsByDate(LocalDateTime start, LocalDateTime end) {
        return em.createNamedQuery("ManualTransfer.findByDate",ManualTransaction.class)
                .setParameter("start", start)
                .setParameter("end", end)
                .getResultList();
    }
}
