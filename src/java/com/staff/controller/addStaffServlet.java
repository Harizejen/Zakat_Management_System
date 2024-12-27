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
import javax.servlet.http.HttpSession;

/**
 *
 * @author nasru
 */
public class addStaffServlet extends HttpServlet {

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
            out.println("<title>Servlet addStaffServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addStaffServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Integer adminId = (Integer) session.getAttribute("adminId");

        // Retrieve form data
        String staffName = request.getParameter("namaStaf");
        String password = request.getParameter("password");
        String staffEmail = request.getParameter("staffEmail");
        String staffCategory = request.getParameter("kategoriStaf");

        // Insert staff into the database
        String insertQuery = "INSERT INTO staff (staff_id, admin_id, staff_name, staff_email, staff_password, staff_role) VALUES (NULL, ?, ?, ?, ?, ?)";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {

            preparedStatement.setInt(1, adminId); // Use the adminId from the session
            preparedStatement.setString(2, staffName);
            preparedStatement.setString(3, staffEmail);
            preparedStatement.setString(4, password);
            preparedStatement.setString(5, staffCategory);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                // Successfully inserted
                // Redirect based on the staff role
                switch (staffCategory) {
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
                        request.getRequestDispatcher("/WEB-INF/view/adminDashboard.jsp").forward(request, response);
                        break;
                }
            } else {
                // Handle failure
                request.setAttribute("error", "Failed to add staff.");
                request.getRequestDispatcher("/WEB-INF/view/addStaff.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/addStaff.jsp").forward(request, response);
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
