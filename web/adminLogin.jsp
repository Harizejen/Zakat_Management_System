<%-- 
    Document   : adminLogin
    Created on : Dec 14, 2024, 2:56:39 PM
    Author     : nasru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container py-5 ">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-lg">
                <div class="row g-0">
                    <div class="col-md-6 p-4">
                        <div class="d-flex align-items-center mb-4">
                            <img src="images/logo_system.png" alt="Logo system" class="img-fluid me-3" style="max-width: 60px;">
                            <div>
                                <h2 class="mb-0">
                                    <span>SEBAGAI</span>
                                    ADMIN
                                </h2>
                            </div>
                        </div>
                        
                        <form action="adminServlet?action=login" method="post">
                            <div class="mb-3">
                                <label for="adminID" class="form-label">Admin ID :</label>
                                <input type="text" id="adminId" name="adminId" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Kata Laluan :</label>
                                <input type="password" id="admin_password" name="admin_password" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">DAFTAR MASUK</button>
                        </form>
                    </div>
                    <div class="col-md-6 rounded-end illustration">
                        <img src="images/login_illustrate.png" alt="Illustration" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
    <%-- Check if an error attribute exists and display it as an alert --%>
<%
    String errorMessage = (String) request.getAttribute("error");
    if (errorMessage != null) {
%>
    <script>
        alert("<%= errorMessage %>");
    </script>
<%
    }
%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>