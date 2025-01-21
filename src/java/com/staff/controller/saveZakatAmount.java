package com.staff.controller;

import com.database.dbconn;
import com.staff.model.staff;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class saveZakatAmount extends HttpServlet {

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
            request.getSession().setAttribute("error", "Date and amount are required.");
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
            return;
        }

        double donationAmount;
        try {
            // Parse zakatAmount to double
            donationAmount = Double.parseDouble(zakatAmount);
            if (donationAmount < 0) {
                request.getSession().setAttribute("error", "Zakat amount cannot be negative.");
                request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("error", "Invalid amount format. Please enter a valid number.");
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
            return;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.sql.Date zakatCredDate;

        try {
            // Parse credDate to java.sql.Date
            java.util.Date credDateUtil = sdf.parse(credDate);
            zakatCredDate = new java.sql.Date(credDateUtil.getTime());

            // Check if the donation date is in the past
            java.util.Date currentDateUtil = new java.util.Date();
            if (zakatCredDate.before(currentDateUtil)) {
                request.getSession().setAttribute("error", "The credit date cannot be in the past.");
                request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
                return;
            }
        } catch (ParseException e) {
            request.getSession().setAttribute("error", "Invalid date format. Please use yyyy-MM-dd.");
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
            request.getSession().setAttribute("success", "Zakat amount saved successfully.");
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}