<%-- 
    Document   : profile.
    Created on : Jun 5, 2025, 7:25:49?PM
    Author     : Lenovo
--%>

<%@page language="java" %>
<%@page session="true" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Profile - MoneyMate</title>
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
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .profile-container {
                background-color: #eae7ff;
                padding: 40px;
                border-radius: 20px;
                width: 100%;
                max-width: 500px;
                text-align: center;
                box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            }

            .profile-icon {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                background-color: #ddd;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 60px;
                color: #555;
                margin: 0 auto 20px;
            }

            .profile-container h2 {
                margin: 10px 0 5px;
            }

            .profile-container p {
                font-size: 14px;
                color: #777;
                margin-bottom: 30px;
            }

            .profile-container label {
                display: block;
                text-align: left;
                margin-bottom: 5px;
                font-size: 14px;
                font-weight: 500;
            }

            .info-box {
                width: 100%;
                background-color: white;
                padding: 10px 15px;
                border-radius: 10px;
                margin-bottom: 20px;
                text-align: left;
                font-size: 14px;
                color: #444;
                border: 1px solid #ccc;
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
                        <a href="dashboard.jsp">
                            <span class="icon"><i class="fas fa-chart-pie"></i></span>
                            Dashboard
                        </a>
                        <a href="transaksi.jsp">
                            <span class="icon"><i class="fas fa-wallet"></i></span>
                            Transactions
                        </a>
                        <a href="laporan.jsp">
                            <span class="icon"><i class="fas fa-chart-simple"></i></span>
                            Laporan
                        </a>
                        <a href="targetTabungan.jsp">
                            <span class="icon"><i class="fas fa-bullseye"></i></span>
                            Target Tabungan
                        </a>
                        <a href="#" class="active">
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
                    String email = (String) session.getAttribute("email");
                    if (username == null || email == null) {
                        response.sendRedirect("login.jsp");
                        return;
                    }
                %>
                <div class="profile-container">
                    <div class="profile-icon">
                        <i class="fas fa-user"></i>
                    </div>
                    <h2><%= username %></h2>
                    <p>Profile Information</p>
                    <label>Username</label>
                    <div class="info-box"><%= username %></div>
                    <label>Email</label>
                    <div class="info-box"><%= email %></div>
                </div>
            </main>
        </div>
    </body>
</html>
