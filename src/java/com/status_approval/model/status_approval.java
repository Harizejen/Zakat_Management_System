/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.status_approval.model;

/**
 *
 * @author nasru
 */
public class status_approval {
    private String approv_status;
    private String approve_date;

    public status_approval(String approv_status, String approve_date) {
        this.approv_status = approv_status;
        this.approve_date = approve_date;
    }

    public String getApprov_status() {
        return approv_status;
    }

    public void setApprov_status(String approv_status) {
        this.approv_status = approv_status;
    }

    public String getApprove_date() {
        return approve_date;
    }

    public void setApprove_date(String approve_date) {
        this.approve_date = approve_date;
    }
    
    
}
