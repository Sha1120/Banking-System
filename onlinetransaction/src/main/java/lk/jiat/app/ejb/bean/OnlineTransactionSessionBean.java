package lk.jiat.app.ejb.bean;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transaction;
import lk.jiat.app.core.model.OnlineTransaction;
import lk.jiat.app.core.service.TransactionService;

import java.util.List;

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
        return List.of();
    }

    @Override
    public Transaction findById(Long id) {
        return em.find(Transaction.class, id);
    }

    @Override
    public List<OnlineTransaction> getTransactionsByAccount(String fromAccount) {
        return em.createNamedQuery("OnlineTransaction.findByAccountNumber",OnlineTransaction.class)
                .setParameter("fromAccount",fromAccount)
                .getResultList();
    }
}
