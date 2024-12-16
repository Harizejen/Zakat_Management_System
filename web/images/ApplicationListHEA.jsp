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
</head>
<body>

<!-- Navbar -->
<nav class="navbar text-light mb-3" style="background-color: #112C55">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <span class="navbar-brand text-white">Hal Ehwal Akademik</span>
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
                <th>CGPA</th> <!-- Changed from Gaji -->
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
                <td>3.85</td> <!-- Changed to CGPA -->
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

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
