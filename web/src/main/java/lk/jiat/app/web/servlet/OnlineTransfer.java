package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transaction;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.OnlineTransaction;
import lk.jiat.app.core.service.AccountService;
import lk.jiat.app.core.service.TransactionService;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@WebServlet("/customer/online_transfer")
public class OnlineTransfer extends HttpServlet {

    @EJB
    private TransactionService transactionService;

    @EJB
    private AccountService accountService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String fromAcc = request.getParameter("fromAccount");
        String toAcc = request.getParameter("toAccount");
        String ownerName = request.getParameter("owner_name");
        String nic = request.getParameter("nic");
        String branch = request.getParameter("branch");
        BigDecimal amount = new BigDecimal(request.getParameter("amount"));

        Account fromAccount = accountService.findByAccountNumber(fromAcc);
        Account toAccount = accountService.findByAccountNumber(toAcc);

        if (fromAccount == null || toAccount == null) {
            request.setAttribute("error", "Invalid account number(s).");
            request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
            return;
        }

        BigDecimal balance = fromAccount.getBalance();
        BigDecimal deduction = new BigDecimal("1000.00");
        BigDecimal available_balance = balance.subtract(deduction);


        if (amount.compareTo(available_balance) <= 0) {

            fromAccount.setBalance(fromAccount.getBalance().subtract(amount));
            toAccount.setBalance(toAccount.getBalance().add(amount));
            accountService.updateAccount(fromAccount);
            accountService.updateAccount(toAccount);

            OnlineTransaction transaction = new OnlineTransaction(
                    fromAcc, toAcc, ownerName, nic, branch, amount, LocalDateTime.now()
            );
            transactionService.createTransaction(transaction);

            request.getSession().setAttribute("customer", fromAccount);

            request.setAttribute("message", "Transfer successful!");
            request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);

        } else {
            // Not enough balance → show error
            request.setAttribute("error", "Insufficient balance in source account.");
            request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
            return;
        }



    }
}
