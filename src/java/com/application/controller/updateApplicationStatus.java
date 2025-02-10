/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.application.controller;

import com.ApplicationDetails.model.ApplicationDetails;
import javax.servlet.annotation.WebServlet;
import com.database.dbconn;
import com.staff.controller.StaffLoginServlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.staff.model.staff;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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
        Integer staffId = st != null ? st.getStaffid() : null;
        String staffRole = st != null ? st.getStaffrole() : null;

        String tab = request.getParameter("tab"); // Retrieve the tab parameter
        String page = request.getParameter("pages"); // Retrieve the page parameter

        if (staffId == null) {
            request.setAttribute("error", "Staff not logged in.");
            request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
            return;
        }

        String appID = request.getParameter("appID");
        String selectedAction = request.getParameter("selectedAction");
        String disemak = request.getParameter("disemak") != null ? "TRUE" : "FALSE";

        if (disemak.equals("FALSE")) {
            request.getSession().setAttribute("error", "You must check the box to update the application status.");
            String redirectUrl = determineRedirectUrl(staffRole, tab, page);
            response.sendRedirect(redirectUrl);
            return;
        }

        String approveStat = "DALAM PROSES";
        if (selectedAction.equalsIgnoreCase("GAGAL")) {
            approveStat = "GAGAL";
        } else if (selectedAction.equalsIgnoreCase("LULUS") && "UZSW".equalsIgnoreCase(staffRole)) {
            approveStat = "LULUS";
        }

        String query = null;
        boolean isUpdated = false;


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

                int rowsUpdated = statement.executeUpdate();
                isUpdated = rowsUpdated > 0;

                if (isUpdated) {
                    // Re-fetch application lists and update session
                    updateSessionAttributes(request, staffRole);
                    request.getSession().setAttribute("success", "Application status updated successfully.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "An error occurred while updating the application status.");
            String redirectUrl = determineRedirectUrl(staffRole, tab, page);
            response.sendRedirect(redirectUrl);
            return;
        }

        if (isUpdated) {
            String redirectUrl = determineRedirectUrl(staffRole, tab, page);
            response.sendRedirect(request.getContextPath() + redirectUrl);
        } else {
            request.setAttribute("errorMessage", "Failed to update application status.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private String determineRedirectUrl(String staffRole, String tab, String page) {
        String baseUrl = "/UZSWServlet";
        if ("HEA".equals(staffRole)) {
            baseUrl = "/HEAListPage";
        } else if ("HEP".equals(staffRole)) {
            baseUrl = "/HEPListPage";
        }
        return baseUrl + "?tab=" + tab + "&pages=" + page;
    }

    private void updateSessionAttributes(HttpServletRequest request, String staffRole) {
        HttpSession session = request.getSession();
        session.setAttribute("totalList", countAllApplicationsByRole(staffRole));
        session.setAttribute("pendingList", countPendingApplicationsByRole(staffRole));
        session.setAttribute("approvedList", countApprovedApplicationsByRole(staffRole));
        session.setAttribute("rejectedList", countRejectedApplicationsByRole(staffRole));
    }

    private List<ApplicationDetails> countPendingApplicationsByRole(String staffRole) {
        List<ApplicationDetails> pendingApplications = new ArrayList<>();
        String query = null;

        if ("HEA".equals(staffRole)) {
            // HEA receives all unreviewed applications
            query = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date FROM application \n"
                    + "LEFT JOIN student ON application.stud_id = student.stud_id \n"
                    + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id \n"
                    + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id \n"
                    + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                    + "WHERE status_approval.hea_review IS NULL AND status_approval.app_stat_hea IS NULL;";
        } else if ("HEP".equals(staffRole)) {
            // HEP receives applications approved by HEA but not yet reviewed by HEP
            query = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date FROM application \n"
                    + "LEFT JOIN student ON application.stud_id = student.stud_id \n"
                    + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id \n"
                    + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id \n"
                    + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                    + "WHERE status_approval.hea_review = 'TRUE' AND status_approval.app_stat_hea = 'LULUS'\n"
                    + "AND status_approval.hep_review IS NULL AND status_approval.app_stat_hep IS NULL;";
        } else if ("UZSW".equals(staffRole)) {
            // UZSW receives applications approved by both HEA and HEP but not yet reviewed by UZSW
            query = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date FROM application \n"
                    + "LEFT JOIN student ON application.stud_id = student.stud_id \n"
                    + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id \n"
                    + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id \n"
                    + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                    + "WHERE status_approval.hea_review = 'TRUE' AND status_approval.app_stat_hea = 'LULUS'\n"
                    + "AND status_approval.hep_review = 'TRUE' AND status_approval.app_stat_hep = 'LULUS'\n"
                    + "AND status_approval.uzsw_review IS NULL AND status_approval.app_stat_uzsw IS NULL;";
        }

        try (Connection connection = dbconn.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                ApplicationDetails appDetails = new ApplicationDetails();

                // Set values for Application table
                appDetails.setApplyId(resultSet.getInt("apply_id"));
                appDetails.setStudId(resultSet.getInt("stud_id"));
                appDetails.setDeadlineId(resultSet.getInt("deadline_id"));
                appDetails.setApplySession(resultSet.getString("apply_session"));
                appDetails.setApplyPart(resultSet.getInt("apply_part"));
                appDetails.setApplyCgpa(resultSet.getDouble("apply_cgpa"));
                appDetails.setApplyGpa(resultSet.getDouble("apply_gpa"));
                // Convert string values to boolean for food incentive and other support
                String foodIncentive = resultSet.getString("apply_foodincentive");
                appDetails.setApplyFoodIncentive("YA".equalsIgnoreCase(foodIncentive));

                String otherSupport = resultSet.getString("apply_otherSupport");
                appDetails.setApplyOtherSupport("YA".equalsIgnoreCase(otherSupport));
                appDetails.setApplyOtherSupportName(resultSet.getString("apply_otherSupportName"));
                appDetails.setApplyOtherSupportAmount(resultSet.getDouble("apply_otherSupportAmount"));
                appDetails.setApplyPurpose(resultSet.getString("apply_purpose"));
                appDetails.setApplyDate(resultSet.getString("apply_date"));
                appDetails.setDonationId(resultSet.getInt("donation_id"));

                // Set values for Student table
                appDetails.setStudName(resultSet.getString("stud_name"));
                appDetails.setStudIc(resultSet.getString("stud_ic"));
                appDetails.setStudEmail(resultSet.getString("stud_email"));
                appDetails.setStudPassword(resultSet.getString("stud_password"));
                appDetails.setStudState(resultSet.getString("stud_state"));
                appDetails.setStudZipcode(resultSet.getString("stud_zipcode"));
                appDetails.setStudCourse(resultSet.getString("stud_course"));
                appDetails.setStudFaculty(resultSet.getString("stud_faculty"));
                appDetails.setStudCampus(resultSet.getString("stud_campus"));
                appDetails.setStudGender(resultSet.getString("stud_gender"));
                appDetails.setStudPhoneNum(resultSet.getString("stud_phoneNum"));
                appDetails.setStudBankName(resultSet.getString("stud_bankName"));
                appDetails.setStudBankNum(resultSet.getString("stud_bankNum"));
                appDetails.setStudAddress(resultSet.getString("stud_address"));
                appDetails.setStudMarriage(resultSet.getString("stud_marriage"));

                // Set values for Guardian table
                appDetails.setGuardId(resultSet.getInt("guard_id"));
                appDetails.setFatherName(resultSet.getString("father_name"));
                appDetails.setFatherOccupation(resultSet.getString("father_occupation"));
                appDetails.setFatherPhoneNum(resultSet.getString("father_phoneNum"));
                appDetails.setFatherAddress(resultSet.getString("father_address"));
                appDetails.setMotherName(resultSet.getString("mother_name"));
                appDetails.setMotherOccupation(resultSet.getString("mother_occupation"));
                appDetails.setMotherPhoneNum(resultSet.getString("mother_phoneNum"));
                appDetails.setMotherAddress(resultSet.getString("mother_address"));
                appDetails.setGuardName(resultSet.getString("guard_name"));
                appDetails.setGuardRelation(resultSet.getString("guard_relation"));
                appDetails.setGuardOccupation(resultSet.getString("guard_occupation"));
                appDetails.setGuardPhoneNum(resultSet.getString("guard_phoneNum"));
                appDetails.setGuardAddress(resultSet.getString("guard_address"));
                appDetails.setGuardPostcode(resultSet.getString("guard_postcode"));
                appDetails.setGuardResidence(resultSet.getString("guard_residence"));
                appDetails.setGuardIncome(resultSet.getDouble("guard_income"));
                appDetails.setMotherIncome(resultSet.getDouble("mother_income"));
                appDetails.setFatherIncome(resultSet.getDouble("father_income"));
                appDetails.setOtherIncome(resultSet.getDouble("other_income"));

                // Set values for Status Approval table
                appDetails.setStaffId(resultSet.getInt("staff_id"));
                appDetails.setApproveStatus(resultSet.getString("approve_status"));
                appDetails.setAppStatHEA(resultSet.getString("app_stat_HEA"));
                appDetails.setAppStatHEP(resultSet.getString("app_stat_HEP"));
                appDetails.setAppStatUZSW(resultSet.getString("app_stat_UZSW"));
                appDetails.setHeaReview(resultSet.getString("hea_review"));
                appDetails.setHepReview(resultSet.getString("hep_review"));
                appDetails.setUzswReview(resultSet.getString("uzsw_review"));

                appDetails.setInterviewDate(resultSet.getDate("interview_date")); // Add this line

                // Add to list
                pendingApplications.add(appDetails);
            }
        } catch (SQLException e) {
            Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, e);
        }

        return pendingApplications;
    }

    private List<ApplicationDetails> countApprovedApplicationsByRole(String staffRole) {
        List<ApplicationDetails> approvedApplications = new ArrayList<>();
        String query = null;

        if ("HEA".equals(staffRole)) {
            // HEA retrieves applications they approved
            query = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date FROM application \n"
                    + "LEFT JOIN student ON application.stud_id = student.stud_id \n"
                    + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id \n"
                    + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id \n"
                    + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                    + "WHERE status_approval.hea_review = 'TRUE' AND status_approval.app_stat_hea = 'LULUS';";
        } else if ("HEP".equals(staffRole)) {
            // HEP retrieves applications approved by both HEA and HEP
            query = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date FROM application \n"
                    + "LEFT JOIN student ON application.stud_id = student.stud_id \n"
                    + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id \n"
                    + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id \n"
                    + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                    + "WHERE status_approval.hea_review = 'TRUE' AND status_approval.app_stat_hea = 'LULUS'\n"
                    + "AND status_approval.hep_review = 'TRUE' AND status_approval.app_stat_hep = 'LULUS';";
        } else if ("UZSW".equals(staffRole)) {
            // UZSW retrieves applications fully approved by HEA, HEP, and UZSW
            query = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date FROM application \n"
                    + "LEFT JOIN student ON application.stud_id = student.stud_id \n"
                    + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id \n"
                    + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id \n"
                    + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                    + "WHERE status_approval.hea_review = 'TRUE' AND status_approval.app_stat_hea = 'LULUS'\n"
                    + "AND status_approval.hep_review = 'TRUE' AND status_approval.app_stat_hep = 'LULUS'\n"
                    + "AND status_approval.uzsw_review = 'TRUE' AND status_approval.app_stat_uzsw = 'LULUS';";
        }

        try (Connection connection = dbconn.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                ApplicationDetails appDetails = new ApplicationDetails();

                // Set values for Application table
                appDetails.setApplyId(resultSet.getInt("apply_id"));
                appDetails.setStudId(resultSet.getInt("stud_id"));
                appDetails.setDeadlineId(resultSet.getInt("deadline_id"));
                appDetails.setApplySession(resultSet.getString("apply_session"));
                appDetails.setApplyPart(resultSet.getInt("apply_part"));
                appDetails.setApplyCgpa(resultSet.getDouble("apply_cgpa"));
                appDetails.setApplyGpa(resultSet.getDouble("apply_gpa"));
                // Convert string values to boolean for food incentive and other support
                String foodIncentive = resultSet.getString("apply_foodincentive");
                appDetails.setApplyFoodIncentive("YA".equalsIgnoreCase(foodIncentive));

                String otherSupport = resultSet.getString("apply_otherSupport");
                appDetails.setApplyOtherSupport("YA".equalsIgnoreCase(otherSupport));
                appDetails.setApplyOtherSupportName(resultSet.getString("apply_otherSupportName"));
                appDetails.setApplyOtherSupportAmount(resultSet.getDouble("apply_otherSupportAmount"));
                appDetails.setApplyPurpose(resultSet.getString("apply_purpose"));
                appDetails.setApplyDate(resultSet.getString("apply_date"));
                appDetails.setDonationId(resultSet.getInt("donation_id"));

                // Set values for Student table
                appDetails.setStudName(resultSet.getString("stud_name"));
                appDetails.setStudIc(resultSet.getString("stud_ic"));
                appDetails.setStudEmail(resultSet.getString("stud_email"));
                appDetails.setStudPassword(resultSet.getString("stud_password"));
                appDetails.setStudState(resultSet.getString("stud_state"));
                appDetails.setStudZipcode(resultSet.getString("stud_zipcode"));
                appDetails.setStudCourse(resultSet.getString("stud_course"));
                appDetails.setStudFaculty(resultSet.getString("stud_faculty"));
                appDetails.setStudCampus(resultSet.getString("stud_campus"));
                appDetails.setStudGender(resultSet.getString("stud_gender"));
                appDetails.setStudPhoneNum(resultSet.getString("stud_phoneNum"));
                appDetails.setStudBankName(resultSet.getString("stud_bankName"));
                appDetails.setStudBankNum(resultSet.getString("stud_bankNum"));
                appDetails.setStudAddress(resultSet.getString("stud_address"));
                appDetails.setStudMarriage(resultSet.getString("stud_marriage"));

                // Set values for Guardian table
                appDetails.setGuardId(resultSet.getInt("guard_id"));
                appDetails.setFatherName(resultSet.getString("father_name"));
                appDetails.setFatherOccupation(resultSet.getString("father_occupation"));
                appDetails.setFatherPhoneNum(resultSet.getString("father_phoneNum"));
                appDetails.setFatherAddress(resultSet.getString("father_address"));
                appDetails.setMotherName(resultSet.getString("mother_name"));
                appDetails.setMotherOccupation(resultSet.getString("mother_occupation"));
                appDetails.setMotherPhoneNum(resultSet.getString("mother_phoneNum"));
                appDetails.setMotherAddress(resultSet.getString("mother_address"));
                appDetails.setGuardName(resultSet.getString("guard_name"));
                appDetails.setGuardRelation(resultSet.getString("guard_relation"));
                appDetails.setGuardOccupation(resultSet.getString("guard_occupation"));
                appDetails.setGuardPhoneNum(resultSet.getString("guard_phoneNum"));
                appDetails.setGuardAddress(resultSet.getString("guard_address"));
                appDetails.setGuardPostcode(resultSet.getString("guard_postcode"));
                appDetails.setGuardResidence(resultSet.getString("guard_residence"));
                appDetails.setGuardIncome(resultSet.getDouble("guard_income"));
                appDetails.setMotherIncome(resultSet.getDouble("mother_income"));
                appDetails.setFatherIncome(resultSet.getDouble("father_income"));
                appDetails.setOtherIncome(resultSet.getDouble("other_income"));

                // Set values for Status Approval table
                appDetails.setStaffId(resultSet.getInt("staff_id"));
                appDetails.setApproveStatus(resultSet.getString("approve_status"));
                appDetails.setAppStatHEA(resultSet.getString("app_stat_HEA"));
                appDetails.setAppStatHEP(resultSet.getString("app_stat_HEP"));
                appDetails.setAppStatUZSW(resultSet.getString("app_stat_UZSW"));
                appDetails.setHeaReview(resultSet.getString("hea_review"));
                appDetails.setHepReview(resultSet.getString("hep_review"));
                appDetails.setUzswReview(resultSet.getString("uzsw_review"));

                appDetails.setInterviewDate(resultSet.getDate("interview_date")); // Add this line

                // Add to list
                approvedApplications.add(appDetails);
            }
        } catch (SQLException e) {
            Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, e);
        }

        return approvedApplications;
    }

    private List<ApplicationDetails> countRejectedApplicationsByRole(String staffRole) {
        List<ApplicationDetails> rejectedApplications = new ArrayList<>();
        String query = null;

        if ("HEA".equals(staffRole)) {
            query = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date FROM application \n"
                    + "LEFT JOIN student ON application.stud_id = student.stud_id \n"
                    + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id \n"
                    + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id \n"
                    + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                    + "WHERE status_approval.hea_review = 'TRUE' AND status_approval.app_stat_hea = 'GAGAL';";
        } else if ("HEP".equals(staffRole)) {
            query = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date FROM application \n"
                    + "LEFT JOIN student ON application.stud_id = student.stud_id \n"
                    + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id \n"
                    + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id \n"
                    + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                    + "WHERE status_approval.hea_review = 'TRUE' AND status_approval.hep_review = 'TRUE' \n"
                    + "AND status_approval.app_stat_hea = 'LULUS' AND status_approval.app_stat_hep = 'GAGAL';";
        } else if ("UZSW".equals(staffRole)) {
            query = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date FROM application \n"
                    + "LEFT JOIN student ON application.stud_id = student.stud_id \n"
                    + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id \n"
                    + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id \n"
                    + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                    + "WHERE status_approval.hea_review = 'TRUE' AND status_approval.hep_review = 'TRUE' \n"
                    + "AND status_approval.app_stat_hea = 'LULUS' AND status_approval.app_stat_hep = 'LULUS' \n"
                    + "AND status_approval.uzsw_review = 'TRUE' AND status_approval.app_stat_uzsw = 'GAGAL';";
        }

        try (Connection connection = dbconn.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                ApplicationDetails appDetails = new ApplicationDetails();

                // Set values for Application table
                appDetails.setApplyId(resultSet.getInt("apply_id"));
                appDetails.setStudId(resultSet.getInt("stud_id"));
                appDetails.setDeadlineId(resultSet.getInt("deadline_id"));
                appDetails.setApplySession(resultSet.getString("apply_session"));
                appDetails.setApplyPart(resultSet.getInt("apply_part"));
                appDetails.setApplyCgpa(resultSet.getDouble("apply_cgpa"));
                appDetails.setApplyGpa(resultSet.getDouble("apply_gpa"));
                // Convert string values to boolean for food incentive and other support
                String foodIncentive = resultSet.getString("apply_foodincentive");
                appDetails.setApplyFoodIncentive("YA".equalsIgnoreCase(foodIncentive));

                String otherSupport = resultSet.getString("apply_otherSupport");
                appDetails.setApplyOtherSupport("YA".equalsIgnoreCase(otherSupport));
                appDetails.setApplyOtherSupportName(resultSet.getString("apply_otherSupportName"));
                appDetails.setApplyOtherSupportAmount(resultSet.getDouble("apply_otherSupportAmount"));
                appDetails.setApplyPurpose(resultSet.getString("apply_purpose"));
                appDetails.setApplyDate(resultSet.getString("apply_date"));
                appDetails.setDonationId(resultSet.getInt("donation_id"));

                // Set values for Student table
                appDetails.setStudName(resultSet.getString("stud_name"));
                appDetails.setStudIc(resultSet.getString("stud_ic"));
                appDetails.setStudEmail(resultSet.getString("stud_email"));
                appDetails.setStudPassword(resultSet.getString("stud_password"));
                appDetails.setStudState(resultSet.getString("stud_state"));
                appDetails.setStudZipcode(resultSet.getString("stud_zipcode"));
                appDetails.setStudCourse(resultSet.getString("stud_course"));
                appDetails.setStudFaculty(resultSet.getString("stud_faculty"));
                appDetails.setStudCampus(resultSet.getString("stud_campus"));
                appDetails.setStudGender(resultSet.getString("stud_gender"));
                appDetails.setStudPhoneNum(resultSet.getString("stud_phoneNum"));
                appDetails.setStudBankName(resultSet.getString("stud_bankName"));
                appDetails.setStudBankNum(resultSet.getString("stud_bankNum"));
                appDetails.setStudAddress(resultSet.getString("stud_address"));
                appDetails.setStudMarriage(resultSet.getString("stud_marriage"));

                // Set values for Guardian table
                appDetails.setGuardId(resultSet.getInt("guard_id"));
                appDetails.setFatherName(resultSet.getString("father_name"));
                appDetails.setFatherOccupation(resultSet.getString("father_occupation"));
                appDetails.setFatherPhoneNum(resultSet.getString("father_phoneNum"));
                appDetails.setFatherAddress(resultSet.getString("father_address"));
                appDetails.setMotherName(resultSet.getString("mother_name"));
                appDetails.setMotherOccupation(resultSet.getString("mother_occupation"));
                appDetails.setMotherPhoneNum(resultSet.getString("mother_phoneNum"));
                appDetails.setMotherAddress(resultSet.getString("mother_address"));
                appDetails.setGuardName(resultSet.getString("guard_name"));
                appDetails.setGuardRelation(resultSet.getString("guard_relation"));
                appDetails.setGuardOccupation(resultSet.getString("guard_occupation"));
                appDetails.setGuardPhoneNum(resultSet.getString("guard_phoneNum"));
                appDetails.setGuardAddress(resultSet.getString("guard_address"));
                appDetails.setGuardPostcode(resultSet.getString("guard_postcode"));
                appDetails.setGuardResidence(resultSet.getString("guard_residence"));
                appDetails.setGuardIncome(resultSet.getDouble("guard_income"));
                appDetails.setMotherIncome(resultSet.getDouble("mother_income"));
                appDetails.setFatherIncome(resultSet.getDouble("father_income"));
                appDetails.setOtherIncome(resultSet.getDouble("other_income"));

                // Set values for Status Approval table
                appDetails.setStaffId(resultSet.getInt("staff_id"));
                appDetails.setApproveStatus(resultSet.getString("approve_status"));
                appDetails.setAppStatHEA(resultSet.getString("app_stat_HEA"));
                appDetails.setAppStatHEP(resultSet.getString("app_stat_HEP"));
                appDetails.setAppStatUZSW(resultSet.getString("app_stat_UZSW"));
                appDetails.setHeaReview(resultSet.getString("hea_review"));
                appDetails.setHepReview(resultSet.getString("hep_review"));
                appDetails.setUzswReview(resultSet.getString("uzsw_review"));

                appDetails.setInterviewDate(resultSet.getDate("interview_date")); // Add this line

                // Add to list
                rejectedApplications.add(appDetails);
            }
        } catch (SQLException e) {
            Logger.getLogger(StaffLoginServlet.class.getName()).log(Level.SEVERE, null, e);
        }

        return rejectedApplications;
    }

    private List<ApplicationDetails> countAllApplicationsByRole(String staffRole) {
        List<ApplicationDetails> applicationList = new ArrayList<>();
        String query = null;

        if ("HEA".equals(staffRole)) {
            query = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date FROM application LEFT JOIN student ON application.stud_id = student.stud_id\n"
                    + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id\n"
                    + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                    + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id;";
        } else if ("HEP".equals(staffRole)) {
            query = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date FROM application LEFT JOIN student ON application.stud_id = student.stud_id\n"
                    + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id\n"
                    + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                    + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id WHERE status_approval.hea_review = 'TRUE' AND status_approval.app_stat_hea = 'LULUS';";
        } else if ("UZSW".equals(staffRole)) {
            query = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date FROM application LEFT JOIN student ON application.stud_id = student.stud_id\n"
                    + "LEFT JOIN guardian ON application.stud_id = guardian.stud_id\n"
                    + "LEFT JOIN interview i ON application.apply_id = i.apply_id "
                    + "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id WHERE status_approval.hea_review = 'TRUE' AND status_approval.hep_review = 'TRUE' \n"
                    + "AND status_approval.app_stat_hea = 'LULUS' AND status_approval.app_stat_hep = 'LULUS';";
        }

        try (Connection connection = dbconn.getConnection();
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                ApplicationDetails appDetails = new ApplicationDetails();

                // Set values for Application table
                appDetails.setApplyId(resultSet.getInt("apply_id"));
                appDetails.setStudId(resultSet.getInt("stud_id"));
                appDetails.setDeadlineId(resultSet.getInt("deadline_id"));
                appDetails.setApplySession(resultSet.getString("apply_session"));
                appDetails.setApplyPart(resultSet.getInt("apply_part"));
                appDetails.setApplyCgpa(resultSet.getDouble("apply_cgpa"));
                appDetails.setApplyGpa(resultSet.getDouble("apply_gpa"));
                // Convert string values to boolean for food incentive and other support
                String foodIncentive = resultSet.getString("apply_foodincentive");
                appDetails.setApplyFoodIncentive("YA".equalsIgnoreCase(foodIncentive));

                String otherSupport = resultSet.getString("apply_otherSupport");
                appDetails.setApplyOtherSupport("YA".equalsIgnoreCase(otherSupport));

                appDetails.setApplyOtherSupportName(resultSet.getString("apply_otherSupportName"));
                appDetails.setApplyOtherSupportAmount(resultSet.getDouble("apply_otherSupportAmount"));
                appDetails.setApplyPurpose(resultSet.getString("apply_purpose"));
                appDetails.setApplyDate(resultSet.getString("apply_date"));
                appDetails.setDonationId(resultSet.getInt("donation_id"));

                // Set values for Student table
                appDetails.setStudName(resultSet.getString("stud_name"));
                appDetails.setStudIc(resultSet.getString("stud_ic"));
                appDetails.setStudEmail(resultSet.getString("stud_email"));
                appDetails.setStudPassword(resultSet.getString("stud_password"));
                appDetails.setStudState(resultSet.getString("stud_state"));
                appDetails.setStudZipcode(resultSet.getString("stud_zipcode"));
                appDetails.setStudCourse(resultSet.getString("stud_course"));
                appDetails.setStudFaculty(resultSet.getString("stud_faculty"));
                appDetails.setStudCampus(resultSet.getString("stud_campus"));
                appDetails.setStudGender(resultSet.getString("stud_gender"));
                appDetails.setStudPhoneNum(resultSet.getString("stud_phoneNum"));
                appDetails.setStudBankName(resultSet.getString("stud_bankName"));
                appDetails.setStudBankNum(resultSet.getString("stud_bankNum"));
                appDetails.setStudAddress(resultSet.getString("stud_address"));
                appDetails.setStudMarriage(resultSet.getString("stud_marriage"));

                // Set values for Guardian table
                appDetails.setGuardId(resultSet.getInt("guard_id"));
                appDetails.setFatherName(resultSet.getString("father_name"));
                appDetails.setFatherOccupation(resultSet.getString("father_occupation"));
                appDetails.setFatherPhoneNum(resultSet.getString("father_phoneNum"));
                appDetails.setFatherAddress(resultSet.getString("father_address"));
                appDetails.setMotherName(resultSet.getString("mother_name"));
                appDetails.setMotherOccupation(resultSet.getString("mother_occupation"));
                appDetails.setMotherPhoneNum(resultSet.getString("mother_phoneNum"));
                appDetails.setMotherAddress(resultSet.getString("mother_address"));
                appDetails.setGuardName(resultSet.getString("guard_name"));
                appDetails.setGuardRelation(resultSet.getString("guard_relation"));
                appDetails.setGuardOccupation(resultSet.getString("guard_occupation"));
                appDetails.setGuardPhoneNum(resultSet.getString("guard_phoneNum"));
                appDetails.setGuardAddress(resultSet.getString("guard_address"));
                appDetails.setGuardPostcode(resultSet.getString("guard_postcode"));
                appDetails.setGuardResidence(resultSet.getString("guard_residence"));
                appDetails.setGuardIncome(resultSet.getDouble("guard_income"));
                appDetails.setMotherIncome(resultSet.getDouble("mother_income"));
                appDetails.setFatherIncome(resultSet.getDouble("father_income"));
                appDetails.setOtherIncome(resultSet.getDouble("other_income"));

                // Set values for Status Approval table
                appDetails.setStaffId(resultSet.getInt("staff_id"));
                appDetails.setApproveStatus(resultSet.getString("approve_status"));
                appDetails.setAppStatHEA(resultSet.getString("app_stat_HEA"));
                appDetails.setAppStatHEP(resultSet.getString("app_stat_HEP"));
                appDetails.setAppStatUZSW(resultSet.getString("app_stat_UZSW"));
                appDetails.setHeaReview(resultSet.getString("hea_review"));
                appDetails.setHepReview(resultSet.getString("hep_review"));
                appDetails.setUzswReview(resultSet.getString("uzsw_review"));

                appDetails.setInterviewDate(resultSet.getDate("interview_date")); // Add this line

                // Add to list
                applicationList.add(appDetails);
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
        return "Short description";
    }// </editor-fold>

}
