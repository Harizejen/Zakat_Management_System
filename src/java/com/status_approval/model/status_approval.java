/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.status_approval.model;
import java.util.Date;

/**
 *
 * @author nasru
 */
public class status_approval {

    public status_approval() {
    }

    public status_approval(int staff_id, int apply_id, String apply_status, String approv_status) {
        this.staff_id = staff_id;
        this.apply_id = apply_id;
        this.apply_status = apply_status;
        this.approv_status = approv_status;
    }

    public int getStaff_id() {
        return staff_id;
    }

    public void setStaff_id(int staff_id) {
        this.staff_id = staff_id;
    }

    public int getApply_id() {
        return apply_id;
    }

    public void setApply_id(int apply_id) {
        this.apply_id = apply_id;
    }

    public String getApply_status() {
        return apply_status;
    }

    public void setApply_status(String apply_status) {
        this.apply_status = apply_status;
    }

    public String getApprov_status() {
        return approv_status;
    }

    public void setApprov_status(String approv_status) {
        this.approv_status = approv_status;
    }
    private int staff_id;
    private int apply_id;
    private String apply_status;
    private String approv_status;   
    
}
