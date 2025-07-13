<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.jiat.app.core.model.Account" %>
<%@ page import="lk.jiat.app.core.model.OnlineTransaction" %>
<%@ page import="java.util.List" %>

<%
    Account customer = (Account) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/customer_login.jsp?error=session_expired");
        return;
    }

    List<OnlineTransaction> transactions = (List<OnlineTransaction>) request.getAttribute("transactions");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Account Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f4f7fb;
            animation: fadeIn 0.7s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .top-bar {
            background-color: #0c5aa6;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-bar .menu {
            display: flex;
            gap: 25px;
        }

        .top-bar .menu div {
            cursor: pointer;
            font-weight: bold;
            transition: color 0.3s;
        }

        .top-bar .menu div:hover {
            color: #ddd;
        }

        .container {
            padding: 40px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 12px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .card h2 {
            margin-bottom: 15px;
            color: #0c5aa6;
        }
        .summery {
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* 3 equal-width columns */
            gap: 20px; /* space between info blocks */
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
        }

        .info {
            background-color: #ffffff;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        @media (max-width: 768px) {
            .summery {
                grid-template-columns: repeat(2, 1fr); /* 2 columns on tablet */
            }
        }

        @media (max-width: 480px) {
            .summery {
                grid-template-columns: 1fr; /* 1 column on mobile */
            }
        }


        .table-container {
            max-height: 300px;
            overflow-y: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #0c5aa6;
            color: white;
            position: sticky;
            top: 0;
        }

        tr:nth-child(even) {
            background-color: #f3f3f3;
        }

        .transfer-btn {
            background-color: #0c5aa6;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.3s ease, background-color 0.3s;
        }

        .transfer-btn:hover {
            background-color: #094481;
            transform: scale(1.05);
        }

        .message {
            font-weight: bold;
            color: green;
        }

        .error {
            font-weight: bold;
            color: red;
        }

        .logout-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 20px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>

<div class="top-bar">
    <div class="menu">
        <div onclick="window.location.href='${pageContext.request.contextPath}/customer/dashboard'">Dashboard</div>
    </div>
    <form action="<%= request.getContextPath() %>/logout" method="post" style="margin-right: 20px;">
        <input type="submit" value="Logout" class="logout-btn">
    </form>
</div>

<div class="container">

    <!-- Account Summary -->
    <div class="card">
        <h2>Account Summary</h2>
        <div class="summery">
            <div class="info">Customer Name: <strong><%= customer.getCustomer_name() %></strong></div>
            <div class="info">NIC Number: <strong><%= customer.getCustomer_nic()%></strong></div>
            <div class="info">Email: <strong><%= customer.getCustomer_email() %></strong></div>
            <div class="info">Created Date: <strong><%= customer.getCreatedAt()%></strong></div>
            <div class="info">Account Number: <strong><%= customer.getAccountNumber() %></strong></div>
            <div class="info">Balance: Rs. <strong><%= customer.getBalance() %></strong></div>
            <div class="info">Available Balance: Rs. <strong><%= customer.getBalance().subtract(new java.math.BigDecimal("1000.00")) %></strong></div>
        </div>

    </div>

    <!-- Messages -->
    <%
        if (request.getAttribute("message") != null) {
    %>
    <div class="message"><%= request.getAttribute("message") %></div>
    <%
        }
        if (request.getAttribute("error") != null) {
    %>
    <div class="error"><%= request.getAttribute("error") %></div>
    <%
        }
    %>

    <!-- Transaction History -->
    <div class="card">
        <h2>Transaction History</h2>
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>To</th>
                    <th>Amount (Rs)</th>
                    <th>Date</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (transactions != null && !transactions.isEmpty()) {
                        for (OnlineTransaction tx : transactions) {
                %>
                <tr>
                    <td><%= tx.getToAccount() %></td>
                    <td><%= tx.getAmount() %></td>
                    <td><%= tx.getTransactionDate() %></td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr><td colspan="4">No transactions found.</td></tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

</div>

</body>
</html>
