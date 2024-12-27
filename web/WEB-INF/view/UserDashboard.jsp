<%-- 
    Document   : UserDashboard
    Created on : 14 Dec 2024, 1:58:48 pm
    Author     : Hariz
--%>

<%@page import="com.user.model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    // Retrieve the student data from the session
    Student st = (Student) request.getSession().getAttribute("student_data"); 
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="css/navbar.css">
        <link rel="stylesheet" href="css/dashboard.css">
    </head>
    <body style="background-color: #f9f6f1"> 
        <!-- Navbar -->
        <nav class="navbar navbar-expand-md">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasMenu" aria-controls="offcanvasMenu">
                     <i class="bi bi-list" style="color: white;"></i> <!-- Use Bootstrap Icon -->
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
                
        <main class="dashboard-container" id="main-content">
            <h1 class="text-center mb-4">SELAMAT DATANG</h1>
            
            <div class="container">
                <!-- Left Column with Two Rows -->
                <div class="left-column">
                    <!-- Maklumat Pengguna -->
                    <div class="card">
                        <h2>Maklumat Pengguna:</h2>
                        <div class="info-row">
                            <span class="label">NAMA</span> <span class="value">: <%= st.getStudName() %></span>
                        </div>
                        <div class="info-row">
                            <span class="label">NO. PELAJAR</span> <span class="value">: <%= st.getStudID() %></span>
                        </div>
                        <div class="info-row">
                            <% if(st.getStudIC() == " ") { %>
                                <span class="label">NO. KP</span> <span class="value" style="color: red">: TIADA MAKLUMAT </span>
                            <% } else { %>
                                <span class="label">NO. KP</span> <span class="value">: <%= st.getStudIC() %></span>
                            <% } %>
                        </div>
                    </div>

                    <!-- Status Permohonan Zakat -->
                    <div class="card">
                        <h2>Status Permohonan Zakat:</h2>
                        <div class="info-row">
                            <span class="label">TARIKH MOHON</span> <span class="value">: 15 JANUARI 2025</span>
                        </div>
                        <div class="info-row">
                            <span class="label">STATUS</span> <span class="value">: SEDANG DIPROSES</span>
                        </div>
                        <div class="info-row">
                            <span class="label">ULASAN</span> <span class="value">: -</span>
                        </div>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="card">
                    <h2>Tawaran Zakat Semasa:</h2>
                    <div class="info-row">
                        <span class="label">STATUS TAWARAN</span> <span class="value">: DIBUKA</span>
                    </div>
                    <div class="info-row">
                        <span class="label">TARIKH BUKA</span> <span class="value">: 01 JANUARI 2025</span>
                    </div>
                    <div class="info-row">
                        <span class="label">TARIKH TUTUP</span> <span class="value">: 15 FEBRUARI 2025</span>
                    </div>

                    <div class="button-container">
                        <a href="<%= request.getContextPath() %>/user.do?action=borang" class="button">MOHON</a>
                        <a href="#" class="button">SYARAT</a>
                        <a href="#" class="button">SENARAI SEMAK</a>
                    </div>
                </div>
            </div>
        </main>
        
        <footer class="text-center py-3 ">
            <p class="mb-0 text-white">&copy;copyrights<span id="year"></span></p>
        </footer>

        <script>
            // Set current year dynamically
            document.getElementById("year").textContent = new Date().getFullYear();
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
