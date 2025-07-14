package lk.jiat.app.ejb.bean;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.app.core.interceptor.Logged;
import lk.jiat.app.core.model.OnlineTransaction;
import lk.jiat.app.core.service.TransactionService;

import java.time.LocalDateTime;
import java.util.List;

@Logged
@Stateless
public class OnlineTransactionSessionBean implements TransactionService {

    @PersistenceContext
    private EntityManager em;


    @Override
    public void createTransaction(OnlineTransaction transaction) {

        em.persist(transaction);
    }

    @Override
    public List<OnlineTransaction> getAllTransactions() {
        return em.createNamedQuery("OnlineTransaction.findAll", OnlineTransaction.class)
                .getResultList();
    }

    @Override
    public OnlineTransaction findById(Long id) {
        return em.find(OnlineTransaction.class, id);
    }

    @Override
    public List<OnlineTransaction> getTransactionsByAccount(String fromAccount) {
        return em.createNamedQuery("OnlineTransaction.findByAccountNumber", OnlineTransaction.class)
                .setParameter("fromAccount", fromAccount)
                .getResultList();
    }

    @Override
    public List<OnlineTransaction> findByDateRange(LocalDateTime from, LocalDateTime to) {
        return em.createNamedQuery("OnlineTransaction.findByDate",OnlineTransaction.class)
                .setParameter("from", from)
                .setParameter("to", to)
                .getResultList();
    }
}
