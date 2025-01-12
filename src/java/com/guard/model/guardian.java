/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.guard.model;

import com.database.dbconn;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author nasru
 */
public class guardian {
    private String father_name;
    private String father_occupation;
    private String father_phoneNum;
    private String father_address;
    private double father_income;
    private String mother_name;
    private String mother_occupation;
    private String mother_phoneNum;
    private String mother_address;
    private double mother_income;
    private String guard_name;
    private String guard_relation;
    private String guard_occupation;
    private String guard_phoneNum;
    private String guard_address;
    private String guard_postcode;
    private String guard_residence;
    private double guard_income;
    private double other_income;
    
    public guardian() {
    }

    public String getFather_name() {
        return father_name;
    }

    public String getFather_occupation() {
        return father_occupation.toUpperCase();
    }

    public String getFather_phoneNum() {
        return father_phoneNum;
    }
    
    public String getFather_Address(){
        return father_address.toUpperCase();
    }

    public double getFather_income() {
        return father_income;
    }

    public String getMother_name() {
        return mother_name;
    }

    public String getMother_occupation() {
        return mother_occupation;
    }

    public String getMother_phoneNum() {
        return mother_phoneNum;
    }
    
    public String getMother_Address(){
        return mother_address;
    }

    public double getMother_income() {
        return mother_income;
    }

    public String getGuard_name() {
        return guard_name;
    }

    public String getGuard_relation() {
        return guard_relation;
    }

    public String getGuard_occupation() {
        return guard_occupation.toUpperCase();
    }

    public String getGuard_phoneNum() {
        return guard_phoneNum;
    }

    public String getGuard_address() {
        return guard_address.toUpperCase();
    }

    public String getGuard_postcode() {
        return guard_postcode;
    }

    public String getGuard_residence() {
        return guard_residence;
    }

    public double getGuard_income() {
        return guard_income;
    }

    public double getOther_income() {
        return other_income;
    }

    public void setFather_name(String father_name) {
        this.father_name = father_name;
    }

    public void setFather_occupation(String father_occupation) {
        this.father_occupation = father_occupation;
    }

    public void setFather_phoneNum(String father_phoneNum) {
        this.father_phoneNum = father_phoneNum;
    }
    
    public void setFather_Address(String father_address){
        this.father_address = father_address;
    }

    public void setFather_income(double father_income) {
        this.father_income = father_income;
    }

    public void setMother_name(String mother_name) {
        this.mother_name = mother_name;
    }

    public void setMother_occupation(String mother_occupation) {
        this.mother_occupation = mother_occupation;
    }

    public void setMother_phoneNum(String mother_phoneNum) {
        this.mother_phoneNum = mother_phoneNum;
    }
    
    public void setMother_Address(String mother_address){
        this.mother_address = mother_address;
    }

    public void setMother_income(double mother_income) {
        this.mother_income = mother_income;
    }

    public void setGuard_name(String guard_name) {
        this.guard_name = guard_name;
    }

    public void setGuard_relation(String guard_relation) {
        this.guard_relation = guard_relation.toUpperCase();
    }

    public void setGuard_occupation(String guard_occupation) {
        this.guard_occupation = guard_occupation;
    }

    public void setGuard_phoneNum(String guard_phoneNum) {
        this.guard_phoneNum = guard_phoneNum;
    }

    public void setGuard_address(String guard_address) {
        this.guard_address = guard_address;
    }

    public void setGuard_postcode(String guard_postcode) {
        this.guard_postcode = guard_postcode;
    }

    public void setGuard_residence(String guard_residence) {
        this.guard_residence = guard_residence;
    }
    
    public String getResidenceDisplay() {
        switch (guard_residence) {
            case "R":
                return "WARGANEGARA";
            case "N":
                return "BUKAN WARGANEGARA";
            default:
                return "UNKNOWN"; // Handle unexpected values
        }
    }

    public void setGuard_income(double guard_income) {
        this.guard_income = guard_income;
    }

    public void setOther_income(double other_income) {
        this.other_income = other_income;
    }

    public guardian findGuardian(int stud_id) {
        guardian gd = null; // Initialize as null in case no guardian is found.
        String query = "SELECT * FROM guardian WHERE stud_id = ?";
        try {
            Connection conn = dbconn.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, stud_id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Safely retrieve values, allowing for potential nulls
                String f_name = rs.getString("father_name");
                String f_occupation = rs.getString("father_occupation");
                String f_pNum = rs.getString("father_phoneNum"); 
                String f_address = rs.getString("father_address");
                double f_income = Double.parseDouble(rs.getString("father_income"));
                String m_name = rs.getString("mother_name");
                String m_occupation = rs.getString("mother_occupation");
                String m_pNum = rs.getString("mother_phoneNum"); 
                String m_address = rs.getString("mother_address");
                double m_income = Double.parseDouble(rs.getString("mother_income"));
                String g_name = rs.getString("guard_name");
                String g_relation = rs.getString("guard_relation");
                String g_residence = rs.getString("guard_residence");
                String g_postcode = rs.getString("guard_postcode");
                String g_occupation = rs.getString("guard_occupation");
                String g_pNum = rs.getString("guard_phoneNum"); 
                String g_address = rs.getString("guard_address");
                double g_income = Double.parseDouble(rs.getString("guard_income"));
                double oth_income = Double.parseDouble(rs.getString("other_income"));
                
                
                gd = new guardian();
                gd.setFather_name(f_name != null ? f_name : "Tiada");
                gd.setFather_occupation(f_occupation != null ? f_occupation : "Tiada");
                gd.setFather_phoneNum(f_pNum != null ? f_pNum : "Tiada");
                gd.setFather_Address(f_address != null ? f_address : "Tiada");
                gd.setFather_income(f_income);
                gd.setMother_name(m_name != null ? m_name : "Tiada");
                gd.setMother_occupation(m_occupation != null ? m_occupation : "Tiada");
                gd.setMother_phoneNum(m_pNum != null ? m_pNum : "Tiada");
                gd.setMother_Address(m_address != null ? m_address : "Tiada");
                gd.setMother_income(m_income);
                gd.setGuard_name(g_name != null ? g_name : "Tiada");
                gd.setGuard_relation(g_relation != null ? g_relation : "Tiada");
                gd.setGuard_residence(g_residence != null ? g_residence : "Tiada");
                gd.setGuard_postcode(g_postcode != null ? g_postcode : "Tiada");
                gd.setGuard_occupation(g_occupation != null ? g_occupation : "Tiada");
                gd.setGuard_phoneNum(g_pNum != null ? g_pNum : "Tiada");
                gd.setGuard_income(g_income);
                gd.setGuard_address(g_address != null ? g_address : "Tiada");
                gd.setOther_income(oth_income);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions appropriately
        }
        return gd; // Return the Student object or null if not found
    }
    
    @Override
    public String toString() {
        return "Guardian{" +
                "fatherName='" + father_name + '\'' +
                ", fatherOccupation='" + father_occupation + '\'' +
                ", fatherPhoneNum='" + father_phoneNum + '\'' +
                ", fatherAddress='" + father_address + '\'' +
                ", fatherIncome=" + father_income +
                ", motherName='" + mother_name + '\'' +
                ", motherOccupation='" + mother_occupation + '\'' +
                ", motherPhoneNum='" + mother_phoneNum + '\'' +
                ", motherAddress='" + mother_address + '\'' +
                ", motherIncome=" + mother_income +
                ", guardName='" + guard_name + '\'' +
                ", guardRelation='" + guard_relation + '\'' +
                ", guardOccupation='" + guard_occupation + '\'' +
                ", guardPhoneNum='" + guard_phoneNum + '\'' +
                ", guardAddress='" + guard_address + '\'' +
                ", guardPostcode='" + guard_postcode + '\'' +
                ", guardResidence='" + guard_residence + '\'' +
                ", guardIncome=" + guard_income +
                ", otherIncome=" + other_income +
                '}';
    }
}
