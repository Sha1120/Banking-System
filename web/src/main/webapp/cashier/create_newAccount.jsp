<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create  New Account</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(120deg, #2980b9, #6dd5fa);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .form-container {
            background-color: white;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
            width: 600px;
            animation: fadeIn 0.7s ease-in-out;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #2c3e50;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #333;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-group input:focus, .form-group select:focus {
            border-color: #2980b9;
            box-shadow: 0 0 5px rgba(41, 128, 185, 0.4);
            outline: none;
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            background-color: #27ae60;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .submit-btn:hover {
            background-color: #219150;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Create New Account</h2>
    <form action="${pageContext.request.contextPath}/add_account" method="post">
        <div class="form-group">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" required />
        </div>

        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required />
        </div>

        <div class="form-group">
            <label for="contact">Contact Number</label>
            <input type="text" id="contact" name="contact" required />
        </div>

        <div class="form-group">
            <label for="nic">NIC / Passport</label>
            <input type="text" id="nic" name="nic" required />
        </div>

        <div class="form-group">
            <label for="accountType">Account Type</label>
            <select id="accountType" name="accountType" required>
                <option value="">-- Select Account Type --</option>
                <option value="SAVINGS">Savings</option>
                <option value="CURRENT">Current</option>
                <option value="FIXED">Fixed Deposit</option>
            </select>
        </div>

        <div class="form-group">
            <label for="initialDeposit">Initial Deposit (Rs.)</label>
            <input type="number" id="initialDeposit" name="initialDeposit" min="1000" required />
        </div>

        <button type="submit" class="submit-btn">Create New Account</button>
    </form>
</div>

</body>
</html>
