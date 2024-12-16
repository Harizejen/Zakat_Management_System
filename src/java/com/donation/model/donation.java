/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.donation.model;
import java.util.Date;

/**
 *
 * @author nasru
 */
public class donation {
    private Date donation_cred_date;
    private double donation_amount;
    
    public donation(Date donation_cred_date, double donation_amount) {
        this.donation_cred_date = donation_cred_date;
        this.donation_amount = donation_amount; 
    }

    public Date getDonation_cred_date() {
        return donation_cred_date;
    }

    public double getDonation_amount() {
        return donation_amount;
    }

    public void setDonation_cred_date(Date donation_cred_date) {
        this.donation_cred_date = donation_cred_date;
    }

    public void setDonation_amount(double donation_amount) {
        this.donation_amount = donation_amount;
    }
    
    
    
}
