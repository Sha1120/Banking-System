<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String account = request.getParameter("accountNumber");
    String amount = request.getParameter("amount");
    String type = request.getParameter("type");
    String date = request.getParameter("date");
    String customer = request.getParameter("customer");
%>
<html>
<head>
    <title> Transaction Receipt</title>
    <style>
        body {
            font-family: 'Courier New', monospace;
            padding: 30px;
        }

        .receipt {
            border: 2px dashed #000;
            padding: 20px;
            width: 400px;
            margin: auto;
        }

        .receipt h2 {
            text-align: center;
        }

        .receipt p {
            margin: 10px 0;
        }

        .print-btn {
            margin-top: 20px;
            display: block;
            text-align: center;
        }

        @media print {
            .print-btn {
                display: none;
            }
        }
    </style>
</head>
<body>

<div class="receipt">
    <h2> National Bank </h2>
    <p><strong>Account:</strong> <%= account %></p>
    <p><strong>Customer:</strong> <%= customer %></p>
    <p><strong>Type:</strong> <%= type %></p>
    <p><strong>Amount:</strong> Rs. <%= amount %></p>
    <p><strong>Date:</strong> <%= date %></p>

    <div class="print-btn">
        <button onclick="window.print()">Print Receipt</button>
    </div>
</div>

</body>
</html>
