/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.deadline.model;
import com.database.dbconn;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

/**
 *
 * @author nasru
 */
public class deadline {
    private int deaadline_id;
    private Date application_deadline;
    private Date application_open_date;
    private Date application_dur_stat;
    
    public deadline(){}

    public deadline(int deaadline_id, Date application_deadline, Date application_open_date, Date application_dur_stat) {
        this.deaadline_id = deaadline_id;
        this.application_deadline = application_deadline;
        this.application_open_date = application_open_date;
        this.application_dur_stat = application_dur_stat;
    }

    public int getDeaadline_id() {
        return deaadline_id;
    }

    public void setDeaadline_id(int deaadline_id) {
        this.deaadline_id = deaadline_id;
    }

    public Date getApplication_deadline() {
        return application_deadline;
    }

    public void setApplication_deadline(Date application_deadline) {
        this.application_deadline = application_deadline;
    }

    public Date getApplication_open_date() {
        return application_open_date;
    }

    public void setApplication_open_date(Date application_open_date) {
        this.application_open_date = application_open_date;
    }

    public Date getApplication_dur_stat() {
        return application_dur_stat;
    }

    public void setApplication_dur_stat(Date application_dur_stat) {
        this.application_dur_stat = application_dur_stat;
    }
    
    public deadline getDeadline(){
        deadline d = new deadline();
        String query = "SELECT * FROM deadline ORDER BY application_deadline DESC LIMIT 1;";
        try{
            Connection conn = dbconn.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                d.setDeaadline_id(rs.getInt("deadline_id"));
                d.setApplication_open_date(rs.getDate("application_open_date"));
                d.setApplication_deadline(rs.getDate("application_deadline"));
                return d;
            } 
        }catch(SQLException e){
            e.printStackTrace();
        }
        return d;
    }
    
    
}
