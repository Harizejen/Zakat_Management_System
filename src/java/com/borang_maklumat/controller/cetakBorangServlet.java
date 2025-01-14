package com.borang_maklumat.controller;

import com.user.model.Student;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

 
public class cetakBorangServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve the student data from the session
        Student st = (Student) request.getSession().getAttribute("student_data");
        
        // Check if student data is available
        if (st != null) {
            System.out.print(st.toString());
            // Forward to the JSP for printing
            request.setAttribute("student", st);
            request.getRequestDispatcher("/WEB-INF/view/printForm.jsp").forward(request, response);
        } else {
            // Handle the case where student data is not found
            request.setAttribute("errorMessage", "No student data found.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}