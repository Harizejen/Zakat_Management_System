/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package com.application.model;

/**
 *
 * @author User
 */
import com.database.dbconn;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class Application implements Serializable {
    private int apply_id;
    private int stud_id;
    private int deadline_id;
    private String apply_session;
    private int apply_part;
    private double apply_cgpa;
    private double apply_gpa;
    private boolean apply_foodIncentive;
    private boolean apply_otherSupport;
    private String apply_otherSupportName;
    private double apply_otherSupportAmount;
    private String apply_purpose;
    private Date apply_date;
    private int donation_id;
    private String apply_status;

    // Constructor
    public Application() {}

    public Application(int apply_id, int stud_id, int deadline_id, String apply_session, int apply_part, double apply_cgpa, 
                       double apply_gpa, boolean apply_foodIncentive, boolean apply_otherSupport, String apply_otherSupportName,
                       double apply_otherSupportAmount, String apply_purpose, Date apply_date, int donation_id, String apply_status) {
        this.apply_id = apply_id;
        this.stud_id = stud_id;
        this.deadline_id = deadline_id;
        this.apply_session = apply_session;
        this.apply_part = apply_part;
        this.apply_cgpa = apply_cgpa;
        this.apply_gpa = apply_gpa;
        this.apply_foodIncentive = apply_foodIncentive;
        this.apply_otherSupport = apply_otherSupport;
        this.apply_otherSupportName = apply_otherSupportName;
        this.apply_otherSupportAmount = apply_otherSupportAmount;
        this.apply_purpose = apply_purpose;
        this.apply_date = apply_date;
        this.donation_id = donation_id;
        this.apply_status = apply_status;
    }

    // Getters and Setters for All Attributes
    public int getApplyID() {
        return apply_id;
    }

    public void setApplyID(int apply_id) {
        this.apply_id = apply_id;
    }

    public int getStudID() {
        return stud_id;
    }

    public void setStudID(int stud_id) {
        this.stud_id = stud_id;
    }

    public int getDeadlineID() {
        return deadline_id;
    }

    public void setDeadlineID(int deadline_id) {
        this.deadline_id = deadline_id;
    }

    public String getApplySession() {
        return apply_session;
    }

    public void setApplySession(String apply_session) {
        this.apply_session = apply_session;
    }

    public int getApplyPart() {
        return apply_part;
    }

    public void setApplyPart(int apply_part) {
        this.apply_part = apply_part;
    }

    public double getApplyCGPA() {
        return apply_cgpa;
    }

    public void setApplyCGPA(double apply_cgpa) {
        this.apply_cgpa = apply_cgpa;
    }

    public double getApplyGPA() {
        return apply_gpa;
    }

    public void setApplyGPA(double apply_gpa) {
        this.apply_gpa = apply_gpa;
    }

    public boolean getApplyFoodIncentive() {
        return apply_foodIncentive;
    }

    public void setApplyFoodIncentive(boolean apply_foodIncentive) {
        this.apply_foodIncentive = apply_foodIncentive;
    }

    public boolean getApplyOtherSupport() {
        return apply_otherSupport;
    }

    public void setApplyOtherSupport(boolean apply_otherSupport) {
        this.apply_otherSupport = apply_otherSupport;
    }

    public String getApplyOtherSupportName() {
        return apply_otherSupportName;
    }

    public void setApplyOtherSupportName(String apply_otherSupportName) {
        this.apply_otherSupportName = apply_otherSupportName;
    }

    public double getApplyOtherSupportAmount() {
        return apply_otherSupportAmount;
    }

    public void setApplyOtherSupportAmount(double apply_otherSupportAmount) {
        this.apply_otherSupportAmount = apply_otherSupportAmount;
    }

    public String getApplyPurpose() {
        return apply_purpose;
    }

    public void setApplyPurpose(String apply_purpose) {
        this.apply_purpose = apply_purpose;
    }

    public Date getApplyDate() {
        return apply_date;
    }

    public void setApplyDate(Date apply_date) {
        this.apply_date = apply_date;
    }

    public int getDonationID() {
        return donation_id;
    }

    public void setDonationID(int donation_id) {
        this.donation_id = donation_id;
    }

    public String getApplyStatus() {
        return apply_status;
    }

    public void setApplyStatus(String apply_status) {
        this.apply_status = apply_status;
    }
    
    public boolean existedApplication(int stud_id, String apply_session) {
        boolean existed = false;
        String query = "SELECT 1 FROM application WHERE stud_id = ? AND apply_session = ?;";

        try (Connection conn = dbconn.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, stud_id);
            ps.setString(2, apply_session);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    existed = true;
                }
            }
        } catch (SQLException e) {
            // Use proper logging or rethrow exception in production
            e.printStackTrace();
        }
        return existed;
    }
    // Additional Methods
    
    public String getAppIDStat(int stud_id){
        String status = "SEDANG DIPROSES";
        String query = "SELECT apply_id FROM application WHERE stud_id = ?;";
        try{
            Connection conn = dbconn.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, stud_id);
            
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                int apply_id = rs.getInt("apply_id");
                status = checkStatus(apply_id);
            }
            return status;
        }catch(SQLException e){
            e.printStackTrace();
        }
        return status;
    }
    
    public String checkStatus(int apply_id) {
        String status = "SEDANG DIPROSES";
        String query = "SELECT approve_status FROM `status_approval` WHERE apply_id = ?;";
        try{
            Connection conn = dbconn.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, apply_id);
            
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                status = rs.getString("approve_status") !=null ? rs.getString("approve_status"): "SEDANG DIPROSES";
            }
            return status;
        }catch(SQLException e){
            e.printStackTrace();
        }
        return status;
    }
    
    public Application getApplication(int stud_id){
        Application ap = new Application();
        
        String query = "SELECT a.*, sa.approve_status\n" +
                       "FROM application a\n" +
                       "LEFT JOIN status_approval sa ON a.apply_id = sa.apply_id\n" +
                       "WHERE a.stud_id = ?;";
        try(Connection conn = dbconn.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)){
            
            ps.setInt(1,stud_id);
            
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                boolean apply_foodIncentive = false;
                boolean apply_otherSupport = false;
                int apply_id = rs.getInt("apply_id");
                int deadline_id = rs.getInt("deadline_id");
                String apply_session = rs.getString("apply_session");
                int apply_part = rs.getInt("apply_part");
                double apply_cgpa = rs.getDouble("apply_cgpa");
                double apply_gpa = rs.getDouble("apply_gpa");
                String apply_foodIncentiveParams = rs.getString("apply_foodIncentive");
                String apply_otherSupportParams = rs.getString("apply_otherSupport");
                double apply_otherSupportAmount = rs.getDouble("apply_otherSupportAmount");
                String apply_purpose = rs.getString("apply_purpose");
                Date apply_date = rs.getDate("apply_date");
                String apply_status = rs.getString("approve_status");
                
                if ("YA".equalsIgnoreCase(apply_foodIncentiveParams) && "YA".equalsIgnoreCase(apply_otherSupportParams)) {
                    apply_foodIncentive = true;
                    apply_otherSupport = true;
                }
                
                ap.setApplyID(apply_id);
                ap.setStudID(stud_id);
                ap.setDeadlineID(deadline_id);
                ap.setApplySession(apply_session);
                ap.setApplyPart(apply_part);
                ap.setApplyCGPA(apply_cgpa);
                ap.setApplyGPA(apply_gpa);
                ap.setApplyFoodIncentive(apply_foodIncentive);
                ap.setApplyOtherSupport(apply_otherSupport);
                ap.setApplyOtherSupportAmount(apply_otherSupportAmount);
                ap.setApplyPurpose(apply_purpose);
                ap.setApplyDate(apply_date);
                ap.setApplyStatus(apply_status);
                
                return ap;
                
            }
            
        }catch(SQLException e){
            e.printStackTrace();
        }
        
        return ap;
    }
    
    public ArrayList<Application> getApplicationList(){
        ArrayList<Application> applicationList = new ArrayList<>();
        
        String query = "SELECT * FROM `application`";
        try{
            Connection conn = dbconn.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                boolean apply_foodIncentive = false;
                boolean apply_otherSupport = false;
                int apply_id = rs.getInt("apply_id");
                int stud_id = rs.getInt("stud_id");
                int deadline_id = rs.getInt("deadline_id");
                String apply_session = rs.getString("apply_session");
                int apply_part = rs.getInt("apply_part");
                double apply_cgpa = rs.getDouble("apply_cgps");
                double apply_gpa = rs.getDouble("apply_gpa");
                String apply_foodIncentiveParams = rs.getString("apply_foodIncentive");
                String apply_otherSupportParams = rs.getString("apply_otherSupport");
                double apply_otherSupportAmount = rs.getDouble("apply_otherSupportAmount");
                String apply_purpose = rs.getString("apply_purpose");
                Date apply_date = rs.getDate("apply_date");
                
                if ("YA".equalsIgnoreCase(apply_foodIncentiveParams) && "YA".equalsIgnoreCase(apply_otherSupportParams)) {
                    apply_foodIncentive = true;
                    apply_otherSupport = true;
                }
                
                
                Application ap = new Application();
                ap.setApplyID(apply_id);
                ap.setStudID(stud_id);
                ap.setDeadlineID(deadline_id);
                ap.setApplySession(apply_session);
                ap.setApplyPart(apply_part);
                ap.setApplyCGPA(apply_cgpa);
                ap.setApplyGPA(apply_gpa);
                ap.setApplyFoodIncentive(apply_foodIncentive);
                ap.setApplyOtherSupport(apply_otherSupport);
                ap.setApplyOtherSupportAmount(apply_otherSupportAmount);
                ap.setApplyPurpose(apply_purpose);
                ap.setApplyDate(apply_date);
                
                applicationList.add(ap);
            }
            return applicationList;
        }catch(SQLException e){
            e.printStackTrace();
        }
        return applicationList;
    }
    
    public ArrayList<Application> getApplicationRecords(int stud_id) {
        ArrayList<Application> appRecord = new ArrayList<>();
        String query = "SELECT a.apply_session AS zakat_session, "
                     + "COALESCE(sa.approve_status, 'DIPROSES') AS application_status "
                     + "FROM application a "
                     + "JOIN student s ON a.stud_id = s.stud_id "
                     + "LEFT JOIN status_approval sa ON a.apply_id = sa.apply_id "
                     + "WHERE s.stud_id = ?";

        try (Connection conn = dbconn.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, stud_id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String apply_session = rs.getString("zakat_session");
                    String apply_status = rs.getString("application_status");

                    Application ap = new Application();
                    ap.setApplySession(apply_session);
                    ap.setApplyStatus(apply_status);

                    appRecord.add(ap);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Log the exception with a proper logging framework (e.g., SLF4J)
        }
        return appRecord;
    }


}

