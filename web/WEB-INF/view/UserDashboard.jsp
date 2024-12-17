<%-- 
    Document   : UserDashboard
    Created on : 14 Dec 2024, 1:58:48 pm
    Author     : Hariz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                <a href="#" class="menu-item"><i class="bi bi-house"></i> ANJUNG</a>
                <a href="#" onclick="loadPage('UserProfile.jsp')" class="menu-item"><i class="bi bi-person"></i> PROFIL</a>
                <a href="#" onclick="loadPage('applications.jsp')" class="menu-item"><i class="bi bi-file-earmark"></i> PERMOHONAN</a>
                <a href="#" onclick="loadPage('records.jsp')" class="menu-item"><i class="bi bi-clipboard"></i> REKOD</a>

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
                             <span class="label">NAMA</span> <span class="value">: NUR AFRINA BINTI MUSTAFA</span>
                        </div>
                        <div class="info-row">
                            <span class="label">NO. PELAJAR</span> <span class="value">: 2021******</span>
                        </div>
                        <div class="info-row">
                            <span class="label">NO. KP</span> <span class="value">: 030115-**-****</span>
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
                        <a href="#" class="button">MOHON</a>
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
            
            // Function to load external HTML files into the main section
            function loadPage(page) {
                fetch(page)
                    .then(response => {
                        if (!response.ok) throw new Error("Failed to load " + page);
                        return response.text();
                    })
                    .then(html => {
                        document.getElementById("main-content").innerHTML = html;
                    })
                    .catch(error => {
                        console.error("Error loading page:", error);
                        document.getElementById("main-content").innerHTML = "<p>Error loading content.</p>";
                    });
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
