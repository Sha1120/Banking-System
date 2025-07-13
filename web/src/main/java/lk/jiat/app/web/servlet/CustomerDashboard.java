package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.AccountType;
import lk.jiat.app.core.service.AccountService;

import java.io.IOException;

@WebServlet("/customer/dashboard")
public class CustomerDashboard extends HttpServlet {

    @EJB
    private AccountService accountService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get customer from session
        Account customer = (Account) request.getSession().getAttribute("customer");

        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/customer_login.jsp?error=session_expired");
            return;
        }

        // Directly use AccountType without converting (already enum)
        AccountType accountType = customer.getAccountType();

        // Count how many accounts the customer has with the same account type
        int accountCount = accountService.countAccountsByTypeForCustomer(
                customer.getCustomer_nic(), accountType
        );

        // Set attributes for JSP
        request.setAttribute("customer", customer);
        request.setAttribute("accountCount", accountCount);

        // Forward to JSP
        request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
    }
}
