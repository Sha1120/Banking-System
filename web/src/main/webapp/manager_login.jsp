<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>App | Login</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #6dd5fa, #2980b9);
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

        .login-box {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 400px;
            animation: slideIn 0.8s ease-out;
        }

        @keyframes slideIn {
            from { transform: translateY(-40px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
        }

        th {
            text-align: left;
            font-size: 14px;
            color: #333;
            padding-bottom: 6px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 10px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease-in-out;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
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
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #1f5f94;
        }

        a {
            display: block;
            margin-top: 15px;
            text-align: center;
            color: #2980b9;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }

        a:hover {
            color: #1f5f94;
            text-decoration: underline;
        }

        @media (max-width: 500px) {
            .login-box {
                padding: 30px 20px;
            }

            h1 {
                font-size: 22px;
            }

            input[type="submit"] {
                font-size: 15px;
            }
        }
    </style>

</head>
<body>
<div class="login-box">
    <h1>Manager Login</h1>
    <form method="POST" action="${pageContext.request.contextPath}/login">
        <table>
            <tr>
                <th>Email</th>
                <td><input type="text" name="email" required></td>
            </tr>
            <tr>
                <th>Password</th>
                <td><input type="password" name="password" required></td>
            </tr>
            <input type="hidden" name="role" value="manager" />
            <tr>
                <td colspan="2"><input type="submit" value="Login"></td>
            </tr>

        </table>
        <a href="${pageContext.request.contextPath}/manager_register.jsp">Don't have an Account? Register</a>
    </form>
</div>
</body>
</html>
