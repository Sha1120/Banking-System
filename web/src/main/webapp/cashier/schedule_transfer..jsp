<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Schedule a Fund Transfer</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #d4fc79, #96e6a1);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            animation: fadeIn 1s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card {
            background-color: white;
            padding: 2rem 3rem;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            width: 400px;
            animation: slideUp 0.8s ease;
        }

        @keyframes slideUp {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #2f5d62;
        }

        label {
            display: block;
            margin-top: 1rem;
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"],
        input[type="datetime-local"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 1rem;
        }

        .btn {
            display: block;
            width: 100%;
            margin-top: 1.5rem;
            padding: 10px;
            background-color: #38a169;
            color: white;
            font-size: 1rem;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn:hover {
            background-color: #2f855a;
        }

        .note {
            font-size: 0.85rem;
            color: #555;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="card">
    <h2>Schedule a Transfer</h2>
    <form action="${pageContext.request.contextPath}/cashier/create-scheduled-transfer" method="POST">
        <label for="fromAccount">From Account</label>
        <input type="text" id="fromAccount" name="fromAccount" required>

        <label for="toAccount">To Account</label>
        <input type="text" id="toAccount" name="toAccount" required>

        <label for="amount">Amount (LKR)</label>
        <input type="number" id="amount" name="amount" step="0.01" min="0" required>

        <label for="scheduledTime">Scheduled Date & Time</label>
        <input type="datetime-local" id="scheduledTime" name="scheduledTime" required>

        <button type="submit" class="btn">Schedule Transfer</button>

        <p class="note">Note: Only valid account numbers can be used. Scheduled time must be in the future.</p>
    </form>
</div>
</body>
</html>
