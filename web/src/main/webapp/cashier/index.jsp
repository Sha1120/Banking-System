
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("CASHIER")) {
        response.sendRedirect(request.getContextPath() + "/unauthorized.jsp");
    }
%>


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

        .functions{
            display: flex;
            flex-direction: row;
            gap: 20px;
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

<%
    String msg = request.getParameter("msg");
    if (msg != null) {
%>
<div style="background-color: #d4edda; color: #155724; padding: 15px; border-radius: 8px;margin-top: 20px; margin-bottom: 20px; font-weight: bold;">
    <%= msg %>
</div>
<%
    }
%>

<div class="functions">
    <div style="margin-top: 25px;">
        <a href="${pageContext.request.contextPath}/cashier/create_newAccount.jsp"
           style="padding: 10px 15px; background-color: #bf3f11; color: white; text-decoration: none; border-radius: 5px;">
            + Add New Account
        </a>
    </div>


    <div style="margin-top: 25px;">
        <a href="${pageContext.request.contextPath}/cashier/schedule_transfer..jsp"
           style="padding: 10px 15px; background-color: #0c5aa6; color: white; text-decoration: none; border-radius: 5px;">
            Schedule Transaction
        </a>
    </div>
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
            <a href="${pageContext.request.contextPath}/cashier/accounts" class="link-btn">Search Customers</a>
        </div>
        <div class="card">
            <h3>Generate Receipts</h3>
            <p>Print and download recent transaction slips.</p>
            <a href="${pageContext.request.contextPath}/cashier/today_transactions" class="link-btn">View Receipts</a>
        </div>
    </div>
</div>

<div class="section">
    <h2>Daily Tools</h2>
    <ul>
        <li><a class="link-btn" href="${pageContext.request.contextPath}/all_transactions">View Transaction History</a></li>
        <li><a class="link-btn" href="${pageContext.request.contextPath}/check_balance">Balance Inquiry</a></li>
    </ul>
</div>
</body>
</html>
