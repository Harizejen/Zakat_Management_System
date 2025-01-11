<%-- 
    Document   : HEAdashboard
    Created on : Dec 15, 2024, 8:02:45 AM
    Author     : User
--%>
<%@page import="java.util.List"%>
<%@page import="com.application.model.Application"%>
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
                    <!-- Log Out -->
                    <a href="#" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Log Keluar</a>
                </div>
            </div>
        </nav>

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
                            <%
                                List<Application> totalList = (List<Application>) session.getAttribute("totalList");
                                int totalCount = (totalList != null) ? totalList.size() : 0; // Get the size safely
%>
                            <h2><%= totalCount%></h2>
                            <!-- Center the button -->
                            <div class="d-flex justify-content-center">
                                <a href="HEAListPage" class="btn btn-danger" >Lihat ></a>
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
                            <%
                                List<Application> pendingList = (List<Application>) session.getAttribute("pendingList");
                                int pendingCount = (pendingList != null) ? pendingList.size() : 0; // Get the size safely
%>
                            <h3><%= pendingCount%></h3>
                        </div>
                    </div>
                </div>
                <!-- Rectangle 2 -->
                <div class="col-md-4 mb-2">
                    <div class="card text-center shadow-sm">
                        <div class="card-body text-white" style="background-color: #8A2565">
                            <h5>PEMOHONAN DISAHKAN:</h5>
                            <%
                                List<Application> approvedList = (List<Application>) session.getAttribute("approvedList");
                                int approvedCount = (approvedList != null) ? approvedList.size() : 0; // Get the size safely
%>
                            <h3><%= approvedCount%></h3>
                        </div>
                    </div>
                </div>
                <!-- Rectangle 3 -->
                <div class="col-md-4 mb-2">
                    <div class="card text-center shadow-sm">
                        <div class="card-body text-white" style="background-color: #7B577D">
                            <h5>PEMOHONAN DITOLAK:</h5>
                            <%
                                List<Application> rejectedList = (List<Application>) session.getAttribute("rejectedList");
                                int rejectedCount = (rejectedList != null) ? rejectedList.size() : 0; // Get the size safely
%>
                            <h3><%= rejectedCount%></h3>
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
                            <a href="staff_logout.do" class="btn btn-outline-light px-4">KELUAR</a>
                            <button type="button" class="btn btn-danger px-4" data-bs-dismiss="modal">BATAL</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
    const pendingCount = <%= pendingCount%>;
    const approvedCount = <%= approvedCount%>;
    const rejectedCount = <%= rejectedCount%>;
    const ctx = document.getElementById('myPieChart').getContext('2d');
    const myPieChart = new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Menunggu', 'Disahkan', 'Ditolak'], // Status Labels
            datasets: [{
                    data: [pendingCount, approvedCount, rejectedCount], // Use the dynamic values
                    backgroundColor: ['#B74A4C', '#8A2565', '#7B577D'], // Colors for each status
                }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: true, // Display the legend
                }
            }
        }
    });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/Zakat_Management_System/js/staffDashboard.js"></script>

    </body>
</html>

