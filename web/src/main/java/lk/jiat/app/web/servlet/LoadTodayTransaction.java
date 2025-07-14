package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.model.ManualTransaction;
import lk.jiat.app.core.service.ManualTransferService;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@WebServlet("/cashier/today_transactions")
public class LoadTodayTransaction extends HttpServlet {

    @EJB
    private ManualTransferService manualTransferService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LocalDate today = LocalDate.now();
        LocalDateTime start = today.atStartOfDay();
        LocalDateTime end = today.atTime(LocalTime.MAX);

        List<ManualTransaction> transactions = manualTransferService.getTransactionsByDate(start, end);

        request.setAttribute("transactions", transactions);
        request.getRequestDispatcher("/cashier/generate_slip.jsp").forward(request, response);
    }
}
