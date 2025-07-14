<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.jiat.app.core.model.Account" %>
<%@ page import="java.math.BigDecimal" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    Account customer = (Account) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect(request.getContextPath() + "/customer_login.jsp?error=session_expired");
        return;
    }
%>

<%
    String accNumber = request.getParameter("acc");
    // Use accNumber to fetch details from database
%>

<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #fdfdfd;
        }

        /* Top navigation bar */
        .top-bar {
            background-color: #0c5aa6;
            padding: 12px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            color: white;
        }

        .top-bar .menu {
            display: flex;
            gap: 25px;
            font-weight: bold;
        }

        .top-bar .menu div {
            cursor: pointer;
            transition: opacity 0.3s;
        }

        .top-bar .menu div:hover {
            opacity: 0.8;
        }

        .search-bar {
            background: white;
            border-radius: 20px;
            padding: 6px 12px;
            width: 280px;
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
        }

        .search-bar input {
            border: none;
            outline: none;
            flex: 1;
            padding-left: 8px;
        }

        .container {
            padding: 30px 40px;
        }

        .section-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #333;
        }

        .account-card {
            background: #fff;
            border-radius: 10px;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            box-shadow: 0 4px 10px rgba(0,0,0,0.06);
            margin-bottom: 30px;
            max-width: 500px;
        }

        .account-card .info {
            display: flex;
            flex-direction: column;
        }

        .account-card .info span:first-child {
            font-weight: bold;
            color: #888;
        }

        .account-card .info span:last-child {
            font-size: 20px;
            color: #2c3e50;
        }

        .account-card .badge {
            background-color: #053360;
            color: white;
            font-weight: bold;
            padding: 4px 10px;
            border-radius: 20px;
            height: fit-content;
        }

        .grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            height: 250px;
        }

        .card h3 {
            margin-bottom: 10px;
            border-bottom: 2px solid #0c5aa6;
            display: inline-block;
            padding-bottom: 5px;
            color: #2c3e50;
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


        @media (max-width: 768px) {
            .grid {
                grid-template-columns: 1fr;
            }

            .search-bar {
                width: 100%;
            }

            .container {
                padding: 20px;
            }
        }

        .menu div {
            cursor: pointer;
            transition: opacity 0.3s;
        }

        .acbody {
            background: #fff;
            padding: 30px;
            margin-top: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        }

        .acbody h3 {
            color: #0c5aa6;
            margin-bottom: 15px;
        }

        .transfer-form {
            max-width: 500px;
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: bold;
            margin-bottom: 5px;
            color: #2c3e50;
        }

        .form-group input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.3s;
        }

        .form-group input:focus {
            border-color: #0c5aa6;
            outline: none;
            box-shadow: 0 0 5px rgba(12, 90, 166, 0.2);
        }

        .transfer-btn {
            padding: 12px;
            background-color: #0c5aa6;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .transfer-btn:hover {
            background-color: #094881;
        }

    </style>

    <script>
        function loadSection(section) {
            const acbody = document.querySelector(".acbody");
            let content = "";

            switch (section) {
                case 'transfer':
                    content = `
        <h3>Transfer Money</h3>

    <form class="transfer-form" action="<%= request.getContextPath() %>/customer/online_transfer" method="POST">

    <div class="form-group">
        <label for="fromAccount">From Account:</label>
        <input type="text" id="fromAccount" name="fromAccount" placeholder="Enter your account number" required />
    </div>

    <div class="form-group">
        <label for="toAccount">To Account:</label>
        <input type="text" id="toAccount" name="toAccount" placeholder="Enter recipient account number" required />
    </div>

    <div class="form-group">
        <label for="fromAccount">Owner's Name:</label>
        <input type="text" id="owner_name" name="owner_name" placeholder="Enter owner's name" required />
    </div>

    <div class="form-group">
        <label for="fromAccount">NIC Number :</label>
        <input type="text" id="nic" name="nic" placeholder="Enter owner's NIC number" required />
    </div>

    <div class="form-group">
        <label for="fromAccount">Branch :</label>
        <input type="text" id="branch" name="branch" placeholder="Enter from account branch name" required />
    </div>

    <div class="form-group">
        <label for="amount">Amount:</label>
        <input type="number" id="amount" name="amount" placeholder="Enter amount" step="0.01" required />
    </div>

    <button type="submit" class="transfer-btn">Send Money</button>
</form>
    `;
                    break;


                case 'bills':
                    content = `
                        <h3>Bill Payments</h3>
                        <p>Feature coming soon...</p>
                    `;
                    break;

                case 'services':
                    content = `
                        <h3>Banking Services</h3>
                        <ul>
                            <li>Open Fixed Deposit</li>
                            <li>Apply for Loan</li>
                        </ul>
                    `;
                    break;

                case 'inquiry':
                    content = `
                        <h3>Transaction Inquiry</h3>
                        <p>Enter date range to view transaction history.</p>
                    `;
                    break;

                default:
                    content = `<p>Please select an option from the menu above.</p>`;
            }

            acbody.innerHTML = content;
        }
    </script>
</head>
<body>

<div class="top-bar">
    <div class="menu">
        <div onclick="loadSection('transfer')">Transfer</div>
        <div onclick="loadSection('bills')">Bill Payments</div>
        <div onclick="loadSection('services')">Services</div>
        <div onclick="loadSection('inquiry')">Inquiry</div>
    </div>


    <form action="<%= request.getContextPath() %>/logout" method="post" style="margin-left: 20px;">
        <input type="submit" value="Logout" class="logout-btn">
    </form>
</div>

<div class="container">
    <div class="section-title">My Accounts</div>

    <div class="grid">

        <div class="account-card">
            <div class="info">
                <span>No. of Accounts</span>
                <span><strong>${accountCount}</strong></span>
            </div>
            <div class="info">
                <span>Total Amount</span>
                <span>Rs. <%= customer.getBalance() %> </span>
            </div>
            <div class="badge"><%= customer.getAccountType()%></div>

        </div>

        <div class="account-card">
            <div class="info">
                <span>Account Number</span>
                <span>
                    <a href="${pageContext.request.contextPath}/customer/my_account" style="text-decoration: none; color: #0c5aa6; font-weight: bold;">
                            <%= customer.getAccountNumber() %>
                    </a>
                </span>
            </div>

            <div class="info">
                <span>Available Balance</span>
                <span>Rs.  <%= customer.getBalance().subtract(new BigDecimal("1000.00")) %></span>
            </div>
        </div>

    </div>

    <!-- Success Message -->
    <c:if test="${not empty message}">
        <div style="color: green; font-weight: bold; margin-bottom: 15px;">
                ${message}
        </div>
    </c:if>

    <!--  Error Message -->
    <c:if test="${not empty error}">
        <div style="color: red; font-weight: bold; margin-bottom: 15px;">
                ${error}
        </div>
    </c:if>

    <div class="acbody">
        <p>Please select an option from the menu above.</p>
    </div>
</div>

</body>
</html>
