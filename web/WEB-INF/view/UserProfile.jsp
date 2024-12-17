<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profil</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/navbar.css">
        <link rel="stylesheet" href="css/profile.css">
    </head>
    <body style="background-color: #f9f6f1;">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-md">
            <div class="container-fluid">
                <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasMenu" aria-controls="offcanvasMenu">
                     <i class="bi bi-list" style="color: white;"></i> <!-- Bootstrap Icon -->
                </button>
            </div>
        </nav>
        
        <!-- Sidebar Menu -->
        <aside class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasMenu" aria-labelledby="offcanvasMenuLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasMenuLabel">Menu</h5>
                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <div class="text-center mb-3">
                    <img src="https://via.placeholder.com/80" class="rounded-circle" alt="Profile Picture">
                    <p class="fw-bold mt-2">NUR AFRINA BINTI MUSTAFA</p>
                </div>
                <a href="user.do?action=dashboard" class="menu-item"><i class="bi bi-house"></i> Anjung</a>
                <a href="user.do?action=profile" class="menu-item active"><i class="bi bi-person"></i> Profil</a>
                <a href="#" class="menu-item"><i class="bi bi-file-earmark"></i> Permohonan</a>
                <a href="#" class="menu-item"><i class="bi bi-clipboard"></i> Rekod</a>
                <a href="#" class="menu-item text-danger"><i class="bi bi-box-arrow-right"></i> Log Keluar</a>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="container mt-4">
            <h1 class="text-center mb-4 fw-bold">PROFIL</h1>
            <div class="row">
                <!-- Left Section -->
                <div class="col-md-8">
                    <div class="p-4 shadow-sm bg-white rounded">
                        <h4 class="mb-3 fw-bold">📌 Maklumat Peribadi</h4>
                        <p><strong>Nama Penuh:</strong> NUR AFRINA BINTI MUSTAFA</p>
                        <p><strong>Jantina:</strong> PEREMPUAN</p>
                        <p><strong>No. Telefon:</strong> 010-****-****</p>
                        <p><strong>Email:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>Alamat Menyurat:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>No. Pelajar:</strong> 2021***</p>
                        <p><strong>No. KP:</strong> 030115-**-****</p>
                        <p><strong>Kod Program:</strong> ADM10</p>
                        <p><strong>Kampus:</strong> RAUB - PAHANG</p>
                        <p><strong>Status Perkahwinan:</strong> BUJANG</p>
                        <p><strong>No. Akaun Bank:</strong> 06696945*****78</p>
                        <p><strong>Nama Bank:</strong> BANK SIMPANAN RAKYAT (BSN)</p>
                        
                        <h4 class="mt-4 fw-bold">📌 Maklumat Keluarga (Ibu Bapa & Penjaga)</h4>
                        <p><strong>NAMA BAPA:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>PEKERJAAN BAPA:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>PENDAPATAN KASAR:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>NO TELEFON BAPA:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>ALAMAT BAPA:</strong> <span class="text-danger">TIDAK LENGKAP</span></p><br>
                        <p><strong>NAMA IBU:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>PEKERJAAN IBU:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>PENDAPATAN KASAR:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>NO TELEFON IBU:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>ALAMAT IBU:</strong> <span class="text-danger">TIDAK LENGKAP</span></p><br>
                        <p><strong>NAMA PENJAGA:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>PEKERJAAN PENJAGA:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>NO TELEFON PENJAGA:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>ALAMAT PENJAGA:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        
                        <a href="user.do?action=borang" class="btn btn-danger mt-3">KEMASKINI</a>
                    </div>
                </div>

                <!-- Right Section -->
                <div class="col-md-4">
                    <div class="p-4 shadow-sm bg-white rounded">
                        <h4 class="fw-bold mb-3">Notifikasi</h4>
                        <p><strong>Status Permohonan:</strong> <span class="text-danger">TIDAK LENGKAP</span></p>
                        <p><strong>Tarikh Temuduga:</strong> TIADA</p>
                        <p><strong>Tarikh Akhir 2025:</strong> 15 FEBRUARI</p>
                    </div>
                </div>
            </div>
        </main>

        <!-- Footer -->
        <footer class="text-center py-3 mt-3" style="background-color: #013220">
            <p class="text-white mb-0">&copy; Copyright <span id="year"></span></p>
        </footer>

        <script>
            // Dynamically set the current year
            document.getElementById("year").textContent = new Date().getFullYear();
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
