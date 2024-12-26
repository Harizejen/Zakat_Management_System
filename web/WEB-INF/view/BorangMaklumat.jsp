<%-- 
    Document   : BorangMaklumat
    Created on : 18 Dec 2024, 4:13:47 am
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Borang Pemohonan Zakat Pendidikan Pelajar</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css"> <!-- Corrected path -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css"> <!-- Added leading slash -->
</head>
<body>
   <!-- Navbar -->
        <nav class="navbar navbar-expand-md">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasMenu" aria-controls="offcanvasMenu">
                     <i class="bi bi-list" style="color: white;"></i> <!-- Use Bootstrap Icon -->
                </button>
            </div>
        </nav>
        
        <!-- Sidebar (Offcanvas) -->
        <aside class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasMenu" aria-labelledby="offcanvasMenuLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasMenuLabel">Menu</h5>
                <button type="button" class="btn-close btn-close-white text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <!-- Profile Section -->
                <div class="profile-section">
                    <img src="https://via.placeholder.com/80" alt="Profile Picture">
                    <p class="profile-name">NUR AFRINA BINTI MUSTAFA</p>
                </div>

                <!-- Menu Items -->
                <a href="<%= request.getContextPath() %>/user.do?action=dashboard" class="menu-item"><i class="bi bi-house"></i> ANJUNG</a>
                <a href="<%= request.getContextPath() %>/user.do?action=profile" class="menu-item"><i class="bi bi-person"></i> PROFIL</a>
                <a href="<%= request.getContextPath() %>/user.do?action=permohonan" class="menu-item"><i class="bi bi-file-earmark"></i> PERMOHONAN</a>
                <a href="<%= request.getContextPath() %>/user.do?action=records" class="menu-item"><i class="bi bi-clipboard"></i> REKOD</a>

                <!-- Logout Button -->
                <a href="#" class="menu-item btn-logout"><i class="bi bi-box-arrow-right"></i> LOG KELUAR</a>
            </div>
        </aside>
    
    <main class="container py-5">
        <h2 class="text-center mb-4 fw-bold">BORANG PEMOHONAN AGIHAN ZAKAT PENDIDIKAN PELAJAR</h2>
        <!-- Section A: Maklumat Pengenalan Pemohon -->
        <form>
            <div class="card mb-4">
                <div class="card-header bg-dark text-white">A. MAKLUMAT PENGENALAN PEMOHON</div>
                <div class="card-body">
                    <div class="mb-3">
                        <label for="noKadPengenalan" class="form-label">No. Kad Pengenalan (Baru)</label>
                        <input type="text" class="form-control" id="noKadPengenalan" placeholder="Contoh: 123456-78-9012">
                    </div>
                    <div class="mb-3">
                        <label for="namaPenuh" class="form-label">Nama Penuh</label>
                        <input type="text" class="form-control" id="namaPenuh" placeholder="Nama penuh seperti di kad pengenalan">
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="alamat" class="form-label">Alamat</label>
                            <textarea class="form-control" id="alamat" rows="2"></textarea>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="poskod" class="form-label">Poskod</label>
                            <input type="text" class="form-control" id="poskod">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="negeri" class="form-label">Negeri</label>
                            <input type="text" class="form-control" id="negeri">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="email" class="form-label">E-mel</label>
                            <input type="email" class="form-control" id="email">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="noTelefon" class="form-label">No. Telefon</label>
                            <input type="tel" class="form-control" id="noTelefon">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label class="form-label">Jantina</label>
                            <div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="jantina" id="lelaki" value="lelaki">
                                    <label class="form-check-label" for="lelaki">Lelaki</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="jantina" id="perempuan" value="perempuan">
                                    <label class="form-check-label" for="perempuan">Perempuan</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section B: Maklumat Pelajar -->
            <div class="card mb-4">
                <div class="card-header bg-dark text-white">B. MAKLUMAT PELAJAR</div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="noMatrik" class="form-label">No. Matrik Pelajar</label>
                            <input type="text" class="form-control" id="noMatrik">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="kodProgram" class="form-label">Kod Program</label>
                            <input type="text" class="form-control" id="kodProgram">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="fakulti" class="form-label">Fakulti</label>
                            <input type="text" class="form-control" id="fakulti">
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section C: Maklumat Bank Pemohon -->
            <div class="card mb-4">
                <div class="card-header bg-dark text-white">C. MAKLUMAT BANK PEMOHON</div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="noAkaunBank" class="form-label">No. Akaun Bank</label>
                            <input type="text" class="form-control" id="noAkaunBank">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="namaBank" class="form-label">Nama Bank</label>
                            <input type="text" class="form-control" id="namaBank">
                        </div>
                    </div>
                </div>
            </div>

            <!-- Section D: Maklumat Ibu Bapa & Penjaga -->
            <div class="card mb-4">
                <div class="card-header bg-dark text-white">D. MAKLUMAT IBU BAPA & PENJAGA</div>
                <div class="card-body">
                    <div class="mb-3">
                        <label for="namaBapa" class="form-label">Nama Bapa</label>
                        <input type="text" class="form-control" id="namaBapa">
                    </div>
                    <div class="mb-3">
                        <label for="namaIbu" class="form-label">Nama Ibu</label>
                        <input type="text" class="form-control" id="namaIbu">
                    </div>
                    <div class="mb-3">
                        <label for="namaPenjaga" class="form-label">Nama Penjaga</label>
                        <input type="text" class="form-control" id="namaPenjaga">
                    </div>
                </div>
            </div>

            <!-- Buttons -->
            <div class="text-center">
                <button type="reset" class="btn btn-outline-danger me-2">BATAL</button>
                <button type="submit" class="btn btn-primary">KEMASKINI PERMOHONAN</button>
            </div>
        </form>
    </main>

    <footer class="text-center py-3 ">
        <p class="mb-0 text-white">&copy;copyrights<span id="year"></span></p>
    </footer>

    <script>
        // Set current year dynamically
        document.getElementById("year").textContent = new Date().getFullYear();
    </script>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

