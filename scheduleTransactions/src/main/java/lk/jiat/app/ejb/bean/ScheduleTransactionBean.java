package lk.jiat.app.ejb.bean;

import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lk.jiat.app.core.model.ScheduledTransfer;
import lk.jiat.app.core.service.ScheduleTransactionService;

import java.math.BigDecimal;

@Stateless
public class ScheduleTransactionBean implements ScheduleTransactionService {

    @PersistenceContext
    private EntityManager em;

    @EJB
    private ScheduleTransactionService scheduleTransactionService;

    @Override
    public void createTransfer(ScheduledTransfer transfer) {
        em.persist(transfer);
    }

    @Override
    public void updateTransfer(ScheduledTransfer transfer) {
        em.merge(transfer);
    }
}
