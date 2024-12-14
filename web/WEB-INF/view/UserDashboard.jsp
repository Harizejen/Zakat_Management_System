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
    <body>
         <!-- Navbar -->
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasMenu" aria-controls="offcanvasMenu">
                    <span class="navbar-toggler-icon"></span>
                    <span class="navbar-toggler-icon"></span>
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>
        </nav>
        
        <!-- Sidebar (Offcanvas) -->
        <aside class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasMenu" aria-labelledby="offcanvasMenuLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasMenuLabel">Menu</h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
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
                <a href="#" onclick="loadPage('applications.html')" class="menu-item"><i class="bi bi-file-earmark"></i> PERMOHONAN</a>
                <a href="#" onclick="loadPage('records.html')" class="menu-item"><i class="bi bi-clipboard"></i> REKOD</a>

                <!-- Logout Button -->
                <a href="#" class="menu-item btn-logout"><i class="bi bi-box-arrow-right"></i> LOG KELUAR</a>
            </div>
        </aside>
        <main class="dashboard-container" id="main-content">
            <h1 class="text-center">SELAMAT DATANG</h1>
            
            <!-- User Information -->
            <div class="section-card">
                <h5>Maklumat Pengguna:</h5>
                <div class="info-row">
                    <span>NAMA:</span>
                    <span>NUR AFRINA BINTI MUSTAFA</span>
                </div>
                <div class="info-row">
                    <span>NO. PELAJAR:</span>
                    <span>2021******</span>
                </div>
                <div class="info-row">
                    <span>NO. KP:</span>
                    <span>030115-**-****</span>
                </div>
            </div>

            <!-- Application Status -->
            <div class="section-card">
                <h5>Status Permohonan Zakat:</h5>
                <div class="info-row">
                    <span>TARIKH MOHON:</span>
                    <span>15 JANUARI 2025</span>
                </div>
                <div class="info-row">
                    <span>STATUS:</span>
                    <span>SEDANG DIPROSES</span>
                </div>
                <div class="info-row">
                    <span>ULASAN:</span>
                    <span>-</span>
                </div>
            </div>

            <!-- Current Zakat Offer -->
            <div class="section-card">
                <h5>Tawaran Zakat Semasa:</h5>
                <div class="info-row">
                    <span>STATUS TAWARAN:</span>
                    <span>DIBUKA</span>
                </div>
                <div class="info-row">
                    <span>TARIKH BUKA:</span>
                    <span>01 JANUARI 2025</span>
                </div>
                <div class="info-row">
                    <span>TARIKH TUTUP:</span>
                    <span>15 FEBRUARI 2025</span>
                </div>
                <button class="btn-red">MOHON</button>
                <button class="btn-red">SYARAT</button>
                <button class="btn-red">SENARAI SEMAK</button>
            </div>
        </main>
        
        <footer class="text-center mt-4 py-3 bg-light">
            <p>&copy;copyrights<span id="year"></span></p>
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
