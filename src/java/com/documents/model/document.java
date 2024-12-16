/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.documents.model;

/**
 *
 * @author nasru
 */
public class document {
    private String doc_id;
    private String doc_type;

    public document(String doc_id, String doc_type) {
        this.doc_id = doc_id;
        this.doc_type = doc_type;
    }

    public String getDoc_id() {
        return doc_id;
    }

    public void setDoc_id(String doc_id) {
        this.doc_id = doc_id;
    }

    public String getDoc_type() {
        return doc_type;
    }

    public void setDoc_type(String doc_type) {
        this.doc_type = doc_type;
    }
    
    
}
