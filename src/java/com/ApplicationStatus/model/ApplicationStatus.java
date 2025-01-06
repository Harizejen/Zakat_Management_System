/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ApplicationStatus.model;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author User
 */
public class ApplicationStatus implements Serializable {
    private int apply_id;
    private int stud_id;
    private int deadline_id;
    private String apply_session;
    private int apply_part;
    private double apply_cgpa;
    private double apply_gpa;
    private String apply_foodIncentive;
    private String apply_otherSupport;
    private String apply_otherSupportName;
    private double apply_otherSupportAmount;
    private String apply_purpose;
    private Date apply_date;
    private int donation_id;
    private int staff_id;
    private String apply_status;
    private String approve_status;

    public int getApply_id() {
        return apply_id;
    }

    public void setApply_id(int apply_id) {
        this.apply_id = apply_id;
    }

    public int getStud_id() {
        return stud_id;
    }

    public void setStud_id(int stud_id) {
        this.stud_id = stud_id;
    }

    public int getDeadline_id() {
        return deadline_id;
    }

    public void setDeadline_id(int deadline_id) {
        this.deadline_id = deadline_id;
    }

    public String getApply_session() {
        return apply_session;
    }

    public void setApply_session(String apply_session) {
        this.apply_session = apply_session;
    }

    public int getApply_part() {
        return apply_part;
    }

    public void setApply_part(int apply_part) {
        this.apply_part = apply_part;
    }

    public double getApply_cgpa() {
        return apply_cgpa;
    }

    public void setApply_cgpa(double apply_cgpa) {
        this.apply_cgpa = apply_cgpa;
    }

    public double getApply_gpa() {
        return apply_gpa;
    }

    public void setApply_gpa(double apply_gpa) {
        this.apply_gpa = apply_gpa;
    }

    public String getApply_foodIncentive() {
        return apply_foodIncentive;
    }

    public void setApply_foodIncentive(String apply_foodIncentive) {
        this.apply_foodIncentive = apply_foodIncentive;
    }

    public String getApply_otherSupport() {
        return apply_otherSupport;
    }

    public void setApply_otherSupport(String apply_otherSupport) {
        this.apply_otherSupport = apply_otherSupport;
    }

    public String getApply_otherSupportName() {
        return apply_otherSupportName;
    }

    public void setApply_otherSupportName(String apply_otherSupportName) {
        this.apply_otherSupportName = apply_otherSupportName;
    }

    public double getApply_otherSupportAmount() {
        return apply_otherSupportAmount;
    }

    public void setApply_otherSupportAmount(double apply_otherSupportAmount) {
        this.apply_otherSupportAmount = apply_otherSupportAmount;
    }

    public String getApply_purpose() {
        return apply_purpose;
    }

    public void setApply_purpose(String apply_purpose) {
        this.apply_purpose = apply_purpose;
    }

    public Date getApply_date() {
        return apply_date;
    }

    public void setApply_date(Date apply_date) {
        this.apply_date = apply_date;
    }

    public int getDonation_id() {
        return donation_id;
    }

    public void setDonation_id(int donation_id) {
        this.donation_id = donation_id;
    }

    public int getStaff_id() {
        return staff_id;
    }

    public void setStaff_id(int staff_id) {
        this.staff_id = staff_id;
    }

    public String getApply_status() {
        return apply_status;
    }

    public void setApply_status(String apply_status) {
        this.apply_status = apply_status;
    }

    public String getApprove_status() {
        return approve_status;
    }

    public void setApprove_status(String approve_status) {
        this.approve_status = approve_status;
    }

    public ApplicationStatus(int apply_id, int stud_id, int deadline_id, String apply_session, int apply_part, double apply_cgpa, double apply_gpa, String apply_foodIncentive, String apply_otherSupport, String apply_otherSupportName, double apply_otherSupportAmount, String apply_purpose, Date apply_date, int donation_id, int staff_id, String apply_status, String approve_status) {
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
        this.staff_id = staff_id;
        this.apply_status = apply_status;
        this.approve_status = approve_status;
    }

    public ApplicationStatus() {
    }
    
}
