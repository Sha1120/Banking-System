<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.jiat.app.core.service.UserService" %>
<%@ page import="lk.jiat.app.core.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>National Bank Dashboard</title>
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

    h1, h2 {
      color: #053360;
    }

    .login-container {
      display: flex;
      gap: 40px;
      margin-top: 40px;
    }

    .login-box {
      background-color: white;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 8px 16px rgba(0,0,0,0.1);
      width: 300px;
      text-align: center;
    }

    .login-box a {
      text-decoration: none;
      color: white;
      background-color: #2980b9;
      padding: 10px 20px;
      border-radius: 5px;
      display: inline-block;
      margin-top: 10px;
    }

    .login-box a:hover {
      background-color: #1c5980;
    }
  </style>
</head>
<body>

<div class="navbar">
  <h1>Welcome to National Bank</h1>
</div>


  <div class="login-container">
    <div class="login-box">
      <h2>Manager Login</h2>
      <p>Only authorized managers can access this area.</p>
      <a href="${pageContext.request.contextPath}/manager_login.jsp">Login as Manager</a>
    </div>

    <div class="login-box">
      <h2>Cashier Login</h2>
      <p>Cashiers can access their dashboard with their Employee code.</p>
      <a href="${pageContext.request.contextPath}/cashier_login.jsp">Login as Cashier</a>
    </div>

    <div class="login-box">
      <h2>Customer Login</h2>
      <p>Customer can access their dashboard with their Account Number.</p>
      <a href="${pageContext.request.contextPath}/customer_login.jsp">Login as Customer</a>
    </div>
  </div>

</body>
</html>
