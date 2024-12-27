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
    <div class="header">
        <a href="#">
            <i class="fas fa-arrow-left fa-2x" style="border: 2px solid white; border-radius: 50%; padding: 5px;"></i>
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
    <div class="footer">
        @copyRight2020
    </div>
</body>
</html>
