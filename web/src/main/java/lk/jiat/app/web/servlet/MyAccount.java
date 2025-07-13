package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.OnlineTransaction;
import lk.jiat.app.core.service.AccountService;
import lk.jiat.app.core.service.TransactionService;

import java.io.IOException;
import java.util.List;

@WebServlet("/customer/my_account")
public class MyAccount extends HttpServlet {

    @EJB
    private AccountService accountService;

    @EJB
    private TransactionService transactionService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Account customer = (Account) request.getSession().getAttribute("customer");

        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/customer_login.jsp?error=session_expired");
            return;
        }

        // Get all transactions for the customer account
        List<OnlineTransaction> transactions =
                transactionService.getTransactionsByAccount(customer.getAccountNumber());

        request.setAttribute("transactions", transactions);
        request.getRequestDispatcher("/customer/my_account.jsp").forward(request, response);
    }
}


