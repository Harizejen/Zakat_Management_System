/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.application.controller;

import javax.servlet.annotation.WebServlet;
import com.database.dbconn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.staff.model.staff;

/**
 *
 * @author User
 */

@WebServlet("/updateApplicationStatus")
public class updateApplicationStatus extends HttpServlet {

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
            out.println("<title>Servlet UpdateApplicationStatus</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateApplicationStatus at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
    
    staff st = (staff) request.getSession().getAttribute("staff_data"); 
    Integer staffId = st.getStaffid();
    String staffRole = st.getStaffrole();
    
    if (staffId == null) {
        request.setAttribute("error", "Staff not logged in.");
        request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
        return;
    }
    
    // Retrieve form data
    String appID = request.getParameter("appID");
    String selectedAction = request.getParameter("selectedAction");
    String disemak = request.getParameter("disemak") != null ? "TRUE" : "FALSE";
    
    // Check if the checkbox is checked
    if (disemak.equals("unchecked")) {
        // Checkbox is not checked, return an error message
        request.setAttribute("errorMessage", "You must check the box to update the application status.");
        request.getRequestDispatcher("error.jsp").forward(request, response); // Redirect to an error page
        return;
    }

    String approveStat = "LULUS";
    if (selectedAction.equalsIgnoreCase("GAGAL")) {
        approveStat = "GAGAL";
    }

    String query = null;
    try (Connection connection = dbconn.getConnection()) {
        if ("HEA".equals(staffRole)) {
            query = "INSERT INTO status_approval (hea_review, app_stat_hea, approve_status, staff_id, apply_id) VALUES (?, ?, ?, ?, ?)";
        } else if ("HEP".equals(staffRole)) {
            query = "UPDATE status_approval SET hep_review = ?, app_stat_hep = ?, approve_status = ? WHERE apply_id = ?";
        } else if ("UZSW".equals(staffRole)) {
            query = "UPDATE status_approval SET uzsw_review = ?, app_stat_uzsw = ?, approve_status = ? WHERE apply_id = ?";
        }

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            if ("HEA".equals(staffRole)) {
                statement.setString(1, disemak);
                statement.setString(2, selectedAction);
                statement.setString(3, approveStat);
                statement.setInt(4, staffId); // Assuming staff_id is an integer
                statement.setInt(5, Integer.parseInt(appID));
            } else if ("HEP".equals(staffRole)) {
                statement.setString(1, disemak);
                statement.setString(2, selectedAction);
                statement.setString(3, approveStat);
                statement.setInt(4, Integer.parseInt(appID)); // Set apply_id as an integer
            } else if ("UZSW".equals(staffRole)) {
                statement.setString(1, disemak);
                statement.setString(2, selectedAction);
                statement.setString(3, approveStat);
                statement.setInt(4, Integer.parseInt(appID)); // Set apply_id as an integer
            }

            // Execute the update
            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {
                // Set a message attribute for success
                request.setAttribute("message", "Application status updated successfully.");
                if ("HEA".equals(staffRole)) {
                    request.getRequestDispatcher("/WEB-INF/view/ApplicationListHEA.jsp").forward(request, response);
                } else if ("HEP".equals(staffRole)) {
                    request.getRequestDispatcher("/WEB-INF/view/ApplicationListHEP.jsp").forward(request, response);
                } else if ("UZSW".equals(staffRole)) {
                    request.getRequestDispatcher("/WEB-INF/view/ApplicationListUZSW.jsp").forward(request, response);
                }
            } else {
                // Set an error message for failure
                request.setAttribute("errorMessage", "Failed to update application status.");
                if ("HEA".equals(staffRole)) {
                    request.getRequestDispatcher("/WEB-INF/view/ApplicationListHEA.jsp").forward(request, response);
                } else if ("HEP".equals(staffRole)) {
                    request.getRequestDispatcher("/WEB-INF/view/ApplicationListHEP.jsp").forward(request, response);
                } else if ("UZSW".equals(staffRole)) {
                    request.getRequestDispatcher("/WEB-INF/view/ApplicationListUZSW.jsp").forward(request, response);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred while updating the application status.");
        request.getRequestDispatcher("error.jsp").forward(request, response); // Redirect to an error page
    }
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
