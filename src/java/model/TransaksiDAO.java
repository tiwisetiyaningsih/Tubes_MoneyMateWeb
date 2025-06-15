/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Lenovo
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Transaksi;
import model.Kategori;
import util.KoneksiDB;

public class TransaksiDAO {

    // Menambahkan transaksi ke database
    public static int addTransaksi(Transaksi transaksi) {
        try (Connection conn = KoneksiDB.getConnection()) {
            String sql = "INSERT INTO transaksi (jumlah, deskripsi, tanggal, tipe, kategori_id, user_id) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDouble(1, transaksi.getJumlah());
            ps.setString(2, transaksi.getDeskripsi());
            // Convert java.util.Date to java.sql.Date
            java.util.Date utilDate = transaksi.getTanggal();  // Get the Date from the Transaksi object
            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());  // Convert to java.sql.Date
            ps.setDate(3, sqlDate);  // Set the date in the PreparedStatement
            ps.setString(4, transaksi.getTipe());
            ps.setInt(5, transaksi.getKategori_id());
            ps.setInt(6, transaksi.getUser_id());
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Menghapus transaksi dari database
    public static int deleteTransaksi(int id) {
        try (Connection conn = KoneksiDB.getConnection()) {
            String sql = "DELETE FROM transaksi WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Baris dihapus: " + rowsAffected);
            return rowsAffected;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Menambahkan metode untuk mengambil transaksi berdasarkan ID
    public static Transaksi getTransaksiById(int id) {
        Transaksi transaksi = null;
        // Kode untuk mengakses database dan mengambil transaksi berdasarkan ID
        try {
            Connection conn = KoneksiDB.getConnection(); // Pastikan DBHelper sudah ada dan terkoneksi
            String sql = "SELECT * FROM transaksi WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                transaksi = new Transaksi();
                transaksi.setId(rs.getInt("id"));
                transaksi.setDeskripsi(rs.getString("deskripsi"));
                transaksi.setTanggal(rs.getDate("tanggal"));
                transaksi.setJumlah(rs.getDouble("jumlah"));
                transaksi.setTipe(rs.getString("tipe"));
                transaksi.setKategori_id(rs.getInt("kategori_id")); // Pastikan ada kolom kategori_id di DB
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transaksi;
    }

    
    public static List<Transaksi> getTransaksiByUserAndFilter(int userId, Integer month, Integer year, String tipe) {
        List<Transaksi> list = new ArrayList<>();
        try (Connection conn = KoneksiDB.getConnection()) {
            StringBuilder sql = new StringBuilder("SELECT * FROM transaksi WHERE user_id = ?");
            if (month != null && year != null) {
                sql.append(" AND MONTH(tanggal) = ? AND YEAR(tanggal) = ?");
            }
            if (tipe != null && !tipe.isEmpty()) {
                sql.append(" AND tipe = ?");
            }

            PreparedStatement ps = conn.prepareStatement(sql.toString());
            int index = 1;
            ps.setInt(index++, userId);
            if (month != null && year != null) {
                ps.setInt(index++, month);
                ps.setInt(index++, year);
            }
            if (tipe != null && !tipe.isEmpty()) {
                ps.setString(index++, tipe);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Transaksi transaksi = new Transaksi(
                        rs.getInt("id"),
                        rs.getDouble("jumlah"),
                        rs.getString("deskripsi"),
                        rs.getDate("tanggal"),
                        rs.getString("tipe"),
                        rs.getInt("kategori_id"),
                        rs.getInt("user_id")
                );
                list.add(transaksi);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static double getTotalByUserMonthYearAndTipe(int userId, int month, int year, String tipe) {
        double total = 0;
        try (Connection conn = KoneksiDB.getConnection()) {
            String sql = "SELECT SUM(jumlah) FROM transaksi WHERE user_id = ? AND MONTH(tanggal) = ? AND YEAR(tanggal) = ? AND tipe = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, month);
            ps.setInt(3, year);
            ps.setString(4, tipe);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
    
    public static List<Map<String, Object>> getTransaksiByUser(int userId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT tanggal, deskripsi, tipe AS jenis, jumlah FROM transaksi WHERE user_id = ? ORDER BY tanggal DESC";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new HashMap<>();
                    row.put("tanggal", rs.getDate("tanggal"));
                    row.put("deskripsi", rs.getString("deskripsi"));
                    row.put("jenis", rs.getString("jenis"));
                    row.put("jumlah", rs.getDouble("jumlah"));
                    list.add(row);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

}
