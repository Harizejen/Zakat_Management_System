/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.staff.controller;

import com.database.dbconn;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/HEAListPageServlet")
public class HEAListPage extends HttpServlet {

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
        // Forward to the JSP
        request.getRequestDispatcher("/WEB-INF/view/ApplicationListHEA.jsp").forward(request, response);
    }

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

        if ("dashboard".equals(action)) {
            showDashboard(request, response);
        } else if ("viewApplications".equals(action)) {
            retrieveHEAApplications(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Fetches and forwards application status counts to the dashboard view.
     */
    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pendingCount = 0, approvedCount = 0, rejectedCount = 0;

        String query = "SELECT application_status, COUNT(*) AS status_count FROM applications WHERE assigned_role = 'HEA' GROUP BY application_status";

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
            Logger.getLogger(HEAListPage.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("approvedCount", approvedCount);
        request.setAttribute("rejectedCount", rejectedCount);
        request.getRequestDispatcher("/WEB-INF/view/DashboardHEA.jsp").forward(request, response);
    }

    /**
     * Retrieves HEA-specific application data and forwards it to the view.
     */
    private void retrieveHEAApplications(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Similar implementation to retrieve HEA-specific applications.
    }

    @Override
    public String getServletInfo() {
        return "Servlet to handle HEA dashboard and application list.";
    }
}
