/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.KoneksiDB;

public class KategoriDAO {

    // Method untuk mengambil semua kategori dari database
    public static List<Kategori> getAllKategori() {
        List<Kategori> kategoriList = new ArrayList<>();
        try (Connection conn = KoneksiDB.getConnection()) {
            String sql = "SELECT * FROM kategori";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Kategori kategori = new Kategori(
                        rs.getInt("id"),
                        rs.getString("namaKategori")
                );
                kategoriList.add(kategori);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return kategoriList;
    }
}
