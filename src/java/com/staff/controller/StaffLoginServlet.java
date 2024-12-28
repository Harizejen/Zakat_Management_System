/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.staff.controller;

import com.database.dbconn;
import com.staff.model.staff;
import com.application.model.Application;
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

    int staffId = 0;
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
        
        HttpSession session = request.getSession();

        String userRole = (String) session.getAttribute("role");
            
        // Retrieve application counts
        int totalCount = dbconn.getAppCount();
        int pendingCount = dbconn.getAppCountByStatus("MENUNGGU");
        int approvedCount = dbconn.getAppCountByStatus("DISAHKAN");
        int rejectedCount = dbconn.getAppCountByStatus("DITOLAK");

        // Set the counts as attributes
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("approvedCount", approvedCount);
        request.setAttribute("rejectedCount", rejectedCount);

        // Retrieve all staff data for the dashboard
        List<Application> totalList = retrieveTotalApp();
        List<Application> pendingList = retrievePendingApp();
        List<Application> approvedList = retrieveApprovedApp();
        List<Application> rejectedList = retrieveRejectedApp();

        // Set the staff lists as attributes
        request.setAttribute("totalList", totalList);
        request.setAttribute("pendingList", pendingList);
        request.setAttribute("approvedList", approvedList);
        request.setAttribute("rejectedList", rejectedList);

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
        request.getRequestDispatcher("/staffLogin.jsp").forward(request, response);
    }
}

private List<Application> retrievePendingApp() {
    List<Application> pendingList = new ArrayList<>();
    String query = "SELECT * FROM application WHERE apply_status = 'MENUNGGU' ";

    try (Connection connection = dbconn.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query);
         ResultSet resultSet = preparedStatement.executeQuery()) {
         
        while (resultSet.next()) {
            Application app = new Application();
            app.setApplyID(resultSet.getInt("apply_id"));
            pendingList.add(app);
        }
    } catch (SQLException e) {
        Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, e);
    }

    return pendingList;
}    
    
private List<Application> retrieveApprovedApp() {
    List<Application> approvedList = new ArrayList<>();
    String query = "SELECT * FROM application WHERE apply_status = 'DISAHKAN' ";

    try (Connection connection = dbconn.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query);
         ResultSet resultSet = preparedStatement.executeQuery()) {
         
        while (resultSet.next()) {
            Application app = new Application();
            app.setApplyID(resultSet.getInt("apply_id"));
            approvedList.add(app);
        }
    } catch (SQLException e) {
        Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, e);
    }

    return approvedList;
} 

private List<Application> retrieveRejectedApp() {
    List<Application> rejectedList = new ArrayList<>();
    String query = "SELECT * FROM application WHERE apply_status = 'DITOLAK' ";

    try (Connection connection = dbconn.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query);
         ResultSet resultSet = preparedStatement.executeQuery()) {
         
        while (resultSet.next()) {
            Application app = new Application();
            app.setApplyID(resultSet.getInt("apply_id"));
            rejectedList.add(app);
        }
    } catch (SQLException e) {
        Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, e);
    }

    return rejectedList;
} 

private List<Application> retrieveTotalApp() {
    List<Application> totalList = new ArrayList<>();
    String query = "SELECT * FROM application";

    try (Connection connection = dbconn.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query);
         ResultSet resultSet = preparedStatement.executeQuery()) {
         
        while (resultSet.next()) {
            Application app = new Application();
            app.setApplyID(resultSet.getInt("apply_id"));
            totalList.add(app);
        }
    } catch (SQLException e) {
        Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, e);
    }

    return totalList;
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
