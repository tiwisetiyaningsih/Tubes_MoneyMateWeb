package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import util.KoneksiDB;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection conn = KoneksiDB.getConnection();

            // Cek apakah email sudah digunakan
            String cekQuery = "SELECT * FROM user WHERE email = ?";
            PreparedStatement cekStmt = conn.prepareStatement(cekQuery);
            cekStmt.setString(1, email);
            ResultSet rs = cekStmt.executeQuery();

            if (rs.next()) {
                // Email sudah terdaftar
                response.sendRedirect("register.jsp?msg=exist");
            } else {
                // Insert ke database
                String query = "INSERT INTO user(username, email, password) VALUES (?, ?, ?)";
                PreparedStatement pst = conn.prepareStatement(query);
                pst.setString(1, username);
                pst.setString(2, email);
                pst.setString(3, password); // bisa di-hash nanti

                int row = pst.executeUpdate();
                if (row > 0) {
                    // Berhasil register, arahkan ke login
                    response.sendRedirect("login.jsp?msg=registered");
                } else {
                    // Gagal insert
                    response.sendRedirect("register.jsp?msg=error");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?msg=error");
        }
    }
}
