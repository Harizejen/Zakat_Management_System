<%-- 
    Document   : rekod
    Created on : 31 Dec 2024, 4:27:00 pm
    Author     : Hariz and Nasrullah
--%>

<%@page import="com.application.model.Application"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.user.model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    // Retrieve the student data from the session
    Student st = (Student) request.getSession().getAttribute("student_data");
    ArrayList<Application> appRecord = (ArrayList<Application>) request.getSession().getAttribute("app_record");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Rekod</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/navbar.css">
        <link rel="stylesheet" href="css/profile.css">
        <link rel="stylesheet" href="css/rekod.css">
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-md bg-dark">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasMenu" aria-controls="offcanvasMenu">
                    <i class="bi bi-list text-white"></i>
                </button>
            </div>
        </nav>

        <!-- Sidebar (Offcanvas) -->
        <aside class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasMenu" aria-labelledby="offcanvasMenuLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasMenuLabel">Menu</h5>
                <button type="button" class="btn-close btn-close-white text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <!-- Profile Section -->
                <div class="profile-section">
                    <img src="https://via.placeholder.com/80" alt="Profile Picture">
                    <p class="profile-name"><%= st.getStudName() %></p>
                </div>

                <!-- Menu Items -->
                <a href="<%= request.getContextPath() %>/user.do?action=dashboard" class="menu-item"><i class="bi bi-house"></i> ANJUNG</a>
                <a href="<%= request.getContextPath() %>/user.do?action=profile" class="menu-item"><i class="bi bi-person"></i> PROFIL</a>
                <a href="<%= request.getContextPath() %>/user.do?action=permohonan" class="menu-item"><i class="bi bi-file-earmark"></i> PERMOHONAN</a>
                <a href="<%= request.getContextPath() %>/user.do?action=records" class="menu-item"><i class="bi bi-clipboard"></i> REKOD</a>

                <!-- Logout Button -->
                <a href="#" class="menu-item btn-logout"><i class="bi bi-box-arrow-right"></i> LOG KELUAR</a>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="container mt-4">
            <div class="record-card">
                <h2 class="text-center mb-4">REKOD</h2>
                <div class="mb-3">
                    <p><strong>NAMA:</strong> <%= st.getStudName() %></p>
                    <p><strong>NO. PELAJAR:</strong> <%= st.getStudID() %></p>
                    <p><strong>NO. KP:</strong> <%= st.getStudIC() %></p>
                </div>
                <table class="table table-bordered text-center">
                    <thead>
                        <tr class="table-light">
                            <th>BIL.</th>
                            <th>ZAKAT SESI</th>
                            <th>STATUS</th>
                        </tr>
                    </thead>
                    <tbody>
                     <% 
                        if (appRecord != null && !appRecord.isEmpty()) {
                          for (int i = 0; i < appRecord.size(); i++) {
                             Application app = appRecord.get(i);
                    %>
                        <tr>
                            <td><%= i+1 %></td>
                            <td><%= app.getApplySession() %></td>
                            <td><%= app.getApplyStatus() %></td>
                        </tr>
                    <%
                            }
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </main>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

