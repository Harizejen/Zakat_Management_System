package com.borang_maklumat.controller;

import com.guard.model.guardian;
import com.user.model.Student;
import com.documents.controller.mergeDocsUtilty; // Import your merge utility
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class cetakBorangServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int stud_id = Integer.parseInt(request.getParameter("stud_id"));
        
        Student st = new Student();
        guardian gd = new guardian();
        
        Student stl = st.findStudent(stud_id);
        guardian gd1 = gd.findGuardian(stud_id);
        
        // Check if student data is available
        if (stl != null) {
            // Assuming you have generated individual PDFs and stored their paths
            List<String> pdfFilePaths = new ArrayList<>();

            // Example paths for individual PDFs (replace with actual paths)
            String basePath = "C:\\Users\\nasru\\OneDrive\\Documents\\NetBeansProjects\\Zakat_Management_System\\uploads\\";
//            String basePath = "D:\\Degree UiTM\\SEM 4\\CSC584\\Group Project\\Zakat System\\Zakat_Management_System\\uploads\\";
            pdfFilePaths.add(basePath + stl.getStudName() + "_Salinan_Kad_Pengenalan_Ibu_dan_Bapa_Penjaga.pdf");
            pdfFilePaths.add(basePath + stl.getStudName() + "_Pengesahan_Pendapatan.pdf");
            pdfFilePaths.add(basePath + stl.getStudName() + "_KadMatrik_Student.pdf");

            // Use the student's name for the merged PDF file name
            String studentName = stl.getStudName().replaceAll("\\s+", "_"); // Replace spaces with underscores
            String mergedPdfPath = basePath + studentName + "_merged.pdf"; // Specify the output path

            // Convert List to Array for merging
            String[] pdfFilesArray = pdfFilePaths.toArray(new String[0]);

            // Call the merge method
            try {
                mergeDocsUtilty.mergePDFs(pdfFilesArray, mergedPdfPath);
                request.setAttribute("mergedPdfPath", mergedPdfPath); // Set the merged PDF path as a request attribute
            } catch (Exception e) {
                request.setAttribute("errorMessage", "Error merging PDFs: " + e.getMessage());
            }

            // Forward to the JSP for printing
            request.setAttribute("student", stl);
            request.setAttribute("guard", gd1);
            request.getRequestDispatcher("/WEB-INF/view/printForm.jsp").forward(request, response);
        } else {
            // Handle the case where student data is not found
            request.setAttribute("errorMessage", "No student data found.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}