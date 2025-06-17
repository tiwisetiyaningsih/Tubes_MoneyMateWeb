/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.KoneksiDB;

/**
 *
 * @author Lenovo
 */
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

public class TagihanDAO {
    private Connection conn;

    public TagihanDAO(Connection conn) {
        this.conn = conn;
    }
   
    public List<Tagihan> getAllTagihanWithReminder(int userId) throws SQLException {
        List<Tagihan> list = new ArrayList<>();
        String query = "SELECT t.*, p.reminderDate FROM tagihan t LEFT JOIN pengingat p ON t.id = p.tagihan_id WHERE t.user_id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Tagihan t = new Tagihan(
                rs.getString("namaTagihan"),
                rs.getDouble("jumlahTagihan"),
                rs.getDate("tanggalDue"),
                rs.getInt("user_id")
            );
            t.setReminderDate(rs.getDate("reminderDate"));
            t.setId(rs.getInt("id"));
            list.add(t);
        }

        return list;
    }

    public void insertTagihan(Tagihan t) throws SQLException {
        String query = "INSERT INTO tagihan (namaTagihan, jumlahTagihan, tanggalDue, user_id) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, t.getNamaTagihan());
        ps.setDouble(2, t.getJumlahTagihan());
        ps.setDate(3, new java.sql.Date(t.getTanggalDue().getTime()));
        ps.setInt(4, t.getUser_id());
        ps.executeUpdate();
    }
    
    public void deleteTagihan(int id) throws SQLException {
        String sqlDeleteReminder = "DELETE FROM pengingat WHERE tagihan_id = ?";
        try (PreparedStatement ps1 = conn.prepareStatement(sqlDeleteReminder)) {
            ps1.setInt(1, id);
            ps1.executeUpdate();
        }

        String sqlDeleteTagihan = "DELETE FROM tagihan WHERE id = ?";
        try (PreparedStatement ps2 = conn.prepareStatement(sqlDeleteTagihan)) {
            ps2.setInt(1, id);
            ps2.executeUpdate();
            }
        }   
    
//
    public Tagihan getTagihanById(int id) throws SQLException {
        String sql = "SELECT * FROM tagihan WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        Tagihan t = new Tagihan(
            rs.getString("namaTagihan"),
            rs.getDouble("jumlahTagihan"),
            rs.getDate("tanggalDue"),
            rs.getInt("user_id")
        );
        t.setId(id); // Asumsikan setId sekarang pakai int
        return t;
    }

    return null; // Jika data tidak ditemukan
}

//    private List<Tagihan> getAllWithReminder() {
//        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
//    }
        
    
}