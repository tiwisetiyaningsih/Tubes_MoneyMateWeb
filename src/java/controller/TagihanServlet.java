/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.TagihanDAO;
import model.Tagihan;
import util.KoneksiDB;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/tagihan")
public class TagihanServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try (Connection conn = KoneksiDB.getConnection()) {
            TagihanDAO dao = new TagihanDAO(conn);
            
            if ("delete".equals(action)){
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteTagihan(id);
                System.out.println("Tagihan ID " + id + " berhasil dihapus.");
                response.sendRedirect("tagihan");
                return;
            }
            
            HttpSession session = request.getSession();
            int userId = (int) session.getAttribute("id");
            List<Tagihan> list = dao.getAllTagihanWithReminder(userId);
            request.setAttribute("tagihanList", list);
            request.getRequestDispatcher("tagihan.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Gagal memproses request di TagihanServlet", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    System.out.println("FORM MASUK KE SERVLET");
        try (Connection conn = KoneksiDB.getConnection()) {
            request.setCharacterEncoding("UTF-8");

            String nama = request.getParameter("namaTagihan");
            double jumlah = Double.parseDouble(request.getParameter("jumlahTagihan"));
            String tanggalStr = request.getParameter("tanggalDue");

            java.util.Date tanggal = new SimpleDateFormat("yyyy-MM-dd").parse(tanggalStr);

            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("id"); // ambil dari session

            if (userId == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            Tagihan tagihan = new Tagihan(nama, jumlah, tanggal, userId); 

            TagihanDAO dao = new TagihanDAO(conn);
            dao.insertTagihan(tagihan);

            response.sendRedirect("tagihan");
        } catch (Exception e) {
            throw new ServletException("Gagal menyimpan tagihan", e);
        }
    }
}