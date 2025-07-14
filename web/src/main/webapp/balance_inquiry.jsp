<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <title>Balance Inquiry</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #6dd5fa, #ffffff);
            font-family: 'Segoe UI', sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card {
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 500px;
            background-color: white;
            animation: slideUp 0.5s ease-in-out;
        }

        @keyframes slideUp {
            from { transform: translateY(40px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        .result-box {
            margin-top: 20px;
            padding: 15px;
            background-color: #f1f9ff;
            border-left: 4px solid #007bff;
            border-radius: 6px;
        }

        .error-msg {
            color: red;
            margin-top: 15px;
        }
    </style>
</head>
<body>

<div class="card">
    <h3 class="text-center mb-4">Balance Inquiry</h3>

    <form action="check_balance" method="post">
        <label for="identifier">Enter NIC or Account Number:</label>
        <input type="text" name="identifier" id="identifier" class="form-control" required>
        <button type="submit" class="btn btn-primary w-100 mt-3">Check Balance</button>
    </form>

    <% if (request.getAttribute("balance") != null) { %>
    <div class="result-box">
        <p><strong>Account Number:</strong> <%= request.getAttribute("accountNumber") %></p>
        <p><strong>Account Number:</strong> <%= request.getAttribute("ownerName") %></p>
        <p><strong>Balance:</strong> Rs. <%= request.getAttribute("balance") %></p>
    </div>
    <% } %>

    <% if (request.getAttribute("error") != null) { %>
    <div class="error-msg"><%= request.getAttribute("error") %></div>
    <% } %>
</div>

</body>
</html>
