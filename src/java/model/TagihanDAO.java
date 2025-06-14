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
//  public void tambahTagihan(Tagihan tagihan) {
//        try (Connection conn = KoneksiDB.getConnection()) {
//            String sql = "INSERT INTO tagihan (nama_tagihan, jumlah_tagihan, tanggal_due) VALUES (?, ?, ?)";
//            PreparedStatement stmt = conn.prepareStatement(sql);
//            stmt.setString(1, tagihan.getNamaTagihan());
//            stmt.setDouble(2, tagihan.getJumlahTagihan());
//            stmt.setDate(3, new java.sql.Date(tagihan.getTanggalDue().getTime()));
//            stmt.executeUpdate();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
   
    public List<Tagihan> getAllTagihanWithReminder() throws SQLException {
        List<Tagihan> list = new ArrayList<>();
        String query = "SELECT * FROM tagihan";
        PreparedStatement ps = conn.prepareStatement(query);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Tagihan t = new Tagihan(
                rs.getString("namaTagihan"),
                rs.getDouble("jumlahTagihan"),
                rs.getDate("tanggalDue")
            );
            t.setId(rs.getInt("id"));
            list.add(t);
        }

        return list;
    }
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try (Connection conn = KoneksiDB.getConnection()) {
        TagihanDAO dao = new TagihanDAO(conn);
        List<Tagihan> list = dao.getAllWithReminder(); // PAKAI YANG DENGAN REMINDER
        request.setAttribute("tagihanList", list);
        request.getRequestDispatcher("tagihan.jsp").forward(request, response);
    } catch (Exception e) {
        throw new ServletException("Error saat mengambil data tagihan", e);
    }
}

//
    // Tambah tagihan
    public void insertTagihan(Tagihan t) throws SQLException {
        String query = "INSERT INTO tagihan (namaTagihan, jumlahTagihan, tanggalDue) VALUES (?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, t.getNamaTagihan());
        ps.setDouble(2, t.getJumlahTagihan());
        ps.setDate(3, new java.sql.Date(t.getTanggalDue().getTime()));
        ps.executeUpdate();
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
            rs.getDate("tanggalDue")
        );
        t.setId(id); // Asumsikan setId sekarang pakai int
        return t;
    }

    return null; // Jika data tidak ditemukan
}

    private List<Tagihan> getAllWithReminder() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
        
    
}