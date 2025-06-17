/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


import model.targetTabungan;
import java.sql.*;
import util.KoneksiDB;
import java.util.ArrayList;
import java.util.List;

public class targetTabunganDAO {

    // Method untuk menyimpan target tabungan ke database
    public void insert(targetTabungan target) throws SQLException {
        String sql = "INSERT INTO targettabungan (namaTarget, jumlahTarget, jumlahdikumpulkan) VALUES (?, ?, ?)";
        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, target.getNamaTarget());
            stmt.setDouble(2, target.getJumlahTarget());
            stmt.setDouble(3, target.getJumlahDikumpulkan());  // Nilai default 0
            stmt.executeUpdate();
        }
        
    }
    

    // Method untuk mengambil semua target tabungan
    public List<targetTabungan> getAll() throws SQLException {
        List<targetTabungan> targets = new ArrayList<>();
        String sql = "SELECT * FROM targettabungan";
        
        try (Connection conn = KoneksiDB.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                targetTabungan target = new targetTabungan();
                target.setId(rs.getInt("id"));
                target.setNamaTarget(rs.getString("nama_target"));
                target.setJumlahTarget(rs.getDouble("jumlah_target"));
                target.setJumlahDikumpulkan(rs.getDouble("jumlah_dikumpulkan"));
                targets.add(target);
            }
        }
        return targets;
    }
}