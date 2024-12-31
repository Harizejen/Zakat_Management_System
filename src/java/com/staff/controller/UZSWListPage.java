/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.staff.controller;

import com.database.dbconn;
import com.application.model.Application;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
@WebServlet("/UZSWServlet")
public class UZSWListPage extends HttpServlet {

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
            out.println("<title>Servlet UZSWListPage</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UZSWListPage at " + request.getContextPath() + "</h1>");
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
              request.getRequestDispatcher("/WEB-INF/view/USZWlist.jsp").forward(request, response);
        
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
        String action = request.getParameter("action");

        if ("approveApplication".equals(action)) {
            approveApplication(request, response);
        } else {
            doGet(request, response);
        }
    }
     private void listApplications(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Application> applications = new ArrayList<>();
        String query = "SELECT apply_id, stud_id, apply_session, apply_part, apply_cgpa, apply_foodIncentive, apply_otherSupport, apply_otherSupportAmount, apply_purpose, apply_status, apply_date FROM applications WHERE apply_status = 'Pending UZSW'";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Application app = new Application();
                app.setApplyID(resultSet.getInt("apply_id"));
                app.setStudID(resultSet.getInt("stud_id"));
                app.setApplySession(resultSet.getString("apply_session"));
                app.setApplyPart(resultSet.getInt("apply_part"));
                app.setApplyCGPA(resultSet.getDouble("apply_cgpa"));
                app.setApplyFoodIncentive(resultSet.getBoolean("apply_foodIncentive"));
                app.setApplyOtherSupport(resultSet.getBoolean("apply_otherSupport"));
                app.setApplyOtherSupAmount(resultSet.getDouble("apply_otherSupportAmount"));
                app.setApplyPurpose(resultSet.getString("apply_purpose"));
                app.setApplyStatus(resultSet.getString("apply_status"));
                app.setApplyDate(resultSet.getDate("apply_date"));

                applications.add(app);
            }

            request.setAttribute("applications", applications);
            request.getRequestDispatcher("/WEB-INF/view/UZSWDashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    }
     private void approveApplication(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int applyId = Integer.parseInt(request.getParameter("applyId"));
        String creditDate = request.getParameter("creditDate");
        double creditAmount = Double.parseDouble(request.getParameter("creditAmount"));

        String updateQuery = "UPDATE applications SET apply_status = 'Approved', credit_date = ?, credit_amount = ? WHERE apply_id = ?";

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(updateQuery)) {

            preparedStatement.setString(1, creditDate);
            preparedStatement.setDouble(2, creditAmount);
            preparedStatement.setInt(3, applyId);

            int rowsUpdated = preparedStatement.executeUpdate();
            if (rowsUpdated > 0) {
                request.setAttribute("message", "Application approved successfully!");
            } else {
                request.setAttribute("error", "Failed to approve application.");
            }

        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        listApplications(request, response);
    }
       private void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getSession().invalidate();
       response.sendRedirect("USZWlist");

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to handle UZSW staff dashboard and application approval.";
    }
}
