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
    <style>
        
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar text-light mb-3" style="background-color: #112C55">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <span class="navbar-brand text-white">Unit Zakat, Sedekah dan Wakaf</span> <!-- Updated title in the navbar -->
        <div class="d-flex align-items-center">
            <!-- Notification Bell -->
            <div class="notification me-3">
                <i class="bi bi-bell-fill fs-5 text-white"></i>
                <span class="badge bg-danger rounded-pill">2</span>
            </div>
            <!-- Log Out -->
            <span class="text-light">Log Keluar</span>
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

</body>
</html>
