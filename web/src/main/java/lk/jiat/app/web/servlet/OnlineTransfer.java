package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transaction;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.ManualTransaction;
import lk.jiat.app.core.model.OnlineTransaction;
import lk.jiat.app.core.service.AccountService;
import lk.jiat.app.core.service.ManualTransferService;
import lk.jiat.app.core.service.TransactionService;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@WebServlet("/customer/online_transfer")
public class OnlineTransfer extends HttpServlet {

    @PersistenceContext
    private EntityManager em;

    @EJB
    private TransactionService transactionService;

    @EJB
    private ManualTransferService manualTransferService;

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

        Account from = em.createNamedQuery("Account.findByAccountNumber", Account.class)
                .setParameter("accountNumber", fromAcc)
                .getSingleResult();

        Account to = em.createNamedQuery("Account.findByAccountNumber", Account.class)
                .setParameter("accountNumber", toAcc)
                .getSingleResult();


        if (from == null || to == null) {
            request.setAttribute("error", "Invalid account number(s).");
            request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
            return;
        }

        BigDecimal balance = from.getBalance();
        BigDecimal deduction = new BigDecimal("1000.00");
        BigDecimal available_balance = balance.subtract(deduction);

        if (amount.compareTo(available_balance) <= 0) {
            from.setBalance(from.getBalance().subtract(amount));
            to.setBalance(to.getBalance().add(amount));
            accountService.updateAccount(from);
            accountService.updateAccount(to);

            // Save online transaction
            OnlineTransaction transaction = new OnlineTransaction(
                    fromAcc, toAcc, ownerName, nic, branch, amount, LocalDateTime.now()
            );
            transactionService.createTransaction(transaction);

            // Save ManualTransaction - WITHDRAW
            ManualTransaction withdraw = new ManualTransaction();
            withdraw.setAccountNumber(fromAcc);
            withdraw.setTransactionType("WITHDRAW");
            withdraw.setAmount(amount);
            withdraw.setTransactionDate(LocalDateTime.now());
            withdraw.setCustomerName(from.getCustomer_name());
            withdraw.setCustomerNic(from.getCustomer_nic());
            withdraw.setBranch("National Bank - Online Transfer");
            manualTransferService.createTransaction(withdraw);

            ManualTransaction deposit = new ManualTransaction();
            deposit.setAccountNumber(toAcc);
            deposit.setTransactionType("DEPOSIT");
            deposit.setAmount(amount);
            deposit.setTransactionDate(LocalDateTime.now());
            deposit.setCustomerName(to.getCustomer_name());
            deposit.setCustomerNic(to.getCustomer_nic());
            deposit.setBranch("National Bank - Online Transfer");
            manualTransferService.createTransaction(deposit);


            request.getSession().setAttribute("customer", from);
            request.setAttribute("message", "Transfer successful!");
            request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);

        } else {
            request.setAttribute("error", "Insufficient balance in source account.");
            request.getRequestDispatcher("/customer/dashboard.jsp").forward(request, response);
        }
    }
}
