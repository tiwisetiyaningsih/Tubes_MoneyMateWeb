package controller;

import model.targetTabunganDAO;
import model.targetTabungan;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.List;
import javax.servlet.annotation.WebServlet;

@WebServlet("/targetTabunganServlet")
public class targetTabunganServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");

            String namaTarget = req.getParameter("namaTarget");
            String jumlahTargetStr = req.getParameter("jumlahTarget");
            String jumlahdikumpulkanStr = req.getParameter("jumlahdikumpulkan");
            String targetIdStr = req.getParameter("id");

            if (namaTarget == null || namaTarget.trim().isEmpty() || jumlahTargetStr == null || jumlahTargetStr.trim().isEmpty()) {
                req.setAttribute("error", "Semua field harus diisi!");
                req.getRequestDispatcher("/targetTabungan.jsp").forward(req, res);
                return;
            }

            double jumlahTarget = Double.parseDouble(jumlahTargetStr);
            double jumlahdikumpulkan = Double.parseDouble(jumlahdikumpulkanStr);

            targetTabungan target = new targetTabungan(namaTarget, jumlahTarget);
            target.setJumlahDikumpulkan(jumlahdikumpulkan);

            targetTabunganDAO dao = new targetTabunganDAO();

            // mengecek id untuk edit
            if (targetIdStr != null && !targetIdStr.isEmpty()) {
                int id = Integer.parseInt(targetIdStr);
                target.setId(id);
                dao.update(target);
            } else {
                dao.insert(target);
            }

            res.sendRedirect(req.getContextPath() + "/targetTabunganServlet");

        } catch (Exception e) {
            req.setAttribute("error", "Terjadi kesalahan saat menyimpan data: " + e.getMessage());
            req.getRequestDispatcher("/targetTabungan.jsp").forward(req, res);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            // edit data target
            String editId = req.getParameter("edit");
            if (editId != null) {
                int id = Integer.parseInt(editId);
                targetTabunganDAO dao = new targetTabunganDAO();
                targetTabungan target = dao.getById(id);
                req.setAttribute("target", target);
                req.getRequestDispatcher("/targetTabungan.jsp").forward(req, res);
                return;
            }

            // hapus data
            String deleteId = req.getParameter("delete");
            if (deleteId != null) {
                int idToDelete = Integer.parseInt(deleteId);
                targetTabunganDAO dao = new targetTabunganDAO();
                dao.delete(idToDelete);
                res.sendRedirect(req.getContextPath() + "/targetTabunganServlet");
                return;
            }

            // mengambil semua data target tabungan
            targetTabunganDAO dao = new targetTabunganDAO();
            List<targetTabungan> targets = dao.getAll();
            req.setAttribute("targets", targets);
            req.getRequestDispatcher("/targetTabungan.jsp").forward(req, res);

        } catch (SQLException e) {
            req.setAttribute("error", "Terjadi kesalahan saat mengambil data: " + e.getMessage());
            req.getRequestDispatcher("/targetTabungan.jsp").forward(req, res);
        }
    }
}
