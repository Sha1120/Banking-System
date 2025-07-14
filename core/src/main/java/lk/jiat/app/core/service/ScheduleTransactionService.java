package lk.jiat.app.core.service;

import jakarta.ejb.Remote;
import lk.jiat.app.core.model.ScheduledTransfer;

import java.math.BigDecimal;



@Remote
public interface ScheduleTransactionService {

    void createTransfer(ScheduledTransfer transfer);
    void updateTransfer(ScheduledTransfer transfer);
}
