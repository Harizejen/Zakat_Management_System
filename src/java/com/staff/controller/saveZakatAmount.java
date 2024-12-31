/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.staff.controller;

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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class saveZakatAmount extends HttpServlet {

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
            out.println("<title>Servlet saveZakatAmount</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet saveZakatAmount at " + request.getContextPath() + "</h1>");
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
    
        // Check if the staff session is valid
        if (st == null) {
            request.setAttribute("error", "Session expired. Please log in again.");
            request.getRequestDispatcher("/WEB-INF/view/staff_login.jsp").forward(request, response);
            return;
        }

        int staffid = st.getStaffid();
        String zakatAmount = request.getParameter("amaunZakat");
        String credDate = request.getParameter("tarikhKred");

        // Validate input parameters
        if (zakatAmount == null || zakatAmount.isEmpty() ||
            credDate == null || credDate.isEmpty()) {
            request.setAttribute("error", "Date and amount are required.");
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
            return;
        }

        double donationAmount;
        try {
            // Parse zakatAmount to double
            donationAmount = Double.parseDouble(zakatAmount);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid amount format. Please enter a valid number.");
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
            return;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.sql.Date zakatCredDate;

        try {
            // Parse credDate to java.sql.Date
            java.util.Date credDateUtil = sdf.parse(credDate);
            zakatCredDate = new java.sql.Date(credDateUtil.getTime());
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format. Please use yyyy-MM-dd.");
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
            return;
        }

        String insertQuery = "INSERT INTO donation(staff_id, donation_date, donation_amount) VALUES (?, ?, ?)";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {

            // Set parameters for the prepared statement
            preparedStatement.setInt(1, staffid);
            preparedStatement.setDate(2, zakatCredDate);
            preparedStatement.setDouble(3, donationAmount); // Use the parsed double value

            // Execute the update
            preparedStatement.executeUpdate();
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
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
