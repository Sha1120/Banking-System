<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.jiat.app.core.model.ManualTransaction" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page isELIgnored="false" %>
<%
    List<ManualTransaction> manualList = (List<ManualTransaction>) request.getAttribute("manualTransactions");
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
%>

<html>
<head>
    <title>All Transactions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: #f8f9fa;
            padding: 30px;
        }
        .filter-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            flex-direction: row;
        }
        table {
            background: white;
            border-radius: 10px;
        }
        thead {
            background-color: #007BFF;
            color: white;
        }
        .no-data {
            text-align: center;
            color: gray;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">All Transactions (Last 30 Days)</h2>

    <div class="filter-bar">
        <input type="text" id="searchInput" class="form-control" placeholder="Search by Account or Name">
        <input type="date" id="fromDate" class="form-control" placeholder="From Date">
        <input type="date" id="toDate" class="form-control" placeholder="To Date">

        <select id="typeFilter" class="form-select">
            <option value="">All Types</option>
            <option value="M">Manual</option>
            <option value="O">Online</option>
            <option value="S">Schedule</option>
        </select>
    </div>

    <table class="table table-bordered table-striped" id="transactionTable">
        <thead>
        <tr>
            <th>#</th>
            <th>Account No</th>
            <th>Customer Name</th>
            <th>Transfer Type</th>
            <th>Withdrew</th>
            <th>Deposit</th>
            <th>Date</th>
        </tr>
        </thead>
        <tbody>
        <% if (manualList != null) {
            for (ManualTransaction m : manualList) {

                String type = "M"; // Default manual
                String branch = m.getBranch();
                if (branch != null) {
                    if (branch.contains("Online Transfer")) {
                        type = "O";
                    } else if (branch.contains("Schedule Transaction")) {
                        type = "S";
                    }
                }

                String withdrawAmount = "";
                String depositAmount = "";
                if ("WITHDRAW".equalsIgnoreCase(m.getTransactionType())) {
                    withdrawAmount = m.getAmount().toString();
                } else if ("DEPOSIT".equalsIgnoreCase(m.getTransactionType())) {
                    depositAmount = m.getAmount().toString();
                }
        %>
        <tr data-type="<%= type %>">
            <td><%= m.getId() %></td>
            <td><%= m.getAccountNumber() %></td>
            <td><%= m.getCustomerName() %></td>
            <td><%= branch %></td>
            <td><%= withdrawAmount %></td>
            <td><%= depositAmount %></td>
            <td><%= m.getTransactionDate().format(formatter) %></td>
        </tr>
        <%  } } %>

        </tbody>
    </table>
</div>

<script>
    const fromDate = document.getElementById("fromDate");
    const toDate = document.getElementById("toDate");
    const typeFilter = document.getElementById("typeFilter");
    const searchInput = document.getElementById("searchInput");
    const tableRows = document.querySelectorAll("#transactionTable tbody tr");

    function filterTable() {
        const from = fromDate.value ? new Date(fromDate.value + "T00:00:00") : null;
        const to = toDate.value ? new Date(toDate.value + "T23:59:59") : null;
        const type = typeFilter.value;
        const keyword = searchInput.value.toLowerCase();

        tableRows.forEach(row => {
            const rowType = row.getAttribute("data-type");
            const accNo = row.cells[1].textContent.toLowerCase();
            const name = row.cells[2].textContent.toLowerCase();
            const date = new Date(row.cells[6].textContent);

            const matchType = !type || rowType === type;
            const matchSearch = accNo.includes(keyword) || name.includes(keyword);
            const matchDate = (!from || date >= from) && (!to || date <= to);

            row.style.display = matchType && matchSearch && matchDate ? "" : "none";
        });
    }

    fromDate.addEventListener("change", filterTable);
    toDate.addEventListener("change", filterTable);
    typeFilter.addEventListener("change", filterTable);
    searchInput.addEventListener("input", filterTable);
</script>

</body>
</html>
