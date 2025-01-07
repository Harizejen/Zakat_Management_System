package com.staff.model;

import com.database.dbconn;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author MY PC
 */
public class staff {
    private int staffid;
    private int adminid;
    private int applyid;
    private String staffname;
    private String staffemail;
    private String staffpassword;
    private String staffrole;
    
    public int getStaffid() {
        return staffid;
    }

    public void setStaffid(int staffid) {
        this.staffid = staffid;
    }

    public int getAdminid() {
        return adminid;
    }

    public void setAdminid(int adminid) {
        this.adminid = adminid;
    }

    public int getApplyid() {
        return applyid;
    }

    public void setApplyid(int applyid) {
        this.applyid = applyid;
    }

    public String getStaffname() {
        return staffname;
    }

    public void setStaffname(String staffname) {
        this.staffname = staffname;
    }

    public String getStaffemail() {
        return staffemail;
    }

    public void setStaffemail(String staffemail) {
        this.staffemail = staffemail;
    }

    public String getStaffpassword() {
        return staffpassword;
    }

    public void setStaffpassword(String staffpassword) {
        this.staffpassword = staffpassword;
    }

    public String getStaffrole() {
        return staffrole;
    }

    public void setStaffrole(String staffrole) {
        this.staffrole = staffrole;
    }

    public staff(int staffid, int adminid, int applyid, String staffname, String staffemail, String staffpassword, String staffrole) {
        this.staffid = staffid;
        this.adminid = adminid;
        this.applyid = applyid;
        this.staffname = staffname;
        this.staffemail = staffemail;
        this.staffpassword = staffpassword;
        this.staffrole = staffrole;
    }    

    public staff() {
    }
    
   public boolean isValid() {
    if (staffid <= 0 || staffpassword == null || staffpassword.isEmpty()) {
        System.out.println("Invalid staff ID or password.");
        return false; // Invalid input
    }

    boolean isValid = false;
    String query = "SELECT * FROM staff WHERE staff_id = ? AND staff_password = ?";

    try (Connection connection = dbconn.getConnection();
         PreparedStatement preparedStatement = connection.prepareStatement(query)) {

        preparedStatement.setInt(1, staffid);
        preparedStatement.setString(2, staffpassword);

        ResultSet resultSet = preparedStatement.executeQuery();
        isValid = resultSet.next();

    } catch (SQLException e) {
        e.printStackTrace(); // Consider logging this instead
    }
    return isValid;
}

public staff findStaff(int staffid) {
    staff staff = null; // Initialize as null in case no staff member is found.
    // Updated query with correct column names
    String query = "SELECT * FROM staff WHERE staff_id = ?";

    try (Connection conn = dbconn.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        ps.setInt(1, staffid);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            // Retrieve values safely, allowing for potential nulls
            int adminid = rs.getInt("admin_id");  // Updated column name
            //int applyid = rs.getInt("apply_id");  // Updated column name
            String staffname = rs.getString("staff_name") != null ? rs.getString("staff_name") : "";  // Updated column name
            String staffemail = rs.getString("staff_email") != null ? rs.getString("staff_email") : "";  // Updated column name
            String staffpassword = rs.getString("staff_password") != null ? rs.getString("staff_password") : "";  // Updated column name
            String staffrole = rs.getString("staff_role") != null ? rs.getString("staff_role") : "";  // Updated column name

            // Create a new staff object
            staff = new staff();
            staff.setStaffid(staffid);
            staff.setAdminid(adminid);
            //staff.setApplyid(applyid);
            staff.setStaffname(staffname);
            staff.setStaffemail(staffemail);
            staff.setStaffpassword(staffpassword);
            staff.setStaffrole(staffrole);
        }

    } catch (SQLException e) {
        e.printStackTrace(); // Handle exceptions appropriately
    }

    return staff; // Return the staff object or null if not found
}



    
    
}


