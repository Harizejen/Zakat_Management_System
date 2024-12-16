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
    private String stud_email;
    private String stud_password;
    private char stud_state;
    private char stud_course;
    private char stud_faculty;
    private char stud_campus;
    private char stud_marriage;
    private char stud_gender;
    private String stud_phoneNum;
    private String stud_bankNum;
    private String stud_bankName;
    private String stud_address;

    // Constructor
    public Student() {}
    
    public Student(int stud_id, String stud_name, String stud_email, String stud_password, char stud_state, char stud_course, char stud_faculty, char stud_campus, char stud_marriage, char stud_gender,String stud_phoneNum,String stud_bankNum, String stud_bankName, String stud_address){
        this.stud_id = stud_id;
        this.stud_name = stud_name;
        this.stud_email = stud_email;
        this.stud_password = stud_password;
        this.stud_state = stud_state;
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

    public String getStudEmail() {
        return stud_email;
    }

    public String getStudPass() {
        return stud_password;
    }

    public char getStudState() {
        return stud_state;
    }

    public char getStudCourse() {
        return stud_course;
    }

    public char getStudFaculty() {
        return stud_faculty;
    }

    public char getStudCampus() {
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

    public void setStudEmail(String stud_email) {
        this.stud_email = stud_email;
    }

    public void setStudPass(String stud_password) {
        this.stud_password = stud_password;
    }

    public void setStudState(char stud_state) {
        this.stud_state = stud_state;
    }

    public void setStudCourse(char stud_course) {
        this.stud_course = stud_course;
    }

    public void setStudFaculty(char stud_faculty) {
        this.stud_faculty = stud_faculty;
    }

    public void setStudCampus(char stud_campus) {
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
}

