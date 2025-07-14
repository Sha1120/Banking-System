package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.service.AccountService;

import java.io.IOException;

@WebServlet("/trigger-daily-interest")
public class ManualInterestTriggerServlet extends HttpServlet {
    @EJB
    private AccountService accountService;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        accountService.applyInterest("SAVINGS");
        resp.getWriter().write("SAVINGS interest applied manually.");
    }
}
