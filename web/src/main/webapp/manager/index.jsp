<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="lk.jiat.app.core.service.UserService" %>
<%@ page import="lk.jiat.app.core.model.User" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Manager Dashboard</title>
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        table th, table td {
            padding: 10px;
            border: 1px solid #ccc;
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
    </style>
</head>
<body>

<%-- Only show dashboard if logged in user is MANAGER --%>
<c:if test="${pageContext.request.userPrincipal != null && pageContext.request.isUserInRole('MANAGER')}">

    <div class="navbar">
        <h1>Manager Dashboard</h1>
        <div>
            <span>Welcome, ${pageContext.request.userPrincipal.name}</span>
            <a class="logout-btn" href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </div>

    <div class="section">
        <h2>Available Cashiers</h2>

        <div style="margin-bottom: 15px;">
            <a href="${pageContext.request.contextPath}/manager/add_user.jsp"
               style="padding: 10px 15px; background-color: #27ae60; color: white; text-decoration: none; border-radius: 5px;">
                + Register New Cashier
            </a>
        </div>

        <%
            try {
                InitialContext ic = new InitialContext();
                UserService userService = (UserService) ic.lookup("lk.jiat.app.core.service.UserService");
                List<User> users = userService.getAllUsers();
                pageContext.setAttribute("users", users);
            } catch (NamingException e) {
                throw new RuntimeException(e);
            }
        %>

        <table>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Contact Number</th>
                <th>User Type</th>
                <th>Status</th>
            </tr>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.name}</td>
                    <td>${user.email}</td>
                    <td>${user.contact}</td>
                    <td>${user.userType}</td>
                    <td style="display: flex; justify-content: space-between; align-items: center;">
                            ${user.status}
                        <form action="${pageContext.request.contextPath}/manager/delete_user" method="post" style="margin-left: auto;">
                            <input type="hidden" name="uid" value="${user.id}" />
                            <button
                                    type="submit"
                                    <c:if test="${user.status == 'DELETED'}">disabled</c:if>
                                    style="background-color: #e74c3c; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">
                                DELETE
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <div class="section">
        <h2>Automated Scheduled Tasks</h2>
        <div class="card-container">
            <div class="card">
                <h3>Interest Calculation</h3>
                <p>Runs Daily at 12:00 AM</p>
                <p>Status: <strong>Active</strong></p>
            </div>
            <div class="card">
                <h3>Scheduled Fund Transfers</h3>
                <p>Runs every hour</p>
                <p>Status: <strong>Active</strong></p>
            </div>
            <div class="card">
                <h3>Daily Balance Update</h3>
                <p>Runs Daily at 12:00 AM</p>
                <p>Status: <strong>Active</strong></p>
            </div>
        </div>
    </div>

    <div class="section">
        <h2>Reports</h2>
        <ul>
            <li><a class="link-btn" href="#">Download Daily Transaction Report</a></li>
            <li><a class="link-btn" href="#">View Monthly Interest Summary</a></li>
            <li><a class="link-btn" href="#">Generate Customer Account Overview</a></li>
        </ul>
    </div>

</c:if>

<c:if test="${pageContext.request.userPrincipal == null || !pageContext.request.isUserInRole('MANAGER')}">
    <p style="color: red;">
        You must <a href="${pageContext.request.contextPath}/manager_login.jsp">Login</a> as <strong>Manager</strong> to view the Dashboard.
    </p>
</c:if>

</body>
</html>
