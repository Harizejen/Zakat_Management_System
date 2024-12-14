/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interview.model;

/**
 *
 * @author nasru
 */
public class interview {
    private String iv_id;
    private String iv_date;
    private String iv_phoneNum;
    private String iv_place;
    private String note;
    private String iv_time;

    public interview(String iv_id, String iv_date, String iv_phoneNum, String iv_place, String note, String iv_time) {
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

    public String getIv_date() {
        return iv_date;
    }

    public void setIv_date(String iv_date) {
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

    public String getIv_time() {
        return iv_time;
    }

    public void setIv_time(String iv_time) {
        this.iv_time = iv_time;
    }
    
    
}
