<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("CASHIER")) {
        response.sendRedirect(request.getContextPath() + "/unauthorized.jsp");
    }
%>

<html>
<head>
    <title>New Transaction</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .transaction-card {
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
            width: 600px;
            animation: slideUp 0.7s ease-out;
        }

        @keyframes slideUp {
            from { transform: translateY(30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        h2 {
            text-align: center;
            color: #333;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 8px;
            transition: 0.3s;
        }

        input:focus, select:focus {
            border-color: #007BFF;
            box-shadow: 0 0 5px rgba(0,123,255,0.5);
            outline: none;
        }

        .submit-btn {
            margin-top: 25px;
            background: #007BFF;
            color: white;
            padding: 12px;
            width: 100%;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: bold;
            transition: background 0.3s;
        }

        .submit-btn:hover {
            background: #0056b3;
        }

        .message {
            margin-top: 15px;
            color: green;
            text-align: center;
            font-weight: bold;
        }

        .error {
            color: red;
        }
    </style>
</head>
<body>
<div class="transaction-card">
    <h2>New Transaction</h2>

    <% if (request.getAttribute("message") != null) { %>
    <div class="message"><%= request.getAttribute("message") %></div>
    <% } %>

    <% if (request.getAttribute("error") != null) { %>
    <div class="message error"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/make_transaction" method="post">
        <label for="accountNumber">Account Number</label>
        <input type="text" name="accountNumber" id="accountNumber" required>

        <label for="transactionType">Transaction Type</label>
        <select name="transactionType" id="transactionType" required>
            <option value="DEPOSIT">Deposit</option>
            <option value="WITHDRAW">Withdraw</option>
        </select>

        <label for="amount">Amount (Rs.)</label>
        <input type="number" name="amount" id="amount" step="0.01" required>

        <label for="customerName">Customer Name</label>
        <input type="text" name="customerName" id="customerName" required>

        <label for="customerNic">Customer NIC</label>
        <input type="text" name="customerNic" id="customerNic" required>

        <label for="branch">Branch</label>
        <input type="text" name="branch" id="branch" required>

        <button type="submit" class="submit-btn">Make Transaction</button>
    </form>

</div>
</body>
</html>
