<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.jiat.app.core.model.ManualTransaction" %>
<%@ page isELIgnored="false" %>
<%
    List<ManualTransaction> transactions = (List<ManualTransaction>) request.getAttribute("transactions");
%>
<html>
<head>
    <title>Today's Manual Transactions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f4f7fa;
            padding: 30px;
        }

        .receipt-btn {
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 5px 10px;
            font-size: 14px;
        }

        .receipt-btn:hover {
            background-color: #218838;
        }

        @media print {
            .no-print { display: none; }
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="mb-4 text-center">Manual Transactions - Today</h2>

    <table class="table table-bordered table-striped">
        <thead class="table-primary">
        <tr>
            <th>Account No</th>
            <th>Customer Name</th>
            <th>NIC</th>
            <th>Branch</th>
            <th>Type</th>
            <th>Amount (Rs.)</th>
            <th>Date</th>
            <th class="no-print">Receipt</th>
        </tr>
        </thead>
        <tbody>
        <% if (transactions != null && !transactions.isEmpty()) {
            for (ManualTransaction tx : transactions) { %>
        <tr>
            <td><%= tx.getAccountNumber() %></td>
            <td><%= tx.getCustomerName() %></td>
            <td><%= tx.getCustomerNic() %></td>
            <td><%= tx.getBranch() %></td>
            <td><%= tx.getTransactionType() %></td>
            <td><%= tx.getAmount() %></td>
            <td><%= tx.getTransactionDate() %></td>
            <td class="no-print">
                <form action="<%= request.getContextPath() %>/print_riceipt.jsp" method="post" target="_blank">
                    <input type="hidden" name="accountNumber" value="<%= tx.getAccountNumber() %>">
                    <input type="hidden" name="amount" value="<%= tx.getAmount() %>">
                    <input type="hidden" name="type" value="<%= tx.getTransactionType() %>">
                    <input type="hidden" name="date" value="<%= tx.getTransactionDate() %>">
                    <input type="hidden" name="customer" value="<%= tx.getCustomerName() %>">
                    <button type="submit" class="receipt-btn">Print</button>
                </form>
            </td>
        </tr>
        <%  }
        } else { %>
        <tr><td colspan="8" class="text-center">No transactions found for today.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
