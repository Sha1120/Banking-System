package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.security.enterprise.SecurityContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.model.User;
import lk.jiat.app.core.service.UserService;

import java.io.IOException;

@WebServlet("/login_cashier")
public class LoginCashier extends HttpServlet {

    @EJB
    private UserService userService;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String c_email = request.getParameter("lc_email");
        String employeeCode = request.getParameter("employee_code");

        boolean isValid = userService.cashierLogin(c_email, employeeCode);

        if (isValid) {
            User user = userService.getUserByEmail(c_email);

            // Save user + role into session
            request.getSession().setAttribute("user", user);
            request.getSession().setAttribute("role", user.getUserType().name());

            // Redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/cashier/index.jsp");

        } else {
            request.setAttribute("error", "Invalid email or verification code");
            request.getRequestDispatcher("/cashier_login.jsp").forward(request, response);
        }
    }
}

