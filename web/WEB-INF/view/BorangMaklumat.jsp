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
    <link rel="stylesheet" href="css/navbar.css">
    <link rel="stylesheet" href="css/form.css">
</head>
<body>
             <!-- Navbar -->
    <nav class="navbar navbar-expand-md">
        <div class="container-fluid" style="height: 42px">
            <button class="navbar-toggler justify-content-center" style="height: 42px; width: 42px " type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasMenu" aria-controls="offcanvasMenu">
                <i class="bi bi-list" style="color: white;">=</i> <!-- Use Bootstrap Icon -->
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
                <a href="user.do?action=dashboard" class="menu-item"><i class="bi bi-house"></i> ANJUNG</a>
                <a href="user.do?action=profile" class="menu-item"><i class="bi bi-person"></i> PROFIL</a>
                <a href="#" class="menu-item"><i class="bi bi-file-earmark"></i> PERMOHONAN</a>
                <a href="#" class="menu-item"><i class="bi bi-clipboard"></i> REKOD</a>

                <!-- Logout Button -->
                <a href="#" class="menu-item btn-logout"><i class="bi bi-box-arrow-right"></i> LOG KELUAR</a>
            </div>
        </aside>
    
        <div class="container py-5">
            <h2 class="text-center mb-4 fw-bold">BORANG PERMOHONAN AGIHAN ZAKAT PENDIDIKAN PELAJAR</h2>
            <form action="borangMaklumat_kemaskini.do" method="post" id="form-paginated">
                <!-- Step 1: Section A and B -->
                <div class="card mb-4 form-step">
                    <div class="card-header bg-dark text-white">LANGKAH 1: MAKLUMAT PEMOHON & PELAJAR</div>
                    <div class="card-body">
                        <!-- Section A: Maklumat Pengenalan Pemohon -->
                        <h5 class="mb-3">A. MAKLUMAT PENGENALAN PEMOHON</h5>
                        <div class="mb-3">
                            <label for="noKadPengenalan" class="form-label">No. Kad Pengenalan (Baru)</label>
                            <input type="text" class="form-control" id="noKadPengenalan" placeholder="Tanpa '-'">
                        </div>
                        <div class="mb-3">
                            <label for="namaPenuh" class="form-label">Nama Penuh (Seperti Dalam K/P)</label>
                            <input type="text" class="form-control" id="namaPenuh">
                        </div>
                        <div class="mb-3">
                            <label for="alamat" class="form-label">Alamat</label>
                            <textarea class="form-control" id="alamat" rows="2"></textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="poskod" class="form-label">Poskod</label>
                                <input type="text" class="form-control" id="poskod">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="negeri" class="form-label">Negeri</label>
                                <input type="text" class="form-control" id="negeri">
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="noTelefon" class="form-label">No. Telefon</label>
                                <input type="text" class="form-control" id="noTelefon">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Jantina</label>
                                <div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="jantina" id="lelaki" value="Lelaki">
                                        <label class="form-check-label" for="lelaki">Lelaki</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="jantina" id="perempuan" value="Perempuan">
                                        <label class="form-check-label" for="perempuan">Perempuan</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Status Perkahwinan</label>
                                <div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="statusPerkahwinan" id="bujang" value="Bujang">
                                        <label class="form-check-label" for="bujang">Bujang</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="statusPerkahwinan" id="berkahwin" value="Berkahwin">
                                        <label class="form-check-label" for="berkahwin">Berkahwin</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="statusPerkahwinan" id="bercerai" value="Bercerai">
                                        <label class="form-check-label" for="bercerai">Bercerai</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Section B: Maklumat Pelajar -->
                        <h5 class="mt-4 mb-3">B. MAKLUMAT PELAJAR</h5>
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label for="noMatrik" class="form-label">No. Matrik Pelajar</label>
                                <input type="text" class="form-control" id="noMatrik">
                            </div>
                            <div class="col-md-3 mb-3">
                                <label for="kodProgram" class="form-label">Kod Program</label>
                                <input type="text" class="form-control" id="kodProgram">
                            </div>
                            <div class="col-md-3 mb-3">
                                <label for="fakulti" class="form-label">Fakulti</label>
                                <input type="text" class="form-control" id="fakulti">
                            </div>
                            <div class="col-md-3 mb-3">
                                <label for="kampus" class="form-label">Kampus</label>
                                <input type="text" class="form-control" id="kampus">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Step 2: Section C -->
                <div class="card mb-4 form-step d-none">
                    <div class="card-header bg-dark text-white">LANGKAH 2: MAKLUMAT BANK PEMOHON DAN MAKLUMAT IBU BAPA & PENJAGA</div>
                    <div class="card-body">
                        <!-- Section C: Maklumat Bank Pemohon -->
                        <h5 class="mb-3">C. MAKLUMAT BANK PEMOHON</h5>
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
                        <!-- Section D: Maklumat Ibu Bapa & Penjaga -->
                        <h5 class="mt-4 mb-3">D. MAKLUMAT IBU BAPA & PENJAGA</h5>
                        <div class="mb-3">
                            <label for="namaBapa" class="form-label">Nama Penuh Bapa (Seperti Dalam K/P)</label>
                            <input type="text" class="form-control" id="namaBapa">
                        </div>
                        <div class="mb-3">
                            <label for="pekerjaanBapa" class="form-label">Pekerjaan</label>
                            <input type="text" class="form-control" id="pekerjaanBapa">
                        </div>
                        <div class="mb-3">
                            <label for="pendapatanBapa" class="form-label">Pendapatan</label>
                            <input type="text" class="form-control" id="pendapatanBapa">
                        </div>
                        <div class="mb-3">
                            <label for="alamatBapa" class="form-label">Alamat</label>
                            <textarea class="form-control" id="alamatBapa" rows="2"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="telefonBapa" class="form-label">No. Telefon</label>
                            <input type="text" class="form-control" id="telefonBapa">
                        </div>
                    </div>
                </div>

                <!-- Step 3: Section D -->
                <div class="card mb-4 form-step d-none">
                    <div class="card-header bg-dark text-white">LANGKAH 3: MAKLUMAT IBU BAPA & PENJAGA LANJUTAN</div>
                    <div class="card-body">
                        <!-- Section D: Maklumat Ibu Bapa & Penjaga -->
                        <h5 class="mt-4 mb-3">D. MAKLUMAT IBU BAPA & PENJAGA LANJUTAN</h5>
                        <div class="mb-3">
                            <label for="namaIbu" class="form-label">Nama Penuh Ibu (Seperti Dalam K/P)</label>
                            <input type="text" class="form-control" id="namaIbu">
                        </div>
                        <div class="mb-3">
                            <label for="pekerjaanIbu" class="form-label">Pekerjaan</label>
                            <input type="text" class="form-control" id="pekerjaanIbu">
                        </div>
                        <div class="mb-3">
                            <label for="pendapatanIbu" class="form-label">Pendapatan</label>
                            <input type="text" class="form-control" id="pendapatanIbu">
                        </div>
                        <div class="mb-3">
                            <label for="alamatIbu" class="form-label">Alamat</label>
                            <textarea class="form-control" id="alamatIbu" rows="2"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="telefonIbu" class="form-label">No. Telefon</label>
                            <input type="text" class="form-control" id="telefonIbu">
                        </div>

                        <div class="mb-3">
                            <label for="namaPenjaga" class="form-label">Nama Penuh Penjaga (Seperti Dalam K/P)</label>
                            <input type="text" class="form-control" id="namaPenjaga">
                        </div>
                        <div class="mb-3">
                            <label for="pekerjaanPenjaga" class="form-label">Pekerjaan</label>
                            <input type="text" class="form-control" id="pekerjaanPenjaga">
                        </div>
                        <div class="mb-3">
                            <label for="pendapatanPenjaga" class="form-label">Pendapatan</label>
                            <input type="text" class="form-control" id="pendapatanPenjaga">
                        </div>
                        <div class="mb-3">
                            <label for="alamatPenjaga" class="form-label">Alamat</label>
                            <textarea class="form-control" id="alamatPenjaga" rows="2"></textarea>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="telefonPenjaga" class="form-label">No. Telefon</label>
                                <input type="text" class="form-control" id="telefonPenjaga">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="hubunganPenjaga" class="form-label">Hubungan</label>
                                <input type="text" class="form-control" id="hubunganPenjaga">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="warganegaraPenjaga" class="form-label">Warganegara</label>
                            <input type="text" class="form-control" id="warganegaraPenjaga">
                        </div>
                        <div class="mb-3">
                            <label for="lainPendapatan" class="form-label">Lain-lain Pendapatan</label>
                            <input type="text" class="form-control" id="lainPendapatan">
                        </div>
                    </div>
                </div>

                <!-- Navigation Buttons -->
                <div class="d-flex justify-content-between mt-4">
                    <button type="button" class="btn btn-secondary" id="prevBtn" disabled>SEBELUM</button>
                    <button type="button" class="btn btn-primary" id="nextBtn">SETERUSNYA</button>
                    <button type="submit" class="btn btn-success d-none" id="submitBtn">HANTAR</button>
                </div>
            </form>
        </div>

    <footer class="text-center py-3 ">
        <p class="mb-0 text-white">&copy;copyrights<span id="year"></span></p>
    </footer>

    <script>
        // Set current year dynamically
        document.getElementById("year").textContent = new Date().getFullYear();
        
        document.addEventListener('DOMContentLoaded', function () {
            const steps = document.querySelectorAll('.form-step');
            const prevBtn = document.getElementById('prevBtn');
            const nextBtn = document.getElementById('nextBtn');
            const submitBtn = document.getElementById('submitBtn');
            let currentStep = 0;

            // Update visibility of steps and buttons
            function updateFormSteps() {
                steps.forEach((step, index) => {
                    step.classList.toggle('d-none', index !== currentStep);
                });

                prevBtn.disabled = currentStep === 0;
                nextBtn.classList.toggle('d-none', currentStep === steps.length - 1);
                submitBtn.classList.toggle('d-none', currentStep !== steps.length - 1);
            }

            // Move to the next step
            nextBtn.addEventListener('click', () => {
                if (currentStep < steps.length - 1) {
                    currentStep++;
                    updateFormSteps();
                }
            });

            // Move to the previous step
            prevBtn.addEventListener('click', () => {
                if (currentStep > 0) {
                    currentStep--;
                    updateFormSteps();
                }
            });

            // Initialize the form steps
            updateFormSteps();
        });




    </script>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

