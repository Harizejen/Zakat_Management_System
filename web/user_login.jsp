<%-- 
    Document   : user_login
    Created on : 13 Dec 2024, 8:42:45 pm
    Author     : Hariz
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
                                    <span>SUDAH MEMPUNYAI AKAUN</span>
                                    LOG MASUK!
                                </h2>
                            </div>
                        </div>
                        
                        <form action="user_login.do" method="post">
                            <div class="mb-3">
                                <label for="stud_id" class="form-label">No Pelajar :</label>
                                <input type="text" id="stud_id" name="stud_id" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="stud_password" class="form-label">Kata Laluan :</label>
                                <input type="password" id="stud_password" name="stud_password" class="form-control" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">DAFTAR MASUK</button>
                        </form>
                        <p class="mt-3">Pengguna Baru? <a href="user_signUp.jsp">Daftar Masuk</a></p>
                    </div>
                    <div class="col-md-6 rounded-end illustration">
                        <img src="images/login_illustrate.png" alt="Illustration" class="img-fluid">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


