<%-- 
    Document   : addStaff
    Created on : Dec 27, 2024, 2:38:48 PM
    Author     : nasru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Tambah Staf</title>
        <link crossorigin="anonymous" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <link rel="stylesheet" href="css/admin.css">
    </head>
    <body>
        <!-- Top Navigation Bar -->
        <nav class="navbar navbar-expand-lg" style="background-color: #522E5C">
            <div class="container-fluid">
                <a class="navbar-brand text-white bold-text" href="adminServlet?action=home">Admin Dashboard</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <div class="ms-auto">
                        <a class="btn btn-light" data-bs-toggle="modal" data-bs-target="#logoutModal" role="button" style="background-color: #6E1313; color: white; border: none;">Logout</a>
                    </div>
                </div>
            </div>
        </nav>
        <div class="d-flex justify-content-between align-items-center mb-3">
            <a href="javascript:window.history.back();" class="btn btn-link">
                <i class="fas fa-arrow-left"></i> Back
            </a>
        </div>
        <div class="container">
            <h2 class="text-center">TAMBAH STAF</h2>
            <form action="addStaffServlet" method="post">
                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label" for="namaStaf">Nama Staf :</label>
                    <div class="col-sm-10">
                        <input class="form-control" id="namaStaf" name="namaStaf" type="text" required/> <!-- Added name attribute -->
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label" for="password">Password :</label>
                    <div class="col-sm-10">
                        <input class="form-control" id="password" name="password" type="password" required/> <!-- Added name attribute -->
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label" for="stafEmail">Staf E-mel :</label>
                    <div class="col-sm-10">
                        <input class="form-control" id="stafEmail" name="staffEmail" type="email" required/> <!-- Added name attribute -->
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-2 col-form-label" for="kategoriStaf">Kategori Staf :</label>
                    <div class="col-sm-10">
                        <select class="form-select" id="kategoriStaf" name="kategoriStaf" required>
                            <option value="" selected disabled>Jenis Kategori Staf</option>
                            <option value="HEA">HEA</option>
                            <option value="HEP">HEP</option>
                            <option value="UZSW">UZSW</option>
                        </select>
                    </div>
                </div>
                <div class="text-end">
                    <button class="btn btn-outline-custom me-2" type="button">
                        BATAL
                    </button>
                    <button class="btn btn-custom" type="submit">
                        TAMBAH
                    </button>
                </div>
            </form>
        </div>
        <footer  style="background-color: #522E5C; color: white; padding: 5px 0; position: fixed; bottom: 0; width: 100%;">
            <div class="text-center">
                <p style="margin: 0;">Copyright © 2024</p>
            </div>
        </footer>
    </body>
</html>
