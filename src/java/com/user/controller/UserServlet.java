/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.user.controller;

import com.application.model.Application;
import com.guard.model.guardian;
import com.interview.model.interview;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class UserServlet extends HttpServlet {

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
            out.println("<title>Servlet UserServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserServlet at " + request.getContextPath() + "</h1>");
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
         String action = request.getParameter("action");

        if ("profile".equals(action)) {
            int stud_id = (Integer) request.getSession().getAttribute("studentID");
            guardian gd = new guardian();
            interview iv = new interview();
            guardian gd1 = gd.findGuardian(stud_id);
            Date iv_date = iv.getInterviewDateByStudentId(stud_id);
            if(gd1 != null){
                request.setAttribute("date", iv_date);
                request.getRequestDispatcher("/WEB-INF/view/UserProfile.jsp").forward(request, response);
            }else {
            request.getSession().setAttribute("warning", "Sila lengkapkan Borang Maklumat terlebih dahulu!");
            request.getRequestDispatcher("/WEB-INF/view/BorangMaklumat.jsp").forward(request, response);
            }
            
        } else if ("dashboard".equals(action)) {
            request.getRequestDispatcher("/WEB-INF/view/userDashboard.jsp").forward(request, response);
        } else if ("borang".equals(action)) {
            int stud_id = (Integer) request.getSession().getAttribute("studentID");
            guardian gd = new guardian();
            guardian gd1 = gd.findGuardian(stud_id);
            if(gd1 != null){
                request.setAttribute("warning", "");
                request.getRequestDispatcher("/WEB-INF/view/BorangMaklumat.jsp").forward(request, response);
            }else {
                request.getSession().setAttribute("warning", "Sila lengkapkan Borang Maklumat terlebih dahulu!");
                request.getRequestDispatcher("/WEB-INF/view/BorangMaklumat.jsp").forward(request, response);
            }
        } else if ("permohonan".equals(action)) {
            int stud_id = (Integer) request.getSession().getAttribute("studentID");
            guardian gd = new guardian();
            guardian gd1 = gd.findGuardian(stud_id);
            if(gd1 != null){
                request.getSession().setAttribute("guard_info", gd1);
                request.getRequestDispatcher("/WEB-INF/view/applicationPage.jsp").forward(request, response);
            }else {
            request.getSession().setAttribute("warning", "Sila lengkapkan Borang Maklumat terlebih dahulu!");
            request.getRequestDispatcher("/WEB-INF/view/BorangMaklumat.jsp").forward(request, response);
            }
            
        } else if ("records".equals(action)) {
            int stud_id = (Integer) request.getSession().getAttribute("studentID");
            Application ap = new Application();
            ArrayList<Application> appRecord = ap.getApplicationRecords(stud_id);
            request.getSession().setAttribute("app_record", appRecord);
            // Handle the records action, e.g., forward to records.jsp
            request.getRequestDispatcher("/WEB-INF/view/rekod.jsp").forward(request, response);
        }
        else {
            processRequest(request, response);
        }
    }
    
//    private void getProfile(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException{
//        
//        int stud_id = Integer.parseInt(request.getParameter("stud_id"));
//        request.setAttribute("stud_id", stud_id);
//        request.getRequestDispatcher("/WEB-INF/view/UserProfile.jsp").forward(request, response);
//        
//    }
//    
//    private void getDashboard(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException{
//        
//        int stud_id = Integer.parseInt(request.getParameter("stud_id"));
//        request.setAttribute("stud_id", stud_id);
//        request.getRequestDispatcher("/WEB-INF/view/UserDashboard.jsp").forward(request, response);
//        
//    }
//    
//    private void getBorang(HttpServletRequest request, HttpServletResponse response)
//        throws ServletException, IOException{
//        
//        int stud_id = Integer.parseInt(request.getParameter("stud_id"));
//        request.setAttribute("stud_id", stud_id);
//        request.getRequestDispatcher("/WEB-INF/view/BorangMaklumat.jsp").forward(request, response);
//        
//    }

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
