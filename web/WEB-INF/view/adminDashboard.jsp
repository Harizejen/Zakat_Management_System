<%@page import="java.util.List"%>
<%@page import="com.staff.model.staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/admin_dashboard.css">
        <title>Admin Dashboard</title>
        <style>
            body {
                background-color: #F2EBDD; /* Light beige background */
                font-family: 'Arial', sans-serif;
                font-weight: bold;
            }
            .content {
                padding: 20px;
            }
            h1 {
                color: #522E5C; /* Dark purple for headings */
                text-align: center;
                margin-top: 20px;
            }
            .navbar {
                background-color: #522E5C; /* Dark purple navbar */
                padding: 1rem;
            }
            .navbar-brand {
                font-size: 1.5rem; /* Bigger font for brand name */
                color: #F2EBDD !important; /* Light beige text for brand */
            }
            .card {
                border: none;
                border-radius: 0.5rem;
                transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth hover effect */
                background-color: #CEB5D4; /* Light purple card background */
                margin: 10px;
            }
            .card:hover {
                transform: translateY(-10px); /* Move card up on hover */
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); /* Add shadow on hover */
            }
            .card-title {
                font-size: 1.5rem;
                color: #522E5C; /* Dark purple for card titles */
                font-family: 'Arial', sans-serif;
                font-weight: bold;
            }
            .card-text {
                font-size: 5rem;
                font-weight: bold;
                color: #522E5C; /* Dark purple for card text */
            }
            .card-body {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                min-height: 350px;
            }
            .btn-primary {
                background-color: #6E1313; /* Dark red for buttons */
                border: none;
                padding: 10px 20px;
                font-size: 1rem;
                font-weight: bold;
                transition: background-color 0.3s ease; /* Smooth hover effect */
            }
            .btn-primary:hover {
                background-color: #8B1A1A; /* Slightly lighter red on hover */
            }
            footer {
                background-color: #522E5C; /* Dark purple footer */
                color: #F2EBDD; /* Light beige text */
                padding: 1rem 0;
                position: fixed;
                left: 0;
                bottom: 0;
                width: 100%;
                text-align: center;
            }
            footer p {
                margin: 0; /* Remove default margin */
            }
        </style>
    </head>
    <body>
        <!-- Main Content -->
        <div class="content">
            <!-- Top Navigation Bar -->
            <nav class="navbar navbar-expand-lg navbar-light" style="background-color: #522E5C;">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#" style="color: #F2EBDD;">Zakat Pendidikan Management System</a>
                </div>
            </nav>

            <!-- Welcome Section -->
            <div class="welcome-container mb-4">
                <h1 class="fw-bold text-center">ADMIN DASHBOARD</h1>
            </div>

            <!-- Dashboard Cards -->
            <div class="container-fluid mt-3">
                <div class="row mt-3 justify-content-center">
                    <!-- Total Applications -->
                    <div class="col-md-3">
                        <%
                            int totalApplications = (Integer) request.getAttribute("totalApplications");
                        %>
                        <div class="card text-center shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">Jumlah Permohonan</h5>
                                <p class="card-text display-4" id="totalApplications"><%= totalApplications %></p>
                                <a href="adminServlet?action=viewApplication" class="btn btn-primary">Lihat Permohonan</a>
                            </div>
                        </div>
                    </div>
                    <!-- HEA Staff -->
                    <div class="col-md-3">
                        <%
                            List<staff> HEAstaffList = (List<staff>) request.getAttribute("HEAstaffList");
                            int HEAstaffCount = (HEAstaffList != null) ? HEAstaffList.size() : 0;
                        %>
                        <div class="card text-center shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">Jumlah Staf HEA</h5>
                                <p class="card-text display-4" id="HEACount"><%= HEAstaffCount %></p>
                                <a href="adminServlet?action=viewHEAStaff&page=1" class="btn btn-primary">Lihat Staf</a>
                            </div>
                        </div>
                    </div>
                    <!-- HEP Staff -->
                    <div class="col-md-3">
                        <%
                            List<staff> HEPstaffList = (List<staff>) request.getAttribute("HEPstaffList");
                            int HEPstaffCount = (HEPstaffList != null) ? HEPstaffList.size() : 0;
                        %>
                        <div class="card text-center shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">Jumlah Staf HEP</h5>
                                <p class="card-text display-4" id="HEPCount"><%= HEPstaffCount %></p>
                                <a href="adminServlet?action=viewHEPStaff" class="btn btn-primary">Lihat Staf</a>
                            </div>
                        </div>
                    </div>
                    <!-- UZSW Staff -->
                    <div class="col-md-3">
                        <%
                            List<staff> UZSWstaffList = (List<staff>) request.getAttribute("UZSWstaffList");
                            int UZSWstaffCount = (UZSWstaffList != null) ? UZSWstaffList.size() : 0;
                        %>
                        <div class="card text-center shadow-sm">
                            <div class="card-body">
                                <h5 class="card-title">Jumlah Staf UZSW</h5>
                                <p class="card-text display-4" id="UZSWCount"><%= UZSWstaffCount %></p>
                                <a href="adminServlet?action=viewUZSWStaff" class="btn btn-primary">Lihat Staf</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <footer>
                <div class="text-center">
                    <p style="margin: 0;">Copyright © 2024</p>
                </div>
            </footer>

            <!-- Scripts -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
            <script src="script.js"></script>
        </div>
    </body>
</html>