package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.ManualTransaction;
import lk.jiat.app.core.service.AccountService;
import lk.jiat.app.core.service.ManualTransferService;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@WebServlet("/make_transaction")
public class ManualTransfer extends HttpServlet {

    @EJB
    private AccountService accountService;

    @EJB
    private ManualTransferService manualTransferService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");
        String type = request.getParameter("transactionType");
        String amountStr = request.getParameter("amount");
        String cusName = request.getParameter("customerName");
        String cusNic = request.getParameter("customerNic");
        String branch = request.getParameter("branch");

        try {
            Account account = accountService.findByAccountNumber(accountNumber);

            if (account == null) {
                request.setAttribute("error", "Invalid account number.");
                request.getRequestDispatcher("/cashier/new_transaction.jsp").forward(request, response);
                return;
            }

            BigDecimal amount = new BigDecimal(amountStr);

            if (type.equals("WITHDRAW")) {
                if (account.getBalance().compareTo(amount) < 0) {
                    request.setAttribute("error", "Insufficient balance.");
                } else {
                    account.setBalance(account.getBalance().subtract(amount));
                    accountService.updateAccount(account);
                    request.setAttribute("message", "Withdraw successful.");
                }
            } else if (type.equals("DEPOSIT")) {
                account.setBalance(account.getBalance().add(amount));
                accountService.updateAccount(account);
                request.setAttribute("message", "Deposit successful.");
            } else {
                request.setAttribute("error", "Invalid transaction type.");
            }

            // Create ManualTransaction record
            ManualTransaction txn = new ManualTransaction();
            txn.setAccountNumber(accountNumber);
            txn.setTransactionType(type);
            txn.setAmount(amount);
            txn.setTransactionDate(LocalDateTime.now());
            txn.setCustomerName(cusName);
            txn.setCustomerNic(cusNic);
            txn.setBranch(branch);

            manualTransferService.createTransaction(txn);

        } catch (Exception e) {
            request.setAttribute("error", "Transaction failed: " + e.getMessage());
        }
        request.getRequestDispatcher("/cashier/new_transaction.jsp").forward(request, response);
    }
}
