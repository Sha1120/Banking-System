package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.mail.VerificationMail;
import lk.jiat.app.core.model.User;
import lk.jiat.app.core.model.UserType;
import lk.jiat.app.core.provider.MailServiceProvider;
import lk.jiat.app.core.service.UserService;
import lk.jiat.app.core.util.Encryption;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/register")
public class Register extends HttpServlet {

    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String password = request.getParameter("password");
        String userTypeStr = request.getParameter("userType"); // Get user type from form

        // Encrypt password
        String encryptedPassword = Encryption.encrypt(password);

        // Convert string to UserType enum
        UserType userType;
        try {
            userType = UserType.valueOf(userTypeStr.toUpperCase());
        } catch (IllegalArgumentException | NullPointerException e) {
            userType = UserType.MANAGER; // fallback/default
        }

        // Create user object
        User user = new User(name, contact, email, encryptedPassword, userType);

        // Generate verification code
        String verificationCode = UUID.randomUUID().toString();
        user.setVerificationCode(verificationCode);

        // Save user
        userService.addUser(user);

        // Send email
        VerificationMail mail = new VerificationMail(email, verificationCode);
        MailServiceProvider.getInstance().sendMail(mail);

        // Redirect to login
        response.sendRedirect(request.getContextPath() + "/manager_login.jsp");
    }
}
