<%@page import="java.sql.*"%>
<%@page import="com.database.dbconn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hal Ehwal Akademik</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/stf.css">
    <link rel="stylesheet" href="css/staffDashboard.css">  
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar text-light mb-3" style="background-color: #112C55">
    <div class="container-fluid d-flex align-items-center">
         <!-- Back Arrow -->
        <a href="HEAdashboard.jsp" class="btn btn-outline-light me-3">
            <i class="bi bi-arrow-left"></i> 
        </a>

        <!-- Right-aligned Section -->
        <div class="d-flex align-items-center ms-auto">
            <!-- Log Out -->
            <a href="#" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Log Keluar</a>
        </div>
    </div>
</nav>
<!-- Main Container -->
<div class="container">
    <!-- Tabs Navigation -->
    <ul class="nav nav-tabs mb-3" id="applicationTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="total-tab" data-bs-toggle="tab" data-bs-target="#total" type="button" role="tab" aria-controls="total" aria-selected="false">Jumlah </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="approved-tab" data-bs-toggle="tab" data-bs-target="#approved" type="button" role="tab" aria-controls="approved" aria-selected="false">Disahkan</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" type="button" role="tab" aria-controls="pending" aria-selected="false">Menunggu</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="rejected-tab" data-bs-toggle="tab" data-bs-target="#rejected" type="button" role="tab" aria-controls="rejected" aria-selected="false">Ditolak</button>
        </li>
    </ul>

    <!-- Tabs Content -->
        <div class="tab-content" id="applicationTabsContent">
            <!-- Total Tab -->
            <div class="tab-pane fade" id="total" role="tabpanel" aria-labelledby="total-tab">
                <div class="jumlah-section mb-4">
                    <span>Jumlah Permohonan: <span class="jumlah-count">1200</span></span>
                </div>
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Bil</th>
                            <th>Nama</th>
                            <th>No. Pelajar</th>
                            <th>Tarikh Mohon</th>
                            <th>Borang</th>
                            <th>Status</th>
                            <th>Disemak</th>
                            <th>Tindakan</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Sample Row -->
                        <tr>
                            <td>1</td>
                            <td>Aris Aidil Bin Baharuddin</td>
                            <td>2023******</td>
                            <td>01/01/2025</td>
                            <td>
                                <a href="#" class="text-decoration-none">
                                    2023******_MAC25OGOS25.pdf
                                    <i class="bi bi-download download-icon"></i>
                                </a>
                            </td>
                            <td>
                                <!-- Dropdown for Aksi -->
                                <form action="aksiAction.do" method="post" style="display: inline;">
                                    <div class="dropdown">
                                        <button
                                            class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                            type="button"
                                            data-bs-toggle="dropdown"
                                            aria-expanded="false">
                                            Aksi
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Lulus</a></li>
                                            <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Gagal</a></li>
                                        </ul>
                                    </div>
                                </form>
                            </td>
                            <td>
                                <!-- Checkbox for Disemak -->
                                <input type="checkbox" name="disemak" value="checked">
                            </td>
                            <td>
                                <!-- Tindakan Form -->
                                <form action="tindakanAction.do" method="post" style="display: inline;">
                                    <button type="submit" class="btn btn-danger btn-sm" name="tindakan" value="serah">
                                        Serah
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-end">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                        </li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Next</a>
                        </li>
                    </ul>
                </nav>
            </div>
            
            <!-- Approved Tab -->
            <div class="tab-pane fade" id="approved" role="tabpanel" aria-labelledby="approved-tab">
                <div class="jumlah-section mb-4">
                    <span>Jumlah Permohonan: <span class="jumlah-count">1200</span></span>
                </div>
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Bil</th>
                            <th>Nama</th>
                            <th>No. Pelajar</th>
                            <th>Tarikh Mohon</th>
                            <th>Borang</th>
                            <th>Status</th>
                            <th>Disemak</th>
                            <th>Tindakan</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Sample Row -->
                        <tr>
                            <td>1</td>
                            <td>Aris Aidil Bin Baharuddin</td>
                            <td>2023******</td>
                            <td>01/01/2025</td>
                            <td>
                                <a href="#" class="text-decoration-none">
                                    2023******_MAC25OGOS25.pdf
                                    <i class="bi bi-download download-icon"></i>
                                </a>
                            </td>
                            <td>
                                <!-- Dropdown for Aksi -->
                                <form action="aksiAction.do" method="post" style="display: inline;">
                                    <div class="dropdown">
                                        <button
                                            class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                            type="button"
                                            data-bs-toggle="dropdown"
                                            aria-expanded="false">
                                            Aksi
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Lulus</a></li>
                                            <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Gagal</a></li>
                                        </ul>
                                    </div>
                                </form>
                            </td>
                            <td>
                                <!-- Checkbox for Disemak -->
                                <input type="checkbox" name="disemak" value="checked">
                            </td>
                            <td>
                                <!-- Tindakan Form -->
                                <form action="tindakanAction.do" method="post" style="display: inline;">
                                    <button type="submit" class="btn btn-danger btn-sm" name="tindakan" value="serah">
                                        Serah
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-end">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                        </li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Next</a>
                        </li>
                    </ul>
                </nav>
            </div>
            
            <!-- Rejected Tab -->
            <div class="tab-pane fade" id="rejected" role="tabpanel" aria-labelledby="rejected-tab">
                <div class="jumlah-section mb-4">
                    <span>Jumlah Permohonan: <span class="jumlah-count">1200</span></span>
                </div>
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Bil</th>
                            <th>Nama</th>
                            <th>No. Pelajar</th>
                            <th>Tarikh Mohon</th>
                            <th>Borang</th>
                            <th>Status</th>
                            <th>Disemak</th>
                            <th>Tindakan</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Sample Row -->
                        <tr>
                            <td>1</td>
                            <td>Aris Aidil Bin Baharuddin</td>
                            <td>2023******</td>
                            <td>01/01/2025</td>
                            <td>
                                <a href="#" class="text-decoration-none">
                                    2023******_MAC25OGOS25.pdf
                                    <i class="bi bi-download download-icon"></i>
                                </a>
                            </td>
                            <td>
                                <!-- Dropdown for Aksi -->
                                <form action="aksiAction.do" method="post" style="display: inline;">
                                    <div class="dropdown">
                                        <button
                                            class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                            type="button"
                                            data-bs-toggle="dropdown"
                                            aria-expanded="false">
                                            Aksi
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Lulus</a></li>
                                            <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Gagal</a></li>
                                        </ul>
                                    </div>
                                </form>
                            </td>
                            <td>
                                <!-- Checkbox for Disemak -->
                                <input type="checkbox" name="disemak" value="checked">
                            </td>
                            <td>
                                <!-- Tindakan Form -->
                                <form action="tindakanAction.do" method="post" style="display: inline;">
                                    <button type="submit" class="btn btn-danger btn-sm" name="tindakan" value="serah">
                                        Serah
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-end">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                        </li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Next</a>
                        </li>
                    </ul>
                </nav>
            </div>
            
            <!-- Approved Tab -->
            <div class="tab-pane fade" id="approved" role="tabpanel" aria-labelledby="approved-tab">
                <div class="jumlah-section mb-4">
                    <span>Jumlah Permohonan: <span class="jumlah-count">1200</span></span>
                </div>
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Bil</th>
                            <th>Nama</th>
                            <th>No. Pelajar</th>
                            <th>Tarikh Mohon</th>
                            <th>Borang</th>
                            <th>Status</th>
                            <th>Disemak</th>
                            <th>Tindakan</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Sample Row -->
                        <tr>
                            <td>1</td>
                            <td>Aris Aidil Bin Baharuddin</td>
                            <td>2023******</td>
                            <td>01/01/2025</td>
                            <td>
                                <a href="#" class="text-decoration-none">
                                    2023******_MAC25OGOS25.pdf
                                    <i class="bi bi-download download-icon"></i>
                                </a>
                            </td>
                            <td>
                                <!-- Dropdown for Aksi -->
                                <form action="aksiAction.do" method="post" style="display: inline;">
                                    <div class="dropdown">
                                        <button
                                            class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                            type="button"
                                            data-bs-toggle="dropdown"
                                            aria-expanded="false">
                                            Aksi
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Lulus</a></li>
                                            <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Gagal</a></li>
                                        </ul>
                                    </div>
                                </form>
                            </td>
                            <td>
                                <!-- Checkbox for Disemak -->
                                <input type="checkbox" name="disemak" value="checked">
                            </td>
                            <td>
                                <!-- Tindakan Form -->
                                <form action="tindakanAction.do" method="post" style="display: inline;">
                                    <button type="submit" class="btn btn-danger btn-sm" name="tindakan" value="serah">
                                        Serah
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-end">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                        </li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Next</a>
                        </li>
                    </ul>
                </nav>
            </div>
            
            <!-- Pending Tab -->
            <div class="tab-pane fade" id="pending" role="tabpanel" aria-labelledby="pending-tab">
                <div class="jumlah-section mb-4">
                    <span>Jumlah Permohonan: <span class="jumlah-count">1200</span></span>
                </div>
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Bil</th>
                            <th>Nama</th>
                            <th>No. Pelajar</th>
                            <th>Tarikh Mohon</th>
                            <th>Borang</th>
                            <th>Status</th>
                            <th>Disemak</th>
                            <th>Tindakan</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Sample Row -->
                        <tr>
                            <td>1</td>
                            <td>Aris Aidil Bin Baharuddin</td>
                            <td>2023******</td>
                            <td>01/01/2025</td>
                            <td>
                                <a href="#" class="text-decoration-none">
                                    2023******_MAC25OGOS25.pdf
                                    <i class="bi bi-download download-icon"></i>
                                </a>
                            </td>
                            <td>
                                <!-- Dropdown for Aksi -->
                                <form action="aksiAction.do" method="post" style="display: inline;">
                                    <div class="dropdown">
                                        <button
                                            class="btn btn-sm btn-outline-secondary dropdown-toggle"
                                            type="button"
                                            data-bs-toggle="dropdown"
                                            aria-expanded="false">
                                            Aksi
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Lulus</a></li>
                                            <li><a class="dropdown-item" href="#" onclick="updateDropdown(this)">Gagal</a></li>
                                        </ul>
                                    </div>
                                </form>
                            </td>
                            <td>
                                <!-- Checkbox for Disemak -->
                                <input type="checkbox" name="disemak" value="checked">
                            </td>
                            <td>
                                <!-- Tindakan Form -->
                                <form action="tindakanAction.do" method="post" style="display: inline;">
                                    <button type="submit" class="btn btn-danger btn-sm" name="tindakan" value="serah">
                                        Serah
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-end">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                        </li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Next</a>
                        </li>
                    </ul>
                </nav>
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
                    <a href="staff_logout.do" class="btn btn-outline-light px-4">KELUAR</a>
                    <button type="button" class="btn btn-danger px-4" data-bs-dismiss="modal">BATAL</button>
                </div>
            </div>
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



