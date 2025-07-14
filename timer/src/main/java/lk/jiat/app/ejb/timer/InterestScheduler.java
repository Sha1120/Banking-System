package lk.jiat.app.ejb.timer;

import jakarta.ejb.*;
import lk.jiat.app.core.service.AccountService;

import java.util.logging.Logger;

@Stateless
public class InterestScheduler {

    private static final Logger logger = Logger.getLogger(InterestScheduler.class.getName());

    @EJB
    private AccountService accountService;

    @Schedule(hour = "23", minute = "59", second = "0", persistent = false)
    public void applyDailyInterestForSavings() {
        logger.info(">>> [TIMER] Applying DAILY interest for SAVINGS...");
        accountService.applyInterest("SAVINGS");
    }

    @Schedule(dayOfMonth = "1", hour = "1", minute = "0", second = "0", persistent = false)
    public void applyMonthlyInterestForFixed() {
        logger.info(">>> [TIMER] Applying MONTHLY interest for FIXED...");
        accountService.applyInterest("FIXED");
    }
}




