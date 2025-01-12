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

        <!-- Main Content -->
        <main class="container mt-4">
            <h1 class="text-center mb-0 fw-bold">PROFIL</h1>
            <div class="row">
                <div class="col-md-8"> <!-- Adjust the width as needed -->
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link active" id="step1-tab" data-bs-toggle="tab" href="#tab1" role="tab" aria-controls="tab1" aria-selected="true">PERIBADI</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link" id="step2-tab" data-bs-toggle="tab" href="#tab2" role="tab" aria-controls="tab2" aria-selected="false">IBU</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link" id="step3-tab" data-bs-toggle="tab" href="#tab3" role="tab" aria-controls="tab3" aria-selected="false">BAPA</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link" id="step4-tab" data-bs-toggle="tab" href="#tab4" role="tab" aria-controls="tab4" aria-selected="false">PENJAGA</a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-4"> <!-- Adjust the width as needed -->
                    <div class="p-4 shadow-sm bg-white rounded">
                        <h4 class="fw-bold mb-3">Notifikasi</h4>
                        <p><strong>Status Permohonan:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>Tarikh Temuduga:</strong> TIADA</p>
                        <p><strong>Tarikh Akhir 2025:</strong> 15 FEBRUARI</p>
                    </div>
                </div>
            </div>    
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="tab1" role="tabpanel" aria-labelledby="tab1-tab">
                    <div class="p-4 mt-2 shadow-sm bg-white rounded">
                        <h4 class="mb-3 fw-bold">📌 Maklumat Peribadi</h4>
                        <div class="row mt-4">
                            <div class="col-md-4">
                                <p><strong>NAMA PENUH:</strong> &nbsp;<%= st.getStudName() != null ? st.getStudName() : "Tiada"%></p>
                                <p><strong>NO. KP:</strong>&nbsp;<%= st.getStudIC() != null ? st.getStudIC() : "Tiada"%></p>
                                <p><strong>JANTINA:</strong>&nbsp;<%= st.getGenderDisplay() != null ? st.getGenderDisplay() : "Tiada"%></p>
                                <p><strong>NO. TELEFON:</strong>&nbsp;<%= st.getStudPhoneNum() != null ? st.getStudPhoneNum() : "Tiada"%></p>
                                <p><strong>EMEL:</strong>&nbsp;<%= st.getStudEmail() != null ? st.getStudEmail() : "Tiada"%>
                                <p><strong>ALAMAT MENYURAT:</strong>&nbsp;<%= st.getStudAddress() != null ? st.getStudAddress() : "Tiada"%></p>
                            </div>
                            <div class="col-md-4">
                                <p><strong>STATUS PERKAHWINAN:</strong><%= st.getGenderDisplay() != null ? st.getGenderDisplay() : "Tiada"%></p>
                                <p><strong>NO. PELAJAR:</strong>&nbsp;<%= st.getStudID()%></p>
                                <p><strong>KOD PROGRAM:</strong>&nbsp;<%= st.getStudCourse() != null ? st.getStudCourse() : "Tiada"%></p>
                                <p><strong>KAMPUS:</strong>&nbsp;<%= st.getStudCampus() != null ? st.getStudCampus() : "Tiada"%></p> 
                                <p><strong>NO. AKAUN BANK:</strong>&nbsp;<%= st.getStudBankNum() != null ? st.getStudBankNum() : "Tiada"%></p>
                                <p><strong>NAMA BANK:</strong>&nbsp;<%= st.getStudBankName() != null ? st.getStudBankName() : "Tiada"%></p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="tab2" role="tabpanel" aria-labelledby="tab2-tab">
                    <div class="p-4 mt-2 shadow-sm bg-white rounded">
                        <h4 class="fw-bold">📌 Maklumat Keluarga (Ibu)</h4>
                        <div class="row mt-4">
                            
                            <!-- Maklumat Ibu -->
                            <div class="col-md-4">
                                <p><strong>NAMA IBU:</strong>&nbsp;<%= gd.getMother_name().toUpperCase() != null ? gd.getMother_name().toUpperCase() : "Tiada"%></p>
                                <p><strong>PEKERJAAN IBU:</strong> &nbsp;<%= gd.getMother_occupation().toUpperCase() != null ? gd.getMother_occupation().toUpperCase() : "Tiada"%></p>
                                <p><strong>PENDAPATAN KASAR:</strong>&nbsp;RM <%= gd.getMother_income() != 0 ? gd.getMother_income() : "-"%></p>
                                <p><strong>NO TELEFON IBU:</strong>&nbsp;<%= gd.getMother_phoneNum() != null ? gd.getMother_phoneNum() : "Tiada"%></p>
                                <p><strong>ALAMAT IBU:</strong>&nbsp;<%= gd.getMother_Address().toUpperCase() != null ? gd.getMother_Address().toUpperCase() : "Tiada"%></p>
                            </div>
                            
                        </div>

                    </div>
                </div>

                <div class="tab-pane fade" id="tab3" role="tabpanel" aria-labelledby="tab3-tab">
                    <div class="p-4 mt-2 shadow-sm bg-white rounded">
                       <h4 class="fw-bold">📌 Maklumat Keluarga (Bapa)</h4>
                        <div class="row mt-4">
                            <!-- Maklumat Bapa -->
                            <div class="col-md-4">
                                <p><strong>NAMA BAPA:</strong>&nbsp;<%= gd.getFather_name() != null ? gd.getFather_name() : "Tiada"%></p>
                                <p><strong>PEKERJAAN BAPA:</strong>&nbsp;<%= gd.getFather_occupation().toUpperCase() != null ? gd.getFather_occupation().toUpperCase() : "Tiada"%></p>
                                <p><strong>PENDAPATAN KASAR:</strong>&nbsp;RM <%= gd.getFather_income() != 0 ? gd.getFather_income() : "Tiada"%></p>
                                <p><strong>NO TELEFON BAPA:</strong>&nbsp;<%= gd.getFather_phoneNum() != null ? gd.getFather_phoneNum() : "Tiada"%></p>
                                <p><strong>ALAMAT BAPA:</strong>&nbsp;<%= gd.getFather_Address().toUpperCase() != null ? gd.getFather_Address().toUpperCase() : "Tiada"%></p>
                            </div>
                        </div> 
                    </div>
                    
                </div>
                        
                <div class="tab-pane fade" id="tab4" role="tabpanel" aria-labelledby="tab4-tab">
                    <div class="p-4 mt-2 shadow-sm bg-white rounded">
                       <h4 class="fw-bold">📌 Maklumat Keluarga (Penjaga)</h4>
                        <div class="row mt-4">
                            <!-- Maklumat Penjaga -->
                            <div class="col-md-4">
                                <p><strong>NAMA PENJAGA:</strong>&nbsp;<%= gd.getGuard_name().toUpperCase() != null ? gd.getGuard_name().toUpperCase() : "Tiada"%></p>
                                <p><strong>PEKERJAAN PENJAGA:</strong>&nbsp;<%= gd.getGuard_occupation().toUpperCase() != null ? gd.getGuard_occupation().toUpperCase() : "Tiada"%></p>
                                <p><strong>NO TELEFON PENJAGA:</strong>&nbsp;<%= gd.getGuard_phoneNum() != null ? gd.getGuard_phoneNum() : "Tiada"%></p>
                                <p><strong>ALAMAT PENJAGA:</strong>&nbsp;<%= gd.getGuard_address().toUpperCase() != null ? gd.getGuard_address().toUpperCase() : "Tiada"%></p>
                            </div>
                        </div> 
                    </div>
                    
                </div>       

            </div>

            <div class="text-center">
                <a href="user.do?action=borang" class="btn btn-danger mt-3">KEMASKINI</a>
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
