/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.model;

import com.database.dbconn;
import com.staff.model.staff;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */

@WebServlet("/updateInterviewDate")
public class updateInterviewDate extends HttpServlet {

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
            out.println("<title>Servlet updateInterviewDate</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateInterviewDate at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        staff st = (staff) request.getSession().getAttribute("staff_data");
        
        if (st == null) {
            request.setAttribute("error", "Session expired. Please log in again.");
            request.getRequestDispatcher("/WEB-INF/view/staff_login.jsp").forward(request, response);
            return;
        }

        String appID = request.getParameter("appID");
        int staffid = st.getStaffid();
        String applicationIVDateStr = request.getParameter("tarikhTemuduga");

        // Validate input parameters
        if (applicationIVDateStr == null || applicationIVDateStr.isEmpty()) {
            request.setAttribute("error", "Dates are required.");
            request.getRequestDispatcher("/WEB-INF/view/ApplicationListUZSW.jsp").forward(request, response);
            return;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.sql.Date applicationIVDate;

        try {
            java.util.Date applicationDateUtil = sdf.parse(applicationIVDateStr);
            applicationIVDate = new java.sql.Date(applicationDateUtil.getTime());
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format. Please use yyyy-MM-dd.");
            request.getRequestDispatcher("/WEB-INF/view/ApplicationListUZSW.jsp").forward(request, response);
            return;
        }


        String insertQuery = "INSERT INTO interview (staff_id, apply_id, iv_date) VALUES (?, ?, ?)";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {

            preparedStatement.setInt(1, staffid);
            preparedStatement.setString(2, appID);
            preparedStatement.setDate(3, applicationIVDate);

            preparedStatement.executeUpdate();
            request.getRequestDispatcher("/WEB-INF/view/ApplicationListUZSW.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/ApplicationListUZSW.jsp").forward(request, response);
        }
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
