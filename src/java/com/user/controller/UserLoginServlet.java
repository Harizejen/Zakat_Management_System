/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.user.controller;

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
public class UserLoginServlet extends HttpServlet {

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
            out.println("<title>Servlet UserLoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserLoginServlet at " + request.getContextPath() + "</h1>");
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

        int stud_id = Integer.parseInt(request.getParameter("stud_id"));
        String stud_password = request.getParameter("stud_password");
        
        request.getSession().setAttribute("studentID", stud_id);
        
        Student st = new Student();
        guardian gd = new guardian();
        st.setStudID(stud_id);
        st.setStudPass(stud_password);

        if (st.isValid()) {
            Student stl = st.findStudent(stud_id);
            guardian gd1 = gd.findGuardian(stud_id);
            request.getSession().setAttribute("student_data", stl);
            //System.out.print(gd1.toString());
            // Check if guardian information is available
//            if (stl != null && (stl.getStudIC() != null && !stl.getStudIC().isEmpty())) {
//                // If guardian information is available, set it in the session
//                request.getSession().setAttribute("student_data", stl);
//            } else {
//                // Handle the case where guardian info is not available
//                request.getSession().setAttribute("student_data", null);
//            }
            // Check if guardian information is available
            if (gd1 != null && (gd1.getFather_name() != null && !gd1.getFather_name().isEmpty())) {
                // If guardian information is available, set it in the session
                request.getSession().setAttribute("guard_info", gd1);
            } else {
                // Handle the case where guardian info is not available
                if(gd1 == null){
                    guardian gd2 = new guardian();
                    gd2.setFather_name("TIADA");
                    gd2.setFather_occupation("TIADA");
                    gd2.setFather_phoneNum("TIADA");
                    gd2.setFather_Address("TIADA");
//                    gd.setFather_income(f_income);
                    gd2.setMother_name("TIADA");
                    gd2.setMother_occupation("TIADA");
                    gd2.setMother_phoneNum("TIADA");
                    gd2.setMother_Address("TIADA");
//                    gd.setMother_income(m_income);
                    gd2.setGuard_name("TIADA");
                    gd2.setGuard_relation("TIADA");
                    gd2.setGuard_residence("TIADA");
                    gd2.setGuard_postcode("TIADA");
                    gd2.setGuard_occupation("TIADA");
                    gd2.setGuard_phoneNum("TIADA");
//                    gd.setGuard_income(g_income);
                    gd2.setGuard_address("TIADA");
//                    gd.setOther_income(oth_income);
                    request.getSession().setAttribute("guard_info", gd2);
                }
                
            }
            
            
            // Check if the student's information is complete
            boolean isComplete = stl.isInformationComplete(stl); // Implement this method in your Student class
            request.setAttribute("isInformationComplete", isComplete);

            request.getRequestDispatcher("/WEB-INF/view/userDashboard.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Invalid student ID or password");
            request.getRequestDispatcher("/user_login.jsp").forward(request, response);
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
