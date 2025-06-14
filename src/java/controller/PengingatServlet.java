/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.sql.Connection;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import model.Pengingat;
import model.PengingatDAO;
import model.Tagihan;
import model.TagihanDAO;
import util.KoneksiDB;
import java.sql.Date;



@WebServlet("/pengingat")
public class PengingatServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int tagihanId = Integer.parseInt(request.getParameter("tagihanId"));
            Date reminderDate = Date.valueOf(request.getParameter("reminderDate"));

            Connection conn = KoneksiDB.getConnection();
            TagihanDAO tagihanDAO = new TagihanDAO((java.sql.Connection) conn);
            Tagihan tagihan = tagihanDAO.getTagihanById(tagihanId);

            Pengingat pengingat = new Pengingat(reminderDate, tagihan);
            PengingatDAO pengingatDAO = new PengingatDAO((java.sql.Connection) conn);
            pengingatDAO.insertPengingat(pengingat);

            response.sendRedirect("tagihan");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Gagal menyimpan pengingat", e);
        }
    }
}