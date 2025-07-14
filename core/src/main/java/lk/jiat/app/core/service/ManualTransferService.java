package lk.jiat.app.core.service;

import jakarta.ejb.Remote;
import lk.jiat.app.core.model.ManualTransaction;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Remote
public interface ManualTransferService {

    void createTransaction(ManualTransaction manualTransaction);
    List<ManualTransaction> getTransactionsByDate(LocalDateTime start, LocalDateTime end);
}
