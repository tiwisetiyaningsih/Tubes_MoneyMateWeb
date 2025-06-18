package controller;

import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import model.Transaksi;
import model.TransaksiDAO;

@WebServlet("/TransaksiServlet")
public class TransaksiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                if (TransaksiDAO.deleteTransaksi(id) > 0) {
                    response.sendRedirect("transaksi.jsp");
                } else {
                    request.setAttribute("errorMessage", "Gagal menghapus transaksi.");
                    request.getRequestDispatcher("transaksi.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("transaksi.jsp");
            }
        } else if ("editForm".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Transaksi transaksi = TransaksiDAO.getTransaksiById(id);
            request.setAttribute("transaksi", transaksi);
            request.getRequestDispatcher("transaksi.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            try {
                double jumlah = Double.parseDouble(request.getParameter("jumlah"));
                String deskripsi = request.getParameter("deskripsi");
                String tanggalStr = request.getParameter("tanggal");
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                Date tanggal = formatter.parse(tanggalStr);
                String tipe = request.getParameter("tipe");
                String kategoriIdString = request.getParameter("kategori_id");

                if (kategoriIdString == null || kategoriIdString.isEmpty()) {
                    request.setAttribute("errorMessage", "Kategori harus dipilih.");
                    request.getRequestDispatcher("transaksi.jsp").forward(request, response);
                    return;
                }

                int kategori_id = Integer.parseInt(kategoriIdString);
                if (kategori_id <= 0) {
                    request.setAttribute("errorMessage", "Kategori tidak valid.");
                    request.getRequestDispatcher("transaksi.jsp").forward(request, response);
                    return;
                }

                jumlah = Math.abs(jumlah);

                HttpSession session = request.getSession();
                Integer userId = (Integer) session.getAttribute("id");

                if (userId == null) {
                    request.setAttribute("errorMessage", "Anda harus login untuk melakukan transaksi.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }

                Transaksi transaksi = new Transaksi(0, jumlah, deskripsi, tanggal, tipe, kategori_id, userId);

                if (TransaksiDAO.addTransaksi(transaksi) > 0) {
                    request.setAttribute("successMessage", "Transaksi berhasil disimpan.");
                    request.getRequestDispatcher("transaksi.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Gagal menyimpan transaksi.");
                    request.getRequestDispatcher("transaksi.jsp").forward(request, response);
                }

            } catch (NumberFormatException | ParseException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Input jumlah, kategori, atau tanggal tidak valid.");
                request.getRequestDispatcher("transaksi.jsp").forward(request, response);
            }
        } else if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                double jumlah = Double.parseDouble(request.getParameter("jumlah"));
                String deskripsi = request.getParameter("deskripsi");
                String tanggalStr = request.getParameter("tanggal");
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                Date tanggal = formatter.parse(tanggalStr);
                String tipe = request.getParameter("tipe");
                int kategori_id = Integer.parseInt(request.getParameter("kategori_id"));

                HttpSession session = request.getSession();
                Integer userId = (Integer) session.getAttribute("id");

                Transaksi transaksi = new Transaksi(id, jumlah, deskripsi, tanggal, tipe, kategori_id, userId);

                if (TransaksiDAO.updateTransaksi(transaksi) > 0) {
                    response.sendRedirect("transaksi.jsp");
                } else {
                    request.setAttribute("errorMessage", "Gagal mengupdate transaksi.");
                    request.getRequestDispatcher("transaksi.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Data tidak valid.");
                request.getRequestDispatcher("transaksi.jsp").forward(request, response);
            }
        }
    }
}
