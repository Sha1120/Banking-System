package lk.jiat.app.core.service;

import jakarta.ejb.Remote;
import jakarta.transaction.Transaction;
import lk.jiat.app.core.exception.BankingException;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.OnlineTransaction;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Remote
public interface TransactionService {
    void createTransaction(OnlineTransaction transaction);
    List<OnlineTransaction> getAllTransactions();
    List<OnlineTransaction> getTransactionsByAccount(String fromAccount);
    OnlineTransaction findById(Long id);
    List<OnlineTransaction> findByDateRange(LocalDateTime from, LocalDateTime to);

}
