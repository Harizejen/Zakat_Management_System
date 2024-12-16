/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.staff.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
@WebServlet(name = "StaffLoginServlet", urlPatterns = {"/staff_login.do"})
public class StaffLoginServlet extends HttpServlet {
     private static final long serialVersionUID = 1L;

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
            out.println("<title>Servlet StaffLoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffLoginServlet at " + request.getContextPath() + "</h1>");
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
        String staffId = request.getParameter("staffId");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        boolean isValidUser  = validateUser (staffId, password, role);

        if (isValidUser ) {
            HttpSession session = request.getSession();
            session.setAttribute("staffId", staffId);
            session.setAttribute("role", role);

            switch (role) {
                case "HEA":
                    request.getRequestDispatcher("/WEB-INF/view/HEAdashboard.jsp").forward(request, response);
                    break;
                case "HEP":
                    request.getRequestDispatcher("/WEB-INF/view/HEPdashboard.jsp").forward(request, response);
                    break;
                case "UZSW":
                    request.getRequestDispatcher("/WEB-INF/view/UZSWdashboard.jsp").forward(request, response);
                    break;
                default:
                    response.sendRedirect("error.jsp");
                    break;
            }
        } else {
            request.setAttribute("errorMessage", "Invalid ID or password.");
            request.getRequestDispatcher("staff_login.jsp").forward(request, response);
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
private boolean validateUser (String staffId, String password, String role) {
        if ("HEA".equals(role)) {
            return "staff123".equals(staffId) && "passwordHEA".equals(password);
        } else if ("HEP".equals(role)) {
            return "staff456".equals(staffId) && "passwordHEP".equals(password);
        } else if ("UZSW".equals(role)) {
            return "staff789".equals(staffId) && "passwordUZSW".equals(password);
        }
        return false;
    }
}
