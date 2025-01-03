/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.documents.controller;

import com.database.dbconn;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author nasrul and hariz
 */
public class GetDocumentServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "D:\\Degree UiTM\\SEM 4\\CSC584\\Group Project\\Zakat System\\Zakat_Management_System\\uploads";

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
            out.println("<title>Servlet addDocumentServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addDocumentServlet at " + request.getContextPath() + "</h1>");
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
            //Kena test nnti
            // Retrieve the file name from the request parameter
            String documentIdParam = request.getParameter("documentId");
            //String fileName = request.getParameter("fileName");
            
            if (documentIdParam == null || documentIdParam.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid or missing document ID.");
                return;
            }

//            if (fileName == null || fileName.trim().isEmpty()) {
//                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "File name is required.");
//                return;
//            }
            
            int documentId;
            try {
                documentId = Integer.parseInt(documentIdParam);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid document ID format.");
                return;
            }
            
            String fileName = null;
            
            try (Connection conn = dbconn.getConnection()) {
                String query = "SELECT doc_name FROM documents WHERE doc_id = ?";
                try (PreparedStatement ps = conn.prepareStatement(query)) {
                    ps.setInt(1, documentId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            fileName = rs.getString("doc_name");
                        } else {
                            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Document not found.");
                            return;
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error occurred.");
                return;
            }
            
            File file = new File(UPLOAD_DIR, fileName);
            if (!file.exists() || !file.isFile()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
                return;
            }

            // Determine the file path
//            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
//            File file = new File(uploadPath, fileName);

//            if (!file.exists()) {
//                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
//                return;
//            }

            // Set the response headers for file download
            response.setContentType(getServletContext().getMimeType(file.getName()));
            response.setContentLength((int) file.length());
            response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");

            // Stream the file content to the client
            try (FileInputStream fis = new FileInputStream(file);
                 OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[1024];
                int bytesRead;

                while ((bytesRead = fis.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
