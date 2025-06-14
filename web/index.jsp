<%-- 
    Document   : index.jsp
    Created on : May 31, 2025, 6:20:13 PM
    Author     : Lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="refresh" content="2;url=login.jsp">
        <title>MoneyMate</title>
        <style>
            body {
                text-align: center;
                font-family: Arial;
            }
            h1 {
                margin-top: 20%;
                font-size: 3em;
                color: maroon;
            }
            .center-container {
                display: flex;
                flex-direction: column;
                text-align: center;
                height: 100vh; 
                justify-content: center; /* Horizontal center */
                align-items: center;     /* Vertical center */
            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    </head>
    <body>
        <div class="center-container">
            <img src="piggy.png" alt="moneymate piggy" width="400">
            <img src="MoneyMate.png" alt="moneymate" width="500">
            <p class="mt-4">Loading...</p>
        </div>
    </body>
</html>
