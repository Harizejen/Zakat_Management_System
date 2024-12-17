<%-- 
    Document   : staff_login
    Created on : 14 Dec 2024, 9:34:45 pm
    Author     : Khairina
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
                        <div class="d-flex justify-content-center mb-4">
                            <img src="images/logo_system.png" alt="Logo system" class="img-fluid me-3" style="max-width: 60px;">
                            <div>
                                <h2 class="mb-0">
                                    <span>BEKERJA DENGAN KAMI</span>
                                    STAF!
                                </h2>
                            </div>
                        </div>
                        
                        <form action="staff_login.do" method="post">
                            <div class="row justify-content-center mb-3">
                                <div class="col-auto">
                                    <input type="radio" class="form-check-input" id="HEA" name="role" value="HEA" checked>
                                    <label class="form-check-label" for="HEA">HEA</label>
                                </div>
                                <div class="col-auto">
                                    <input type="radio" class="form-check-input" id="HEP" name="role" value="HEP">
                                    <label class="form-check-label" for="HEP">HEP</label>
                                </div>
                                <div class="col-auto">
                                    <input type="radio" class="form-check-input" id="UZSW" name="role" value="UZSW">
                                    <label class="form-check-label" for="UZSW">UZSW</label>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="staffId" class="form-label">ID Staf :</label>
                                <input type="text" id="staffId" name="staffId" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Kata Laluan :</label>
                                <input type="password" id="password" name="password" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">LOG MASUK</button>
                        </form>
                        <p class="mt-3">Lupa Kata Laluan? <a href>Tekan Sini</a></p>
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


