/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.*;
import java.util.*;
import util.KoneksiDB;
import java.util.Date;

/**
 *
 * @author Lenovo
 */
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

public class PengingatDAO {
    private Connection conn;

    public PengingatDAO(Connection conn) {
        this.conn = conn;
    }

    public void insertPengingat(Pengingat p) throws SQLException {
        String sql = "INSERT INTO pengingat (reminder_date, tagihan_id) VALUES (?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setDate(1, new java.sql.Date(p.getReminderDate().getTime()));
        ps.setInt(2, p.getTagihan().getId());
        ps.executeUpdate();
    }

    public List<Pengingat> getAllPengingat() throws SQLException {
        List<Pengingat> list = new ArrayList<>();
        String sql = "SELECT * FROM pengingat";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("id");
            Date reminderDate = rs.getDate("reminder_date");
            int tagihanId = rs.getInt("tagihan_id");

            // Ambil tagihan terkait (bisa lewat DAO lain atau simpan map lokal)
            Tagihan tagihan = new TagihanDAO(conn).getTagihanById(tagihanId);

            Pengingat p = new Pengingat(reminderDate, tagihan);
            p.setId(id);
            list.add(p);
        }

        return list;
    }
}
