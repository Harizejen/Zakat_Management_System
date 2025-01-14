/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ApplicationDetails.model;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 *
 * @author User
 */

public class ApplicationDetails implements Serializable {

    public ApplicationDetails(){
        
    }
    // Application table attributes
    public ApplicationDetails(int applyId, int studId, int deadlineId, String applySession, int applyPart, double applyCgpa, double applyGpa, boolean applyFoodIncentive, boolean applyOtherSupport, String applyOtherSupportName, double applyOtherSupportAmount, String applyPurpose, String applyDate, int donationId, String studName, String studIc, String studEmail, String studPassword, String studState, String studZipcode, String studCourse, String studFaculty, String studCampus, String studGender, String studPhoneNum, String studBankName, String studBankNum, String studAddress, String studMarriage, int guardId, String fatherName, String fatherOccupation, String fatherPhoneNum, String fatherAddress, String motherName, String motherOccupation, String motherPhoneNum, String motherAddress, String guardName, String guardRelation, String guardOccupation, String guardPhoneNum, String guardAddress, String guardPostcode, String guardResidence, double guardIncome, double motherIncome, double fatherIncome, double otherIncome, int staffId, String approveStatus, String appStatHEA, String appStatHEP, String appStatUZSW, String heaReview, String hepReview, String uzswReview, int iv_id, Date iv_date) {
        this.applyId = applyId;
        this.studId = studId;
        this.deadlineId = deadlineId;
        this.applySession = applySession;
        this.applyPart = applyPart;
        this.applyCgpa = applyCgpa;
        this.applyGpa = applyGpa;
        this.applyFoodIncentive = applyFoodIncentive;
        this.applyOtherSupport = applyOtherSupport;
        this.applyOtherSupportName = applyOtherSupportName;
        this.applyOtherSupportAmount = applyOtherSupportAmount;
        this.applyPurpose = applyPurpose;
        this.applyDate = applyDate;
        this.donationId = donationId;
        this.studName = studName;
        this.studIc = studIc;
        this.studEmail = studEmail;
        this.studPassword = studPassword;
        this.studState = studState;
        this.studZipcode = studZipcode;
        this.studCourse = studCourse;
        this.studFaculty = studFaculty;
        this.studCampus = studCampus;
        this.studGender = studGender;
        this.studPhoneNum = studPhoneNum;
        this.studBankName = studBankName;
        this.studBankNum = studBankNum;
        this.studAddress = studAddress;
        this.studMarriage = studMarriage;
        this.guardId = guardId;
        this.fatherName = fatherName;
        this.fatherOccupation = fatherOccupation;
        this.fatherPhoneNum = fatherPhoneNum;
        this.fatherAddress = fatherAddress;
        this.motherName = motherName;
        this.motherOccupation = motherOccupation;
        this.motherPhoneNum = motherPhoneNum;
        this.motherAddress = motherAddress;
        this.guardName = guardName;
        this.guardRelation = guardRelation;
        this.guardOccupation = guardOccupation;
        this.guardPhoneNum = guardPhoneNum;
        this.guardAddress = guardAddress;
        this.guardPostcode = guardPostcode;
        this.guardResidence = guardResidence;
        this.guardIncome = guardIncome;
        this.motherIncome = motherIncome;
        this.fatherIncome = fatherIncome;
        this.otherIncome = otherIncome;
        this.staffId = staffId;
        this.approveStatus = approveStatus;
        this.appStatHEA = appStatHEA;
        this.appStatHEP = appStatHEP;
        this.appStatUZSW = appStatUZSW;
        this.heaReview = heaReview;
        this.hepReview = hepReview;
        this.uzswReview = uzswReview;
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
    
    public int getApplyId() {
        return applyId;
    }

    public int getStudId() {
        return studId;
    }

    public int getDeadlineId() {
        return deadlineId;
    }

    public String getApplySession() {
        return applySession;
    }

    public int getApplyPart() {
        return applyPart;
    }

    public double getApplyCgpa() {
        return applyCgpa;
    }

    public double getApplyGpa() {
        return applyGpa;
    }

    public boolean getApplyFoodIncentive() {
        return applyFoodIncentive;
    }

    public boolean getApplyOtherSupport() {
        return applyOtherSupport;
    }

    public String getApplyOtherSupportName() {
        return applyOtherSupportName;
    }

    public double getApplyOtherSupportAmount() {
        return applyOtherSupportAmount;
    }

    public String getApplyPurpose() {
        return applyPurpose;
    }

    public String getApplyDate() {
        return applyDate;
    }

    public int getDonationId() {
        return donationId;
    }

    public String getStudName() {
        return studName;
    }

    public String getStudIc() {
        return studIc;
    }

    public String getStudEmail() {
        return studEmail;
    }

    public String getStudPassword() {
        return studPassword;
    }

    public String getStudState() {
        return studState;
    }

    public String getStudZipcode() {
        return studZipcode;
    }

    public String getStudCourse() {
        return studCourse;
    }

    public String getStudFaculty() {
        return studFaculty;
    }

    public String getStudCampus() {
        return studCampus;
    }

    public String getStudGender() {
        return studGender;
    }

    public String getStudPhoneNum() {
        return studPhoneNum;
    }

    public String getStudBankName() {
        return studBankName;
    }

    public String getStudBankNum() {
        return studBankNum;
    }

    public String getStudAddress() {
        return studAddress;
    }

    public String getStudMarriage() {
        return studMarriage;
    }

    public int getGuardId() {
        return guardId;
    }

    public String getFatherName() {
        return fatherName;
    }

    public String getFatherOccupation() {
        return fatherOccupation;
    }

    public String getFatherPhoneNum() {
        return fatherPhoneNum;
    }

    public String getFatherAddress() {
        return fatherAddress;
    }

    public String getMotherName() {
        return motherName;
    }

    public String getMotherOccupation() {
        return motherOccupation;
    }

    public String getMotherPhoneNum() {
        return motherPhoneNum;
    }

    public String getMotherAddress() {
        return motherAddress;
    }

    public String getGuardName() {
        return guardName;
    }

    public String getGuardRelation() {
        return guardRelation;
    }

    public String getGuardOccupation() {
        return guardOccupation;
    }

    public String getGuardPhoneNum() {
        return guardPhoneNum;
    }

    public String getGuardAddress() {
        return guardAddress;
    }

    public String getGuardPostcode() {
        return guardPostcode;
    }

    public String getGuardResidence() {
        return guardResidence;
    }

    public double getGuardIncome() {
        return guardIncome;
    }

    public double getMotherIncome() {
        return motherIncome;
    }

    public double getFatherIncome() {
        return fatherIncome;
    }

    public double getOtherIncome() {
        return otherIncome;
    }

    public int getStaffId() {
        return staffId;
    }

    public String getApproveStatus() {
        return approveStatus;
    }

    public String getAppStatHEA() {
        return appStatHEA;
    }

    public String getAppStatHEP() {
        return appStatHEP;
    }

    public String getAppStatUZSW() {
        return appStatUZSW;
    }

    public String getHeaReview() {
        return heaReview;
    }

    public String getHepReview() {
        return hepReview;
    }

    public String getUzswReview() {
        return uzswReview;
    }

    public void setApplyId(int applyId) {
        this.applyId = applyId;
    }

    public void setStudId(int studId) {
        this.studId = studId;
    }

    public void setDeadlineId(int deadlineId) {
        this.deadlineId = deadlineId;
    }

    public void setApplySession(String applySession) {
        this.applySession = applySession;
    }

    public void setApplyPart(int applyPart) {
        this.applyPart = applyPart;
    }

    public void setApplyCgpa(double applyCgpa) {
        this.applyCgpa = applyCgpa;
    }

    public void setApplyGpa(double applyGpa) {
        this.applyGpa = applyGpa;
    }

    public void setApplyFoodIncentive(boolean applyFoodIncentive) {
        this.applyFoodIncentive = applyFoodIncentive;
    }

    public void setApplyOtherSupport(boolean applyOtherSupport) {
        this.applyOtherSupport = applyOtherSupport;
    }

    public void setApplyOtherSupportName(String applyOtherSupportName) {
        this.applyOtherSupportName = applyOtherSupportName;
    }

    public void setApplyOtherSupportAmount(double applyOtherSupportAmount) {
        this.applyOtherSupportAmount = applyOtherSupportAmount;
    }

    public void setApplyPurpose(String applyPurpose) {
        this.applyPurpose = applyPurpose;
    }

    public void setApplyDate(String applyDate) {
        this.applyDate = applyDate;
    }

    public void setDonationId(int donationId) {
        this.donationId = donationId;
    }

    public void setStudName(String studName) {
        this.studName = studName;
    }

    public void setStudIc(String studIc) {
        this.studIc = studIc;
    }

    public void setStudEmail(String studEmail) {
        this.studEmail = studEmail;
    }

    public void setStudPassword(String studPassword) {
        this.studPassword = studPassword;
    }

    public void setStudState(String studState) {
        this.studState = studState;
    }

    public void setStudZipcode(String studZipcode) {
        this.studZipcode = studZipcode;
    }

    public void setStudCourse(String studCourse) {
        this.studCourse = studCourse;
    }

    public void setStudFaculty(String studFaculty) {
        this.studFaculty = studFaculty;
    }

    public void setStudCampus(String studCampus) {
        this.studCampus = studCampus;
    }

    public void setStudGender(String studGender) {
        this.studGender = studGender;
    }

    public void setStudPhoneNum(String studPhoneNum) {
        this.studPhoneNum = studPhoneNum;
    }

    public void setStudBankName(String studBankName) {
        this.studBankName = studBankName;
    }

    public void setStudBankNum(String studBankNum) {
        this.studBankNum = studBankNum;
    }

    public void setStudAddress(String studAddress) {
        this.studAddress = studAddress;
    }

    public void setStudMarriage(String studMarriage) {
        this.studMarriage = studMarriage;
    }

    public void setGuardId(int guardId) {
        this.guardId = guardId;
    }

    public void setFatherName(String fatherName) {
        this.fatherName = fatherName;
    }

    public void setFatherOccupation(String fatherOccupation) {
        this.fatherOccupation = fatherOccupation;
    }

    public void setFatherPhoneNum(String fatherPhoneNum) {
        this.fatherPhoneNum = fatherPhoneNum;
    }

    public void setFatherAddress(String fatherAddress) {
        this.fatherAddress = fatherAddress;
    }

    public void setMotherName(String motherName) {
        this.motherName = motherName;
    }

    public void setMotherOccupation(String motherOccupation) {
        this.motherOccupation = motherOccupation;
    }

    public void setMotherPhoneNum(String motherPhoneNum) {
        this.motherPhoneNum = motherPhoneNum;
    }

    public void setMotherAddress(String motherAddress) {
        this.motherAddress = motherAddress;
    }

    public void setGuardName(String guardName) {
        this.guardName = guardName;
    }

    public void setGuardRelation(String guardRelation) {
        this.guardRelation = guardRelation;
    }

    public void setGuardOccupation(String guardOccupation) {
        this.guardOccupation = guardOccupation;
    }

    public void setGuardPhoneNum(String guardPhoneNum) {
        this.guardPhoneNum = guardPhoneNum;
    }

    public void setGuardAddress(String guardAddress) {
        this.guardAddress = guardAddress;
    }

    public void setGuardPostcode(String guardPostcode) {
        this.guardPostcode = guardPostcode;
    }

    public void setGuardResidence(String guardResidence) {
        this.guardResidence = guardResidence;
    }

    public void setGuardIncome(double guardIncome) {
        this.guardIncome = guardIncome;
    }

    public void setMotherIncome(double motherIncome) {
        this.motherIncome = motherIncome;
    }

    public void setFatherIncome(double fatherIncome) {
        this.fatherIncome = fatherIncome;
    }

    public void setOtherIncome(double otherIncome) {
        this.otherIncome = otherIncome;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public void setApproveStatus(String approveStatus) {
        this.approveStatus = approveStatus;
    }

    public void setAppStatHEA(String appStatHEA) {
        this.appStatHEA = appStatHEA;
    }

    public void setAppStatHEP(String appStatHEP) {
        this.appStatHEP = appStatHEP;
    }

    public void setAppStatUZSW(String appStatUZSW) {
        this.appStatUZSW = appStatUZSW;
    }

    public void setHeaReview(String heaReview) {
        this.heaReview = heaReview;
    }

    public void setHepReview(String hepReview) {
        this.hepReview = hepReview;
    }

    public void setUzswReview(String uzswReview) {
        this.uzswReview = uzswReview;
    }
    private int applyId;
    private int studId;
    private int deadlineId;
    private String applySession;
    private int applyPart;
    private double applyCgpa;
    private double applyGpa;
    private boolean applyFoodIncentive;
    private boolean applyOtherSupport;
    private String applyOtherSupportName;
    private double applyOtherSupportAmount;
    private String applyPurpose;
    private String applyDate;
    private int donationId;

    // Student table attributes
    private String studName;
    private String studIc;
    private String studEmail;
    private String studPassword;
    private String studState;
    private String studZipcode;
    private String studCourse;
    private String studFaculty;
    private String studCampus;
    private String studGender;
    private String studPhoneNum;
    private String studBankName;
    private String studBankNum;
    private String studAddress;
    private String studMarriage;

    // Guardian table attributes
    private int guardId;
    private String fatherName;
    private String fatherOccupation;
    private String fatherPhoneNum;
    private String fatherAddress;
    private String motherName;
    private String motherOccupation;
    private String motherPhoneNum;
    private String motherAddress;
    private String guardName;
    private String guardRelation;
    private String guardOccupation;
    private String guardPhoneNum;
    private String guardAddress;
    private String guardPostcode;
    private String guardResidence;
    private double guardIncome;
    private double motherIncome;
    private double fatherIncome;
    private double otherIncome;

    // Status_approval table attributes
    private int staffId;
    private String approveStatus;
    private String appStatHEA;
    private String appStatHEP;
    private String appStatUZSW;
    private String heaReview;
    private String hepReview;
    private String uzswReview;
    
    private int iv_id;
    private Date iv_date;
    
}
