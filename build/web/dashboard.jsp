<%-- 
    Document   : dashboard
    Created on : May 31, 2025, 6:21:01?PM
    Author     : Lenovo
--%>

<%@page language="java" %>
<%@page session="true" %>
<!DOCTYPE html>
<%@page import="java.util.*, model.TransaksiDAO" %>
<%
    Integer userId = (Integer) session.getAttribute("id");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    double totalPemasukan = 0;
    double totalPengeluaran = 0;
    double totalSaldo = 0;

    // Data per bulan untuk chart
    int[] pemasukanBulanan = new int[12];
    int[] pengeluaranBulanan = new int[12];

    for (int bulan = 1; bulan <= 12; bulan++) {
        int tahun = Calendar.getInstance().get(Calendar.YEAR);
        pemasukanBulanan[bulan - 1] = (int) TransaksiDAO.getTotalByUserMonthYearAndTipe(userId, bulan, tahun, "Pemasukan");
        pengeluaranBulanan[bulan - 1] = (int) TransaksiDAO.getTotalByUserMonthYearAndTipe(userId, bulan, tahun, "Pengeluaran");

        totalPemasukan += pemasukanBulanan[bulan - 1];
        totalPengeluaran += pengeluaranBulanan[bulan - 1];
    }

    totalSaldo = totalPemasukan - totalPengeluaran;
%>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Dashboard MoneyMate</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

            .cards {
                background-color: white;
                padding: 20px;
                border-radius: 15px;
                display: flex;
                gap: 20px;
                margin-bottom: 40px;
                margin-top: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            }

            .card {
                flex: 1;
                padding: 20px;
                background-color: white;
                border-radius: 15px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                display: flex;
                flex-direction: column;
                gap: 10px;
            }
            
            .card.blue {
                background-color: #e0f0ff; /* biru muda */
                border-left: 6px solid #2196F3;
            }

            .card.red {
                background-color: #ffe0e0; /* merah muda */
                border-left: 6px solid #f44336;
            }

            .card.yellow {
                background-color: #fff8dc; /* kuning muda */
                border-left: 6px solid #fbc02d;
            }


            .card h3 {
                font-size: 18px;
                color: #555;
            }

            .card .amount {
                font-size: 24px;
                font-weight: bold;
                color: #333;
            }

            .chart-container {
                background-color: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            }

            canvas {
                max-width: 100%;
                max-height: 80%
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
                        <a href="#" class="active">
                            <span class="icon"><i class="fas fa-chart-pie"></i></span>
                            Dashboard
                        </a>
                        <a href="transaksi.jsp">
                            <span class="icon"><i class="fas fa-wallet"></i></span>
                            Transactions
                        </a>
                        <a href="tagihan">
                            <span class="icon"><i class="fas fa-file-invoice-dollar"></i></span>
                            Tagihan
                        </a>
                        <a href="laporan.jsp">
                            <span class="icon"><i class="fas fa-chart-simple"></i></span>
                            Laporan
                        </a>
                        <a href="targetTabungan.jsp">
                            <span class="icon"><i class="fas fa-bullseye"></i></span>
                            Target Tabungan
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
                <%@ page session="true" %>
                <%
                    String username = (String) session.getAttribute("username");
                    if (username == null) {
                        response.sendRedirect("login.jsp");
                        return;
                    }
                %>

                <h1>Welcome to MoneyMate Dashboard</h1>
                <h3 style="margin-bottom: 40px;">Ringkasan keuangan, <%= username%> !</h3>

                <div class="cards">
                    <div class="card blue">
                        <h3>Total Pemasukan</h3>
                        <div class="amount">Rp <%= String.format("%,.0f", totalPemasukan) %></div>
                    </div>
                    <div class="card red">
                        <h3>Total Pengeluaran</h3>
                        <div class="amount">Rp <%= String.format("%,.0f", totalPengeluaran) %></div>
                    </div>
                    <div class="card yellow">
                        <h3>Total Saldo</h3>
                        <div class="amount">Rp <%= String.format("%,.0f", totalSaldo) %></div>
                    </div>
                </div>


                <div class="chart-container">
                    <h3 style="margin-bottom: 20px;">Grafik Keuangan Bulanan</h3>
                    <canvas id="financeChart" width="400" height="400"></canvas>
                </div>

                        <script>
                            const ctx = document.getElementById('financeChart').getContext('2d');
                            const financeChart = new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'],
                                    datasets: [
                                        {
                                            label: 'Pemasukan',
                                            data: [
                                            <%= pemasukanBulanan[0]%>, <%= pemasukanBulanan[1]%>, <%= pemasukanBulanan[2]%>,
                                            <%= pemasukanBulanan[3]%>, <%= pemasukanBulanan[4]%>, <%= pemasukanBulanan[5]%>,
                                            <%= pemasukanBulanan[6]%>, <%= pemasukanBulanan[7]%>, <%= pemasukanBulanan[8]%>,
                                            <%= pemasukanBulanan[9]%>, <%= pemasukanBulanan[10]%>, <%= pemasukanBulanan[11]%>
                                            ],
                                            backgroundColor: '#4CAF50'
                                        },
                                        {
                                            label: 'Pengeluaran',
                                            data: [
                                            <%= pengeluaranBulanan[0]%>, <%= pengeluaranBulanan[1]%>, <%= pengeluaranBulanan[2]%>,
                                            <%= pengeluaranBulanan[3]%>, <%= pengeluaranBulanan[4]%>, <%= pengeluaranBulanan[5]%>,
                                            <%= pengeluaranBulanan[6]%>, <%= pengeluaranBulanan[7]%>, <%= pengeluaranBulanan[8]%>,
                                            <%= pengeluaranBulanan[9]%>, <%= pengeluaranBulanan[10]%>, <%= pengeluaranBulanan[11]%>
                                            ],
                                            backgroundColor: '#F44336'
                                        }
                                    ]
                                },
                                options: {
                                    responsive: true,
                                    scales: {
                                        y: {
                                            beginAtZero: true
                                        }
                                    }
                                }
                            });
                        </script>

            </main>
        </div>
    </body>
</html>
