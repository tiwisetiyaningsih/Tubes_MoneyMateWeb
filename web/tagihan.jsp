<%-- 
    Document   : tagihan
    Created on : May 31, 2025, 6:21:36?PM
    Author     : Lenovo
--%>

<%@ page import="java.util.*, model.Tagihan" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tagihan - MoneyMate</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: 'Inter', sans-serif;
            }

            body {
                background-color: #f4f4ff;
            }

            .dashboard {
                display: flex;
            }

            .sidebar {
                width: 250px;
                background-color: #fff;
                height: 100vh;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                padding: 30px 20px;
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
            }

            .logo {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .logo img {
                width: 50px;
                height: 40px;
                border-radius: 50%;
            }

            .logo h2 {
                font-size: 20px;
                font-weight: 600;
                color: #3b3b3b;
            }

            .menu {
                display: flex;
                flex-direction: column;
                gap: 20px;
                margin-top: 30px;
            }

            .menu a {
                text-decoration: none;
                color: #555;
                font-weight: 500;
                display: flex;
                align-items: center;
                padding: 10px 15px;
                border-radius: 8px;
                transition: background-color 0.2s;
            }

            .menu a .icon {
                margin-right: 10px;
                width: 20px;
                text-align: center;
            }

            .menu a:hover,
            .menu a.active {
                background-color: #8d83ff;
                color: white;
                font-weight: bold;
            }

            .signout a {
                display: flex;
                align-items: center;
                text-decoration: none;
                color: #555;
                font-size: 14px;
                padding: 10px;
                transition: color 0.2s;
            }

            .signout a .icon {
                margin-right: 8px;
            }

            .signout a:hover {
                color: #e74c3c;
            }

            .content {
                flex: 1;
                background-color: #f4f4ff;
                padding-left:40px;
                padding-right:40px;
                padding-bottom:40px;
            }
            .card_saldo {
                background-color: #E2E2FF;
                border-radius: 0px 0px 47px 47px;
                padding: 40px;
                margin-left: -38px;
                margin-right: -38px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                flex-direction: column;
            }
            
            .card1 {
                background-color: white;
                border-radius: 20px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                margin-bottom: 20px;
                margin-left: 40px;
                margin-right: 40px;
                height: 200px;
                flex-direction: row;
                display: flex;
                flex: 1;
            }

            .card {
                background-color: transparent;
                border-radius: 20px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                margin-bottom: 20px;
                margin-left: 40px;
                margin-right: 40px;
            }

            .transaction-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 1px 5px rgba(0, 0, 0, 0.05);
                margin-bottom: 10px;
            }

            .transaction-item .info {
                display: flex;
                align-items: center;
            }

            .transaction-item .icon {
                width: 40px;
                height: 40px;
                background: #ddd;
                border-radius: 8px;
                margin-right: 10px;
            }

            .transaction-item .label {
                font-weight: 600;
            }

            .transaction-item .date {
                font-size: 12px;
                color: gray;
            }

            .transaction-item .amount {
                font-weight: bold;
            }

            .amount.income {
                color: green;
            }

            .amount.expense {
                color: red;
            }
            .card.blue {
                background-color: #e0f0ff; /* biru muda */
                border-left: 6px solid #2196F3;
            }

            .card.red {
                background-color: #ffe0e0; /* merah muda */
                border-left: 6px solid #f44336;
            }
            .card .amount2 {
                font-size: 24px;
                font-weight: bold;
                color: #333;
            }
        </style>
<body>
        <div class="dashboard">
                <!-- Sidebar -->
                <aside class="sidebar">
                    <div>
                        <div class="logo">
                            <img src="piggy.png" alt="MoneyMate" />
                            <h2>MoneyMate</h2>
                        </div>
                        <nav class="menu">
                            <a href="dashboard.jsp">
                                <span class="icon"><i class="fas fa-chart-pie"></i></span>
                                Dashboard
                            </a>
                            <a href="transaksi.jsp">
                                <span class="icon"><i class="fas fa-wallet"></i></span>
                                Transactions
                            </a>
                            <a href="anggaran.jsp">
                                <span class="icon"><i class="fas fa-money-bill-alt"></i></span>
                                Anggaran
                            </a>
                            <a href="tagihan.jsp" class="active">
                                <span class="icon"><i class="fas fa-file-invoice-dollar"></i></span>
                                Tagihan
                            </a>
                            <a href="laporan.jsp">
                                <span class="icon"><i class="fas fa-chart-simple"></i></span>
                                Laporan
                            </a>
                            <a href="profile.jsp">
                                <span class="icon"><i class="fas fa-user"></i></span>
                                Profile
                            </a>
                        </nav>
                    </div>
                    <div class="signout">
                        <a href="login.jsp" onclick="return confirmLogout();">
                            <span class="icon"><i class="fas fa-sign-out-alt"></i></span>
                            Sign Out
                        </a>
                    </div>
                </aside>
    <div class="container mt-5">
        <h3>Daftar Tagihan</h3>
        <form action="tagihan" method="post" class="mb-4">
            <div class="row g-3">
                <div class="col-md-3">
                    <input type="text" name="namaTagihan" placeholder="Nama Tagihan" class="form-control" required>
                </div>
                <div class="col-md-2">
                    <input type="number" step="0.01" name="jumlahTagihan" placeholder="Nominal Tagihan" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <input type="date" name="tanggalDue" placeholder="Jatuh Tempo" class="form-control" required>
                </div>
                <div class="col-md-1">
                    <button class="btn btn-success" type="submit">Tambah</button>
                </div>
            </div>
        </form>

        <table class="table table-bordered">
    <thead>
    <tr>
        <th>ID</th>
        <th>Nama Tagihan</th>
        <th>Nominal Tagihan</th>
        <th>Jatuh Tempo</th>
        <th>Tanggal Reminder</th>
        <th>Set Reminder</th>
        <th>Aksi</th>
    </tr>
</thead>

    

    <tr>
<!--        <td>1</td>
        <td>Listrik PLN</td>
        <td>250000</td>
        <td>2025-06-20</td>
        <td>
            <form action="pengingat" method="post" class="d-flex">
                <input type="hidden" name="id" value="1">
                <input type="hidden" name="namaTagihan" value="Listrik PLN">
                <input type="hidden" name="jumlahTagihan" value="250000">
                <input type="hidden" name="tanggalDue" value="2025-06-20">
                <input type="date" name="reminderDate" class="form-control me-2" value="2025-06-18" required>
                <button type="submit" class="btn btn-sm btn-primary">Set</button>
            </form>
        </td>
    </tr>
    <tr>
        <td>2</td>
        <td>Spotify Premium</td>
        <td>55000</td>
        <td>2025-06-15</td>
        <td>
            <form action="pengingat" method="post" class="d-flex">
                <input type="hidden" name="id" value="2">
                <input type="hidden" name="namaTagihan" value="Spotify Premium">
                <input type="hidden" name="jumlahTagihan" value="55000">
                <input type="hidden" name="tanggalDue" value="2025-06-15">
                <input type="date" name="reminderDate" class="form-control me-2" value="" required>
                <button type="submit" class="btn btn-sm btn-primary">Set</button>
            </form>
        </td>
    </tr>
    <tr>
        <td>3</td>
        <td>Kost Bulanan</td>
        <td>1000000</td>
        <td>2025-07-01</td>
        <td>
            <form action="pengingat" method="post" class="d-flex">
                <input type="hidden" name="id" value="3">
                <input type="hidden" name="namaTagihan" value="Kost Bulanan">
                <input type="hidden" name="jumlahTagihan" value="1000000">
                <input type="hidden" name="tanggalDue" value="2025-07-01">
                <input type="date" name="reminderDate" class="form-control me-2" value="2025-06-28" required>
                <button type="submit" class="btn btn-sm btn-primary">Set</button>
            </form>
        </td>
    </tr>
</tbody>-->
<tbody>
    <%
    List<Tagihan> tagihanList = (List<Tagihan>) request.getAttribute("tagihanList");
    if (tagihanList == null) tagihanList = new ArrayList<>();
    request.setAttribute("tagihanList", tagihanList);
%>
    <c:forEach var="tagihan" items="${tagihanList}">
    <tr>
        <td>${tagihan.id}</td>
        <td>${tagihan.namaTagihan}</td>
        <td>${tagihan.jumlahTagihan}</td>
        <td>${tagihan.tanggalDue}</td>
        <td>
            <c:choose>
                <c:when test="${tagihan.reminderDate != null}">
                    ${tagihan.reminderDate}
                </c:when>
                <c:otherwise>
                    <span class="text-muted">Belum diset</span>
                </c:otherwise>
            </c:choose>
        </td>
        <td>
            <form action="pengingat" method="post" class="d-flex">
                <input type="hidden" name="tagihanId" value="${tagihan.id}">
                <input type="date" name="reminderDate" class="form-control me-2" required>
                <button type="submit" class="btn btn-sm btn-primary">Set</button>
            </form>
        </td>
        <td>
            <a href="editTagihan?id=${tagihan.id}" class="btn btn-sm btn-warning">Edit</a>
            <a href="hapusTagihan?id=${tagihan.id}" class="btn btn-sm btn-danger" onclick="return confirm('Yakin ingin hapus tagihan ini?')">Hapus</a>
        </td>
    </tr>
</c:forEach>

</tbody>
</table>

    
    </body>
</html>
