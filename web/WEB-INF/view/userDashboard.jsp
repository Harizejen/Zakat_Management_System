<%-- 
    Document   : UserDashboard
    Created on : 14 Dec 2024, 1:58:48 pm
    Author     : Hariz
--%>

<%@page import="java.util.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="com.deadline.model.deadline"%>
<%@page import="com.application.model.Application"%>
<%@page import="com.user.model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Retrieve the student data from the session
    Student st = (Student) request.getSession().getAttribute("student_data");
    Application ap = new Application();
    ap = ap.getApplication(st.getStudID());
    deadline d = new deadline();
    d = d.getDeadline();
    Date currentDate = new Date();
    String eligibilityMessage = (String) request.getAttribute("eligibilityMessage");
    String popupMessage = (String) request.getAttribute("popupMessage");
    String redirectTo = (String) request.getAttribute("redirectTo");
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
                    <img src="${pageContext.request.contextPath}/images/logo_system.png" style="width: 80px; height: auto; border-radius: 50% " alt="Profile Picture">
                    <p class="profile-name"><%= st.getStudName()%></p>
                </div>

                <!-- Menu Items -->
                <a href="<%= request.getContextPath()%>/user.do?action=dashboard" class="menu-item"><i class="bi bi-house"></i> ANJUNG</a>
                <a href="<%= request.getContextPath()%>/user.do?action=profile" class="menu-item"><i class="bi bi-person"></i> PROFIL</a>
                <a href="<%= request.getContextPath()%>/user.do?action=permohonan" class="menu-item"><i class="bi bi-file-earmark"></i> PERMOHONAN</a>
                <a href="<%= request.getContextPath()%>/user.do?action=records" class="menu-item"><i class="bi bi-clipboard"></i> REKOD</a>

                <!-- Logout Button -->
                <a href="${pageContext.request.contextPath}/user_logout.do" class="menu-item btn-logout"><i class="bi bi-box-arrow-right"></i> LOG KELUAR</a>
            </div>
        </aside>

        <main class="dashboard-container" id="main-content">
            <h1 class="text-center mb-0">SELAMAT DATANG</h1>

            <div class="container">
                <!-- Left Column with Two Rows -->
                <div class="left-column">
                    <!-- Maklumat Pengguna -->
                    <div class="card">
                        <h2>Maklumat Pengguna:</h2>
                        <div class="info-row">
                            <span class="label">NAMA</span> <span class="value">: <%= st.getStudName()%></span>
                        </div>
                        <div class="info-row">
                            <span class="label">NO. PELAJAR</span> <span class="value">: <%= st.getStudID()%></span>
                        </div>
                        <div class="info-row">
                            <% if (st.getStudIC() == "" || st.getStudIC() == null) { %>
                            <span class="label">NO. KP</span> <span class="value" style="color: red">: TIADA MAKLUMAT </span>
                            <% } else {%>
                            <span class="label">NO. KP</span> <span class="value">: <%= st.getStudIC()%></span>
                            <% } %>
                        </div>
                    </div>

                    <!-- Status Permohonan Zakat -->
                    <div class="card">
                        <h2>Status Permohonan Zakat:</h2>
                        <% if (ap != null) {%>
                        <div class="info-row">
                            <span class="label">TARIKH MOHON</span> 
                            <span class="value">: <%= ap.getApplyDate() != null ? ap.getApplyDate() : "BELUM MEMOHON"%></span>
                        </div>
                        <div class="info-row">
                            <span class="label">STATUS</span> 
                            <span class="value">: <%= ap.getApplyStatus() != null ? ap.getApplyStatus() : "BELUM MEMOHON"%></span>
                        </div>
                        <% } else { %>
                        <div class="info-row">
                            <span class="label">TARIKH MOHON</span> <span class="value">: BELUM MEMOHON</span>
                        </div>
                        <div class="info-row">
                            <span class="label">STATUS</span> <span class="value">: BELUM MEMOHON</span>
                        </div>
                        <% } %>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="card">
                    <h2>Tawaran Zakat Semasa:</h2>
                    <% if (d != null) {
                            if (d.getApplication_deadline().after(currentDate)) {
                    %>
                    <div class="info-row">
                        <span class="label">STATUS TAWARAN</span> <span class="value">: DIBUKA</span>
                    </div>
                    <div class="info-row">
                        <span class="label">TARIKH BUKA</span> <span class="value">: <%= d.getApplication_open_date()%></span>
                    </div>
                    <div class="info-row">
                        <span class="label">TARIKH TUTUP</span> <span class="value">: <%= d.getApplication_deadline()%></span>
                    </div>
                    <% } else {%>
                    <div class="info-row">
                        <span class="label">STATUS TAWARAN</span> <span class="value">: DITUTUP</span>
                    </div>
                    <div class="info-row">
                        <span class="label">TARIKH BUKA</span> <span class="value">: <%= d.getApplication_open_date()%></span>
                    </div>
                    <div class="info-row">
                        <span class="label">TARIKH TUTUP</span> <span class="value">: <%= d.getApplication_deadline()%></span>
                    </div>

                    <%  }
                        }
                    %>


                    <div class="button-container">
                        <a href="<%= request.getContextPath()%>/user.do?action=borang" class="button">MOHON</a>
                        <a href="#" class="button">SYARAT</a>
                        <a href="#" class="button" onclick="submitPostForm()">SEMAK KELAYAKAN</a>
                    </div>
                </div>
            </div>
        </main>

        <!-- Modal for Pop-Up Message -->
        <div class="modal fade" id="eligibilityModal" tabindex="-1" aria-labelledby="eligibilityModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eligibilityModalLabel">Semakan Kelayakan</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p><%= eligibilityMessage != null ? eligibilityMessage : ""%></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>

        <footer class="text-center py-3 ">
            <p class="mt-3-0 text-white">&copy;copyrights<span id="year"></span></p>
        </footer>

        <script>
            // Set current year dynamically
            document.getElementById("year").textContent = new Date().getFullYear();

            function submitPostForm() {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '<%= request.getContextPath()%>/eligible_check.do';
                document.body.appendChild(form);
                form.submit();
            }
            ;

            window.onload = function () {
                var popupMessage = "<%= popupMessage != null ? popupMessage : ""%>";
                var eligibilityMessage = "<%= eligibilityMessage != null ? eligibilityMessage : ""%>";
                var redirectTo = "<%= redirectTo != null ? redirectTo : ""%>";

                if (popupMessage) {
                    // Show alert and redirect
                    alert(popupMessage);
                    if (redirectTo) {
                        window.location.href = redirectTo;
                    }
                }

                if (eligibilityMessage) {
                    // Show eligibility modal
                    var modal = new bootstrap.Modal(document.getElementById('eligibilityModal'));
                    modal.show();
                }
            };
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
