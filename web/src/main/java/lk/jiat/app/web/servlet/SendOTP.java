package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.mail.SendOtpMail;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.provider.MailServiceProvider;
import lk.jiat.app.core.service.AccountService;

import java.io.IOException;
import java.util.Random;

@WebServlet("/send_otp")
public class SendOTP extends HttpServlet {

    @EJB
    private AccountService accountService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accNumber = request.getParameter("ac_number");

        if (accNumber == null || accNumber.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/customer_login.jsp?error=missing_account");
            return;
        }

        Account account = accountService.findByAccountNumber(accNumber.trim());

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/customer_login.jsp?error=invalid_account");
            return;
        }

        // Generate 5-digit OTP
        String otpCode = String.format("%05d", new Random().nextInt(100000));

        try {
            // Send OTP via email
           // SendOtpMail mail = new SendOtpMail(account.getCustomer_email(), otpCode);
          //  MailServiceProvider.getInstance().sendMail(mail);

            account.setOtpCode(otpCode);
            accountService.updateAccount(account);


            // Success redirect
            response.sendRedirect(request.getContextPath() + "/customer_login.jsp?otp=sent&ac_number=" + accNumber.trim());


        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/customer_login.jsp?error=mail_failed");
        }
    }
}
