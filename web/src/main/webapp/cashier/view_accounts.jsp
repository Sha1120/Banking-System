<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="lk.jiat.app.core.model.Account" %>
<%@ page isELIgnored="false" %>
<%
  List<Account> accounts = (List<Account>) request.getAttribute("accounts");
%>
<html>
<head>
  <title>Customer Accounts</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background: linear-gradient(to right, #74ebd5, #ACB6E5);
      padding: 30px;
      animation: fadeIn 0.8s ease-in-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .filter-bar {
      margin-bottom: 20px;
      gap: 10px;
      display: flex;
      flex-direction: row;
    }

    .filter-bar input, .filter-bar select {
      border-radius: 8px;
    }

    table {
      background: white;
      border-radius: 10px;
      overflow: hidden;
    }

    thead {
      background-color: #007BFF;
      color: white;
    }

    tbody tr:hover {
      background-color: #f1f1f1;
    }

    .table-responsive {
      animation: slideUp 0.7s ease-out;
    }

    @keyframes slideUp {
      from { transform: translateY(30px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }
  </style>
</head>
<body>

<div class="container">
  <h2 class="text-center mb-4">All Customer Accounts</h2>

  <div class="filter-bar">
    <input type="text" id="searchInput" class="form-control" placeholder="Search by Account Number or Name">
    <select id="typeFilter" class="form-select">
      <option value="">All Types</option>
      <option value="SAVINGS">SAVINGS</option>
      <option value="CURRENT">CURRENT</option>
      <option value="FIXED">FIXED</option>
    </select>
    <select id="statusFilter" class="form-select">
      <option value="">All Status</option>
      <option value="ACTIVE">ACTIVE</option>
      <option value="SUSPENDED">SUSPENDED</option>
      <option value="CLOSED">CLOSED</option>
    </select>
  </div>

  <div class="table-responsive">
    <table class="table table-bordered table-striped" id="accountTable">
      <thead>
      <tr>
        <th>Account Number</th>
        <th>Customer Name</th>
        <th>Type</th>
        <th>Balance (Rs.)</th>
        <th>Status</th>
        <th>Created Date</th>
      </tr>
      </thead>
      <tbody>
      <% if (accounts != null) {
        for (Account acc : accounts) { %>
      <tr>
        <td><%= acc.getAccountNumber() %></td>
        <td><%= acc.getCustomer_name() %></td>
        <td><%= acc.getAccountType() %></td>
        <td><%= acc.getBalance() %></td>
        <td><%= acc.getStatus() %></td>
        <td><%= acc.getCreatedAt()%></td>
      </tr>
      <%  }
      } %>
      </tbody>
    </table>
  </div>
</div>

<script>
  const searchInput = document.getElementById('searchInput');
  const typeFilter = document.getElementById('typeFilter');
  const statusFilter = document.getElementById('statusFilter');
  const table = document.getElementById('accountTable').getElementsByTagName('tbody')[0];

  function filterTable() {
    const search = searchInput.value.toLowerCase();
    const type = typeFilter.value;
    const status = statusFilter.value;

    const rows = table.getElementsByTagName('tr');
    for (let row of rows) {
      const accNo = row.cells[0].textContent.toLowerCase();
      const name = row.cells[1].textContent.toLowerCase();
      const accType = row.cells[2].textContent;
      const accStatus = row.cells[4].textContent;

      const matchesSearch = accNo.includes(search) || name.includes(search);
      const matchesType = !type || accType === type;
      const matchesStatus = !status || accStatus === status;

      if (matchesSearch && matchesType && matchesStatus) {
        row.style.display = '';
      } else {
        row.style.display = 'none';
      }
    }
  }

  searchInput.addEventListener('input', filterTable);
  typeFilter.addEventListener('change', filterTable);
  statusFilter.addEventListener('change', filterTable);
</script>

</body>
</html>
