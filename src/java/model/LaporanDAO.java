package model;

import java.sql.*;
import java.util.*;
import util.KoneksiDB;

public class LaporanDAO {
    public void insertLaporan(double pemasukan, double pengeluaran, int transaksiId) {
        String sql = "INSERT INTO laporan (totalPemasukan, totalPengeluaran, transaksi) VALUES (?, ?, ?)";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, pemasukan);
            ps.setDouble(2, pengeluaran);
            ps.setInt(3, transaksiId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Map<String, Object>> getLaporanByMonth(int month, int year) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT * FROM laporan l JOIN transaksi t ON l.transaksi = t.id WHERE MONTH(t.tanggal) = ? AND YEAR(t.tanggal) = ?";

        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, month);
            ps.setInt(2, year);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("tanggal", rs.getDate("t.tanggal"));
                map.put("deskripsi", rs.getString("t.deskripsi"));
                map.put("jenis", rs.getString("t.jenis"));
                map.put("jumlah", rs.getDouble("t.jumlah"));
                map.put("totalPemasukan", rs.getDouble("l.totalPemasukan"));
                map.put("totalPengeluaran", rs.getDouble("l.totalPengeluaran"));
                list.add(map);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Map<String, Object>> getTransaksiByMonth(int bulan, int tahun) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}