package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.mail.VerificationCashierMail;
import lk.jiat.app.core.model.User;
import lk.jiat.app.core.model.UserType;
import lk.jiat.app.core.provider.MailServiceProvider;
import lk.jiat.app.core.service.UserService;
import lk.jiat.app.core.util.Encryption;
import lk.jiat.app.core.util.VerificationUtil;

import java.io.IOException;

@WebServlet("/add_new_cashier")
public class RegisterCashier extends HttpServlet {

    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cashier_name = request.getParameter("c_name");
        String cashier_contact = request.getParameter("c_contact");
        String cashier_email = request.getParameter("c_email");
        String cashier_password = request.getParameter("c_password");
        String userTypeStr = request.getParameter("userType");

        String cashier_encryptedPassword = Encryption.encrypt(cashier_password);

        UserType userType;
        try {
            userType = UserType.valueOf(userTypeStr.toUpperCase());
        } catch (IllegalArgumentException | NullPointerException e) {
            userType = UserType.CASHIER; // fallback/default
        }

        User user = new User(cashier_name, cashier_contact, cashier_email, cashier_encryptedPassword, userType);

        // Generate 6-digit verification code
        String cashierVerificationCode = VerificationUtil.generate6DigitCode();
        user.setVerificationCode(cashierVerificationCode);

        // Save user
        userService.addUser(user);

        // Send email with the verification code
        VerificationCashierMail mail = new VerificationCashierMail(cashier_email, cashierVerificationCode);
        MailServiceProvider.getInstance().sendMail(mail);

        //send redirect page
        response.sendRedirect(request.getContextPath() + "/manager/index.jsp");
    }
}
