package controller;

import model.TransaksiDAO;
import model.Transaksi;
import model.Laporan;
import model.LaporanDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.servlet.RequestDispatcher;

@WebServlet("/laporan")
public class LaporanServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bulanParam = request.getParameter("month");
        String tahunParam = request.getParameter("year");

        int bulan = bulanParam != null ? Integer.parseInt(bulanParam) : -1;
        int tahun = tahunParam != null ? Integer.parseInt(tahunParam) : -1;

        LaporanDAO laporanDAO = new LaporanDAO();
        List<Map<String, Object>> transaksiList = laporanDAO.getTransaksiByMonth(bulan, tahun);

        double totalPemasukan = 0;
        double totalPengeluaran = 0;
        for (Map<String, Object> trx : transaksiList) {
            String jenis = (String) trx.get("jenis");
            Double jumlah = (Double) trx.get("jumlah");
            if ("pemasukan".equalsIgnoreCase(jenis)) {
                totalPemasukan += jumlah;
            } else if ("pengeluaran".equalsIgnoreCase(jenis)) {
                totalPengeluaran += jumlah;
            }
        }

        double saldo = totalPemasukan - totalPengeluaran;

        request.setAttribute("transaksiList", transaksiList);
        request.setAttribute("totalPemasukan", totalPemasukan);
        request.setAttribute("totalPengeluaran", totalPengeluaran);
        request.setAttribute("saldo", saldo);

        RequestDispatcher dispatcher = request.getRequestDispatcher("laporan.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
