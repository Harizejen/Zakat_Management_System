<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hal Ehwal Akademik</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.3/font/bootstrap-icons.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/stf.css">
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

<!-- Main Container -->
<div class="container">
    <!-- Jumlah Permohonan Section -->
    <div class="jumlah-section mb-4">
        <span>Jumlah Permohonan: <span class="jumlah-count">1200</span></span>
    </div>

    <!-- Table Section -->
    <table class="table table-hover align-middle">
        <thead class="table-light">
            <tr>
                <th>Bil</th>
                <th>Disemak</th>
                <th>Nama</th>
                <th>No. Pelajar</th>
                <th>CGPA</th> 
                <th>Tarikh Mohon</th>
                <th>Borang</th>
                <th>Status</th>
                <th>Tindakan</th>
            </tr>
        </thead>
        <tbody>
            <!-- Sample Rows -->
            <tr>
                <td>1</td>
                <td><input type="checkbox"></td>
                <td>Aris Aidil Bin Baharuddin</td>
                <td>2023******</td>
                <td>3.85</td> 
                <td>01/01/2025</td>
                <td>
                    <a href="#" class="text-decoration-none">
                        2023******_MAC25OGOS25.pdf
                        <i class="bi bi-download download-icon"></i>
                    </a>
                </td>
                <td>
                    <span class="circle-status status-green"></span>
                    <span class="status-text">Diluluskan</span>
                </td>
                <td>
                    <!-- Dropdown Tindakan -->
                    <div class="d-flex align-items-center gap-2">
                        <div class="dropdown">
                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Tindakan
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Semak</a></li>
                                <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Sahkan</a></li>
                                <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Tolak</a></li>
                            </ul>
                        </div>
                        <!-- Serah Button -->
                        <button class="btn btn-danger btn-sm">Serah</button>
                    </div>
                </td>
            </tr>
            <!-- Repeat rows as necessary -->
        </tbody>
    </table>

    <!-- Pagination -->
    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center">
            <li class="page-item disabled">
                <a class="page-link" href="#" tabindex="-1" aria-disabled="true">Sebelumnya</a>
            </li>
            <li class="page-item"><a class="page-link" href="#">1</a></li>
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

<!-- JavaScript to Update Dropdown -->
<script>
    // Function to update the dropdown button text
    function updateDropdown(element) {
        const dropdownButton = element.closest('.dropdown').querySelector('.dropdown-toggle');
        dropdownButton.textContent = element.textContent;
    }
</script>
</body>
</html>
