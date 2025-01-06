/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.staff.controller;

import com.database.dbconn;
import com.staff.model.staff;
import com.application.model.Application;
import com.status_approval.model.status_approval;
import com.ApplicationStatus.model.ApplicationStatus;
import javax.servlet.ServletException;
import java.io.PrintWriter;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;
/**
 *
 * @author User
 */
@WebServlet(name = "StaffLoginServlet", urlPatterns = {"/staff_login.do"})
public class StaffLoginServlet extends HttpServlet {
     private static final long serialVersionUID = 1L;

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
            out.println("<title>Servlet StaffLoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffLoginServlet at " + request.getContextPath() + "</h1>");
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
    
    String staffIdParam = request.getParameter("staffId");
    String password = request.getParameter("password");
    String role = request.getParameter("role");

    if (staffIdParam == null || password == null || role == null) {
        request.setAttribute("error", "All fields are required.");
        request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
        return;
    }

    int staffId;
    try {
        staffId = Integer.parseInt(staffIdParam);
    } catch (NumberFormatException e) {
        request.setAttribute("error", "Invalid Staff ID format.");
        request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
        return;
    }

    // Create staff object and set credentials
    staff st = new staff();
    st.setStaffid(staffId);
    st.setStaffpassword(password);

    if (st.isValid()) {
        staff stl = st.findStaff(staffId);

        if (stl != null && stl.getStaffrole().equalsIgnoreCase(role)) {
            // Store staff data in the session
            HttpSession session = request.getSession();
            session.setAttribute("staff_data", stl);

            // Redirect to the appropriate dashboard based on staff role
            switch (role) {
                case "HEA":
                    request.getRequestDispatcher("/WEB-INF/view/HEAdashboard.jsp").forward(request, response);
                    break;
                case "HEP":
                    request.getRequestDispatcher("/WEB-INF/view/HEPdashboard.jsp").forward(request, response);
                    break;
                case "UZSW":
                    request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
                    break;
                default:
                    request.setAttribute("error", "Invalid role.");
                    request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
                    break;
            }
        } else {
            request.setAttribute("error", "Invalid credentials or role.");
            request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
        }
    } else {
        request.setAttribute("error", "Invalid credentials.");
        request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
    }
    
    if (st.isValid()) {
        
        staff ss = (staff) request.getSession().getAttribute("staff_data"); 
        String userRole = (String) ss.getStaffrole();
            
        // Retrieve all staff data for the dashboard
        List<ApplicationStatus> totalList = retrieveAllApplicationsByRole(userRole);
        
        // Set the staff lists as attributes
        request.setAttribute("totalList", totalList);

        // Decide which JSP to forward based on the user role
        if ("UZSW".equals(userRole)) {
            request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
        } else if ("HEA".equals(userRole)) {
            request.getRequestDispatcher("/WEB-INF/view/HEAdashboard.jsp").forward(request, response);
        } else if ("HEP".equals(userRole)) {
            request.getRequestDispatcher("/WEB-INF/view/HEPdashboard.jsp").forward(request, response);
        } else {
            // Default fallback if no role is set
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You do not have permission to view this page.");
        }
            
    } else {
        request.setAttribute("error", "Invalid credentials");
        request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
    }
}
    private List<ApplicationStatus> retrieveAllApplicationsByRole(String staffRole) {
        List<ApplicationStatus> applicationList = new ArrayList<>();
        String query = null;

        if ("HEA".equals(staffRole)) {
            query = "SELECT * FROM application";
        } else if ("HEP".equals(staffRole)) {
            query = "SELECT a.* FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id WHERE sa.reviewed_by_hea = 'TRUE' AND sa.app_stat_hea = 'TRUE'";
        } else if ("UZSW".equals(staffRole)) {
            query = "SELECT a.* FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id WHERE sa.reviewed_by_hea = 'TRUE' AND sa.reviewed_by_hep = 'TRUE' AND sa.app_stat_hea = 'TRUE' AND sa.app_stat_hep = 'TRUE'";
        }

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                ApplicationStatus appStatus = new ApplicationStatus();
                appStatus.setApply_id(resultSet.getInt("apply_id"));
                appStatus.setStud_id(resultSet.getInt("stud_id"));
                appStatus.setDeadline_id(resultSet.getInt("deadline_id"));
                appStatus.setApply_session(resultSet.getString("apply_session"));
                appStatus.setApply_part(resultSet.getInt("apply_part"));
                appStatus.setApply_cgpa(resultSet.getDouble("apply_cgpa"));
                appStatus.setApply_gpa(resultSet.getDouble("apply_gpa"));
                appStatus.setApply_foodIncentive(resultSet.getString("apply_foodincentive"));
                appStatus.setApply_otherSupport(resultSet.getString("apply_otherSupport"));
                appStatus.setApply_otherSupportName(resultSet.getString("apply_otherSupportName"));
                appStatus.setApply_otherSupportAmount(resultSet.getDouble("apply_otherSupportAmount"));
                appStatus.setApply_purpose(resultSet.getString("apply_purpose"));
                appStatus.setApply_date(resultSet.getDate("apply_date"));
                appStatus.setDonation_id(resultSet.getInt("donation_id"));
                applicationList.add(appStatus);
            }
        } catch (SQLException e) {
            Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, e);
        }

        return applicationList;
    }
    


   

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Staff Login Servlet";
    }// </editor-fold>
}