package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.model.ScheduledTransfer;
import lk.jiat.app.core.service.ScheduleTransactionService;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;

@WebServlet("/cashier/create-scheduled-transfer")
public class CreateScheduledTransferServlet extends HttpServlet {

    @EJB
    private ScheduleTransactionService scheduleTransactionService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            // Get and validate input parameters
            String fromAccount = req.getParameter("fromAccount");
            String toAccount = req.getParameter("toAccount");
            String amountStr = req.getParameter("amount");
            String scheduledTimeStr = req.getParameter("scheduledTime");

            if (fromAccount == null || fromAccount.isEmpty() ||
                    toAccount == null || toAccount.isEmpty() ||
                    amountStr == null || scheduledTimeStr == null) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters.");
                return;
            }

            BigDecimal amount;
            LocalDateTime scheduledTime;

            try {
                amount = new BigDecimal(amountStr);
                if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                    resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Amount must be greater than zero.");
                    return;
                }
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid amount format.");
                return;
            }

            try {
                scheduledTime = LocalDateTime.parse(scheduledTimeStr);
            } catch (DateTimeParseException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid scheduled time format. Use ISO_LOCAL_DATE_TIME.");
                return;
            }

            // Create transfer and save
            ScheduledTransfer transfer = new ScheduledTransfer(fromAccount, toAccount, amount, scheduledTime);
            scheduleTransactionService.createTransfer(transfer);

            // Redirect properly
            String message = "Scheduled transfer successfully created!";
            resp.sendRedirect(req.getContextPath() + "/cashier/index.jsp?msg=" + java.net.URLEncoder.encode(message, "UTF-8"));

        } catch (Exception e) {
            getServletContext().log("Error creating scheduled transfer", e);
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create scheduled transfer.");
        }
    }
}
