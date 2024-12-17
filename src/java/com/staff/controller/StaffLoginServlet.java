/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.staff.controller;

import com.database.dbconn;
import javax.servlet.ServletException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author User
 */
@WebServlet(name = "StaffLoginServlet", urlPatterns = {"/staff_login.do"})
public class StaffLoginServlet extends HttpServlet {
     private static final long serialVersionUID = 1L;

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
            out.println("<title>Servlet StaffLoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffLoginServlet at " + request.getContextPath() + "</h1>");
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
        String staffIdParam = request.getParameter("staffId");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Null checks for form parameters
        if (staffIdParam == null || password == null || role == null) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
            return;
        }

        int staffId = 0;
        try {
            staffId = Integer.parseInt(staffIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Staff ID format.");
            request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
            return;
        }

        // Database logic
        try (Connection connection = dbconn.getConnection()) {
            if (connection == null) {
                throw new SQLException("Database connection failed!");
            }

            String query = "SELECT * FROM staff WHERE staff_id = ? AND BINARY staff_password = ? AND staff_role = ?";
            
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setInt(1, staffId);
                preparedStatement.setString(2, password);  // Adjust if password is hashed
                preparedStatement.setString(3, role);

                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    // Valid staff
                    HttpSession session = request.getSession();
                    session.setAttribute("staffId", staffId);
                    session.setAttribute("role", role);

                    // Redirect to appropriate dashboard based on staff role
                    switch (role) {
                        case "HEA":
                            request.getRequestDispatcher("/WEB-INF/view/HEAdashboard.jsp").forward(request, response);
                            break;
                        case "HEP":
                            request.getRequestDispatcher("/WEB-INF/view/HEPdashboard.jsp").forward(request, response);
                            break;
                        case "UZSW":
                            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
                            break;
                        default:
                            request.setAttribute("error", "Invalid role.");
                            request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
                            break;
                    }
                } else {
                    // Invalid credentials
                    request.setAttribute("error", "Invalid credentials.");
                    request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
        }
    }
    
    

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Staff Login Servlet";
    }// </editor-fold>
}
