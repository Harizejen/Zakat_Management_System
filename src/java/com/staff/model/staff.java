package com.staff.model;

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
    
    
}


