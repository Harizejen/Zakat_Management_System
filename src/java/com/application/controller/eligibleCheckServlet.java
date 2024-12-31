/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.application.controller;

import com.application.model.Application;
import com.guard.model.guardian;
import com.user.model.Student;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class eligibleCheckServlet extends HttpServlet {

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
            out.println("<title>Servlet eligibleCheckServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet eligibleCheckServlet at " + request.getContextPath() + "</h1>");
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
        // Gaji Abah + Mak < 5000 Layak
        // CGPA > 3.0 Layak
        Student st = (Student) request.getSession().getAttribute("student_data");
        guardian guard = (guardian) request.getSession().getAttribute("guard_info");
        Application ap = new Application();
        ap = ap.getApplication(st.getStudID());
        
//        System.out.println(guard.getFather_income());
//        System.out.println(guard.getMother_income());
//        System.out.println(ap.getApplyCGPA());

        // boolean to check eligibility
        boolean eligibleIncome = false;
        boolean eligibleCGPA = false;

        if (st.isInformationComplete(st) == false) {
            String eligibilityMessage = "Please complete your information!";
            request.setAttribute("eligibilityMessage", eligibilityMessage);
            request.setAttribute("popupMessage", "Maklumat anda tidak lengkap. Sila lengkapkan borang maklumat.");
            request.setAttribute("redirectTo", "BorangMaklumat.jsp");
            request.getRequestDispatcher("/WEB-INF/view/UserDashboard.jsp").forward(request, response);
            return;
        }

        double incomeParents = guard.getFather_income() + guard.getMother_income();

        if (incomeParents < 5000) {
            eligibleIncome = true;
        }

        if (ap.getApplyCGPA() >= 3.0) {
            eligibleCGPA = true;
        }

        // Set eligibility messages
        if (eligibleIncome && eligibleCGPA) {
            request.setAttribute("eligibilityMessage", "Anda layak memohon!");
        } else if (!eligibleIncome) {
            request.setAttribute("eligibilityMessage", "Anda tidak layak kerana pendapatan ibu bapa melebihi RM5000.");
        } else if (!eligibleCGPA) {
            request.setAttribute("eligibilityMessage", "Anda tidak layak kerana CGPA kurang daripada 3.0.");
        }

        request.getSession().setAttribute("guard_info", guard);
        request.getRequestDispatcher("/WEB-INF/view/UserDashboard.jsp").forward(request, response);
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
