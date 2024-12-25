/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.staff.controller;

import com.application.model.Application;
import com.database.dbconn;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HEAListPageServlet")
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Application> applications = new ArrayList<>();
        int approved = 0, pending = 0, rejected = 0;

        try (Connection connection = dbconn.getConnection()) {
            String query = "SELECT id, name, student_id, cgpa, date, form, status FROM applications";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Application app = new Application();
                app.setId(resultSet.getInt("id"));
                app.setName(resultSet.getString("name"));
                app.setStudentId(resultSet.getString("student_id"));
                app.setCgpa(resultSet.getDouble("cgpa"));
                app.setDate(resultSet.getString("date"));
                app.setForm(resultSet.getString("form"));
                app.setApplyStatus(resultSet.getString("status"));
                
                String status = app.getApplyStatus(); // Get the status
                // Count statuses
                switch (status.toLowerCase()) {
                    case "approved":
                        approved++;
                        break;
                    case "pending":
                        pending++;
                        break;
                    case "rejected":
                        rejected++;
                        break;
                }

                applications.add(app);
            }
            
            //request.setAttribute("countApproved", approved);
            //request.getRequestDispatcher("/WEB-INF/view/HEAdashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set attributes for list page
        request.setAttribute("applications", applications);
        
        // Set attributes for dashboard
        request.setAttribute("totalApplications", applications.size());
        request.setAttribute("approved", approved);
        request.setAttribute("pending", pending);
        request.setAttribute("rejected", rejected);

        // Forward to the list page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/ApplicationListHEA.jsp");
        dispatcher.forward(request, response);
    }
}
