package com.staff.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/StaffServlet")
public class StaffServlet extends HttpServlet {

    // Database configuration
    private static final String DB_URL = "jdbc:mysql://localhost:3306/zakat_management";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = ""; // Use an empty password if your DB doesn't require one

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Fetch total applications
            String totalApplicationsQuery = "SELECT COUNT(*) AS total FROM application";
            stmt = conn.prepareStatement(totalApplicationsQuery);
            rs = stmt.executeQuery();
            if (rs.next()) {
                request.setAttribute("totalApplications", rs.getInt("total"));
            } else {
                request.setAttribute("totalApplications", 0); // Set to 0 if no result
            }
            rs.close();
            stmt.close();

            // Fetch applications with status 'Menunggu' (Pending)
            String pendingApplicationsQuery = "SELECT COUNT(*) AS pending FROM application WHERE apply_status = 'Menunggu'";
            stmt = conn.prepareStatement(pendingApplicationsQuery);
            rs = stmt.executeQuery();
            if (rs.next()) {
                request.setAttribute("pendingApplications", rs.getInt("pending"));
            } else {
                request.setAttribute("pendingApplications", 0); // Set to 0 if no result
            }
            rs.close();
            stmt.close();

            // Fetch applications with status 'Disahkan' (Approved)
            String approvedApplicationsQuery = "SELECT COUNT(*) AS approved FROM application WHERE apply_status = 'Disahkan'";
            stmt = conn.prepareStatement(approvedApplicationsQuery);
            rs = stmt.executeQuery();
            if (rs.next()) {
                request.setAttribute("approvedApplications", rs.getInt("approved"));
            } else {
                request.setAttribute("approvedApplications", 0); // Set to 0 if no result
            }
            rs.close();
            stmt.close();

            // Fetch applications with status 'Ditolak' (Rejected)
            String rejectedApplicationsQuery = "SELECT COUNT(*) AS rejected FROM application WHERE apply_status = 'Ditolak'";
            stmt = conn.prepareStatement(rejectedApplicationsQuery);
            rs = stmt.executeQuery();
            if (rs.next()) {
                request.setAttribute("rejectedApplications", rs.getInt("rejected"));
            } else {
                request.setAttribute("rejectedApplications", 0); // Set to 0 if no result
            }
            rs.close();
            stmt.close();

            // Forward data to the JSP
            request.getRequestDispatcher("UZSWdashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while fetching data.");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
