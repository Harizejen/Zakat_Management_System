/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.application.controller;

import com.application.model.Application;
import com.database.dbconn;
import com.deadline.model.deadline;
import com.user.model.Student;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author User
 */
@MultipartConfig(
//    location = "D:\\Degree UiTM\\SEM 4\\CSC584\\Group Project\\Zakat System\\Zakat_Management_System\\uploads", //hariz file
    location = "C:\\Users\\nasru\\OneDrive\\Documents\\NetBeansProjects\\Zakat_Management_System\\uploads",    //Nasrullah file
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 61   // 61MB
)
public class AddApplicationServlet extends HttpServlet {
    
    private static final String UPLOAD_DIR = "uploads";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddApplicationServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddApplicationServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean insertApplication = false;
        boolean insertDocument = false;
        deadline d = new deadline();
        d = d.getDeadline();

        Student st = (Student) request.getSession().getAttribute("student_data");

        // Retrieve application data
        int stud_id = st.getStudID();
        int deadline_id = d.getDeaadline_id(); // Example value for testing; replace with actual logic
        String apply_session = "Sesi " + LocalDate.now().getYear();
        String apply_foodIncentive = request.getParameter("apply_foodIncentive");
        String apply_otherSupport = request.getParameter("apply_otherSupport");
        String apply_otherSupportName = request.getParameter("apply_otherSupportName") != null ? request.getParameter("apply_otherSupportName") : "TIADA";
        String apply_otherSupportAmountParam = request.getParameter("apply_otherSupportAmount");
        double apply_otherSupportAmount = 0.0;

        if (apply_otherSupportAmountParam != null && !apply_otherSupportAmountParam.trim().isEmpty()) {
            try {
                apply_otherSupportAmount = Double.parseDouble(apply_otherSupportAmountParam);
            } catch (NumberFormatException e) {
                apply_otherSupportAmount = 0.0; // Default if parsing fails
            }
        }

        String apply_part = request.getParameter("apply_part");
        double apply_gpa = Double.parseDouble(request.getParameter("apply_gpa"));
        double apply_cgpa = Double.parseDouble(request.getParameter("apply_cgpa"));
        String apply_purpose = request.getParameter("apply_purpose");
        LocalDate apply_date = LocalDate.now();
        int donation_id = 1;//default value

        // Create directory to save uploaded files
        String uploadPath = File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Create directory if it does not exist
        }
        
//        Application ap = new Application();
//        if (ap.existedApplication(stud_id, apply_session)) {
//                request.setAttribute("error", "You have already applied.");
//                request.getRequestDispatcher("/WEB-INF/view/applicationPage.jsp").forward(request, response);
//                return;
//        }

        String applyQuery = "INSERT INTO application (stud_id, deadline_id, apply_session, apply_part, apply_cgpa, apply_gpa, apply_foodIncentive, apply_otherSupport, apply_otherSupportName, apply_otherSupportAmount, apply_purpose, apply_date, donation_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String documentQuery = "INSERT INTO documents (apply_id, doc_name) VALUES (?, ?)";

        try (Connection conn = dbconn.getConnection()) {
            conn.setAutoCommit(false);

            // Insert application
            try (PreparedStatement psApplication = conn.prepareStatement(applyQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
                psApplication.setInt(1, stud_id);
                psApplication.setInt(2, deadline_id);
                psApplication.setString(3, apply_session);
                psApplication.setString(4, apply_part);
                psApplication.setDouble(5, apply_cgpa);
                psApplication.setDouble(6, apply_gpa);
                psApplication.setString(7, apply_foodIncentive);
                psApplication.setString(8, apply_otherSupport);
                psApplication.setString(9, apply_otherSupportName);
                psApplication.setDouble(10, apply_otherSupportAmount);
                psApplication.setString(11, apply_purpose);
                psApplication.setDate(12, java.sql.Date.valueOf(apply_date));
                psApplication.setInt(13, donation_id);

                int rowsInserted = psApplication.executeUpdate();
                if (rowsInserted > 0) {
                    insertApplication = true;

                    // Retrieve generated application ID
                    try (ResultSet generatedKeys = psApplication.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int apply_id = generatedKeys.getInt(1);

                            // Save uploaded files and insert document data
                            try (PreparedStatement psDocument = conn.prepareStatement(documentQuery)) {
                                Collection<Part> parts = request.getParts();
                                for (Part filePart : parts) {
                                    String fileName = getFileName(filePart);
                                    if (fileName != null && !fileName.isEmpty()) {
                                          filePart.write(fileName);

                                        // Save file name to database
                                        psDocument.setInt(1, apply_id);
                                        request.getSession().setAttribute("apply_id", apply_id);
                                        psDocument.setString(2, fileName);
                                        psDocument.addBatch();
                                    }
                                }
                                int[] documentResults = psDocument.executeBatch();
                                insertDocument = documentResults.length > 0;
                            }
                        }
                    }
                }
            }

            // Commit or rollback based on the results
            if (insertApplication && insertDocument) {
                conn.commit();
                request.getRequestDispatcher("/WEB-INF/view/successBP.jsp").forward(request, response);
            } else {
                conn.rollback();
                request.setAttribute("errorMessage", "Failed to insert application or document data.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while processing your application. Please try again later.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    private String getFileName(Part part){
        String contentDisposition = part.getHeader("content-disposition");
        
        if(!contentDisposition.contains("filename=")){
            return null;
        }
        
        int beginIndex = contentDisposition.indexOf("filename=")+10;
        int endIndex = contentDisposition.length() - 1;
        
        return contentDisposition.substring(beginIndex,endIndex);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
