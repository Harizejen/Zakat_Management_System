<%@page import="com.user.model.Student"%>
<%@page import="com.guard.model.guardian"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    // Retrieve the student data from the session
    Student st = (Student) request.getSession().getAttribute("student_data"); 
    // Retrieve the student data from the session
    guardian gd = (guardian) request.getSession().getAttribute("guard_info"); 
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profil</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/navbar.css">
        <link rel="stylesheet" href="css/profile.css">
    </head>
    <body style="background-color: #f9f6f1;">
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

        <!-- Main Content -->
        <main class="container mt-4">
            <h1 class="text-center mb-0 fw-bold">PROFIL</h1>
            <div class="row">
                <!-- Left Section -->
                <div class="col-md-8">
                    <div class="p-4 shadow-sm bg-white rounded">
                        <h4 class="mb-3 fw-bold">📌 Maklumat Peribadi</h4>
                        <p><strong>Nama Penuh:</strong> &nbsp;<%= st.getStudName() %></p>
                        <p><strong>Jantina:</strong>&nbsp;<%= st.getGenderDisplay() %></p>
                        <p><strong>No. Telefon:</strong>&nbsp;<%= st.getStudPhoneNum() %></p>
                        <p><strong>Email:</strong>&nbsp;<%= st.getStudEmail() %>
                        <p><strong>Alamat Menyurat:</strong>&nbsp;<%= st.getStudAddress() %></p>
                        <p><strong>No. Pelajar:</strong>&nbsp;<%= st.getStudID() %></p>
                        <p><strong>No. KP:</strong>&nbsp;<%= st.getStudIC() %></p>
                        <p><strong>Kod Program:</strong>&nbsp;<%= st.getStudCourse() %></p>
                        <p><strong>Kampus:</strong>&nbsp;<%= st.getStudCampus() %></p>
                        <p><strong>Status Perkahwinan:</strong> BUJANG</p>
                        <p><strong>No. Akaun Bank:</strong>&nbsp;<%= st.getStudBankNum() %></p>
                        <p><strong>Nama Bank:</strong>&nbsp;<%= st.getStudBankName() %></p>
                    </div>
                </div>

                <!-- Right Section -->
                <div class="col-md-4">
                    <div class="p-4 shadow-sm bg-white rounded">
                        <h4 class="fw-bold mb-3">Notifikasi</h4>
                        <p><strong>Status Permohonan:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>Tarikh Temuduga:</strong> TIADA</p>
                        <p><strong>Tarikh Akhir 2025:</strong> 15 FEBRUARI</p>
                    </div>
                </div>
            </div>
            
                <div class="p-4 mt-2 shadow-sm bg-white rounded">
                    <h4 class="fw-bold">📌 Maklumat Keluarga (Ibu Bapa & Penjaga)</h4>
                    <div class="row mt-4">
                        <!-- Maklumat Bapa -->
                        <div class="col-md-4">
                            <p><strong>NAMA BAPA:</strong>&nbsp;<%= gd.getFather_name() %></p>
                            <p><strong>PEKERJAAN BAPA:</strong>&nbsp;<%= gd.getFather_occupation().toUpperCase() %></p>
                            <p><strong>PENDAPATAN KASAR:</strong>&nbsp;RM <%= gd.getFather_income() %></p>
                            <p><strong>NO TELEFON BAPA:</strong>&nbsp;<%= gd.getFather_phoneNum() %></p>
                            <p><strong>ALAMAT BAPA:</strong>&nbsp;<%= gd.getFather_Address().toUpperCase() %></p>
                        </div>
                        <!-- Maklumat Ibu -->
                        <div class="col-md-4">
                            <p><strong>NAMA IBU:</strong>&nbsp;<%= gd.getMother_name().toUpperCase() %></p>
                            <p><strong>PEKERJAAN IBU:</strong> &nbsp;<%= gd.getMother_occupation().toUpperCase() %></p>
                            <p><strong>PENDAPATAN KASAR:</strong>&nbsp;RM <%= gd.getMother_income() %></p>
                            <p><strong>NO TELEFON IBU:</strong>&nbsp;<%= gd.getMother_phoneNum() %></p>
                            <p><strong>ALAMAT IBU:</strong>&nbsp;<%= gd.getMother_Address().toUpperCase() %></p>
                        </div>
                        <!-- Maklumat Penjaga -->
                        <div class="col-md-4">
                            <p><strong>NAMA PENJAGA:</strong>&nbsp;<%= gd.getGuard_name().toUpperCase() %></p>
                            <p><strong>PEKERJAAN PENJAGA:</strong>&nbsp;<%= gd.getGuard_occupation().toUpperCase() %></p>
                            <p><strong>NO TELEFON PENJAGA:</strong>&nbsp;<%= gd.getGuard_phoneNum() %></p>
                            <p><strong>ALAMAT PENJAGA:</strong>&nbsp;<%= gd.getGuard_address().toUpperCase() %></p>
                        </div>
                    </div>
                    <div class="text-center">
                        <a href="user.do?action=borang" class="btn btn-danger mt-3">KEMASKINI</a>
                    </div>
                </div>
            </main>

        <!-- Footer -->
        <footer class="text-center py-3 mt-3" style="background-color: #013220">
            <p class="text-white mb-0">&copy; Copyright <span id="year"></span></p>
        </footer>

        <script>
            // Dynamically set the current year
            document.getElementById("year").textContent = new Date().getFullYear();
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
