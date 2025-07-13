<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer Login</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #6dd5fa, #2980b9);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            animation: fadeInBody 1s ease-in-out;
        }

        @keyframes fadeInBody {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-box {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 420px;
            animation: popIn 0.9s ease-out;
        }

        @keyframes popIn {
            0% { transform: scale(0.9); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 25px;
            font-size: 28px;
        }

        table {
            width: 100%;
        }

        th {
            text-align: left;
            font-size: 15px;
            color: #34495e;
            padding-bottom: 6px;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px 10px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease-in-out;
        }

        input[type="text"]:focus {
            border-color: #2980b9;
            box-shadow: 0 0 5px rgba(41, 128, 185, 0.5);
            outline: none;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #2980b9;
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s;
        }

        input[type="submit"]:hover {
            background-color: #1f5f94;
            transform: translateY(-1px);
        }

        input[type="submit"]:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        #sendOtpBtn {
            background-color: orange;
            color: white;
            font-weight: bold;
            width: 150px;
        }

        #sendOtpBtn:hover {
            background-color: darkorange;
        }

        .error-message {
            color: red;
            font-size: 14px;
            text-align: center;
            margin-bottom: 15px;
        }

        .success-message {
            color: green;
            font-size: 14px;
            text-align: center;
            margin-bottom: 15px;
        }

        @media (max-width: 500px) {
            .login-box {
                padding: 30px 20px;
            }

            h1 {
                font-size: 24px;
            }

            input[type="submit"] {
                font-size: 15px;
            }
        }
    </style>

    <script>
        function toggleOtpButton() {
            const accInput = document.getElementById("ac_number");
            const otpBtn = document.getElementById("sendOtpBtn");
            const loginAccHidden = document.getElementById("login_ac_number");
            const sendOtpHidden = document.getElementById("send_otp_ac_number");

            const accValue = accInput.value.trim();
            otpBtn.disabled = accValue === "";

            loginAccHidden.value = accValue;
            sendOtpHidden.value = accValue;
        }

        window.onload = function () {
            toggleOtpButton();
        };
    </script>
</head>
<body>
<div class="login-box">
    <h1>Customer Login</h1>

    <%-- Message logic --%>
    <%
        String error = request.getParameter("error");
        String otp = request.getParameter("otp");
        String accValue = request.getParameter("ac_number");
    %>

    <% if ("missing_account".equals(error)) { %>
    <div class="error-message">Please enter your account number.</div>
    <% } else if ("invalid_account".equals(error)) { %>
    <div class="error-message">Invalid account number.</div>
    <% } else if ("mail_failed".equals(error)) { %>
    <div class="error-message">Failed to send OTP. Try again later.</div>
    <% } else if ("sent".equals(otp)) { %>
    <div class="success-message">OTP sent to your registered email address.</div>
    <% } %>

    <!-- Account Number Input -->
    <table>
        <tr>
            <th>Account Number</th>
            <td>
                <input type="text" name="ac_number" id="ac_number"
                       value="<%= accValue != null ? accValue : "" %>"
                       onkeyup="toggleOtpButton()" required>
            </td>
        </tr>
    </table>

    <!-- Send OTP -->
    <form method="POST" action="${pageContext.request.contextPath}/send_otp">
        <input type="hidden" name="ac_number" id="send_otp_ac_number">
        <input type="submit" id="sendOtpBtn" value="Send OTP Code" disabled>
    </form>

    <!-- Login with OTP -->
    <form method="POST" action="${pageContext.request.contextPath}/login_customer">
        <input type="hidden" name="role" value="cashier" />
        <input type="hidden" name="ac_number" id="login_ac_number" />

        <table>
            <tr>
                <th>OTP Code</th>
                <td><input type="text" name="otp_code" required></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Login"></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
