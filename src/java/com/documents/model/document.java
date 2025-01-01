/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.documents.model;

import com.database.dbconn;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author nasru
 */
public class document {
    private int doc_id;
    private int apply_id;
    private String doc_name;

    public document(int doc_id, String doc_type) {
        this.doc_id = doc_id;
        this.doc_name = doc_type;
    }

    public int getDoc_id() {
        return doc_id;
    }

    public void setDoc_id(int doc_id) {
        this.doc_id = doc_id;
    }
    
    public int getApply_id() {
        return apply_id;
    }
    
    public void setApply_id(int apply_id) {
        this.apply_id = apply_id;
    }

    public String getDoc_name() {
        return doc_name;
    }

    public void setDoc_name(String doc_name) {
        this.doc_name = doc_name;
    }
    
    public int getSpecDoc_ID(int apply_id, String doc_name) {
        String query = "SELECT doc_id FROM documents WHERE apply_id = ? AND doc_name = ?";
        int doc_id = -1; // Default value if no record is found

        try (Connection conn = dbconn.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            // Set the parameters in the prepared statement
            pstmt.setInt(1, apply_id);
            pstmt.setString(2, doc_name);

            try (ResultSet rs = pstmt.executeQuery()) {
                // If a result is found, retrieve the doc_id
                if (rs.next()) {
                    doc_id = rs.getInt("doc_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions appropriately
        }

        return doc_id;
    }
    
}
