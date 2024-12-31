package com.staff.controller;

import com.staff.model.staff;
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Date;

@WebServlet(name = "SaveDeadlineServlet", urlPatterns = {"/deadline_save.do"})
public class SaveDeadlineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {     
        staff st = (staff) request.getSession().getAttribute("staff_data"); 
        
        if (st == null) {
            request.setAttribute("error", "Session expired. Please log in again.");
            request.getRequestDispatcher("/WEB-INF/view/staff_login.jsp").forward(request, response);
            return;
        }

        int staffid = st.getStaffid();
        String applicationOpenDateStr = request.getParameter("tarikhMula");
        String applicationDeadlineStr = request.getParameter("tarikhAkhir");

        // Validate input parameters
        if (applicationOpenDateStr == null || applicationOpenDateStr.isEmpty() ||
            applicationDeadlineStr == null || applicationDeadlineStr.isEmpty()) {
            request.setAttribute("error", "Both dates are required.");
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
            return;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.sql.Date applicationOpenDate;
        java.sql.Date applicationDeadline;

        try {
            java.util.Date openDateUtil = sdf.parse(applicationOpenDateStr);
            java.util.Date deadlineDateUtil = sdf.parse(applicationDeadlineStr);
            applicationOpenDate = new java.sql.Date(openDateUtil.getTime());
            applicationDeadline = new java.sql.Date(deadlineDateUtil.getTime());
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format. Please use yyyy-MM-dd.");
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
            return;
        }


        // Determine application_dur_start
        String applicationDurStart;
        java.util.Date currentDateUtil = new java.util.Date();
        if (currentDateUtil.before(applicationOpenDate) || currentDateUtil.after(applicationDeadline)) {
            applicationDurStart = "DITUTUP";
        } else {
            applicationDurStart = "DIBUKA";
        }

        String insertQuery = "INSERT INTO deadline (staff_id, application_open_date, application_deadline, application_start) VALUES (?, ?, ?, ?)";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {

            preparedStatement.setInt(1, staffid);
            preparedStatement.setDate(2, applicationOpenDate);
            preparedStatement.setDate(3, applicationDeadline);
            preparedStatement.setString(4, applicationDurStart);

            preparedStatement.executeUpdate();
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);

            
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
        }
    }
}
