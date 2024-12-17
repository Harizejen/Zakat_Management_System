/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.user.controller;

import com.database.dbconn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class UserSignUpServlet extends HttpServlet {

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
            out.println("<title>Servlet UserSignUpServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserSignUpServlet at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String stud_name = request.getParameter("stud_name");
        int stud_id = Integer.parseInt(request.getParameter("stud_id"));
        String stud_email = request.getParameter("stud_email");
        String stud_password = request.getParameter("stud_password");
        
        String query = "INSERT INTO STUDENT (stud_id, stud_name, stud_email, stud_password) VALUES (?,?,?,?)" ;
        
        try{
            Connection conn = dbconn.getConnection();
            conn.setAutoCommit(false);
            PreparedStatement pstmt= conn.prepareStatement(query);
            pstmt.setInt(1,stud_id);
            pstmt.setString(2,stud_name);
            pstmt.setString(3, stud_email);
            pstmt.setString(4,stud_password);
            
            int rowsAffected = pstmt.executeUpdate(); //check num of row affected
            
            conn.commit();
            conn.setAutoCommit(true);
            
            if(rowsAffected > 0){
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script type='text/javascript'>");
                out.println("alert('Registration successful! Redirecting to login page...');");
                out.println("window.location.href='user_login.jsp';");
                out.println("</script>");
                out.close();
                request.setAttribute("stud_id",stud_id);
                request.getRequestDispatcher("/user_login.jsp").forward(request, response);
                pstmt.close();
                conn.close();
            }
            
        }catch(SQLException e){
            e.printStackTrace();
        }
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
