/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.model;
import java.util.Date;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author nasru
 */
public class interview {
    private String iv_id;
    private Date iv_date;
    private String iv_phoneNum;
    private String iv_place;
    private String note;
    private LocalTime iv_time;

    public interview(String iv_id, Date iv_date, String iv_phoneNum, String iv_place, String note, LocalTime iv_time) {
        this.iv_id = iv_id;
        this.iv_date = iv_date;
        this.iv_phoneNum = iv_phoneNum;
        this.iv_place = iv_place;
        this.note = note;
        this.iv_time = iv_time;
    }

    public String getIv_id() {
        return iv_id;
    }

    public void setIv_id(String iv_id) {
        this.iv_id = iv_id;
    }

    public Date getIv_date() {
        return iv_date;
    }

    public void setIv_date(Date iv_date) {
        this.iv_date = iv_date;
    }

    public String getIv_phoneNum() {
        return iv_phoneNum;
    }

    public void setIv_phoneNum(String iv_phoneNum) {
        this.iv_phoneNum = iv_phoneNum;
    }

    public String getIv_place() {
        return iv_place;
    }

    public void setIv_place(String iv_place) {
        this.iv_place = iv_place;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public LocalTime getIv_time() {
        return iv_time;
    }

    public void setIv_time(LocalTime iv_time) {
        this.iv_time = iv_time;
    }
    
    
}
