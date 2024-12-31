/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.borang_maklumat.controller;

import com.database.dbconn;
import com.user.model.Student;
import com.guard.model.guardian;
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

/**
 *
 * @author User
 */
public class borangMaklumatServlet extends HttpServlet {

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
            out.println("<title>Servlet borangMaklumatServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet borangMaklumatServlet at " + request.getContextPath() + "</h1>");
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
    // Retrieve student ID from the session
    int studId = (Integer) request.getSession().getAttribute("studentID");

    // SQL to retrieve student details
    String selectStudentQuery = "SELECT * FROM student WHERE stud_id = ?";
    try (Connection connection = dbconn.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(selectStudentQuery)) {

        preparedStatement.setInt(1, studId);
        ResultSet studentResultSet = preparedStatement.executeQuery();

        if (studentResultSet.next()) {
            // Create a Student object and populate it with retrieved details
            Student student = new Student();
            student.setStudID(studentResultSet.getInt("stud_id"));
            student.setStudName(studentResultSet.getString("stud_name"));
            student.setStudIC(studentResultSet.getString("stud_ic"));
            student.setStudAddress(studentResultSet.getString("stud_address"));
            student.setStudZipCode(studentResultSet.getString("stud_zipcode"));
            student.setStudState(studentResultSet.getString("stud_state"));
            student.setStudPhoneNum(studentResultSet.getString("stud_phoneNum"));
            student.setStudGender(studentResultSet.getString("stud_gender").charAt(0));
            student.setStudMarriage(studentResultSet.getString("stud_marriage").charAt(0));
            student.setStudCourse(studentResultSet.getString("stud_course"));
            student.setStudFaculty(studentResultSet.getString("stud_faculty"));
            student.setStudCampus(studentResultSet.getString("stud_campus"));
            student.setStudBankNum(studentResultSet.getString("stud_bankNum"));
            student.setStudBankName(studentResultSet.getString("stud_bankName"));

            // Set the student object as a request attribute
            request.setAttribute("student", student);

            request.getRequestDispatcher("/WEB-INF/view/borangMaklumat.jsp").forward(request, response);
        } else {
            // Handle case where student is not found
            request.setAttribute("error", "Student not found.");
            request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("error", "Database error: " + e.getMessage());
        request.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(request, response);
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
        boolean upStud = false;
        boolean upGuard = false;

        // Gather parameters
        String stud_ic = request.getParameter("stud_ic");
        String stud_name = request.getParameter("stud_name").toUpperCase();
        String stud_address = request.getParameter("stud_address");
        String stud_zipcode = request.getParameter("stud_zipcode");
        String stud_state = request.getParameter("stud_state");
        String stud_phoneNum = request.getParameter("stud_phoneNum");
        char stud_gender = request.getParameter("stud_gender").charAt(0);
        char stud_marriage = request.getParameter("stud_marriage").charAt(0);
        int stud_id = Integer.parseInt(request.getParameter("stud_id"));
        String stud_course = request.getParameter("stud_course");
        String stud_faculty = request.getParameter("stud_faculty");
        String stud_campus = request.getParameter("stud_campus");
        String stud_bankNum = request.getParameter("stud_bankNum");
        String stud_bankName = request.getParameter("stud_bankName");

        // Guardian Information
        String father_name = request.getParameter("father_name");
        String father_occupation = request.getParameter("father_occupation");
        double father_income = Double.parseDouble(request.getParameter("father_income"));
        String father_address = request.getParameter("father_address");
        String father_phoneNum = request.getParameter("father_phoneNum");
        String mother_name = request.getParameter("mother_name");
        String mother_occupation = request.getParameter("mother_occupation");
        double mother_income = Double.parseDouble(request.getParameter("mother_income"));
        String mother_address = request.getParameter("mother_address");
        String mother_phoneNum = request.getParameter("mother_phoneNum");
        String guard_name = request.getParameter("guard_name");
        String guard_occupation = request.getParameter("guard_occupation");
        double guard_income = Double.parseDouble(request.getParameter("guard_income"));
        String guard_address = request.getParameter("guard_address");
        String guard_postcode = request.getParameter("guard_postcode");
        String guard_phoneNum = request.getParameter("guard_phoneNum");
        String guard_relation = request.getParameter("guard_relation");
        char guard_residence = request.getParameter("guard_residence").charAt(0);
        double other_income = Double.parseDouble(request.getParameter("other_income"));

        String updateStudQuery = "UPDATE student SET " +
                                 "stud_name = ?, stud_ic = ?, stud_state = ?, stud_zipcode = ?, " +
                                 "stud_course = ?, stud_faculty = ?, stud_campus = ?, stud_gender = ?, " +
                                 "stud_phoneNum = ?, stud_bankName = ?, stud_bankNum = ?, stud_address = ?, " +
                                 "stud_marriage = ? WHERE stud_id = ?";

        try (Connection conn = dbconn.getConnection()) {
            conn.setAutoCommit(false); // Start transaction

            // Update Student
            try (PreparedStatement pstmt = conn.prepareStatement(updateStudQuery)) {
                pstmt.setString(1, stud_name);
                pstmt.setString(2, stud_ic);
                pstmt.setString(3, stud_state);
                pstmt.setString(4, stud_zipcode);
                pstmt.setString(5, stud_course);
                pstmt.setString(6, stud_faculty);
                pstmt.setString(7, stud_campus);
                pstmt.setString(8, String.valueOf(stud_gender));
                pstmt.setString(9, stud_phoneNum);
                pstmt.setString(10, stud_bankName);
                pstmt.setString(11, stud_bankNum);
                pstmt.setString(12, stud_address);
                pstmt.setString(13, String.valueOf(stud_marriage));
                pstmt.setInt(14, stud_id);

                upStud = pstmt.executeUpdate() > 0;
            }

            // Check if guardian exists
            String checkGuardian = "SELECT guard_id FROM guardian WHERE stud_id = ?";
            try (PreparedStatement ps2 = conn.prepareStatement(checkGuardian)) {
                ps2.setInt(1, stud_id);
                ResultSet rs = ps2.executeQuery();

                if (rs.next()) {
                    // Update Guardian
                    String updateGuardian = "UPDATE guardian SET " +
                                            "father_name = ?, father_occupation = ?, father_phoneNum = ?, father_address = ?, " +
                                            "mother_name = ?, mother_occupation = ?, mother_phoneNum = ?, mother_address = ?, " +
                                            "guard_name = ?, guard_relation = ?, guard_occupation = ?, guard_phoneNum = ?, " +
                                            "guard_address = ?, guard_postcode = ?, guard_residence = ?, guard_income = ?, " +
                                            "mother_income = ?, father_income = ?, other_income = ? WHERE guard_id = ?";
                    try (PreparedStatement ps3 = conn.prepareStatement(updateGuardian)) {
                        ps3.setString(1, father_name);
                        ps3.setString(2, father_occupation);
                        ps3.setString(3, father_phoneNum);
                        ps3.setString(4, father_address);
                        ps3.setString(5, mother_name);
                        ps3.setString(6, mother_occupation);
                        ps3.setString(7, mother_phoneNum);
                        ps3.setString(8, mother_address);
                        ps3.setString(9, guard_name);
                        ps3.setString(10, guard_relation);
                        ps3.setString(11, guard_occupation);
                        ps3.setString(12, guard_phoneNum);
                        ps3.setString(13, guard_address);
                        ps3.setString(14, guard_postcode);
                        ps3.setString(15, String.valueOf(guard_residence));
                        ps3.setDouble(16, guard_income);
                        ps3.setDouble(17, mother_income);
                        ps3.setDouble(18, father_income);
                        ps3.setDouble(19, other_income);
                        ps3.setInt(20, rs.getInt("guard_id"));

                        upGuard = ps3.executeUpdate() > 0;
                    }
                } else {
                    // Insert Guardian
                    String insertGuardian = "INSERT INTO guardian " +
                                            "(stud_id, father_name, father_occupation, father_phoneNum, father_address, " +
                                            "mother_name, mother_occupation, mother_phoneNum, mother_address, " +
                                            "guard_name, guard_relation, guard_occupation, guard_phoneNum, guard_address, " +
                                            "guard_postcode, guard_residence, guard_income, mother_income, father_income, other_income) " +
                                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement ps4 = conn.prepareStatement(insertGuardian)) {
                        ps4.setInt(1, stud_id);
                        ps4.setString(2, father_name);
                        ps4.setString(3, father_occupation);
                        ps4.setString(4, father_phoneNum);
                        ps4.setString(5, father_address);
                        ps4.setString(6, mother_name);
                        ps4.setString(7, mother_occupation);
                        ps4.setString(8, mother_phoneNum);
                        ps4.setString(9, mother_address);
                        ps4.setString(10, guard_name);
                        ps4.setString(11, guard_relation);
                        ps4.setString(12, guard_occupation);
                        ps4.setString(13, guard_phoneNum);
                        ps4.setString(14, guard_address);
                        ps4.setString(15, guard_postcode);
                        ps4.setString(16, String.valueOf(guard_residence));
                        ps4.setDouble(17, guard_income);
                        ps4.setDouble(18, mother_income);
                        ps4.setDouble(19, father_income);
                        ps4.setDouble(20, other_income);

                        upGuard = ps4.executeUpdate() > 0;
                    }
                }
            }

            if (upStud && upGuard) {
                conn.commit(); // Commit transaction
                request.setAttribute("stud_id", stud_id);
                request.getRequestDispatcher("/WEB-INF/view/applicationPage.jsp").forward(request, response);
            } else {
                conn.rollback(); // Rollback transaction
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log error
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
