<%-- 
    Document   : login
    Created on : May 31, 2025, 6:20:32?PM
    Author     : Lenovo
--%>

<%@page language="java" %>
<%@page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Login - MoneyMate</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            h1 {
                margin-top: 18%;
                font-size: 4em;
                color: black;
            }
            .h4 {
                margin-left: 75%;
                color: #8D8D8D ;
            }
            .center-container {
                display: flex;
                flex-direction: column;
                text-align: center; 
                width: 65vh;
                margin-left: 150px;
                margin-top: 40px;
                justify-content: center; /* Horizontal center */
                align-items: center;     /* Vertical center */
            }
            .bagian-kiri {
                display: flex;
                flex-direction: column;
                height: 100vh;
                width: 150vh;
                padding: 50px;
                margin-left: 20px;
            }
            .bagian-luar-kanan{
                margin-top: 50px;
            }
            .bagian-kanan {
                display: flex;
                flex-direction: column;
                width: 100vh;
                padding-left: 100px;
                justify-content: center;
                margin-left: -30px;
                margin-right: -50px;
                
            }
            .bagian-semua {
                flex-direction: row;
                width: 200vh;
                display: flex;
            }
            .btn-ungu {
                background-color: #6665E7;
                font-size: 20px;
                color: white;
                padding: 15px;
                margin-top: 50px;
            }
            .text-input {
                padding: 10px;
            }
            .mt-10{
                margin-top: 20px;
            }
            .ml-30{
                margin-left: 60px;
            }
                     
        </style>
    </head>
    <body>
        <div class="bagian-semua">
            <div class="bagian-kiri">
                <img src="MoneyMate.png" class="ml-30" alt="moneymate" width="200">
                <img src="login_money.png" class=" center-container" alt="loginimage" width="500">
            </div>
            <div class="bagian-luar-kanan">
                <h4 class="h4">New User? <a href="register.jsp" >Sign Up</a></h4>
                <div class="bagian-kanan">
                    <h1>Welcome Back!</h1>
                    <p class="mb-5">Login to continue</p>
                    <% 
                        String msg = request.getParameter("msg");
                        if ("registered".equals(msg)) {
                    %>
                        <div style="color: green; background: #d4edda; padding: 10px; border-radius: 5px; margin-bottom: 10px;">
                            Registrasi berhasil! Silakan login.
                        </div>
                    <% 
                        } else if ("error".equals(msg)) {
                    %>
                        <div style="color: red; background: #f8d7da; padding: 10px; border-radius: 5px; margin-bottom: 10px;">
                            An error occurred. Please try again.
                        </div>
                    <%
                        }
                    %>

                    <form action="LoginServlet" method="post">
                        <div class="mb-3 mt-10">
                            <label>Email</label>
                            <input type="email" name="email" placeholder="Input your email" class="form-control text-input" required />
                        </div>
                        <div class="mb-3 mt-10">
                            <label>Password</label>
                            <input type="password" name="password" placeholder="Input your password" class="form-control text-input" required />
                        </div>
                        <button type="submit" class="btn w-100 btn-ungu">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
