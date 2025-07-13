
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Cashier Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f7fa;
            padding: 20px;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #2c3e50;
            padding: 15px 25px;
            color: white;
            border-radius: 8px;
        }

        .section {
            margin-top: 30px;
        }

        h1, h2 {
            color: #053360;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }

        .card {
            background-color: #fff;
            padding: 20px;
            width: 300px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }

        .logout-btn {
            text-decoration: none;
            color: white;
            background-color: #e74c3c;
            padding: 10px 15px;
            border-radius: 5px;
        }

        .link-btn {
            color: #2980b9;
            text-decoration: none;
        }

        ul li {
            margin: 8px 0;
        }
    </style>
</head>
<body>

<div class="navbar">
    <h1>Cashier Dashboard</h1>
    <div>
        <span>Welcome, ${sessionScope.user.name}</span>
        <a class="logout-btn" href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<div style="margin-top: 25px;">
    <a href="${pageContext.request.contextPath}/cashier/create_newAccount.jsp"
       style="padding: 10px 15px; background-color: #bf3f11; color: white; text-decoration: none; border-radius: 5px;">
        + Add New Account
    </a>
</div>

<div class="section">
    <h2>Quick Actions</h2>
    <div class="card-container">
        <div class="card">
            <h3>New Transaction</h3>
            <p>Deposit or withdraw from a customer account.</p>
            <a href="${pageContext.request.contextPath}/cashier/new_transaction.jsp" class="link-btn">Make Transaction</a>
        </div>
        <div class="card">
            <h3>View Customer Info</h3>
            <p>Search and manage customer accounts.</p>
            <a href="${pageContext.request.contextPath}/cashier/customers.jsp" class="link-btn">Search Customers</a>
        </div>
        <div class="card">
            <h3>Generate Receipts</h3>
            <p>Print and download recent transaction slips.</p>
            <a href="${pageContext.request.contextPath}/cashier/receipts.jsp" class="link-btn">View Receipts</a>
        </div>
    </div>
</div>

<div class="section">
    <h2>Daily Tools</h2>
    <ul>
        <li><a class="link-btn" href="#">View Transaction History</a></li>
        <li><a class="link-btn" href="#">Balance Inquiry</a></li>
        <li><a class="link-btn" href="#">End of Day Summary</a></li>
    </ul>
</div>
</body>
</html>
