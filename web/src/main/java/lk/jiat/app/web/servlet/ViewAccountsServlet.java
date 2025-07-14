package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.service.AccountService;

import java.io.IOException;
import java.util.List;

@WebServlet("/cashier/accounts")
public class ViewAccountsServlet extends HttpServlet {

    @EJB
    private AccountService accountService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Account> allAccounts = accountService.findAllAccount();
        request.setAttribute("accounts", allAccounts);

        request.getRequestDispatcher("/cashier/view_accounts.jsp").forward(request, response);
    }
}
