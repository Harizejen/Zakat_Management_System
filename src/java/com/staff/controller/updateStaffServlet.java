package com.staff.controller;

import com.database.dbconn;
import com.staff.model.staff;
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
import javax.servlet.http.HttpSession;

public class updateStaffServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Retrieve staffId from the request
        int staffId = Integer.parseInt(request.getParameter("staffId"));

        // SQL to retrieve staff details
        String selectQuery = "SELECT * FROM staff WHERE staff_id = ?";
        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(selectQuery)) {

            preparedStatement.setInt(1, staffId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // Create a staff object and populate it with retrieved details
                staff staffMember = new staff();
                staffMember.setStaffid(resultSet.getInt("staff_id"));
                staffMember.setStaffname(resultSet.getString("staff_name"));
                staffMember.setStaffemail(resultSet.getString("staff_email"));
                staffMember.setStaffpassword(resultSet.getString("staff_password"));
                staffMember.setStaffrole(resultSet.getString("staff_role"));
                staffMember.setAdminid(resultSet.getInt("admin_id")); // If needed

                // Set the staff object as a request attribute
                request.setAttribute("staffMember", staffMember);

                // Forward to updateStaff.jsp
                request.getRequestDispatcher("/WEB-INF/view/updateStaff.jsp").forward(request, response);
            } else {
                // Handle case where staff is not found
                request.setAttribute("error", "Staff not found.");
                request.getRequestDispatcher("/WEB-INF/view/adminDashboard.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/adminDashboard.jsp").forward(request, response);
        }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        // Retrieve the adminId from the session
        HttpSession session = request.getSession();
        Integer adminId = (Integer) session.getAttribute("adminId");

        // Retrieve form data
        int staffId = Integer.parseInt(request.getParameter("staffId")); 
        String staffName = request.getParameter("namaStaf");
        String staffEmail = request.getParameter("stafEmail");
        String password = request.getParameter("password");
        String staffRole = request.getParameter("kategoriStaf");

        // SQL Update Query
        String updateQuery = "UPDATE staff SET admin_id = ?, staff_email = ?, staff_password = ?, staff_role = ?, staff_name = ? WHERE staff_id = ?";
//UPDATE `staff` SET `admin_id` = 1001, `staff_email` = 'hzq@gmail.com', `staff_password` = '12345New', `staff_role` = 'UZSW', `staff_name` = 'Haziq Human Hamilrol' WHERE `staff_id` = 14;
        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(updateQuery)) {

            preparedStatement.setInt(1, adminId); // Set adminId from session
            preparedStatement.setString(2, staffEmail);
            preparedStatement.setString(3, password);
            preparedStatement.setString(4, staffRole);
            preparedStatement.setString(5, staffName);
            preparedStatement.setInt(6, staffId);

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                switch (staffRole) {
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
                request.setAttribute("error", "Failed to update staff.");
                request.getRequestDispatcher("/WEB-INF/view/updateStaff.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/updateStaff.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}