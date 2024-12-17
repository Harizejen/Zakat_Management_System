<%-- 
    Document   : adminDashboard
    Created on : Dec 16, 2024, 8:42:11 AM
    Author     : nasru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="admin_dashboard.css">
    <title>Admin Dashboard</title>
</head>
    <body>
        <div class="container-fluid">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">Admin Dashboard</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <div class="ms-auto"> <!-- This div will push the button to the right -->
                            <a class="btn btn-outline-danger" href="#" role="button">Logout</a>
                        </div>
                    </div>
                </div>
            </nav>

            <div class="row mt-4 d-flex align-items-stretch">
                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">Total HEA Staff</h5>
                            <p class="card-text" id="heaCount">0</p>
                            <a href="HEATable.jsp" class="btn btn-primary">View Staff</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">Total HEP Staff</h5>
                            <p class="card-text" id="hepCount">0</p>
                            <a href="HEPTable.jsp" class="btn btn-primary">View Staff</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <h5 class="card-title">Total UZSW Staff</h5>
                            <p class="card-text" id="uzswCount">0</p>
                            <a href="UZSWTable.jsp" class="btn btn-primary">View Staff</a>
                        </div>
                    </div>
                </div>
            </div>

            <footer class="mt-4">
                <div class="text-center">
                    <p>Copyright © 2024</p>
                </div>
            </footer>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="script.js"></script>
    </body>
</html>
