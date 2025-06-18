/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import util.KoneksiDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class targetTabunganDAO {

    // menyimpan target tabungan ke database
    public void insert(targetTabungan target) throws SQLException {
        String sql = "INSERT INTO targettabungan (namaTarget, jumlahTarget, jumlahdikumpulkan) VALUES (?, ?, ?)";
        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, target.getNamaTarget());
            stmt.setDouble(2, target.getJumlahTarget());
            stmt.setDouble(3, target.getJumlahDikumpulkan());
            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Gagal menyimpan data target.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Kesalahan saat menyimpan data target: " + e.getMessage());
        }
    }

    // mengambil semua target tabungan
    public List<targetTabungan> getAll() throws SQLException {
        List<targetTabungan> targets = new ArrayList<>();
        String sql = "SELECT * FROM targettabungan";

        try (Connection conn = KoneksiDB.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                targetTabungan target = new targetTabungan();
                target.setId(rs.getInt("id"));
                target.setNamaTarget(rs.getString("namaTarget"));
                target.setJumlahTarget(rs.getDouble("jumlahTarget"));
                target.setJumlahDikumpulkan(rs.getDouble("jumlahdikumpulkan"));
                targets.add(target);
            }
        }
        return targets;
    }

    // memperbarui target tabungan di database
    public void update(targetTabungan target) throws SQLException {
        String sql = "UPDATE targettabungan SET namaTarget = ?, jumlahTarget = ?, jumlahdikumpulkan = ? WHERE id = ?";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Set parameter-parameter query update
            stmt.setString(1, target.getNamaTarget()); // Nama target yang diubah
            stmt.setDouble(2, target.getJumlahTarget()); // Jumlah target yang diubah
            stmt.setDouble(3, target.getJumlahDikumpulkan()); // Jumlah yang terkumpul yang diubah
            stmt.setInt(4, target.getId()); // ID target yang akan diupdate

            // Eksekusi query update
            stmt.executeUpdate();
        }
    }
    // mengambil target tabungan berdasarkan ID

    public targetTabungan getById(int id) throws SQLException {
        targetTabungan target = null;
        String sql = "SELECT * FROM targettabungan WHERE id = ?";
        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    target = new targetTabungan();
                    target.setId(rs.getInt("id"));
                    target.setNamaTarget(rs.getString("namaTarget"));
                    target.setJumlahTarget(rs.getDouble("jumlahTarget"));
                    target.setJumlahDikumpulkan(rs.getDouble("jumlahdikumpulkan"));
                }
            }
        }
        return target;
    }

    // menghapus target tabungan di database
    public void delete(int id) throws SQLException {
        String sql = "DELETE FROM targettabungan WHERE id = ?";
        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
