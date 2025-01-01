/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.staff.controller;

import com.database.dbconn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author User
 */
public class HEPListPage extends HttpServlet {

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
            out.println("<title>Servlet HEPListPage</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HEPListPage at " + request.getContextPath() + "</h1>");
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
         request.getRequestDispatcher("/WEB-INF/view/ApplicationListHEA.jsp").forward(request, response);
        String action = request.getParameter("action");

        if ("dashboard".equals(action)) {
            showDashboard(request, response);
        } else if ("viewApplications".equals(action)) {
            retrieveHEPApplications(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
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
        doGet(request, response);
    }

     /**
     * Fetches and forwards application status counts to the HEP dashboard view.
     */
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pendingCount = 0, approvedCount = 0, rejectedCount = 0;

        // Query to fetch application statuses assigned to HEP after HEA processing
        String query = "SELECT status_approval, COUNT(*) AS status_count " +
                       "FROM application " +
                       "WHERE staff_role = 'HEP' AND hea_status = 'checked' " +
                       "GROUP BY approve_status";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                String status = resultSet.getString("application_status");
                int count = resultSet.getInt("status_count");

                switch (status.toLowerCase()) {
                    case "pending":
                        pendingCount = count;
                        break;
                    case "approved":
                        approvedCount = count;
                        break;
                    case "rejected":
                        rejectedCount = count;
                        break;
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(HEPListPage.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
            return;
        }

        // Set attributes for the JSP
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("approvedCount", approvedCount);
        request.setAttribute("rejectedCount", rejectedCount);

        // Forward to HEP dashboard JSP
        request.getRequestDispatcher("/WEB-INF/view/DashboardHEP.jsp").forward(request, response);
    }

     /**
     * Retrieves HEP-specific application data and forwards it to the view.
     */
    private void retrieveHEPApplications(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = "SELECT * FROM applications WHERE assigned_role = 'HEP' AND hea_status = 'checked'";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            // Add application data to the request
            request.setAttribute("applications", resultSet);

        } catch (SQLException e) {
            Logger.getLogger(HEPListPage.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
            return;
        }

        // Forward to the HEP-specific application list JSP
        request.getRequestDispatcher("/WEB-INF/view/ApplicationListHEP.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
     @Override
    public String getServletInfo() {
        return "Servlet to handle HEP dashboard and application list.";
    }
}
