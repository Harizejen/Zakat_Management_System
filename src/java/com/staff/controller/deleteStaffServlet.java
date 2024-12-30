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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author nasru
 */
public class deleteStaffServlet extends HttpServlet {

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
            out.println("<title>Servlet deleteStaffServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet deleteStaffServlet at " + request.getContextPath() + "</h1>");
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
        // Retrieve staff ID from the request
        int staffId = Integer.parseInt(request.getParameter("staffId")); // Assuming you have a hidden input for staffId

        staff st = new staff();
        staff st1 = st.findStaff(staffId);

        // SQL Delete Query
        String deleteQuery = "DELETE FROM staff WHERE staff_id = ?";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery)) {

            preparedStatement.setInt(1, staffId);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                // Successfully deleted
                if (st1 != null) { // Check if st1 is not null
                    switch (st1.getStaffrole()) {
                        case "HEA":
                            response.sendRedirect("adminServlet?action=viewHEAStaff");
                            break;
                        case "HEP":
                            response.sendRedirect("adminServlet?action=viewHEPStaff");
                            break;
                        case "UZSW":
                            response.sendRedirect("adminServlet?action=viewUZSWStaff");
                            break;
                        default:
                            // Handle unexpected roles if necessary
                            request.setAttribute("error", "Staff role is not recognized.");
                            request.getRequestDispatcher("/WEB-INF/view/adminDashboard .jsp").forward(request, response);
                            break;
                    }
                } else {
                    // Handle case where staff is not found
                    request.setAttribute("error", "Staff not found.");
                    request.getRequestDispatcher("/WEB-INF/view/adminDashboard.jsp").forward(request, response);
                }
            } else {
                // Handle failure
                request.setAttribute("error", "Failed to delete staff.");
                request.getRequestDispatcher("/WEB-INF/view/adminDashboard.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/adminDashboard.jsp").forward(request, response);
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
