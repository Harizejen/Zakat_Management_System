package com.borang_maklumat.controller;



import org.apache.pdfbox.multipdf.PDFMergerUtility;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.apache.pdfbox.pdmodel.interactive.form.PDAcroForm;
import org.apache.pdfbox.pdmodel.interactive.form.PDField;
import org.apache.pdfbox.pdmodel.encryption.StandardProtectionPolicy;
import org.apache.pdfbox.pdmodel.encryption.AccessPermission;

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
