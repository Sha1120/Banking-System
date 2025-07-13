<%@ page import="lk.jiat.app.core.model.UserType" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Add New User</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f4f7fa;
      padding: 30px;
    }

    .form-container {
      background-color: white;
      padding: 25px;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      max-width: 500px;
      margin: auto;
    }

    h2 {
      color: #053360;
      text-align: center;
    }

    label {
      display: block;
      margin-top: 15px;
      font-weight: bold;
    }

    input, select {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .btn {
      background-color: #2980b9;
      color: white;
      padding: 12px;
      border: none;
      width: 100%;
      margin-top: 25px;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
    }

    .btn:hover {
      background-color: #21618c;
    }

    .back-link {
      display: block;
      margin-top: 20px;
      text-align: center;
      text-decoration: none;
      color: #2980b9;
    }
  </style>
</head>
<body>

<div class="form-container">
  <h2>Add New User</h2>

  <form action="${pageContext.request.contextPath}/add_new_cashier" method="post">
    <label for="c_name">Full Name</label>
    <input type="text" id="c_name" name="c_name" required>

    <label for="c_contact">Contact Number</label>
    <input type="text" id="c_contact" name="c_contact" required>

    <label for="c_email">Email Address</label>
    <input type="email" id="c_email" name="c_email" required>

    <label for="c_password">Password</label>
    <input type="password" id="c_password" name="c_password" required>

    <label for="userType">User Role</label>
    <select id="userType" name="userType" required>
      <option value="CASHIER">CASHIER</option>
    </select>

    <button class="btn" type="submit">Add User</button>
  </form>

  <a class="back-link" href="${pageContext.request.contextPath}/manager/index.jsp">← Back to Dashboard</a>
</div>

</body>
</html>
