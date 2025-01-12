/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package com.user.model;

import com.database.dbconn;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author User
 */
public class Student implements Serializable {
    private int stud_id;
    private String stud_name;
    private String stud_ic;
    private String stud_email;
    private String stud_password;
    private String stud_state;
    private String stud_zipcode;
    private String stud_course;
    private String stud_faculty;
    private String stud_campus;
    private char stud_marriage;
    private char stud_gender;
    private String stud_phoneNum;
    private String stud_bankNum;
    private String stud_bankName;
    private String stud_address;

    // Constructor
    public Student() {}
    
    public Student(int stud_id, String stud_name, String stud_ic, String stud_email, String stud_password, String stud_state, String stud_zipcode, String stud_course, String stud_faculty, String stud_campus, char stud_marriage, char stud_gender,String stud_phoneNum,String stud_bankNum, String stud_bankName, String stud_address){
        this.stud_id = stud_id;
        this.stud_name = stud_name;
        this.stud_ic = stud_ic;
        this.stud_email = stud_email;
        this.stud_password = stud_password;
        this.stud_state = stud_state;
        this.stud_zipcode = stud_zipcode;
        this.stud_course = stud_course;
        this.stud_faculty = stud_faculty;
        this.stud_campus = stud_campus;
        this.stud_marriage = stud_marriage;
        this.stud_gender = stud_gender;
        this.stud_phoneNum = stud_phoneNum;
        this.stud_bankNum = stud_bankNum;
        this.stud_bankName = stud_bankName;
        this.stud_address = stud_address;
    }

    // Getters
    public int getStudID() {
        return stud_id;
    }

    public String getStudName() {
        return stud_name;
    }
    
        /**
     * @return the stud_ic
     */
    public String getStudIC() {
        return stud_ic;
    }

    public String getStudEmail() {
        return stud_email;
    }

    public String getStudPass() {
        return stud_password;
    }

    public String getStudState() {
        return stud_state.toUpperCase();
    }
    
    public String getStudZipCode(){
        return stud_zipcode;
    }

    public String getStudCourse() {
        return stud_course;
    }

    public String getStudFaculty() {
        return stud_faculty;
    }

    public String getStudCampus() {
        return stud_campus;
    }

    public char getStudMarriage() {
        return stud_marriage;
    }

    public char getStudGender() {
        return stud_gender;
    }

    public String getStudPhoneNum() {
        return stud_phoneNum;
    }

    public String getStudBankNum() {
        return stud_bankNum;
    }

    public String getStudBankName() {
        return stud_bankName;
    }

    public String getStudAddress() {
        return stud_address;
    }

    // Setters
    public void setStudID(int stud_id) {
        this.stud_id = stud_id;
    }

    public void setStudName(String stud_name) {
        this.stud_name = stud_name;
    }
    
        /**
     * @param stud_ic the stud_ic to set
     */
    public void setStudIC(String stud_ic) {
        this.stud_ic = stud_ic;
    }


    public void setStudEmail(String stud_email) {
        this.stud_email = stud_email;
    }

    public void setStudPass(String stud_password) {
        this.stud_password = stud_password;
    }

    public void setStudState(String stud_state) {
        this.stud_state = stud_state;
    }
    
    public void setStudZipCode(String stud_zipcode){
        this.stud_zipcode = stud_zipcode;
    }

    public void setStudCourse(String stud_course) {
        this.stud_course = stud_course;
    }

    public void setStudFaculty(String stud_faculty) {
        this.stud_faculty = stud_faculty;
    }

    public void setStudCampus(String stud_campus) {
        this.stud_campus = stud_campus;
    }

    public void setStudMarriage(char stud_marriage) {
        this.stud_marriage = stud_marriage;
    }

    public void setStudGender(char stud_gender) {
        this.stud_gender = stud_gender;
    }

    public void setStudPhoneNum(String stud_phoneNum) {
        this.stud_phoneNum = stud_phoneNum;
    }

    public void setStudBankNum(String stud_bankNum) {
        this.stud_bankNum = stud_bankNum;
    }

    public void setStudBankName(String stud_bankName) {
        this.stud_bankName = stud_bankName;
    }

    public void setStudAddress(String stud_address) {
        this.stud_address = stud_address;
    }

    // Update Application
    public void updateApplication() {
        // Update application logic here
    }

    // Submit Application
    public void submitApplication() {
        // Submit application logic here
    }
    
    public String getGenderDisplay() {
        switch (stud_gender) {
            case 'L':
                return "LELAKI";
            case 'P':
                return "PEREMPUAN";
            default:
                return "UNKNOWN"; // Handle unexpected values
        }
    }
    
    public String getMarriageDisplay() {
        switch (stud_marriage) {
            case 'S':
                return "BUJANG";
            case 'M':
                return "BERKAHWIN";
            case 'D':
                return "BERCERAI";
            default:
                return "UNKNOWN"; // Handle unexpected values
        }
    }
    
   public boolean isValid() {
        boolean isValid = false;
        String query = "SELECT * FROM Student WHERE stud_id = ? AND stud_password =  ? " ;

        try (Connection connection = dbconn.getConnection(); // Use your dbconn class to get the connection
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
             
            preparedStatement.setInt(1, stud_id);
            preparedStatement.setString(2, stud_password);
            
            ResultSet resultSet = preparedStatement.executeQuery();
            isValid = resultSet.next(); // If a record is found, the student is valid

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isValid;
    }
   
    public Student findStudent(int stud_id) {
        Student st = null; // Initialize as null in case no student is found.
        String query = "SELECT * FROM Student WHERE stud_id = ?";
        try {
            Connection conn = dbconn.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, stud_id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Safely retrieve values, allowing for potential nulls
                String s_name = rs.getString("stud_name");
                String s_ic = rs.getString("stud_ic") != null ? rs.getString("stud_ic") : ""; // Default to empty string if null
                String s_email = rs.getString("stud_email");
                String s_password = rs.getString("stud_password");
                String s_state = rs.getString("stud_state") != null ? rs.getString("stud_state") : "";
                String s_zipcode = rs.getString("stud_zipcode") != null ? rs.getString("stud_zipcode") : "";
                String s_course = rs.getString("stud_course") != null ? rs.getString("stud_course") : "";
                String s_faculty = rs.getString("stud_faculty") != null ? rs.getString("stud_faculty") : "";
                String s_campus = rs.getString("stud_campus") != null ? rs.getString("stud_campus") : "";
                char s_marriage = rs.getString("stud_marriage") != null ? rs.getString("stud_marriage").charAt(0) : 'U'; // Default to 'U' (Unknown) if null
                char s_gender = rs.getString("stud_gender") != null ? rs.getString("stud_gender").charAt(0) : 'U'; // Default to 'U' (Unknown) if null
                String s_phoneNum = rs.getString("stud_phoneNum") != null ? rs.getString("stud_phoneNum") : "";
                String s_bankNum = rs.getString("stud_bankNum") != null ? rs.getString("stud_bankNum") : "";
                String s_bankName = rs.getString("stud_bankName") != null ? rs.getString("stud_bankName") : "";
                String s_address = rs.getString("stud_address") != null ? rs.getString("stud_address") : "";

                // Create a new Student object
                st = new Student();
                st.setStudID(stud_id);
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
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions appropriately
        }
        return st; // Return the Student object or null if not found
    }
    
    public boolean isInformationComplete(Student st){
       
       // Check if the student object is null
        if (st == null) {
            return false; // No student found, information is incomplete
        }

        // Check if all necessary fields are filled
        return st.getStudName() != null && !st.getStudName().isEmpty()
                && st.getStudIC() != null && !st.getStudIC().isEmpty()
                && st.getStudEmail() != null && !st.getStudEmail().isEmpty()
                && st.getStudPass() != null && !st.getStudPass().isEmpty()
                && st.getStudState() != null && !st.getStudState().isEmpty()
                && st.getStudZipCode() != null && !st.getStudZipCode().isEmpty()
                && st.getStudCourse() != null && !st.getStudCourse().isEmpty()
                && st.getStudFaculty() != null && !st.getStudFaculty().isEmpty()
                && st.getStudCampus() != null && !st.getStudCampus().isEmpty()
                && st.getStudMarriage() != 'U' // Assuming 'U' indicates incomplete marriage status
                && st.getStudGender() != 'U'   // Assuming 'U' indicates incomplete gender status
                && st.getStudPhoneNum() != null && !st.getStudPhoneNum().isEmpty()
                && st.getStudBankNum() != null && !st.getStudBankNum().isEmpty()
                && st.getStudBankName() != null && !st.getStudBankName().isEmpty()
                && st.getStudAddress() != null && !st.getStudAddress().isEmpty();
    }
}
  


