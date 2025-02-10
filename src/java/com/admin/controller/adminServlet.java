/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.admin.controller;

import com.ApplicationDetails.model.ApplicationDetails;
import com.database.dbconn;
import com.staff.controller.StaffLoginServlet;
import com.staff.model.staff;
import com.user.model.Student;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author nasru
 */
public class adminServlet extends HttpServlet {

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
            out.println("<title>Servlet adminServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet adminServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            List<staff> HEAstaffList = retrieveStaffData("HEA");
            List<staff> HEPstaffList = retrieveStaffData("HEP");
            List<staff> UZSWstaffList = retrieveStaffData("UZSW");
            List<ApplicationDetails> totalApplications = countAllApplications();
            int totalUsers = countUsers();

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("HEAstaffList", HEAstaffList);
            request.setAttribute("HEPstaffList", HEPstaffList);
            request.setAttribute("UZSWstaffList", UZSWstaffList);
            request.setAttribute("totalApplications", totalApplications); // Pass to JSP

            request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
        } else if ("viewHEAStaff".equals(action)) {
            // Parse the current page from the request
            String pageParam = request.getParameter("page");
            int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;

            int itemsPerPage = 5; // Items per page
            int offset = (currentPage - 1) * itemsPerPage;

            // Retrieve paginated staff data
            List<staff> HEAstaffList = retrieveStaffData("HEA", offset, itemsPerPage);
            int totalStaffCount = countStaff("HEA"); // Total staff count
            int totalPages = (int) Math.ceil((double) totalStaffCount / itemsPerPage);

            // Set attributes for the JSP
            request.setAttribute("HEAstaffList", HEAstaffList);
            request.setAttribute("count", totalStaffCount);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            request.setAttribute("itemsPerPage", itemsPerPage);

            // Forward to the JSP page
            request.getRequestDispatcher("/WEB-INF/view/HEATable.jsp").forward(request, response);
        } else if ("viewHEPStaff".equals(action)) {
            // Parse the current page from the request
            String pageParam = request.getParameter("page");
            int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;

            int itemsPerPage = 5; // Items per page
            int offset = (currentPage - 1) * itemsPerPage;

            // Retrieve paginated staff data
            List<staff> HEAstaffList = retrieveStaffData("HEP", offset, itemsPerPage);
            int totalStaffCount = countStaff("HEP"); // Total staff count
            int totalPages = (int) Math.ceil((double) totalStaffCount / itemsPerPage);

            // Set attributes for the JSP
            request.setAttribute("HEPstaffList", HEAstaffList);
            request.setAttribute("count", totalStaffCount);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            request.setAttribute("itemsPerPage", itemsPerPage);

            // Forward to the JSP page
            request.getRequestDispatcher("/WEB-INF/view/HEPTable.jsp").forward(request, response);
        } else if ("viewUZSWStaff".equals(action)) {
            // Parse the current page from the request
            String pageParam = request.getParameter("page");
            int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;

            int itemsPerPage = 5; // Items per page
            int offset = (currentPage - 1) * itemsPerPage;

            // Retrieve paginated staff data
            List<staff> HEAstaffList = retrieveStaffData("UZSW", offset, itemsPerPage);
            int totalStaffCount = countStaff("UZSW"); // Total staff count
            int totalPages = (int) Math.ceil((double) totalStaffCount / itemsPerPage);

            // Set attributes for the JSP
            request.setAttribute("UZSWstaffList", HEAstaffList);
            request.setAttribute("count", totalStaffCount);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            request.setAttribute("itemsPerPage", itemsPerPage);

            // Forward to the JSP page
            request.getRequestDispatcher("/WEB-INF/view/UZSWTable.jsp").forward(request, response);
        } else if ("addStaff".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/view/addStaff.jsp").forward(request, response);
        } else if ("updateStaff".equals(action)) {
            // Redirect to updateStaffServlet with staffId parameter
            response.sendRedirect(request.getContextPath() + "/updateStaffServlet?staffId=" + request.getParameter("staffId"));
        } else if ("home".equals(action)) {
            List<staff> HEAstaffList = retrieveStaffData("HEA");
            List<staff> HEPstaffList = retrieveStaffData("HEP");
            List<staff> UZSWstaffList = retrieveStaffData("UZSW");
            List<ApplicationDetails> totalApplications = countAllApplications();

            // Set the staff lists as attributes
            request.setAttribute("HEAstaffList", HEAstaffList);
            request.setAttribute("HEPstaffList", HEPstaffList);
            request.setAttribute("UZSWstaffList", UZSWstaffList);
            request.setAttribute("totalApplications", totalApplications); // Pass to 
            int totalUsers = countUsers(); // Retrieve total number of users
            request.setAttribute("totalUsers", totalUsers);

            request.getRequestDispatcher("/WEB-INF/view/adminDashboard.jsp").forward(request, response);
        } else if ("viewApplication".equals(action)) {
            // Parse the current page from the request
            String pageParam = request.getParameter("page");
            int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;

            int itemsPerPage = 5; // Items per page
            int offset = (currentPage - 1) * itemsPerPage;

            // Retrieve paginated application data
            List<ApplicationDetails> applicationList = countAllApplications(offset, itemsPerPage);
            int totalApplications = countApplications(); // Total application count
            int totalPages = (int) Math.ceil((double) totalApplications / itemsPerPage);

            // Set attributes for the JSP
            request.setAttribute("ApplicationList", applicationList); // Corrected this line
            request.setAttribute("count", totalApplications);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("itemsPerPage", itemsPerPage);

            // Forward to the JSP page
            request.getRequestDispatcher("/WEB-INF/view/applicationTable.jsp").forward(request, response);
        } else if ("viewUsers".equals(action)) {
            // Parse pagination parameters
            String pageParam = request.getParameter("page");
            int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
            int itemsPerPage = 5; // Number of users per page
            int offset = (currentPage - 1) * itemsPerPage;

            // Retrieve paginated user data
            List<Student> userList = retrieveUsers(offset, itemsPerPage);
            int totalUsers = countUsers(); // Retrieve total number of users
            int totalPages = (int) Math.ceil((double) totalUsers / itemsPerPage);

            // Set attributes for the JSP
            request.setAttribute("userList", userList);
            request.setAttribute("count", totalUsers);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("itemsPerPage", itemsPerPage);

            // Forward to the user table JSP
            request.getRequestDispatcher("/WEB-INF/view/userTable.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
        }
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
        boolean isValid = false;

        String adminIdParam = request.getParameter("adminId");
        String admin_password = request.getParameter("admin_password");

        if (adminIdParam == null || admin_password == null) {
            request.setAttribute("error", "Admin ID and password are required.");
            request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
            return;
        }

        int admin_id = 0;
        try {
            admin_id = Integer.parseInt(adminIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Admin ID format.");
            request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
            return;
        }

        String query = "SELECT * FROM admin WHERE admin_id = ? AND admin_password = ?";

        try (Connection connection = dbconn.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, admin_id);
            preparedStatement.setString(2, admin_password);

            ResultSet resultSet = preparedStatement.executeQuery();
            isValid = resultSet.next(); // If a record is found, the admin is valid
        } catch (SQLException ex) {
            Logger.getLogger(adminServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("error", "Database error: " + ex.getMessage());
            request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
            return;
        }

        if (isValid) {
            HttpSession session = request.getSession();
            session.setAttribute("adminId", admin_id);

            List<staff> HEAstaffList = retrieveStaffData("HEA");
            List<staff> HEPstaffList = retrieveStaffData("HEP");
            List<staff> UZSWstaffList = retrieveStaffData("UZSW");
            List<ApplicationDetails> totalApplications = countAllApplications();

            // Set the staff lists as attributes
            request.setAttribute("HEAstaffList", HEAstaffList);
            request.setAttribute("HEPstaffList", HEPstaffList);
            request.setAttribute("UZSWstaffList", UZSWstaffList);
            request.setAttribute("totalApplications", totalApplications); // Pass to 
            int totalUsers = countUsers(); // Retrieve total number of users
            request.setAttribute("totalUsers", totalUsers);

            // Forward to the dashboard
            request.getRequestDispatcher("/WEB-INF/view/adminDashboard.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Invalid credentials");
            request.getRequestDispatcher("/adminLogin.jsp").forward(request, response);
        }
    }

    private List<staff> retrieveStaffData(String role) {
        List<staff> staffList = new ArrayList<>();
        String query = "SELECT staff_id, staff_name, staff_email FROM staff WHERE staff_role = ?";

        try (Connection connection = dbconn.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, role);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                staff staff = new staff();
                staff.setStaffid(resultSet.getInt("staff_id"));
                staff.setStaffname(resultSet.getString("staff_name"));
                staff.setStaffemail(resultSet.getString("staff_email"));
                staffList.add(staff);
            }
        } catch (SQLException e) {
            Logger.getLogger(adminServlet.class.getName()).log(Level.SEVERE, null, e);
        }

        return staffList;
    }

    private List<staff> retrieveStaffData(String role, int offset, int limit) {
        List<staff> staffList = new ArrayList<>();
        String query = "SELECT staff_id, staff_name, staff_email FROM staff WHERE staff_role = ? LIMIT ? OFFSET ?";

        try (Connection connection = dbconn.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, role);
            preparedStatement.setInt(2, limit);
            preparedStatement.setInt(3, offset);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                staff staff = new staff();
                staff.setStaffid(resultSet.getInt("staff_id"));
                staff.setStaffname(resultSet.getString("staff_name"));
                staff.setStaffemail(resultSet.getString("staff_email"));
                staffList.add(staff);
            }
        } catch (SQLException e) {
            Logger.getLogger(adminServlet.class.getName()).log(Level.SEVERE, null, e);
        }

        return staffList;
    }

    private int countStaff(String role) {
        String query = "SELECT COUNT(*) AS total FROM staff WHERE staff_role = ?";
        try (Connection connection = dbconn.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, role);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("total");
            }
        } catch (SQLException e) {
            Logger.getLogger(adminServlet.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }

// Method to count total applications
    private int countApplications() {
        String query = "SELECT COUNT(DISTINCT application.apply_id) AS total "
            + "FROM application "
            + "LEFT JOIN student ON application.stud_id = student.stud_id "
            + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id "
            + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
            + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id ";

        try (Connection connection = dbconn.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("total");
            }
        } catch (SQLException e) {
            Logger.getLogger(adminServlet.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }

    private List<ApplicationDetails> countAllApplications(int offset, int limit) {
        List<ApplicationDetails> applicationList = new ArrayList<>();
        String query = "SELECT DISTINCT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date "
                + "FROM application "
                + "LEFT JOIN student ON application.stud_id = student.stud_id "
                + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id "
                + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id "
                + "WHERE application.apply_id IS NOT NULL AND status_approval.approve_status IS NOT NULL "
                + "ORDER BY application.apply_id LIMIT ? OFFSET ?";

        try (Connection connection = dbconn.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, limit);
            preparedStatement.setInt(2, offset);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    ApplicationDetails appDetails = new ApplicationDetails();

                    // Set values for Application table
                    appDetails.setApplyId(resultSet.getObject("apply_id") != null ? resultSet.getInt("apply_id") : 0);
                    appDetails.setStudId(resultSet.getObject("stud_id") != null ? resultSet.getInt("stud_id") : 0);
                    appDetails.setDeadlineId(resultSet.getObject("deadline_id") != null ? resultSet.getInt("deadline_id") : 0);
                    appDetails.setApplySession(resultSet.getString("apply_session") != null ? resultSet.getString("apply_session") : "TIADA");
                    appDetails.setApplyPart(resultSet.getObject("apply_part") != null ? resultSet.getInt("apply_part") : 0);
                    appDetails.setApplyCgpa(resultSet.getObject("apply_cgpa") != null ? resultSet.getDouble("apply_cgpa") : 0.0);
                    appDetails.setApplyGpa(resultSet.getObject("apply_gpa") != null ? resultSet.getDouble("apply_gpa") : 0.0);
                    appDetails.setApplyFoodIncentive("YA".equalsIgnoreCase(resultSet.getString("apply_foodincentive")));
                    appDetails.setApplyOtherSupport("YA".equalsIgnoreCase(resultSet.getString("apply_otherSupport")));
                    appDetails.setApplyOtherSupportName(resultSet.getString("apply_otherSupportName") != null ? resultSet.getString("apply_otherSupportName") : "TIADA");
                    appDetails.setApplyOtherSupportAmount(resultSet.getObject("apply_otherSupportAmount") != null ? resultSet.getDouble("apply_otherSupportAmount") : 0.0);
                    appDetails.setApplyPurpose(resultSet.getString("apply_purpose") != null ? resultSet.getString("apply_purpose") : "TIADA");
                    appDetails.setApplyDate(resultSet.getString("apply_date") != null ? resultSet.getString("apply_date") : "TIADA");
                    appDetails.setDonationId(resultSet.getObject("donation_id") != null ? resultSet.getInt("donation_id") : 0);

                    // Set values for Student table
                    appDetails.setStudName(resultSet.getString("stud_name") != null ? resultSet.getString("stud_name") : "TIADA");
                    appDetails.setStudIc(resultSet.getString("stud_ic") != null ? resultSet.getString("stud_ic") : "TIADA");
                    appDetails.setStudEmail(resultSet.getString("stud_email") != null ? resultSet.getString("stud_email") : "TIADA");
                    appDetails.setStudPassword(resultSet.getString("stud_password") != null ? resultSet.getString("stud_password") : "TIADA");
                    appDetails.setStudState(resultSet.getString("stud_state") != null ? resultSet.getString("stud_state") : "TIADA");
                    appDetails.setStudZipcode(resultSet.getString("stud_zipcode") != null ? resultSet.getString("stud_zipcode") : "TIADA");
                    appDetails.setStudCourse(resultSet.getString("stud_course") != null ? resultSet.getString("stud_course") : "TIADA");
                    appDetails.setStudFaculty(resultSet.getString("stud_faculty") != null ? resultSet.getString("stud_faculty") : "TIADA");
                    appDetails.setStudCampus(resultSet.getString("stud_campus") != null ? resultSet.getString("stud_campus") : "TIADA");
                    appDetails.setStudGender(resultSet.getString("stud_gender") != null ? resultSet.getString("stud_gender") : "TIADA");
                    appDetails.setStudPhoneNum(resultSet.getString("stud_phoneNum") != null ? resultSet.getString("stud_phoneNum") : "TIADA");
                    appDetails.setStudBankName(resultSet.getString("stud_bankName") != null ? resultSet.getString("stud_bankName") : "TIADA");
                    appDetails.setStudBankNum(resultSet.getString("stud_bankNum") != null ? resultSet.getString("stud_bankNum") : "TIADA");
                    appDetails.setStudAddress(resultSet.getString("stud_address") != null ? resultSet.getString("stud_address") : "TIADA");
                    appDetails.setStudMarriage(resultSet.getString("stud_marriage") != null ? resultSet.getString("stud_marriage") : "TIADA");

                    // Set values for Guardian table
                    appDetails.setGuardId(resultSet.getObject("guard_id") != null ? resultSet.getInt("guard_id") : 0);
                    appDetails.setFatherName(resultSet.getString("father_name") != null ? resultSet.getString("father_name") : "TIADA");
                    appDetails.setFatherOccupation(resultSet.getString("father_occupation") != null ? resultSet.getString("father_occupation") : "TIADA");
                    appDetails.setFatherPhoneNum(resultSet.getString("father_phoneNum") != null ? resultSet.getString("father_phoneNum") : "TIADA");
                    appDetails.setFatherAddress(resultSet.getString("father_address") != null ? resultSet.getString("father_address") : "TIADA");
                    appDetails.setMotherName(resultSet.getString("mother_name") != null ? resultSet.getString("mother_name") : "TIADA");
                    appDetails.setMotherOccupation(resultSet.getString("mother_occupation") != null ? resultSet.getString("mother_occupation") : "TIADA");
                    appDetails.setMotherPhoneNum(resultSet.getString("mother_phoneNum") != null ? resultSet.getString("mother_phoneNum") : "TIADA");
                    appDetails.setMotherAddress(resultSet.getString("mother_address") != null ? resultSet.getString("mother_address") : "TIADA");
                    appDetails.setGuardName(resultSet.getString("guard_name") != null ? resultSet.getString("guard_name") : "TIADA");
                    appDetails.setGuardRelation(resultSet.getString("guard_relation") != null ? resultSet.getString("guard_relation") : "TIADA");
                    appDetails.setGuardOccupation(resultSet.getString("guard_occupation") != null ? resultSet.getString("guard_occupation") : "TIADA");
                    appDetails.setGuardPhoneNum(resultSet.getString("guard_phoneNum") != null ? resultSet.getString("guard_phoneNum") : "TIADA");
                    appDetails.setGuardAddress(resultSet.getString("guard_address") != null ? resultSet.getString("guard_address") : "TIADA");
                    appDetails.setGuardPostcode(resultSet.getString("guard_postcode") != null ? resultSet.getString("guard_postcode") : "TIADA");
                    appDetails.setGuardResidence(resultSet.getString("guard_residence") != null ? resultSet.getString("guard_residence") : "TIADA");
                    appDetails.setGuardIncome(resultSet.getObject("guard_income") != null ? resultSet.getDouble("guard_income") : 0.0);
                    appDetails.setMotherIncome(resultSet.getObject("mother_income") != null ? resultSet.getDouble("mother_income") : 0.0);
                    appDetails.setFatherIncome(resultSet.getObject("father_income") != null ? resultSet.getDouble("father_income") : 0.0);
                    appDetails.setOtherIncome(resultSet.getObject("other_income") != null ? resultSet.getDouble("other_income") : 0.0);

                    // Set values for Status Approval table
                    appDetails.setStaffId(resultSet.getObject("staff_id") != null ? resultSet.getInt("staff_id") : 0);
                    appDetails.setApproveStatus(resultSet.getString("approve_status") != null ? resultSet.getString("approve_status") : "TIADA");
                    appDetails.setAppStatHEA(resultSet.getString("app_stat_HEA") != null ? resultSet.getString("app_stat_HEA") : "TIADA");
                    appDetails.setAppStatHEP(resultSet.getString("app_stat_HEP") != null ? resultSet.getString("app_stat_HEP") : "TIADA");
                    appDetails.setAppStatUZSW(resultSet.getString("app_stat_UZSW") != null ? resultSet.getString("app_stat_UZSW") : "TIADA");

                    // Handle interview date safely
                    Date interviewDate = resultSet.getDate("interview_date");
                    appDetails.setInterviewDate(interviewDate != null ? interviewDate : null);

                    // Add the details object to the list
                    applicationList.add(appDetails);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(adminServlet.class.getName()).log(Level.SEVERE, "Database error: ", ex);
        }

        return applicationList;
    }

    private List<ApplicationDetails> countAllApplications() {
        List<ApplicationDetails> applicationList = new ArrayList<>();
        String query = "SELECT DISTINCT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date "
                + "FROM application "
                + "LEFT JOIN student ON application.stud_id = student.stud_id "
                + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id "
                + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id "
                + "WHERE application.apply_id IS NOT NULL AND status_approval.approve_status IS NOT NULL ";

        try (Connection connection = dbconn.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    ApplicationDetails appDetails = new ApplicationDetails();

                    // Set values for Application table
                    appDetails.setApplyId(resultSet.getObject("apply_id") != null ? resultSet.getInt("apply_id") : 0);
                    appDetails.setStudId(resultSet.getObject("stud_id") != null ? resultSet.getInt("stud_id") : 0);
                    appDetails.setDeadlineId(resultSet.getObject("deadline_id") != null ? resultSet.getInt("deadline_id") : 0);
                    appDetails.setApplySession(resultSet.getString("apply_session") != null ? resultSet.getString("apply_session") : "TIADA");
                    appDetails.setApplyPart(resultSet.getObject("apply_part") != null ? resultSet.getInt("apply_part") : 0);
                    appDetails.setApplyCgpa(resultSet.getObject("apply_cgpa") != null ? resultSet.getDouble("apply_cgpa") : 0.0);
                    appDetails.setApplyGpa(resultSet.getObject("apply_gpa") != null ? resultSet.getDouble("apply_gpa") : 0.0);
                    appDetails.setApplyFoodIncentive("YA".equalsIgnoreCase(resultSet.getString("apply_foodincentive")));
                    appDetails.setApplyOtherSupport("YA".equalsIgnoreCase(resultSet.getString("apply_otherSupport")));
                    appDetails.setApplyOtherSupportName(resultSet.getString("apply_otherSupportName") != null ? resultSet.getString("apply_otherSupportName") : "TIADA");
                    appDetails.setApplyOtherSupportAmount(resultSet.getObject("apply_otherSupportAmount") != null ? resultSet.getDouble("apply_otherSupportAmount") : 0.0);
                    appDetails.setApplyPurpose(resultSet.getString("apply_purpose") != null ? resultSet.getString("apply_purpose") : "TIADA");
                    appDetails.setApplyDate(resultSet.getString("apply_date") != null ? resultSet.getString("apply_date") : "TIADA");
                    appDetails.setDonationId(resultSet.getObject("donation_id") != null ? resultSet.getInt("donation_id") : 0);

                    // Set values for Student table
                    appDetails.setStudName(resultSet.getString("stud_name") != null ? resultSet.getString("stud_name") : "TIADA");
                    appDetails.setStudIc(resultSet.getString("stud_ic") != null ? resultSet.getString("stud_ic") : "TIADA");
                    appDetails.setStudEmail(resultSet.getString("stud_email") != null ? resultSet.getString("stud_email") : "TIADA");
                    appDetails.setStudPassword(resultSet.getString("stud_password") != null ? resultSet.getString("stud_password") : "TIADA");
                    appDetails.setStudState(resultSet.getString("stud_state") != null ? resultSet.getString("stud_state") : "TIADA");
                    appDetails.setStudZipcode(resultSet.getString("stud_zipcode") != null ? resultSet.getString("stud_zipcode") : "TIADA");
                    appDetails.setStudCourse(resultSet.getString("stud_course") != null ? resultSet.getString("stud_course") : "TIADA");
                    appDetails.setStudFaculty(resultSet.getString("stud_faculty") != null ? resultSet.getString("stud_faculty") : "TIADA");
                    appDetails.setStudCampus(resultSet.getString("stud_campus") != null ? resultSet.getString("stud_campus") : "TIADA");
                    appDetails.setStudGender(resultSet.getString("stud_gender") != null ? resultSet.getString("stud_gender") : "TIADA");
                    appDetails.setStudPhoneNum(resultSet.getString("stud_phoneNum") != null ? resultSet.getString("stud_phoneNum") : "TIADA");
                    appDetails.setStudBankName(resultSet.getString("stud_bankName") != null ? resultSet.getString("stud_bankName") : "TIADA");
                    appDetails.setStudBankNum(resultSet.getString("stud_bankNum") != null ? resultSet.getString("stud_bankNum") : "TIADA");
                    appDetails.setStudAddress(resultSet.getString("stud_address") != null ? resultSet.getString("stud_address") : "TIADA");
                    appDetails.setStudMarriage(resultSet.getString("stud_marriage") != null ? resultSet.getString("stud_marriage") : "TIADA");

                    // Set values for Guardian table
                    appDetails.setGuardId(resultSet.getObject("guard_id") != null ? resultSet.getInt("guard_id") : 0);
                    appDetails.setFatherName(resultSet.getString("father_name") != null ? resultSet.getString("father_name") : "TIADA");
                    appDetails.setFatherOccupation(resultSet.getString("father_occupation") != null ? resultSet.getString("father_occupation") : "TIADA");
                    appDetails.setFatherPhoneNum(resultSet.getString("father_phoneNum") != null ? resultSet.getString("father_phoneNum") : "TIADA");
                    appDetails.setFatherAddress(resultSet.getString("father_address") != null ? resultSet.getString("father_address") : "TIADA");
                    appDetails.setMotherName(resultSet.getString("mother_name") != null ? resultSet.getString("mother_name") : "TIADA");
                    appDetails.setMotherOccupation(resultSet.getString("mother_occupation") != null ? resultSet.getString("mother_occupation") : "TIADA");
                    appDetails.setMotherPhoneNum(resultSet.getString("mother_phoneNum") != null ? resultSet.getString("mother_phoneNum") : "TIADA");
                    appDetails.setMotherAddress(resultSet.getString("mother_address") != null ? resultSet.getString("mother_address") : "TIADA");
                    appDetails.setGuardName(resultSet.getString("guard_name") != null ? resultSet.getString("guard_name") : "TIADA");
                    appDetails.setGuardRelation(resultSet.getString("guard_relation") != null ? resultSet.getString("guard_relation") : "TIADA");
                    appDetails.setGuardOccupation(resultSet.getString("guard_occupation") != null ? resultSet.getString("guard_occupation") : "TIADA");
                    appDetails.setGuardPhoneNum(resultSet.getString("guard_phoneNum") != null ? resultSet.getString("guard_phoneNum") : "TIADA");
                    appDetails.setGuardAddress(resultSet.getString("guard_address") != null ? resultSet.getString("guard_address") : "TIADA");
                    appDetails.setGuardPostcode(resultSet.getString("guard_postcode") != null ? resultSet.getString("guard_postcode") : "TIADA");
                    appDetails.setGuardResidence(resultSet.getString("guard_residence") != null ? resultSet.getString("guard_residence") : "TIADA");
                    appDetails.setGuardIncome(resultSet.getObject("guard_income") != null ? resultSet.getDouble("guard_income") : 0.0);
                    appDetails.setMotherIncome(resultSet.getObject("mother_income") != null ? resultSet.getDouble("mother_income") : 0.0);
                    appDetails.setFatherIncome(resultSet.getObject("father_income") != null ? resultSet.getDouble("father_income") : 0.0);
                    appDetails.setOtherIncome(resultSet.getObject("other_income") != null ? resultSet.getDouble("other_income") : 0.0);

                    // Set values for Status Approval table
                    appDetails.setStaffId(resultSet.getObject("staff_id") != null ? resultSet.getInt("staff_id") : 0);
                    appDetails.setApproveStatus(resultSet.getString("approve_status") != null ? resultSet.getString("approve_status") : "TIADA");
                    appDetails.setAppStatHEA(resultSet.getString("app_stat_HEA") != null ? resultSet.getString("app_stat_HEA") : "TIADA");
                    appDetails.setAppStatHEP(resultSet.getString("app_stat_HEP") != null ? resultSet.getString("app_stat_HEP") : "TIADA");
                    appDetails.setAppStatUZSW(resultSet.getString("app_stat_UZSW") != null ? resultSet.getString("app_stat_UZSW") : "TIADA");

                    // Handle interview date safely
                    Date interviewDate = resultSet.getDate("interview_date");
                    appDetails.setInterviewDate(interviewDate != null ? interviewDate : null);

                    // Add the details object to the list
                    applicationList.add(appDetails);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(adminServlet.class.getName()).log(Level.SEVERE, "Database error: ", ex);
        }

        return applicationList;
    }

    private List<Student> retrieveUsers(int offset, int limit) {
        List<Student> users = new ArrayList<>();
        String sql = "SELECT * FROM student LIMIT ? OFFSET ?";

        try (Connection connection = dbconn.getConnection();
                PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            stmt.setInt(2, offset);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {

                    int s_id = rs.getInt("stud_id");
                    String s_name = rs.getString("stud_name");
                    String s_ic = rs.getString("stud_ic") != null ? rs.getString("stud_ic") : ""; // Default to empty string if null
                    String s_email = rs.getString("stud_email") != null ? rs.getString("stud_email") : "TIADA";
                    String s_password = rs.getString("stud_password");
                    String s_state = rs.getString("stud_state") != null ? rs.getString("stud_state") : "";
                    String s_zipcode = rs.getString("stud_zipcode") != null ? rs.getString("stud_zipcode") : "";
                    String s_course = rs.getString("stud_course") != null ? rs.getString("stud_course") : "TIADA";
                    String s_faculty = rs.getString("stud_faculty") != null ? rs.getString("stud_faculty") : "TIADA";
                    String s_campus = rs.getString("stud_campus") != null ? rs.getString("stud_campus") : "";
                    char s_marriage = rs.getString("stud_marriage") != null ? rs.getString("stud_marriage").charAt(0) : 'U'; // Default to 'U' (Unknown) if null
                    char s_gender = rs.getString("stud_gender") != null ? rs.getString("stud_gender").charAt(0) : 'U'; // Default to 'U' (Unknown) if null
                    String s_phoneNum = rs.getString("stud_phoneNum") != null ? rs.getString("stud_phoneNum") : "";
                    String s_bankNum = rs.getString("stud_bankNum") != null ? rs.getString("stud_bankNum") : "";
                    String s_bankName = rs.getString("stud_bankName") != null ? rs.getString("stud_bankName") : "";
                    String s_address = rs.getString("stud_address") != null ? rs.getString("stud_address") : "";

                    // Create a new Student object
                    Student st = new Student();

                    st.setStudID(s_id);
                    st.setStudName(s_name != null ? s_name : ""); // Default to empty string
                    st.setStudIC(s_ic);
                    st.setStudEmail(s_email);
                    st.setStudPass(s_password);
                    st.setStudState(s_state);
                    st.setStudZipCode(s_zipcode);
                    st.setStudCourse(s_course);
                    st.setStudFaculty(s_faculty);
                    st.setStudCampus(s_campus);
                    st.setStudMarriage(s_marriage);
                    st.setStudGender(s_gender);
                    st.setStudPhoneNum(s_phoneNum);
                    st.setStudBankNum(s_bankNum);
                    st.setStudBankName(s_bankName);
                    st.setStudAddress(s_address);
                    users.add(st);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    private int countUsers() {
        String query = "SELECT COUNT(*) AS total FROM student";
        try (Connection connection = dbconn.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("total");
            }
        } catch (SQLException e) {
            Logger.getLogger(adminServlet.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
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
