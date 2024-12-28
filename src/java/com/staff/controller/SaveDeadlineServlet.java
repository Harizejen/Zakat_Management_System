package com.staff.controller;

import com.database.dbconn; // Replace with your actual database connection import
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "SaveDeadlineServlet", urlPatterns = {"/deadline_save.do"})
public class SaveDeadlineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String startDateStr = request.getParameter("start_date");
            String endDateStr = request.getParameter("end_date");

            // Parse dates
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = sdf.parse(startDateStr);
            Date endDate = sdf.parse(endDateStr);
            Date currentDate = new Date();

            // Determine status
            String status = (currentDate.after(startDate) && currentDate.before(endDate)) || currentDate.equals(startDate) ? "Dibuka" : "Ditutup";

            // Get staff ID from session
            HttpSession session = request.getSession();
            Integer staffId = (Integer) session.getAttribute("staffId");

            if (staffId == null) {
                out.println("<script>alert('Staff ID is missing. Please log in.'); window.location.href='staff_login.jsp';</script>");
                return;
            }

            // Save deadline
            try {
                saveDeadlineToDatabase(staffId, startDate, endDate, status);
                out.println("<script>alert('Deadline successfully saved!'); window.location.href='staffDashboard.jsp';</script>");
            } catch (SQLException ex) {
                Logger.getLogger(SaveDeadlineServlet.class.getName()).log(Level.SEVERE, null, ex);
                out.println("<script>alert('Database error: " + ex.getMessage() + "'); window.location.href='staffDashboard.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('Error processing request: " + e.getMessage() + "'); window.location.href='staffDashboard.jsp';</script>");
        }
    }

    private void saveDeadlineToDatabase(int staffId, Date startDate, Date endDate, String status) throws SQLException {
        String insertSQL = "INSERT INTO deadlines (staff_id, application_open_date, application_deadline, application_dur_stat) VALUES (?, ?, ?, ?)";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(insertSQL)) {

            preparedStatement.setInt(1, staffId);
            preparedStatement.setDate(2, new java.sql.Date(startDate.getTime()));
            preparedStatement.setDate(3, new java.sql.Date(endDate.getTime()));
            preparedStatement.setString(4, status);

            preparedStatement.executeUpdate();
        }
    }
}
