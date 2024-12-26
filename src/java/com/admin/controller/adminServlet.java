/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.admin.controller;

import com.database.dbconn;
import com.staff.model.staff;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author nasru
 */
public class adminServlet extends HttpServlet {

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
            out.println("<title>Servlet adminServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminServlet at " + request.getContextPath() + "</h1>");
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
    String action = request.getParameter("action");

    // Check the action and retrieve data accordingly
    if ("viewHEAStaff".equals(action)) {
        retrieveHEAStaffData(request, response);
        // Forward to HEA staff view (if applicable)
    } else if ("viewHEPStaff".equals(action)) {
        retrieveHEPStaffData(request, response);
        // Forward to HEP staff view (if applicable)
    } else if ("viewUZSWStaff".equals(action)) {
        retrieveUZSWStaffData(request, response);
        // Forward to UZSW staff view (if applicable)
    } else {
        // If no valid action is provided, redirect to the login page or show an error
        request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
    }
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
    boolean isValid = false;

    String adminIdParam = request.getParameter("adminId");
    String admin_password = request.getParameter("admin_password");

    if (adminIdParam == null || admin_password == null) {
        request.setAttribute("error", "Admin ID and password are required.");
        request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
        return;
    }

    int admin_id = 0;
    try {
        admin_id = Integer.parseInt(adminIdParam);
    } catch (NumberFormatException e) {
        request.setAttribute("error", "Invalid Admin ID format.");
        request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
        return;
    }

    String query = "SELECT * FROM admin WHERE admin_id = ? AND admin_password = ?";

    try (Connection connection = dbconn.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query)) {

        preparedStatement.setInt(1, admin_id);
        preparedStatement.setString(2, admin_password);

        ResultSet resultSet = preparedStatement.executeQuery();
        isValid = resultSet.next(); // If a record is found, the admin is valid
    } catch (SQLException ex) {
        Logger.getLogger(adminServlet.class.getName()).log(Level.SEVERE, null, ex);
        request.setAttribute("error", "Database error: " + ex.getMessage());
        request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
        return;
    }

    if (isValid) {
        HttpSession session = request.getSession();
        session.setAttribute("adminId", admin_id);

        // Retrieve staff counts
        int heaCount = dbconn.getStaffCountByCategory("HEA");
        int hepCount = dbconn.getStaffCountByCategory("HEP");
        int uzswCount = dbconn.getStaffCountByCategory("UZSW");

        // Set the counts as attributes
        request.setAttribute("heaCount", heaCount);
        request.setAttribute("hepCount", hepCount);
        request.setAttribute("uzswCount", uzswCount);

        // Retrieve all staff data for the dashboard
        retrieveHEAStaffData(request, response);
        retrieveHEPStaffData(request, response);
        retrieveUZSWStaffData(request, response);

        // Forward to the dashboard
        request.getRequestDispatcher("/WEB-INF/view/adminDashboard.jsp").forward(request, response);
    } else {
        request.setAttribute("error", "Invalid credentials");
        request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
    }
}

    private void retrieveHEAStaffData(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<staff> HEAstaffList = new ArrayList<>();
        String query = "SELECT staff_id, staff_name, staff_email FROM staff WHERE staff_role = 'HEA' ";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
             
            while (resultSet.next()) {
                staff staff = new staff();
                staff.setStaffid(resultSet.getInt("staff_id"));
                staff.setStaffname(resultSet.getString("staff_name"));
                staff.setStaffemail(resultSet.getString("staff_email"));
                HEAstaffList.add(staff);
            }
        } catch (SQLException e) {
            Logger.getLogger(adminServlet.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("HEAstaffList", HEAstaffList);
        request.getRequestDispatcher("/WEB-INF/view/HEATable.jsp").forward(request, response);
    }
    
    private void retrieveHEPStaffData(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<staff> HEPstaffList = new ArrayList<>();
        String query = "SELECT staff_id, staff_name, staff_email FROM staff WHERE staff_role = 'HEP' ";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
             
            while (resultSet.next()) {
                staff staff = new staff();
                staff.setStaffid(resultSet.getInt("staff_id"));
                staff.setStaffname(resultSet.getString("staff_name"));
                staff.setStaffemail(resultSet.getString("staff_email"));
                HEPstaffList.add(staff);
            }
        } catch (SQLException e) {
            Logger.getLogger(adminServlet.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("HEPstaffList", HEPstaffList);
        request.getRequestDispatcher("/WEB-INF/view/HEPTable.jsp").forward(request, response);
    }
    
    private void retrieveUZSWStaffData(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<staff> UZSWstaffList = new ArrayList<>();
        String query = "SELECT staff_id, staff_name, staff_email FROM staff WHERE staff_role = 'UZSW' ";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
             
            while (resultSet.next()) {
                staff staff = new staff();
                staff.setStaffid(resultSet.getInt("staff_id"));
                staff.setStaffname(resultSet.getString("staff_name"));
                staff.setStaffemail(resultSet.getString("staff_email"));
                UZSWstaffList.add(staff);
            }
        } catch (SQLException e) {
            Logger.getLogger(adminServlet.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("UZSWstaffList", UZSWstaffList);
        request.getRequestDispatcher("/WEB-INF/view/UZSWTable.jsp").forward(request, response);
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
