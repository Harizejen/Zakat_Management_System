<%@page import="java.util.List"%>
<%@page import="com.staff.model.staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Admin Dashboard</title>
        <style>
            body {
                background-color: #F2EBDD;
                font-family: 'Arial', sans-serif;
                font-weight: bold;
                overflow-y: hidden;
            }
            .content {
                padding: 20px;
            }
            h1 {
                color: #522E5C;
                text-align: center;
                margin-top: 20px;
            }
            .navbar {
                background-color: #522E5C;
                padding: 1rem;
            }
            .navbar-brand {
                font-size: 1.5rem;
                color: #F2EBDD !important;
            }
            /* Bento Grid Layout */
            .dashboard-container {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                grid-template-rows: repeat(2, 1fr);
                gap: 15px;
                padding: 20px;
            }
            .card {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 20px;
                border-radius: 10px;
                background-color: #CEB5D4;
                transition: transform 0.3s, box-shadow 0.3s;
            }
            .card:hover {
                transform: translateY(-10px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            }
            .card-title {
                font-size: 1.5rem;
                color: #522E5C;
            }
            .card-text {
                font-size: 5rem;
                font-weight: bold;
                color: #522E5C;
            }
            .btn-primary {
                background-color: #6E1313;
                border: none;
                padding: 10px 20px;
                font-size: 1rem;
                font-weight: bold;
            }
            .btn-primary:hover {
                background-color: #8B1A1A;
            }
            /* Define Bento Layout Positions */
            .item1, .item5 { grid-column: span 2; } /* Wider */
            .item2, .item4 { grid-column: span 1; }
            .item3 { grid-row: span 2; } /* Taller card for HEP staff */

            footer {
                background-color: #522E5C;
                color: #F2EBDD;
                padding: 1rem 0;
                position: fixed;
                left: 0;
                bottom: -20px;
                margin-top: 5px;
                width: 100%;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <!-- Top Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light">
            <div class="container-fluid">
                <a class="navbar-brand text-white" href="adminServlet?action=login">Zakat Pendidikan Management System</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <div class="ms-auto">
                        <a class="btn btn-light" 
                           href="${pageContext.request.contextPath}/adminLogOutServlet" 
                           role="button" 
                           style="background-color: #6E1313; color: white; border: none;">
                            Logout
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Welcome Section -->
        <div class="content">
            <h1>ADMIN DASHBOARD</h1>

            <!-- Dashboard Bento Grid -->
            <div class="container-fluid mt-3">
                <div class="dashboard-container">
                    <!-- Total Applications -->
                    <div class="card text-center shadow-sm item1">
                        <h5 class="card-title">Jumlah Permohonan</h5>
                        <p class="card-text display-4">
                            <%= (Integer) request.getAttribute("totalApplications")%>
                        </p>
                        <a href="adminServlet?action=viewApplication" class="btn btn-primary">Lihat Permohonan</a>
                    </div>

                    <!-- HEA Staff -->
                    <div class="card text-center shadow-sm item2">
                        <h5 class="card-title">Jumlah Staf HEA</h5>
                        <p class="card-text display-4">
                            <%= ((List<staff>) request.getAttribute("HEAstaffList") != null)
                                                ? ((List<staff>) request.getAttribute("HEAstaffList")).size() : 0%>
                        </p>
                        <a href="adminServlet?action=viewHEAStaff&page=1" class="btn btn-primary">Lihat Staf</a>
                    </div>

                    <!-- HEP Staff (Taller Card) -->
                    <div class="card text-center shadow-sm item3">
                        <h5 class="card-title">Jumlah Staf HEP</h5>
                        <p class="card-text display-4">
                            <%= ((List<staff>) request.getAttribute("HEPstaffList") != null)
                                                ? ((List<staff>) request.getAttribute("HEPstaffList")).size() : 0%>
                        </p>
                        <a href="adminServlet?action=viewHEPStaff" class="btn btn-primary">Lihat Staf</a>
                    </div>

                    <!-- UZSW Staff -->
                    <div class="card text-center shadow-sm item4">
                        <h5 class="card-title">Jumlah Staf UZSW</h5>
                        <p class="card-text display-4">
                            <%= ((List<staff>) request.getAttribute("UZSWstaffList") != null)
                                                ? ((List<staff>) request.getAttribute("UZSWstaffList")).size() : 0%>
                        </p>
                        <a href="adminServlet?action=viewUZSWStaff" class="btn btn-primary">Lihat Staf</a>
                    </div>

                    <!-- List of Users (New Card) -->
                    <div class="card text-center shadow-sm item5">
                        <h5 class="card-title">Senarai Pengguna</h5>
                            <p class="card-text display-4"><%= (request.getAttribute("totalUsers") != null)? request.getAttribute("totalUsers") : 0%></p>
                        <a href="adminServlet?action=viewUsers" class="btn btn-primary">Lihat Pengguna</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer>
            <div class="text-center">
                <p>Copyright © 2024</p>
            </div>
        </footer>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
