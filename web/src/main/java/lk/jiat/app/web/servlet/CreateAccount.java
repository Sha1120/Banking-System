package lk.jiat.app.web.servlet;

import jakarta.annotation.security.DeclareRoles;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.AccountStatus;
import lk.jiat.app.core.model.AccountType;
import lk.jiat.app.core.model.User;
import lk.jiat.app.core.service.AccountService;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@WebServlet("/add_account")
public class CreateAccount extends HttpServlet {

    @EJB
    private AccountService accountService;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String nic = request.getParameter("nic");
        String accountTypeStr = request.getParameter("accountType");
        String initialDepositStr = request.getParameter("initialDeposit");

        // Basic validation
        if (name == null || email == null || contact == null || nic == null || accountTypeStr == null || initialDepositStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required fields.");
            return;
        }


        User currentUser = (User) request.getSession().getAttribute("user");

        if (currentUser != null) {

            Account account = new Account(name, email, contact, nic, AccountType.valueOf(accountTypeStr), new BigDecimal(initialDepositStr), new BigDecimal(initialDepositStr), "LKR", AccountStatus.ACTIVE, LocalDateTime.now(), LocalDateTime.now(), currentUser);

            // Delegate to EJB (account number will be generated there)
            accountService.createAccount(account);

            // Redirect to success page or list page
            response.sendRedirect(request.getContextPath() + "/cashier/index.jsp?success=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/cashier/create_newAccount.jsp?error=true");
        }


    }
}
