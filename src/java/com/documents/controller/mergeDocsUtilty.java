/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Other/File.java to edit this template
 */
package com.documents.controller;

/**
 *
 * @author User
 */
import org.apache.pdfbox.multipdf.PDFMergerUtility;
import java.io.File;
import java.io.IOException;

public class mergeDocsUtilty {

    public static void mergePDFs(String[] pdfFiles, String outputFilePath) {
        PDFMergerUtility merger = new PDFMergerUtility();
        try {
            for (String pdfFile : pdfFiles) {
                merger.addSource(new File(pdfFile));
            }
            merger.setDestinationFileName(outputFilePath);
            merger.mergeDocuments(null);
            System.out.println("Merged PDF created at: " + outputFilePath);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
