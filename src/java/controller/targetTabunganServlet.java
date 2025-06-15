package controller;

import model.targetTabunganDAO;
import model.targetTabungan;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.List;

public class targetTabunganServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            
            // Ambil data dari form
            String namaTarget = req.getParameter("namaTarget");
            String jumlahTargetStr = req.getParameter("jumlahTarget");

            // Validasi input
            if (namaTarget == null || namaTarget.trim().isEmpty() || jumlahTargetStr == null || jumlahTargetStr.trim().isEmpty()) {
                req.setAttribute("error", "Semua field harus diisi!");
                req.getRequestDispatcher("/model/target-form.jsp").forward(req, res);
                return;
            }

            // Konversi jumlahTarget menjadi angka
            double jumlahTarget = Double.parseDouble(jumlahTargetStr);

            // Membuat objek TargetTabungan
            targetTabungan target = new targetTabungan(namaTarget, jumlahTarget); 

            // Menggunakan DAO untuk menyimpan target ke database
            targetTabunganDAO dao = new targetTabunganDAO();
            dao.insert(target);

            // Redirect ke halaman daftar target setelah data disimpan
            res.sendRedirect(req.getContextPath() + "/targetTabunganServlet");

        } catch (Exception e) {
            req.setAttribute("error", "Terjadi kesalahan saat menyimpan data: " + e.getMessage());
            req.getRequestDispatcher("/model/target-form.jsp").forward(req, res);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            // Mengambil data target tabungan menggunakan DAO
            targetTabunganDAO dao = new targetTabunganDAO();
            List<targetTabungan> targets = dao.getAll();
            req.setAttribute("targets", targets);

            // Forward ke halaman untuk menampilkan daftar target
            req.getRequestDispatcher("/model/target-list.jsp").forward(req, res);
        } catch (SQLException e) {
            req.setAttribute("error", "Terjadi kesalahan saat mengambil data: " + e.getMessage());
            req.getRequestDispatcher("/model/target-list.jsp").forward(req, res);
        }
    }
     
    // Method untuk mengedit target tabungan
protected void editTarget(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
    try {
        int id = Integer.parseInt(req.getParameter("id"));
        String namaTarget = req.getParameter("namaTarget");
        double jumlahTarget = Double.parseDouble(req.getParameter("jumlahTarget"));
        double jumlahdikumpulkan = Double.parseDouble(req.getParameter("jumlahdikumpulkan"));

        // Validasi input
        if (namaTarget == null || namaTarget.trim().isEmpty()) {
            req.setAttribute("error", "Nama target harus diisi!");
            req.getRequestDispatcher("/model/target-form.jsp").forward(req, res);
            return;
        }

        // Membuat objek TargetTabungan dengan konstruktor yang sesuai
        targetTabungan target = new targetTabungan(id, namaTarget, jumlahTarget, jumlahdikumpulkan);

        // Menggunakan DAO untuk memperbarui target di database
        targetTabunganDAO dao = new targetTabunganDAO();
        dao.update(target);

        // Redirect ke halaman daftar target setelah data diperbarui
        res.sendRedirect(req.getContextPath() + "/targetTabunganServlet");

    } catch (Exception e) {
        req.setAttribute("error", "Terjadi kesalahan saat mengedit data: " + e.getMessage());
        req.getRequestDispatcher("/model/target-form.jsp").forward(req, res);
    }
}
    
}