package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.service.AccountService;

import java.io.IOException;

@WebServlet("/check_balance")
public class CheckBalanceServlet extends HttpServlet {

    @EJB
    private AccountService accountService;

    // Support GET (just forward to JSP)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/balance_inquiry.jsp").forward(request, response);
    }

    // Handle POST from form
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String identifier = request.getParameter("identifier");
        Account account = null;

        if (identifier != null && !identifier.trim().isEmpty()) {
            // NIC or Account Number
            if (identifier.matches("\\d{9}[vVxX]") || identifier.matches("\\d{12}")) {
                account = accountService.findByNic(identifier);
            } else {
                account = accountService.findByAccountNumber(identifier);
            }

            if (account != null) {
                request.setAttribute("accountNumber", account.getAccountNumber());
                request.setAttribute("balance", account.getBalance());
                request.setAttribute("ownerName", account.getCustomer_name());
            } else {
                request.setAttribute("error", "Account not found for given NIC or Account Number.");
            }

        } else {
            request.setAttribute("error", "Please enter a valid NIC or Account Number.");
        }

        request.getRequestDispatcher("/balance_inquiry.jsp").forward(request, response);
    }
}
