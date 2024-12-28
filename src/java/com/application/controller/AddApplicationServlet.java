/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.application.controller;

import com.database.dbconn;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author User
 */
public class AddApplicationServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddApplicationServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddApplicationServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        int stud_id = (Integer)request.getAttribute("stud_id");
        int deadline_id = 1;//kena ubah logik.. ni untuk testing
        String apply_session = "Sesi"+" "+LocalDate.now().getYear();
        String apply_foodIncentive = request.getParameter("apply_foodIncentive");
        String apply_otherSupport = request.getParameter("apply_otherSupport");
        String apply_otherSupportName = request.getParameter("apply_otherSupportName") != null ? request.getParameter("apply_otherSupportName") : "";
        String apply_otherSupportAmount = request.getParameter("apply_otherSupportAmount") != null ? request.getParameter("apply_otherSupportAmount") : "0";
        String apply_part = request.getParameter("apply_part");
        double apply_gpa = Double.parseDouble(request.getParameter("apply_gpa")) ;
        double apply_cgpa = Double.parseDouble(request.getParameter("apply_cgpa"));
        String apply_purpose = request.getParameter("apply_purpose");
        //set apply date now
        LocalDate apply_date = LocalDate.now();
        
        String applyQuery = "INSERT INTO application (stud_id, deadline_id, apply_session, apply_part, apply_cgpa, apply_gpa, apply_foodIncentive, apply_otherSupport, apply_otherSupportName, apply_otherSupportAmount, apply_purpose, apply_date) "
                            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try{
            Connection conn = dbconn.getConnection();
            conn.setAutoCommit(false);
            PreparedStatement ps = conn.prepareStatement(applyQuery);
            
            ps.setInt(1, stud_id);
            ps.setInt(2, deadline_id);
            ps.setString(3, apply_session); // Replace with the actual session value if needed
            ps.setString(4, apply_part);
            ps.setDouble(5, apply_cgpa);
            ps.setDouble(6, apply_gpa);
            ps.setString(7, apply_foodIncentive);
            ps.setString(8, apply_otherSupport);
            ps.setString(9, apply_otherSupportName);
            ps.setString(10, apply_otherSupportAmount);
            ps.setString(11, apply_purpose);
            ps.setDate(12, java.sql.Date.valueOf(apply_date));
            
            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("Application inserted successfully!");
            }
            conn.commit();
            ps.close();
            conn.close();
            
            // Redirect or forward to a success page
            response.sendRedirect("success.jsp");
        }catch(SQLException e){
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing your application. Please try again later.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
        // Process the data (e.g., save to database)
        // Example: Application application = new Application(bantuanMakanan, bantuanLain, ...);
        // applicationService.save(application);


    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
