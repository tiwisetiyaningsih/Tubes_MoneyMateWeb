<%@page import="model.targetTabungan"%>
<%@page import="model.targetTabunganDAO"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="util.KoneksiDB" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page session="true" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Target Tabungan - MoneyMate</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            /* Styling yang sudah ada tetap sama */
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

            .content {
                flex: 1;
                background-color: #f4f4ff;
                padding: 40px;
            }

            .card-container {
                background-color: white;
                padding: 20px;
                border-radius: 15px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            }

            .tabungan-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
                padding: 15px 20px;
                background-color: #f9f9ff;
                border-left: 6px solid #8d83ff;
                border-radius: 10px;
            }

            .tabungan-item h4 {
                margin: 0;
                font-size: 18px;
                color: #444;
            }

            .tabungan-item span {
                font-weight: bold;
                color: #333;
            }

            .btn-tambah {
                display: inline-block;
                margin-bottom: 20px;
                background-color: #8d83ff;
                color: white;
                padding: 10px 18px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 600;
                transition: background-color 0.2s;
            }

            .btn-tambah:hover {
                background-color: #6a61e8;
            }

            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
                padding-top: 60px;
            }

            .modal-content {
                background-color: #fefefe;
                margin: 5% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 400px;
                border-radius: 10px;
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

            .form-container {
                background-color: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
                max-width: 500px;
                margin: 20px auto;
            }

            .form-container input {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border-radius: 8px;
                border: 1px solid #ccc;
                font-size: 16px;
            }

            .form-container button {
                background-color: #8d83ff;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                width: 100%;
            }

            .form-container button:hover {
                background-color: #6a61e8;
            }
        </style>
    </head>
    <body>
        <div class="dashboard">
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
                        <a href="tagihan">
                            <span class="icon"><i class="fas fa-file-invoice-dollar"></i></span>
                            Tagihan
                        </a>
                        <a href="laporan.jsp">
                            <span class="icon"><i class="fas fa-chart-simple"></i></span>
                            Laporan
                        </a>
                        <a href="#" class="active">
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
                    <a href="login.jsp">
                        <span class="icon"><i class="fas fa-sign-out-alt"></i></span>
                        Sign Out
                    </a>
                </div>
            </aside>

            <main class="content">
                <h1>Target Tabungan</h1>
                <h3>Daftar target keuangan</h3>

                <!-- Form untuk menambahkan target tabungan -->
                <a href="targetTabungan.jsp?add=true" class="btn-tambah"><i class="fas fa-plus-circle"></i> Tambah Target</a>

                <%
                    if ("true".equals(request.getParameter("add"))) {
                %>
                <div class="form-container">
                    <h2>Tambah Target Tabungan</h2>
                    <form action="targetTabunganServlet" method="post">
                        <label for="namaTarget">Nama Target:</label>
                        <input type="text" id="namaTarget" name="namaTarget" placeholder="Masukkan Nama Target" required />

                        <label for="jumlahTarget">Jumlah Target:</label>
                        <input type="number" id="jumlahTarget" name="jumlahTarget" placeholder="Masukkan Jumlah Target" required />

                        <label for="jumlahdikumpulkan">Jumlah Dikumpulkan:</label>
                        <input type="number" id="jumlahdikumpulkan" name="jumlahdikumpulkan" placeholder="Masukkan Jumlah Dikumpulkan" required />

                        <button type="submit"><i class="fas fa-check-circle"></i> Simpan Target</button>
                    </form>
                </div>
                <% } %>

                <%
                    // Menampilkan daftar target tabungan yang sudah disimpan
                    targetTabunganDAO dao = new targetTabunganDAO();
                    List<targetTabungan> targets = dao.getAll(); // Mendapatkan semua target tabungan dari database
                    if (targets.isEmpty()) {
                        out.println("<p>Tidak ada target tabungan yang ditemukan.</p>");
                    } else {
                        for (targetTabungan target : targets) {
                %>
                <div class="tabungan-item">
                    <h4><%= target.getNamaTarget()%></h4>
                    <span>Rp <%= target.getJumlahDikumpulkan()%> / Rp <%= target.getJumlahTarget()%></span>

                    <!-- Edit Button -->
                    <a href="targetTabunganServlet?edit=<%= target.getId()%>" class="btn-edit"><i class="fas fa-edit"></i> Edit</a>
                    <a href="targetTabunganServlet?delete=<%= target.getId()%>" class="btn-hapus"><i class="fas fa-trash"></i> Hapus</a>
                </div>
                <% }
                } %>

                <%

                    String editId = request.getParameter("edit");
                    if (editId != null) {
                        int id = Integer.parseInt(editId);
                        targetTabungan target = dao.getById(id);
                %>
                <!-- Form untuk mengedit target tabungan -->
                <div class="form-container">
                    <h2>Edit Target Tabungan</h2>
                    <form action="targetTabunganServlet" method="post">
                        <input type="hidden" name="id" value="<%= target.getId()%>" />

                        <label for="namaTarget">Nama Target:</label>
                        <input type="text" id="namaTarget" name="namaTarget" value="<%= target.getNamaTarget()%>" required />

                        <label for="jumlahTarget">Jumlah Target:</label>
                        <input type="number" id="jumlahTarget" name="jumlahTarget" value="<%= target.getJumlahTarget()%>" required />

                        <label for="jumlahdikumpulkan">Jumlah Dikumpulkan:</label>
                        <input type="number" id="jumlahdikumpulkan" name="jumlahdikumpulkan" value="<%= target.getJumlahDikumpulkan()%>" required />

                        <button type="submit"><i class="fas fa-check-circle"></i> Simpan Perubahan</button>
                    </form>
                </div>
                <% }%>
            </main>
        </div>
    </body>
</html>