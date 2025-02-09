/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.application.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.ApplicationDetails.model.ApplicationDetails;
import com.database.dbconn;
import com.staff.model.staff;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author User
 */
//@WebServlet(name = "searchApp", urlPatterns = {"/searchApp"})
public class searchApp extends HttpServlet {

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
            out.println("<title>Servlet searchApp</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet searchApp at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        String query = request.getParameter("query");

        // Retrieve staff details from the session
    staff st = (staff) request.getSession().getAttribute("staff_data");
    Integer staffId = st != null ? st.getStaffid() : null;
    String staffRole = st != null ? st.getStaffrole() : null;

    if (staffId == null) {
        request.setAttribute("error", "Staff not logged in.");
        request.getRequestDispatcher("/staff_login.jsp").forward(request, response);
        return;
    }
        
        List<ApplicationDetails> searchList = new ArrayList<>();

        if (query != null && !query.trim().isEmpty()) {
            searchList = searchApplications(query, staffRole);
        }

        // Store the search results in the session
        session.setAttribute("searchList", searchList);

        String redirectPage;
        if ("HEA".equals(staffRole)) {
            redirectPage = "WEB-INF/view/ApplicationListHEA.jsp?tab=search";
        } else if ("HEP".equals(staffRole)) {
            redirectPage = "WEB-INF/view/ApplicationListHEP.jsp?tab=search";
        } else if ("UZSW".equals(staffRole)) {
            redirectPage = "WEB-INF/view/USZWlist.jsp?tab=search";
        } else {
            redirectPage = "/staff_login.jsp"; // Fallback if role is not recognized
        }
        request.getRequestDispatcher(redirectPage).forward(request, response);
    }
private List<ApplicationDetails> searchApplications(String query, String staffRole) {
        List<ApplicationDetails> applications = new ArrayList<>();
        String sql = null;

        // Add role-based filtering if necessary
        if ("HEA".equals(staffRole)) {
            sql = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date " +
                     "FROM application " +
                     "LEFT JOIN student ON application.stud_id = student.stud_id " +
                     "LEFT JOIN guardian ON application.stud_id = guardian.stud_id " +
                     "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id " +
                    "LEFT JOIN interview i ON application.apply_id = i.apply_id " +
                     "WHERE (student.stud_name LIKE ? OR student.stud_id LIKE ? OR application.apply_date LIKE ?) ";
        } else if ("HEP".equals(staffRole)) {
            sql = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date " +
                     "FROM application " +
                     "LEFT JOIN student ON application.stud_id = student.stud_id " +
                     "LEFT JOIN guardian ON application.stud_id = guardian.stud_id " +
                     "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id " +
                    "LEFT JOIN interview i ON application.apply_id = i.apply_id " +
                     "WHERE status_approval.hea_review = 'TRUE' AND status_approval.app_stat_hea = 'LULUS' AND (student.stud_name LIKE ? OR student.stud_id LIKE ? OR application.apply_date LIKE ?) ";
        } else if ("UZSW".equals(staffRole)) {
            sql = "SELECT application.*, student.*, guardian.*, status_approval.*, i.iv_date AS interview_date " +
                     "FROM application " +
                     "LEFT JOIN student ON application.stud_id = student.stud_id " +
                     "LEFT JOIN guardian ON application.stud_id = guardian.stud_id " +
                     "LEFT JOIN status_approval ON application.apply_id = status_approval.apply_id " +
                    "LEFT JOIN interview i ON application.apply_id = i.apply_id " +
                     "WHERE status_approval.hea_review = 'TRUE' AND status_approval.hep_review = 'TRUE' \n" +
                    "AND status_approval.app_stat_hea = 'LULUS' AND status_approval.app_stat_hep = 'LULUS' AND (student.stud_name LIKE ? OR student.stud_id LIKE ? OR application.apply_date LIKE ?) ";
        }

        try (Connection connection = dbconn.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            String searchPattern = "%" + query + "%";
            preparedStatement.setString(1, searchPattern);
            preparedStatement.setString(2, searchPattern);
            preparedStatement.setString(3, searchPattern);

            ResultSet resultSet = preparedStatement.executeQuery();

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

                applications.add(appDetails);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return applications;
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
        processRequest(request, response);
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
