<%-- 
    Document   : laporan
    Created on : May 31, 2025, 6:21:44 PM
    Author     : Lenovo
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat, java.util.*, java.util.Locale" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Laporan Keuangan - MoneyMate</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
                padding: 40px;
            }

            .c-h2 {
                text-align: center;
                margin-bottom: 20px;
            } 
            
            .c-h3 {
                text-align: center;
                margin-bottom: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
                margin-bottom: 30px;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            }

            th, td {
                padding: 12px 16px;
                border-bottom: 1px solid #ddd;
                text-align: left;
            }

            th {
                background-color: #8d83ff;
                color: white;
            }

            tr:last-child td {
                border-bottom: none;
            }

            .summary-table td {
                font-weight: bold;
            }
        </style>
    </head>
    <script>
        function confirmLogout() {
            return confirm("Apakah Anda yakin ingin logout?");
        }
    </script>
    <body>
        <div class="dashboard">
            <aside class="sidebar">
                <div>
                    <div class="logo">
                        <img src="piggy.png" alt="MoneyMate" />
                        <h2>MoneyMate</h2>
                    </div>
                    <nav class="menu">
                        <a href="dashboard.jsp" >
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
                        <a href="laporan.jsp" class="active">
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

            <main class="content">
                <h2 class="c-h2">Laporan Keuangan</h2>

                <%
                    List<Map<String, Object>> transaksiList = (List<Map<String, Object>>) request.getAttribute("transaksiList");
                    Double totalPemasukan = (Double) request.getAttribute("totalPemasukan");
                    Double totalPengeluaran = (Double) request.getAttribute("totalPengeluaran");
                    Double saldo = (Double) request.getAttribute("saldo");

                    NumberFormat nf = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
                %>
                
                <c:if test="${not empty error}">
                    <p style="color:red;">${error}</p>
                </c:if>
                <%
                    String filterMonth = request.getParameter("filterMonth"); // Ambil dari parameter GET
                %>

                <form method="get" action="laporan.jsp" style="margin-bottom: 20px;">
                    <label for="filterMonth">Pilih Bulan:</label>
                    <input type="month" name="filterMonth" id="filterMonth" value="<%= filterMonth != null ? filterMonth : "" %>">
                    <button type="submit" style="background:#8d83ff; color:#fff; border:none; padding:8px 20px; border-radius:8px;">Tampilkan</button>
                </form>

                <table>
                    <tr>
                        <th>Tanggal</th>
                        <th>Deskripsi</th>
                        <th>Jenis</th>
                        <th>Jumlah</th>
                    </tr>
                    <%
                        if (transaksiList != null) {
                            for (Map<String, Object> row : transaksiList) {
                    %>
                    <tr>
                        <td><%= row.get("tanggal")%></td>
                        <td><%= row.get("deskripsi")%></td>
                        <td><%= row.get("jenis")%></td>
                        <td><%= nf.format(row.get("jumlah"))%></td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </table>

                <h3 class="c-h3">Ringkasan</h3>
                <table class="summary-table">
                    <tr>
                        <td>Total Pemasukan</td>
                        <td><%= totalPemasukan != null ? nf.format(totalPemasukan) : "Rp 0"%></td>
                    </tr>
                    <tr>
                        <td>Total Pengeluaran</td>
                        <td><%= totalPengeluaran != null ? nf.format(totalPengeluaran) : "Rp 0"%></td>
                    </tr>
                    <tr>
                        <td>Saldo Akhir</td>
                        <td><%= saldo != null ? nf.format(saldo) : "Rp 0"%></td>
                    </tr>
                </table>
            </main>
        </div>
    </body>
</html>