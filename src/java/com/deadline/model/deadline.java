/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.deadline.model;

/**
 *
 * @author nasru
 */
public class deadline {
    private String deaadline_id;
    private String application_deadline;
    private String application_open_date;
    private String application_dur_stat;

    public deadline(String deaadline_id, String application_deadline, String application_open_date, String application_dur_stat) {
        this.deaadline_id = deaadline_id;
        this.application_deadline = application_deadline;
        this.application_open_date = application_open_date;
        this.application_dur_stat = application_dur_stat;
    }

    public String getDeaadline_id() {
        return deaadline_id;
    }

    public void setDeaadline_id(String deaadline_id) {
        this.deaadline_id = deaadline_id;
    }

    public String getApplication_deadline() {
        return application_deadline;
    }

    public void setApplication_deadline(String application_deadline) {
        this.application_deadline = application_deadline;
    }

    public String getApplication_open_date() {
        return application_open_date;
    }

    public void setApplication_open_date(String application_open_date) {
        this.application_open_date = application_open_date;
    }

    public String getApplication_dur_stat() {
        return application_dur_stat;
    }

    public void setApplication_dur_stat(String application_dur_stat) {
        this.application_dur_stat = application_dur_stat;
    }
    
    
}
