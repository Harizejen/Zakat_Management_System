<%-- 
    Document   : HEPdashboard
    Created on : Dec 15, 2024, 8:02:45 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="css/staffDashboard.css">
</head>
<body>
    <!-- Navigation Bar -->
<nav class="navbar text-light mb-3" style="background-color: #112C55">
    <div class="container-fluid d-flex align-items-center">
        <!-- Right-aligned Section -->
        <div class="d-flex align-items-center ms-auto">
            <!-- Notification Bell -->
                <div class="notification me-3 position-relative" id="notificationBell" style="cursor: pointer;">
                    <i class="bi bi-bell-fill fs-4 text-white"></i>
                    <span class="badge bg-danger rounded-pill position-absolute top-0 start-100 translate-middle d-flex align-items-center justify-content-center" style="width: 20px; height: 20px; font-size: 12px; top: 20%; left: 80%;">1</span>
                </div>
            <!-- Log Out -->
            <a href="#" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Log Keluar</a>
        </div>
    </div>
</nav>

    <!-- Notification Box -->
    <div id="notificationBox">
        <div class="notification-header">
            <span><i class="bi bi-bell me-2"></i> Notifikasi Sistem</span>
            <small class="text-muted" id="currentDayTime"></small>
        </div>
        <div class="notification-body">
            <div class="alert alert-primary m-0 py-2">
                <small>Terdapat 1 permohonan baru.</small>
            </div>
        </div>
    </div>

    <!-- Main Container -->
    <div class="container main-container">
        <!-- Top Section -->
        <div class="row mb-3">
            <!-- Left: Welcome Text and Card -->
            <div class="col-md-6 d-flex flex-column">
                <!-- Welcome Text -->
                <div class="welcome-container mb-3">
                    <h1 class="fw-bold text-center">SELAMAT KEMBALI</h1>
                </div>
                <!-- Summary Card -->
                <div class="card text-center border-0 shadow-sm">
                    <div class="card-body card-body-lg text-white" style="background-color: #112C55">
                        <h5>JUMLAH PERMOHONAN:</h5>
                        <h2>1,200</h2>
                        <!-- Center the button -->
                        <div class="d-flex justify-content-center">
                            <button class="btn btn-danger">Lihat ></button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right: Pie Chart -->
            <div class="col-md-6 d-flex justify-content-center align-items-center">
                <div>
                    <canvas id="myPieChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Bottom Section -->
        <div class="row gx-3">
            <!-- Rectangle 1 -->
            <div class="col-md-4 mb-2">
                <div class="card text-center shadow-sm">
                    <div class="card-body text-white" style="background-color: #B74A4C">
                        <h5>PEMOHONAN MENUNGGU:</h5>
                        <h3>425</h3>
                    </div>
                </div>
            </div>
            <!-- Rectangle 2 -->
            <div class="col-md-4 mb-2">
                <div class="card text-center shadow-sm">
                    <div class="card-body text-white" style="background-color: #8A2565">
                        <h5>PEMOHONAN DISAHKAN:</h5>
                        <h3>700</h3>
                    </div>
                </div>
            </div>
            <!-- Rectangle 3 -->
            <div class="col-md-4 mb-2">
                <div class="card text-center shadow-sm">
                    <div class="card-body text-white" style="background-color: #7B577D">
                        <h5>PEMOHONAN DITOLAK:</h5>
                        <h3>75</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- Logout Confirmation Modal -->
<div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content text-center" style="background-color: #112C55; color: white;">
            <!-- Modal Body -->
            <div class="modal-body py-4">
                <h5 id="logoutModalLabel" class="mb-4">Adakah anda ingin keluar?</h5>
                <!-- Buttons -->
                <div class="d-flex justify-content-center gap-3">
                    <button type="button" class="btn btn-outline-light px-4" data-bs-dismiss="modal">KELUAR</button>
                    <button type="button" class="btn btn-danger px-4" data-bs-dismiss="modal">BATAL</button>
                </div>
            </div>
        </div>
    </div>
</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/Zakat_Management_System/js/staffDashboard.js"></script>

</body>
</html>
