<%-- 
    Document   : UserProfile
    Created on : 14 Dec 2024, 4:53:57 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
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
                    <p class="profile-name">NUR AFRINA BINTI MUSTAFA</p>
                </div>

                <!-- Menu Items -->
                <a href="UserDashboard.jsp" class="menu-item"><i class="bi bi-house"></i> ANJUNG</a>
                <a href="#" onclick="loadPage('UserProfile.jsp')" class="menu-item"><i class="bi bi-person"></i> PROFIL</a>
                <a href="#" onclick="loadPage('applications.html')" class="menu-item"><i class="bi bi-file-earmark"></i> PERMOHONAN</a>
                <a href="#" onclick="loadPage('records.html')" class="menu-item"><i class="bi bi-clipboard"></i> REKOD</a>

                <!-- Logout Button -->
                <a href="#" class="menu-item btn-logout"><i class="bi bi-box-arrow-right"></i> LOG KELUAR</a>
            </div>
        </aside>
        
        <main class="dashboard-container" id="main-content">
            <!-- Main Container -->
            <div class="container">
                <!-- Left Section: Maklumat Peribadi -->
                <div class="content">
                    <h2>Maklumat Peribadi</h2>
                    <div class="section-title">📌 Maklumat Pemohon</div>
                    <div class="info">NAMA PENUH : NUR AFRINA BINTI MUSTAFA</div>
                    <div class="info">JANTINA : PEREMPUAN</div>
                    <div class="info">NO. TELEFON : 010-****-****</div>
                    <div class="info">EMAIL : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">ALAMAT MENYURAT : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">NEGERI ASAL : SELANGOR</div>
                    <div class="info">NO. PELAJAR : 2021***</div>
                    <div class="info">NO. KP : 030115-**-****</div>
                    <div class="info">KOD PROGRAM : ADM10</div>
                    <div class="info">KAMPUS : RAUB - PAHANG</div>
                    <div class="info">STATUS PERKAHWINAN : BUJANG</div>
                    <div class="info">NO. AKAUN BANK : 06696945*****78</div>
                    <div class="info">NAMA BANK : BANK SIMPANAN RAKYAT (BSN)</div>

                    <div class="section-title">📌 Maklumat Keluarga (Ibu Bapa & Penjaga)</div>
                    <div class="info">NAMA BAPA : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">PEKERJAAN BAPA : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">PENDAPATAN KASAR : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">NO. TELEFON BAPA : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">ALAMAT BAPA : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">NAMA IBU : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">PEKERJAAN IBU : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">PENDAPATAN KASAR : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">NO. TELEFON IBU : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">ALAMAT IBU : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">NAMA PENJAGA : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">PEKERJAAN PENJAGA : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">NO. TELEFON PENJAGA : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">ALAMAT PENJAGA : <span class="red">TIDAK LENGKAP</span></div>

                    <!-- Update Button -->
                    <a href="updateForm.jsp" class="update-button">KEMASKINI</a>
                </div>

                <!-- Right Section: Notifikasi -->
                <div class="notification">
                    <h3>Notifikasi</h3>
                    <div class="info">STATUS PERMOHONAN : <span class="red">TIDAK LENGKAP</span></div>
                    <div class="info">TARIKH TEMUDUGA : TIADA</div>
                    <div class="info">TARIKH AKHIR 2025 : 15 FEBRUARI</div>
                </div>
            </div>
        </main>
    </body>
</html>

