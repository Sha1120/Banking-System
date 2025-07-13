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
import java.time.LocalDateTime;

@WebServlet("/login_customer")
public class LoginCustomer extends HttpServlet {

    @EJB
    private AccountService accountService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accNumber = request.getParameter("ac_number");
        String otpCode = request.getParameter("otp_code");

        // Validate inputs
        if (accNumber == null || otpCode == null || accNumber.trim().isEmpty() || otpCode.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/customer_login.jsp?error=missing_fields");
            return;
        }

        // Find account
        Account account = accountService.findByAccountNumber(accNumber.trim());

        // Invalid account or incorrect OTP
        if (account == null || !otpCode.equals(account.getOtpCode())) {
            response.sendRedirect(request.getContextPath() + "/customer_login.jsp?error=invalid_otp&ac_number=" + accNumber);
            return;
        }

        // Valid login – update account
        account.setUpdatedAt(LocalDateTime.now());
        account.setOtpCode(null); // clear OTP
        accountService.updateAccount(account);

        // Set account in session
        request.getSession().setAttribute("customer", account);

        // Redirect to dashboard servlet (better practice)
        response.sendRedirect(request.getContextPath() + "/customer/dashboard");
    }
}
