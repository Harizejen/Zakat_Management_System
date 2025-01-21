<%@page import="java.util.List"%>
<%@page import="com.ApplicationDetails.model.ApplicationDetails"%>
<%@page import="com.staff.model.staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    // Retrieve the staff data from the session
    staff st = (staff) request.getSession().getAttribute("staff_data"); 
%>
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
    
    <!-- Sidebar -->
    <div id="sidebar">
        <!-- Profile Section -->
        <div class="profile-section d-flex flex-column align-items-center justify-content-center mb-4">
            <img src="https://via.placeholder.com/80" class="rounded-circle mb-2" alt="Profile" style="width: 80px; height: 80px;">
            <h5 class="text-white text-center"><%= st.getStaffname() %></h5>
        </div>

        <!-- Sidebar Menu -->
        <ul class="list-unstyled">
            <li>
                <a href="goUZSWdashboard">
                    <i class="bi bi-house-door"></i>
                    <span>Anjung</span>
                </a>
            </li>
            <li>
                <a href="#" data-bs-toggle="modal" data-bs-target="#durasiModal">
                    <i class="bi bi-clock"></i>
                    <span>Tetapkan Tarikh</span>
                </a>
            </li>
            <li>
                <a href="#" data-bs-toggle="modal" data-bs-target="#zakatModal">
                    <i class="bi bi-cash"></i>
                    <span>Tetapkan Nilai Zakat</span>
                </a>
            </li>
            <li>
                <a href="UZSWServlet">
                    <i class="bi bi-list-ul"></i>
                    <span>Senarai Permohonan</span>
                </a>
            </li>
            <li>
                <a href="#" data-bs-toggle="modal" data-bs-target="#logoutModal">
                    <i class="bi bi-box-arrow-right"></i>
                    <span>Log Keluar</span>
                </a>
            </li>
        </ul>
    </div>
    
    <!-- Toggle Button -->
    <div class="toggle-btn text-danger">
        <i class="bi bi-list"></i>
    </div>
    
    <!-- Overlay -->
    <div id="overlay" class="overlay"></div>
    
    <!-- Navigation Bar -->
    <nav class="navbar text-light mb-3" style="background-color: #112C55">
        <div class="container-fluid d-flex align-items-center">
            <!-- Brand Name with Increased Left Margin -->
            <span class="navbar-brand fw-bold ms-5" style="color: white; font-size: 1.5rem;">Zakat Pendidikan Management System</span>
            
            <!-- Right-aligned Section -->
            <div class="d-flex align-items-center ms-auto">
                <!-- Log Out -->
                <a href="#" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Log Keluar</a>
            </div>
        </div>
    </nav>
         
    <!-- Main Container -->
    <div id="content">
        <div class="container main-container">
            <!-- Top Section -->
            <div class="row mb-3">
                <!-- Left: Welcome Text and Card -->
                <div class="col-md-6 d-flex flex-column">
                    <!-- Welcome Text -->
                    <div class="welcome-container mb-3">
                        <h1 class="fw-bold text-center" style="font-size: 2rem;">UNIT ZAKAT, SEDEKAH & WAKAF</h1>
                    </div>
                    <!-- Summary Card -->
                    <div class="card text-center border-0 shadow-sm">
                        <div class="card-body card-body-lg text-white" style="background-color: #112C55">
                            <h5>JUMLAH KESELURUHAN PERMOHONAN:</h5>
                            <% 
                            List<ApplicationDetails> totalList = (List<ApplicationDetails>) session.getAttribute("totalList");
                            int totalCount = (totalList != null) ? totalList.size() : 0; // Get the size safely
                            %>
                            <h2><%= totalCount %></h2>
                            <!-- Center the button -->
                            <div class="d-flex justify-content-center">
                                <a href="UZSWServlet" class="btn btn-danger">Lihat ></a>
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
                            <h5>PERMOHONAN DALAM PROSES:</h5>
                            <% 
                            List<ApplicationDetails> pendingList = (List<ApplicationDetails>) session.getAttribute("pendingList");
                            int pendingCount = (pendingList != null) ? pendingList.size() : 0; // Get the size safely
                            %>
                            <h3><%= pendingCount %></h3>
                        </div>
                    </div>
                </div>
                <!-- Rectangle 2 -->
                <div class="col-md-4 mb-2">
                    <div class="card text-center shadow-sm">
                        <div class="card-body text-white" style="background-color: #8A2565">
                            <h5>PEMOHONAN DILULUSKAN</h5>
                            <% 
                            List<ApplicationDetails> approvedList = (List<ApplicationDetails>) session.getAttribute("approvedList");
                            int approvedCount = (approvedList != null) ? approvedList.size() : 0; // Get the size safely
                            %>
                            <h3><%= approvedCount %></h3>
                        </div>
                    </div>
                </div>
                <!-- Rectangle 3 -->
                <div class="col-md-4 mb-2">
                    <div class="card text-center shadow-sm">
                        <div class="card-body text-white" style="background-color: #7B577D">
                            <h5>PEMOHONAN DIGAGALKAN:</h5>
                            <% 
                            List<ApplicationDetails> rejectedList = (List<ApplicationDetails>) session.getAttribute("rejectedList");
                            int rejectedCount = (rejectedList != null) ? rejectedList.size() : 0; // Get the size safely
                            %>
                            <h3><%= rejectedCount %></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Zakat Modal -->
    <div class="modal fade" id="zakatModal" tabindex="-1" aria-labelledby="zakatModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="background-color: #6E97B2; color: white;">
                <!-- Modal Header -->
                <form action="saveZakatAmount" method="post">
                    <div class="modal-header text-white d-flex justify-content-center border-0" style="background-color: #6E97B2">
                        <h5 class="modal-title fw-bold text-center w-100" id="zakatModalLabel">
                            <span class="d-block fs-6 fw-bold">SESI MAC2025/OGOS2025</span>
                            Masukkan Nilai Zakat: 
                        </h5>
                    </div>

                    <!-- Modal Body -->
                    <div class="modal-body">
                        <div class="d-flex justify-content-center">
                            <input type="text" name="amaunZakat" class="form-control text-center w-75 fs-5" placeholder="RM ------">
                        </div>
                    </div>

                    <div class="modal-header text-white d-flex justify-content-center border-0" style="background-color: #6E97B2">
                        <h5 class="modal-title fw-bold text-center w-100" id="zakatModalLabel">
                            Masukkan Tarikh Zakat: 
                        </h5>
                    </div>
                    
                    <div class="modal-body">
                        <div class="d-flex justify-content-center">
                            <input type="date" name="tarikhKred" class="form-control" required>
                        </div>
                    </div>

                    <!-- Modal Footer -->
                    <div class="modal-footer d-flex justify-content-between">
                        <button type="button" class="btn btn-light text-danger" data-bs-dismiss="modal">BATAL</button>
                        <button type="submit" class="btn btn-danger">TETAPKAN</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Tetapkan Durasi Modal -->
    <div class="modal fade" id="durasiModal" tabindex="-1" aria-labelledby="durasiModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="background-color: #6E97B2; color: white;">
                <!-- Modal Header -->
                <div class="modal-header text-white justify-content-center border-0" style="background-color: #6E97B2;">
                    <h5 class="modal-title fw-bold text-center w-100" id="durasiModalLabel">Tetapkan Durasi</h5>
                    <button type="button" class="btn-close text-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <!-- Modal Body -->
                <div class="modal-body">
                    <form action="deadline_save.do" method="post">
                        <!-- Tarikh Mula -->
                        <div class="mb-3">
                            <label for="tarikhMula" class="form-label">Tarikh Mula</label>
                            <input type="date" class="form-control" id="tarikhMula" name="tarikhMula" required>
                        </div>
                        <!-- Tarikh Akhir -->
                        <div class="mb-3">
                            <label for="tarikhAkhir" class="form-label">Tarikh Akhir</label>
                            <input type="date" class="form-control" id="tarikhAkhir" name="tarikhAkhir" required>
                        </div>
                        <!-- Modal Footer -->
                        <div class="modal-footer d-flex justify-content-between">
                            <button type="button" class="btn btn-light text-danger" data-bs-dismiss="modal">BATAL</button>
                            <button type="submit" class="btn btn-danger">TETAPKAN</button>
                        </div>
                    </form>
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
                        <a href="staff_logout.do" class="btn btn-outline-light px-4">KELUAR</a>
                        <button type="button" class="btn btn-danger px-4" data-bs-dismiss="modal">BATAL</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const pendingCount = <%= pendingCount %>;
        const approvedCount = <%= approvedCount %>;
        const rejectedCount = <%= rejectedCount %>;
        const ctx = document.getElementById('myPieChart').getContext('2d');
        const myPieChart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: ['Dalam Proses', 'Diluluskan', 'Digagalkan'],  // Status Labels
                datasets: [{
                    data: [pendingCount, approvedCount, rejectedCount],  // Use the dynamic values
                    backgroundColor: ['#B74A4C', '#8A2565', '#7B577D'],  // Colors for each status
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,  // Display the legend
                    }
                }
            }
        });
        
        // Check if there is an error message in the session
    <% 
        String errorMessage = (String) session.getAttribute("error");
        if (errorMessage != null) {
            // Clear the error message from the session after displaying it
            session.removeAttribute("error");
    %>
        alert('<%= errorMessage %>');
    <% 
        } 
    %>

    // Check if there is a success message in the session
    <% 
        String successMessage = (String) session.getAttribute("success");
        if (successMessage != null) {
            // Clear the success message from the session after displaying it
            session.removeAttribute("success");
    %>
        alert('<%= successMessage %>');
    <% 
        } 
    %>
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/Zakat_Management_System/js/staffDashboard.js"></script>

</body>
</html>