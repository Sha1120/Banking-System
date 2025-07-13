package lk.jiat.app.core.service;

import jakarta.ejb.Remote;
import jakarta.transaction.Transaction;
import lk.jiat.app.core.model.OnlineTransaction;

import java.util.List;

@Remote
public interface TransactionService {
    void createTransaction(OnlineTransaction transaction);
    List<OnlineTransaction> getAllTransactions();
    List<OnlineTransaction> getTransactionsByAccount(String fromAccount);
    Transaction findById(Long id);
}
