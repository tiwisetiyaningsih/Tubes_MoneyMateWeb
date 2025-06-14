package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class KoneksiDB {
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Sesuaikan dengan versi MySQL
            String url = "jdbc:mysql://localhost:3306/db_mm"; // ganti db_mm dengan nama database kamu
            String user = "root"; // ganti jika pakai user lain
            String pass = "";     // ganti jika ada password
            return DriverManager.getConnection(url, user, pass);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
