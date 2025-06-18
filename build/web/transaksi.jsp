<%-- 
    Document   : transaksi
    Created on : May 31, 2025, 6:21:10?PM
    Author     : Lenovo
--%>

<%@page import="model.Kategori"%>
<%@page import="model.KategoriDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.Transaksi" %>
<%@ page import="model.TransaksiDAO" %>
<%@ page import="model.KategoriDAO" %>
<%@ page import="model.Kategori" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<%
    HttpSession sessionUser = request.getSession();
    Integer userId = (Integer) sessionUser.getAttribute("id");

    String filterTipe = request.getParameter("filterType");
    String filterMonth = request.getParameter("filterMonth");

    Calendar cal = Calendar.getInstance();
    int month = (filterMonth != null && !filterMonth.isEmpty()) ? Integer.parseInt(filterMonth.split("-")[1]) : cal.get(Calendar.MONTH) + 1;
    int year = (filterMonth != null && !filterMonth.isEmpty()) ? Integer.parseInt(filterMonth.split("-")[0]) : cal.get(Calendar.YEAR);

    double pemasukan = TransaksiDAO.getTotalByUserMonthYearAndTipe(userId, month, year, "Pemasukan");
    double pengeluaran = TransaksiDAO.getTotalByUserMonthYearAndTipe(userId, month, year, "Pengeluaran");
    double saldo = pemasukan - pengeluaran;

    List<Transaksi> transaksiListByFilter = TransaksiDAO.getTransaksiByUserAndFilter(userId, month, year, filterTipe);
%>

<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Transactions - MoneyMate</title>
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
                height: 250px;
                flex-direction: column;
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
    </head>
    <!-- Modal -->
    <div id="modal" style="display:none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 1000;">
        <div style="background: white; width: 400px; margin: 10% auto; padding: 30px; border-radius: 10px; position: relative;">
            <!-- Tombol close -->
            <span onclick="document.getElementById('modal').style.display='none'" 
                  style="position:absolute; top:10px; right:15px; font-size:18px; cursor:pointer;">&times;</span>
                  <%-- Menampilkan pesan sukses jika ada --%>
                  <%
                      String successMessage = (String) request.getAttribute("successMessage");
                      if (successMessage != null) {
                  %>
                  <script>
                        alert("<%= successMessage%>");
                  </script>
                  <%
                      }
                  %>

                  <%-- Menampilkan pesan error jika ada --%>
                  <%
                      String errorMessage = (String) request.getAttribute("errorMessage");
                      if (errorMessage != null) {
                  %>
                  <script>
                        alert("<%= errorMessage%>");
                  </script>
                  <%
                      }
                  %>

            <h3 style="margin-bottom: 20px;">Tambah Transaksi</h3>
            <form action="TransaksiServlet" method="post">
                <input type="hidden" name="action" value="add" />
                <label>Judul:</label><br>
                <input type="text" name="deskripsi" required style="width:100%; padding:8px; margin-bottom:10px;" /><br>

                <label>Tanggal:</label><br>
                <input type="date" name="tanggal" required style="width:100%; padding:8px; margin-bottom:10px;" /><br>

                <label>Jumlah:</label><br>
                <input type="number" name="jumlah" required style="width:100%; padding:8px; margin-bottom:10px;" /><br>
                
                <label>Tipe:</label><br>
                <select name="tipe" required style="width:100%; padding:8px; margin-bottom:20px;">
                    <option value="">-- Pilih --</option>
                    <option value="Pemasukan">Pemasukan</option>
                    <option value="Pengeluaran">Pengeluaran</option>
                </select><br>
                <label>Kategori:</label><br>
                <select name="kategori_id" required style="width:100%; padding:8px; margin-bottom:20px;">
                    <option value="">Pilih Kategori</option>
                    <% 
                        List<Kategori> kategoriList = KategoriDAO.getAllKategori();
                        for (Kategori kategori : kategoriList) {
                    %>
                        <option value="<%= kategori.getId() %>"><%= kategori.getNamaKategori() %></option>
                    <% 
                        }  // Pastikan blok 'for' ini ditutup dengan benar
                    %>
                </select><br>

                <button type="submit" style="padding: 10px 20px; background-color: #8d83ff; color: white; border: none; border-radius: 6px;">Simpan</button>
            </form>
        </div>
    </div>
    <%-- end Modul Tambah Transaksi --%>
    
    <script>
        window.onclick = function(event) {
            var modal = document.getElementById('modal');
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
    <script>
        function confirmLogout() {
            return confirm("Apakah Anda yakin ingin logout?");
        }
    </script>
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
                        <a href="transaksi.jsp" class="active">
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

            <!-- Content -->
            <main class="content">
                <div class="card_saldo">
                    <div>
                        <h2 style="margin-left: 50px; margin-bottom: 5px; color: #494854; font-size: 20px;">Total Balance</h2>
                        <h1 style="margin-left: 50px; margin-bottom: 80px; font-size: 28px; font-weight: bold;">Rp <%= String.format("%,.2f", saldo) %>,-</h1>
                    </div>
                </div>
                
                <!-- Form Tambah Transaksi -->
                <div class="card1" style="margin-top: -60px;">
                    <div class="card blue">
                        <h3>Total Pemasukan</h3>
                        <div class="amount2">Rp <%= String.format("%,.0f", pemasukan) %></div>
                    </div>
                    <div class="card red">
                        <h3>Total Pengeluaran</h3>
                        <div class="amount2">Rp <%= String.format("%,.0f", pengeluaran)%></div>
                    </div>
                </div>
                

                <div style="margin-top: 20px; padding-left: 50px; padding-right: 50px; display: flex; justify-content: flex-end;">
                    <!-- Tombol buka modal -->
                    <button onclick="document.getElementById('modal').style.display='block'" style="margin: 20px 0; padding: 10px 20px; background-color: #8d83ff; color: white; border: none; border-radius: 8px; cursor: pointer; font-size: 20px;">
                        + Tambah Transaksi
                    </button>
                </div>
                
                <!-- Filter transaksi -->
                
                <div class="card" style="margin-top: 20px;">
                    <h3 style="margin-bottom: 18px; font-size: 22px;">Filter Transaksi</h3>
                    <form method="get" action="transaksi.jsp" style="display: flex; gap: 15px; align-items: center;">
                        <label for="filterType" style="font-size: 18px;">Tipe:</label>
                        <select style=" padding:5px;" class="form-select" name="filterType" id="filterType">
                            <option value="">Semua</option>
                            <option value="Pemasukan" <%= "Pemasukan".equals(request.getParameter("filterType")) ? "selected" : ""%>>Pemasukan</option>
                            <option value="Pengeluaran" <%= "Pengeluaran".equals(request.getParameter("filterType")) ? "selected" : ""%>>Pengeluaran</option>
                        </select>

                        <label style="margin-left: 25px; font-size: 18px;" for="filterMonth">Bulan:</label>
                        <input style=" padding:5px;" type="month" name="filterMonth" id="filterMonth" value="<%= filterMonth != null ? filterMonth : ""%>"/>

                        <button type="submit" style="background:#8d83ff; color:#fff; border:none; border-radius:8px; padding:8px 25px;">Filter</button>
                    </form>
                </div>
                
                        <%
                            Transaksi t = (Transaksi) request.getAttribute("transaksi");
                            if (t != null) {
                                List<Kategori> kategori = KategoriDAO.getAllKategori();
                        %>
                        <!-- Form untuk mengedit target tabungan -->
                        <div class="form-container card" style="margin-top: 20px;">
                            <h2>Edit Transaksi</h2>
                            <form action="TransaksiServlet" method="post">
                                <input type="hidden" name="action" value="update" />
                                <input type="hidden" name="id" value="<%= t.getId()%>" />

                                <label>Judul:</label>
                                <input type="text" name="deskripsi" value="<%= t.getDeskripsi()%>" required 
                                       style="width:100%; padding:8px; margin-bottom:10px;"/>

                                <label>Tanggal:</label>
                                <input type="date" name="tanggal" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(t.getTanggal())%>" required 
                                       style="width:100%; padding:8px; margin-bottom:10px;"/>

                                <label>Jumlah:</label>
                                <input type="number" name="jumlah" value="<%= String.format("%.0f", t.getJumlah())%>" required 
                                       style="width:100%; padding:8px; margin-bottom:10px;"/>

                                <label>Tipe:</label>
                                <select name="tipe" required style="width:100%; padding:8px; margin-bottom:10px;">
                                    <option value="Pemasukan" <%= "Pemasukan".equals(t.getTipe()) ? "selected" : ""%>>Pemasukan</option>
                                    <option value="Pengeluaran" <%= "Pengeluaran".equals(t.getTipe()) ? "selected" : ""%>>Pengeluaran</option>
                                </select>

                                <label>Kategori:</label>
                                <select name="kategori_id" required style="width:100%; padding:8px; margin-bottom:10px;">
                                    <% for (Kategori k : kategori) {
                                            String selected = (t.getKategori_id() == k.getId()) ? "selected" : "";
                                    %>
                                    <option value="<%= k.getId()%>" <%= selected%>><%= k.getNamaKategori()%></option>
                                    <% } %>
                                </select>

                                <button type="submit" style="background:#8d83ff; color:#fff; border:none; border-radius:8px; padding:8px 25px;"><i class="fas fa-check-circle"></i> Simpan Perubahan</button>
                            </form>
                        </div>
                        <% }%>

                <!-- Daftar Transaksi -->
                <div class="card" style="margin-top: 20px;">
                    <h3 style="margin-bottom: 18px; font-size: 22px;">Catatan Transaksi</h3>

                    <%
                        // Menampilkan semua transaksi
                        List<Transaksi> transaksiList = transaksiListByFilter; // Mendapatkan semua transaksi
                    %>
                    <% if (transaksiList.isEmpty()) { %>
                    <div style="padding: 20px; font-size: 18px; color: gray;">
                        Tidak ada transaksi untuk filter yang dipilih.
                    </div>
                    <% } else {
                        for (Transaksi transaksi : transaksiList) {
                            String amountClass = "expense";
                            String sign = "";

                            if ("Pemasukan".equals(transaksi.getTipe())) {
                                amountClass = "income";
                                sign = "+";
                            } else if ("Pengeluaran".equals(transaksi.getTipe())) {
                                amountClass = "expense";
                                sign = "-";
                            }

                            double absAmount = transaksi.getJumlah();
                    %>

                    <div class="transaction-item">
                        <div class="info">
                            <div class="icon"></div>
                            <div>
                                <div class="label"><%= transaksi.getDeskripsi() %></div>
                                <div class="date"><%= transaksi.getTanggal() %></div>
                            </div>
                        </div>
                        <div class="amount <%= amountClass %>"><%= sign %>Rp <%= String.format("%,d", (int) absAmount) %>.00</div>
                        <div>
                            <a href="TransaksiServlet?action=editForm&id=<%= transaksi.getId()%>">Edit</a>
                            <!-- Link delete -->
                            <a href="TransaksiServlet?action=delete&id=<%= transaksi.getId()%>" onclick="return confirm('Hapus transaksi ini?')">Hapus</a>
                        </div>
                    </div>
                    <%
                        }
                        }
                    %>
                </div>
            </main>
        </div>
    </body>
</html>