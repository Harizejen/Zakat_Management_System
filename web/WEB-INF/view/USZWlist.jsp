<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unit Zakat, Sedekah dan Wakaf</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.3/font/bootstrap-icons.min.css">
   <link rel="stylesheet" href="css/stf.css">
    <link rel="stylesheet" href="css/staffDashboard.css">
    <style>
        
    </style>
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

<!-- Main Content -->
<div class="container">
    <!-- Table Section -->
    <div class="d-flex justify-content-between mb-3">
        <h5>Jumlah Telah Disahkan <span class="text-muted">(700 forms)</span></h5>
    </div>
    <table class="table table-hover">
        <thead>
            <tr>
                <th>Bil</th>
                <th>Disemak</th>
                <th>Nama</th>
                <th>No. Pelajar</th>
                <th>Borang</th>
                <th>Tarikh Temuduga</th>
                <th>Verifikasi</th>
            </tr>
        </thead>
        <tbody>
            <!-- Sample Row -->
            <tr>
                <td>31</td>
                <td><input type="checkbox"></td>
                <td>Aris Aidil Bin Baharuddin</td>
                <td>2023******</td>
                <td>
                    <a href="#" class="text-decoration-none">
                        2023******_MAC25OGOS25.pdf
                        <i class="bi bi-download download-icon"></i>
                    </a>
                </td>
                <td>11/03/2025</td>
                <td>
                
                    <button class="btn btn-sahkan btn-sm">SAHKAN</button>
                </td>
            </tr>
            <tr>
                <td>35</td>
                <td><input type="checkbox"></td>
                <td>Muhammad Haziq Human Bin Hamiril</td>
                <td>2023******</td>
                <td>
                    <a href="#" class="text-decoration-none">
                        2023******_MAC25OGOS25.pdf
                        <i class="bi bi-download download-icon"></i>
                    </a>
                </td>
                <td>--TIADA--</td>
                <td>
                    <button class="btn btn-sahkan btn-sm btn-disabled">SAHKAN</button>
                </td>
            </tr>
            <!-- Repeat rows -->
        </tbody>
    </table>

    <!-- Pagination -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1">Sebelumnya</a>
            </li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item">
                <a class="page-link" href="#">Seterusnya</a>
            </li>
        </ul>
    </nav>
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
                    <a href="staff_logout.do" class="btn btn-outline-light px-4">KELUAR</a>
                    <button type="button" class="btn btn-danger px-4" data-bs-dismiss="modal">BATAL</button>
                </div>
            </div>
        </div>
    </div>
</div>

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
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="/Zakat_Management_System/js/staffDashboard.js"></script>

</body>
</html>
