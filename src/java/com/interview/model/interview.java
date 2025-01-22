/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.model;
import com.database.dbconn;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author nasru
 */
public class interview {

    public interview() {}
    public interview(int iv_id, Date iv_date) {
        this.iv_id = iv_id;
        this.iv_date = iv_date;
    }

    public int getIv_id() {
        return iv_id;
    }

    public void setIv_id(int iv_id) {
        this.iv_id = iv_id;
    }

    public Date getIv_date() {
        return iv_date;
    }

    public void setIv_date(Date iv_date) {
        this.iv_date = iv_date;
    }
    private int iv_id;
    private Date iv_date;

    public static Date getInterviewDateByStudentId(int studId) {
        String sql = "SELECT i.iv_date " +
                     "FROM interview i " +
                     "JOIN application a ON i.apply_id = a.apply_id " +
                     "JOIN student s ON a.stud_id = s.stud_id " +
                     "WHERE s.stud_id = ?";
        
        try (Connection conn = dbconn.getConnection();  // Replace with your DB connection
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, studId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getDate("iv_date");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;  // No interview found
    }
}
