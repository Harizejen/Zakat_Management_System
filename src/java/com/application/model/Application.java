/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package com.application.model;

/**
 *
 * @author User
 */
import java.io.Serializable;
import java.util.Date;

public class Application implements Serializable {
    private int apply_id;
    private int stud_id;
    private String apply_session;
    private int apply_part;
    private double apply_cgpa;
    private boolean apply_foodIncentive;
    private boolean apply_otherSupport;
    private double apply_otherSupportAmount;
    private String apply_purpose;
    private String apply_status;
    private Date apply_date;

    // Constructor
    public Application() {}
    
    // Normal Constructor
    public Application(int apply_id,int stud_id,String apply_session,int apply_part, double apply_cgpa, boolean apply_foodIncentive, boolean apply_otherSupport, double apply_otherSupportAmount, String apply_purpose, String apply_status, Date apply_date){
        this.apply_id = apply_id;
        this.stud_id = stud_id;
        this.apply_session = apply_session;
        this.apply_part = apply_part;
        this.apply_cgpa = apply_cgpa;
        this.apply_foodIncentive = apply_foodIncentive;
        this.apply_otherSupport = apply_otherSupport;
        this.apply_purpose = apply_purpose;
        this.apply_status = apply_status;
        this.apply_date = apply_date;
    }

    // Getters
    public int getApplyID() {
        return apply_id;
    }

    public int getStudID() {
        return stud_id;
    }

    public String getApplySession() {
        return apply_session;
    }

    public int getApplyPart() {
        return apply_part;
    }

    public double getApplyCGPA() {
        return apply_cgpa;
    }

    public boolean getApplyFoodIncentive() {
        return apply_foodIncentive;
    }

    public boolean getApplyOtherSupport() {
        return apply_otherSupport;
    }

    public double getApplyOtherSupAmount() {
        return apply_otherSupportAmount;
    }

    public String getApplyPurpose() {
        return apply_purpose;
    }

    public String getApplyStatus() {
        return apply_status;
    }

    public Date getApplyDate() {
        return apply_date;
    }

    // Setters
    public void setApplyID(int apply_id) {
        this.apply_id = apply_id;
    }

    public void setStudID(int stud_id) {
        this.stud_id = stud_id;
    }

    public void setApplySession(String apply_session) {
        this.apply_session = apply_session;
    }

    public void setApplyPart(int apply_part) {
        this.apply_part = apply_part;
    }

    public void setApplyCGPA(double apply_cgpa) {
        this.apply_cgpa = apply_cgpa;
    }

    public void setApplyFoodIncentive(boolean apply_foodIncentive) {
        this.apply_foodIncentive = apply_foodIncentive;
    }

    public void setApplyOtherSupport(boolean apply_otherSupport) {
        this.apply_otherSupport = apply_otherSupport;
    }

    public void setApplyOtherSupAmount(double apply_otherSupportAmount) {
        this.apply_otherSupportAmount = apply_otherSupportAmount;
    }

    public void setApplyPurpose(String apply_purpose) {
        this.apply_purpose = apply_purpose;
    }

    public void setApplyStatus(String apply_status) {
        this.apply_status = apply_status;
    }

    public void setApplyDate(Date apply_date) {
        this.apply_date = apply_date;
    }

    // Additional Methods
    public void checkStatus() {
        // Logic to check application status
    }

    public void setId(int aInt) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public void setName(String string) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public void setStudentId(String string) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public void setCgpa(double aDouble) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public void setDate(String string) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public void setForm(String string) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public void setStatus(String string) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public Object getStatus() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}

