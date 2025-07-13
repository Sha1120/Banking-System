<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>APP | Register</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #1c92d2, #f2fcfe);
            margin: 0;
            padding: 0;
            display: flex;
            height: 100vh;
            align-items: center;
            justify-content: center;
            animation: fadeIn 1.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        form {
            background-color: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            min-width: 350px;
            animation: slideUp 1s ease;
        }

        @keyframes slideUp {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        table {
            width: 100%;
        }

        th {
            text-align: left;
            padding: 10px 0;
            color: #555;
        }

        td {
            padding-bottom: 15px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #007BFF;
            outline: none;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
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

        @media screen and (max-width: 480px) {
            form {
                padding: 20px;
                min-width: auto;
                width: 90%;
            }
        }
    </style>
</head>
<body>
<form method="POST" action="${pageContext.request.contextPath}/register">
    <h1>Register</h1>
    <table>
        <tr>
            <th>Name</th>
            <td><input type="text" name="name" required></td>
        </tr>
        <tr>
            <th>Email</th>
            <td><input type="text" name="email" required></td>
        </tr>
        <tr>
            <th>Contact</th>
            <td><input type="text" name="contact" required></td>
        </tr>
        <tr>
            <th>Password</th>
            <td><input type="password" name="password" required></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="Register"></td>
        </tr>
    </table>
    <a href="${pageContext.request.contextPath}/login.jsp">Do you have an Account? Login</a>
</form>
</body>
</html>
