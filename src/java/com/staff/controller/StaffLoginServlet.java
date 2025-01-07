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
        staff ss = (staff) request.getSession().getAttribute("staff_data"); 
        String userRole = (String) ss.getStaffrole();
            
        // Retrieve all data for the dashboard
        List<Application> totalList = retrieveAllApplicationsByRole(userRole);
        List<Application> pendingList = retrievePendingApplicationsByRole(userRole);
        List<Application> approvedList = retrieveApprovedApplicationsByRole(userRole);
        List<Application> rejectedList = retrieveRejectedApplicationsByRole(userRole);
        
        // Set the lists as attributes
        request.setAttribute("totalList", totalList);
        request.setAttribute("pendingList", pendingList);
        request.setAttribute("approvedList", approvedList);
        request.setAttribute("rejectedList", rejectedList);
        
        request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);

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

            // Retrieve all data for the dashboard
            String userRole = stl.getStaffrole();
            List<Application> totalList = retrieveAllApplicationsByRole(userRole);
            List<Application> pendingList = retrievePendingApplicationsByRole(userRole);
            List<Application> approvedList = retrieveApprovedApplicationsByRole(userRole);
            List<Application> rejectedList = retrieveRejectedApplicationsByRole(userRole);
            
            // Set the lists as attributes
            request.setAttribute("totalList", totalList);
            request.setAttribute("pendingList", pendingList);
            request.setAttribute("approvedList", approvedList);
            request.setAttribute("rejectedList", rejectedList);

            // Decide which JSP to forward based on the user role
            String dashboardPage;
            switch (role) {
                case "HEA":
                    dashboardPage = "/WEB-INF/view/HEAdashboard.jsp";
                    break;
                case "HEP":
                    dashboardPage = "/WEB-INF/view/HEPdashboard.jsp";
                    break;
                case "UZSW":
                    dashboardPage = "/WEB-INF/view/UZSWdashboard.jsp";
                    break;
                default:
                    request.setAttribute("error", "Invalid role.");
                    dashboardPage = "/staff_login.jsp";
                    break;
            }
            request.getRequestDispatcher(dashboardPage).forward(request, response);
        } else {
            request.setAttribute("error", "Invalid credentials or role.");
            request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
        }
    } else {
        request.setAttribute("error", "Invalid credentials.");
        request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
    }
}
    private List<Application> retrieveAllApplicationsByRole(String staffRole) {
        List<Application> applicationList = new ArrayList<>();
        String query = null;

        if ("HEA".equals(staffRole)) {
            query = "SELECT a.*, approve_status FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id";
        } else if ("HEP".equals(staffRole)) {
            query = "SELECT a.*, approve_status FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id WHERE sa.hea_review = 'TRUE' AND sa.app_stat_hea = 'TRUE'";
        } else if ("UZSW".equals(staffRole)) {
            query = "SELECT a.*, approve_status FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id WHERE sa.hea_review = 'TRUE' AND sa.hep_review = 'TRUE' AND sa.app_stat_hea = 'TRUE' AND sa.app_stat_hep = 'TRUE'";
        }

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Application appStatus = new Application();
                appStatus.setApplyID(resultSet.getInt("apply_id"));
                appStatus.setStudID(resultSet.getInt("stud_id"));
                appStatus.setDeadlineID(resultSet.getInt("deadline_id"));
                appStatus.setApplySession(resultSet.getString("apply_session"));
                appStatus.setApplyPart(resultSet.getInt("apply_part"));
                appStatus.setApplyCGPA(resultSet.getDouble("apply_cgpa"));
                appStatus.setApplyGPA(resultSet.getDouble("apply_gpa"));

                // Convert string values to boolean for food incentive and other support
                String foodIncentive = resultSet.getString("apply_foodincentive");
                appStatus.setApplyFoodIncentive("YA".equalsIgnoreCase(foodIncentive));

                String otherSupport = resultSet.getString("apply_otherSupport");
                appStatus.setApplyOtherSupport("YA".equalsIgnoreCase(otherSupport));

                // Remove the `apply_otherSupportName` field, as it doesn't exist in the Application class
                // appStatus.setApply_otherSupportName(resultSet.getString("apply_otherSupportName")); // Remove this line

                appStatus.setApplyOtherSupportAmount(resultSet.getDouble("apply_otherSupportAmount"));
                appStatus.setApplyPurpose(resultSet.getString("apply_purpose"));

                // Set the status as a string (not Date)
                appStatus.setApplyStatus(resultSet.getString("approve_status"));

                appStatus.setApplyDate(resultSet.getDate("apply_date"));
                appStatus.setDonationID(resultSet.getInt("donation_id"));

                applicationList.add(appStatus);
            }
        } catch (SQLException e) {
            Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, e);
        }

        return applicationList;
    }
    private List<Application> retrievePendingApplicationsByRole(String staffRole) {
    List<Application> pendingApplications = new ArrayList<>();
    String query = null;

    if ("HEA".equals(staffRole)) {
        // HEA receives all unreviewed applications
        query = "SELECT a.*, approve_status FROM application a LEFT JOIN status_approval sa ON a.apply_id = sa.apply_id\n" +
                "WHERE sa.apply_id IS NULL OR sa.hea_review = 'FALSE'";
    } else if ("HEP".equals(staffRole)) {
        // HEP receives applications approved by HEA but not yet reviewed by HEP
        query = "SELECT a.*, approve_status FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id\n" +
                "WHERE sa.hea_review = 'TRUE' AND sa.app_stat_hea = 'TRUE' AND sa.hep_review  = 'FALSE'";
    } else if ("UZSW".equals(staffRole)) {
        // UZSW receives applications approved by both HEA and HEP but not yet reviewed by UZSW
        query = "SELECT a.*, approve_status FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id\n" +
                "WHERE sa.hea_review = 'TRUE' AND sa.hep_review = 'TRUE'\n" +
                "AND sa.app_stat_hea = 'TRUE' AND sa.app_stat_hep = 'TRUE' AND sa.uzsw_review  = 'FALSE'";
    }

    try (Connection connection = dbconn.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query);
         ResultSet resultSet = preparedStatement.executeQuery()) {

        while (resultSet.next()) {
            Application appStatus = new Application();
                appStatus.setApplyID(resultSet.getInt("apply_id"));
                appStatus.setStudID(resultSet.getInt("stud_id"));
                appStatus.setDeadlineID(resultSet.getInt("deadline_id"));
                appStatus.setApplySession(resultSet.getString("apply_session"));
                appStatus.setApplyPart(resultSet.getInt("apply_part"));
                appStatus.setApplyCGPA(resultSet.getDouble("apply_cgpa"));
                appStatus.setApplyGPA(resultSet.getDouble("apply_gpa"));

                // Convert string values to boolean for food incentive and other support
                String foodIncentive = resultSet.getString("apply_foodincentive");
                appStatus.setApplyFoodIncentive("YA".equalsIgnoreCase(foodIncentive));

                String otherSupport = resultSet.getString("apply_otherSupport");
                appStatus.setApplyOtherSupport("YA".equalsIgnoreCase(otherSupport));

                // Remove the `apply_otherSupportName` field, as it doesn't exist in the Application class
                // appStatus.setApply_otherSupportName(resultSet.getString("apply_otherSupportName")); // Remove this line

                appStatus.setApplyOtherSupportAmount(resultSet.getDouble("apply_otherSupportAmount"));
                appStatus.setApplyPurpose(resultSet.getString("apply_purpose"));

                // Set the status as a string (not Date)
                appStatus.setApplyStatus(resultSet.getString("approve_status"));

                appStatus.setApplyDate(resultSet.getDate("apply_date"));
                appStatus.setDonationID(resultSet.getInt("donation_id"));
            pendingApplications.add(appStatus);
        }
    } catch (SQLException e) {
        Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, e);
    }

    return pendingApplications;
}
private List<Application> retrieveApprovedApplicationsByRole(String staffRole) {
    List<Application> approvedApplications = new ArrayList<>();
    String query = null;

    if ("HEA".equals(staffRole)) {
        // HEA retrieves applications they approved
        query = "SELECT a.*, approve_status FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id\n" +
                "WHERE sa.hea_review = 'TRUE' AND sa.app_stat_hea = 'TRUE'";
    } else if ("HEP".equals(staffRole)) {
        // HEP retrieves applications approved by both HEA and HEP
        query = "SELECT a.*, approve_status FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id\n" +
                "WHERE sa.hea_review = 'TRUE' AND sa.app_stat_hea = 'TRUE'\n" +
                "AND sa.hep_review = 'TRUE' AND sa.app_stat_hep = 'TRUE'";
    } else if ("UZSW".equals(staffRole)) {
        // UZSW retrieves applications fully approved by HEA, HEP, and UZSW
        query = "SELECT a.*, approve_status FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id\n" +
                "WHERE sa.hea_review = 'TRUE' AND sa.app_stat_hea = 'TRUE'\n" +
                "AND sa.hep_review = 'TRUE' AND sa.app_stat_hep = 'TRUE'\n" +
                "AND sa.uzsw_review = 'TRUE' AND sa.app_stat_uzsw = 'TRUE'";
    }

    try (Connection connection = dbconn.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query);
         ResultSet resultSet = preparedStatement.executeQuery()) {

        while (resultSet.next()) {
            Application appStatus = new Application();
                appStatus.setApplyID(resultSet.getInt("apply_id"));
                appStatus.setStudID(resultSet.getInt("stud_id"));
                appStatus.setDeadlineID(resultSet.getInt("deadline_id"));
                appStatus.setApplySession(resultSet.getString("apply_session"));
                appStatus.setApplyPart(resultSet.getInt("apply_part"));
                appStatus.setApplyCGPA(resultSet.getDouble("apply_cgpa"));
                appStatus.setApplyGPA(resultSet.getDouble("apply_gpa"));

                // Convert string values to boolean for food incentive and other support
                String foodIncentive = resultSet.getString("apply_foodincentive");
                appStatus.setApplyFoodIncentive("YA".equalsIgnoreCase(foodIncentive));

                String otherSupport = resultSet.getString("apply_otherSupport");
                appStatus.setApplyOtherSupport("YA".equalsIgnoreCase(otherSupport));

                // Remove the `apply_otherSupportName` field, as it doesn't exist in the Application class
                // appStatus.setApply_otherSupportName(resultSet.getString("apply_otherSupportName")); // Remove this line

                appStatus.setApplyOtherSupportAmount(resultSet.getDouble("apply_otherSupportAmount"));
                appStatus.setApplyPurpose(resultSet.getString("apply_purpose"));

                // Set the status as a string (not Date)
                appStatus.setApplyStatus(resultSet.getString("approve_status"));

                appStatus.setApplyDate(resultSet.getDate("apply_date"));
                appStatus.setDonationID(resultSet.getInt("donation_id"));
            approvedApplications.add(appStatus);
        }
    } catch (SQLException e) {
        Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, e);
    }

    return approvedApplications;
}
private List<Application> retrieveRejectedApplicationsByRole(String staffRole) {
    List<Application> rejectedApplications = new ArrayList<>();
    String query = null;

    if ("HEA".equals(staffRole)) {
        // HEA retrieves applications they rejected
        query = "SELECT a.*, approve_status FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id\n" +
                "WHERE sa.hea_review = 'TRUE' AND sa.app_stat_hea = 'FALSE'";
    } else if ("HEP".equals(staffRole)) {
        // HEP retrieves applications rejected at their stage
        query = "SELECT a.*, approve_status FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id\n" +
                "WHERE sa.hea_review = 'TRUE' AND sa.app_stat_hea = 'TRUE'\n" +
                "AND sa.hep_review = 'TRUE' AND sa.app_stat_hep = 'FALSE'";
    } else if ("UZSW".equals(staffRole)) {
        // UZSW retrieves applications rejected at their stage
        query = "SELECT a.*, approve_status FROM application a JOIN status_approval sa ON a.apply_id = sa.apply_id\n" +
                "WHERE sa.hea_review = 'TRUE' AND sa.app_stat_hea = 'TRUE'\n" +
                "AND sa.hep_review = 'TRUE' AND sa.app_stat_hep = 'TRUE'\n" +
                "AND sa.uzsw_review = 'TRUE' AND sa.app_stat_uzsw = 'FALSE'";
    }

    try (Connection connection = dbconn.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query);
         ResultSet resultSet = preparedStatement.executeQuery()) {

        while (resultSet.next()) {
            Application appStatus = new Application();
                appStatus.setApplyID(resultSet.getInt("apply_id"));
                appStatus.setStudID(resultSet.getInt("stud_id"));
                appStatus.setDeadlineID(resultSet.getInt("deadline_id"));
                appStatus.setApplySession(resultSet.getString("apply_session"));
                appStatus.setApplyPart(resultSet.getInt("apply_part"));
                appStatus.setApplyCGPA(resultSet.getDouble("apply_cgpa"));
                appStatus.setApplyGPA(resultSet.getDouble("apply_gpa"));

                // Convert string values to boolean for food incentive and other support
                String foodIncentive = resultSet.getString("apply_foodincentive");
                appStatus.setApplyFoodIncentive("YA".equalsIgnoreCase(foodIncentive));

                String otherSupport = resultSet.getString("apply_otherSupport");
                appStatus.setApplyOtherSupport("YA".equalsIgnoreCase(otherSupport));

                // Remove the `apply_otherSupportName` field, as it doesn't exist in the Application class
                // appStatus.setApply_otherSupportName(resultSet.getString("apply_otherSupportName")); // Remove this line

                appStatus.setApplyOtherSupportAmount(resultSet.getDouble("apply_otherSupportAmount"));
                appStatus.setApplyPurpose(resultSet.getString("apply_purpose"));

                // Set the status as a string (not Date)
                appStatus.setApplyStatus(resultSet.getString("approve_status"));

                appStatus.setApplyDate(resultSet.getDate("apply_date"));
                appStatus.setDonationID(resultSet.getInt("donation_id"));
            rejectedApplications.add(appStatus);
        }
    } catch (SQLException e) {
        Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, e);
    }

    return rejectedApplications;
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