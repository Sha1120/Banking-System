package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.model.ManualTransaction;
import lk.jiat.app.core.model.OnlineTransaction;
import lk.jiat.app.core.service.ManualTransferService;
import lk.jiat.app.core.service.TransactionService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/all_transactions")
public class AllTransactionsServlet extends HttpServlet {

    @EJB
    private ManualTransferService manualService;


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LocalDateTime now = LocalDateTime.now();
        LocalDateTime fromDate = now.minusDays(30);

        List<ManualTransaction> manualList = manualService.getTransactionsByDate(fromDate, now);

        request.setAttribute("manualTransactions", manualList);


        request.getRequestDispatcher("/all_transactions.jsp").forward(request, response);
    }
}

