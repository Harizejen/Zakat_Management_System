<%-- 
    Document   : applicationPage
    Created on : Dec 25, 2024, 8:40:13 PM
    Author     : nasru
--%>

<%@page import="com.user.model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    // Retrieve the student data from the session
    Student st = (Student) request.getSession().getAttribute("student_data"); 
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Permohonan Zakat</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/applyPage.css">
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
                    <p class="profile-name"><%= st.getStudName() %></p>
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

        <div class="container">
            <h2 class="text-center my-4">PERMOHONAN</h2>
            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="card mb-4">
                            <div class="card-header">
                                Borang Permohonan Zakat
                            </div>
                            <div class="card-body">
                                <p><strong>SESI ZAKAT: MAC2025/OGOS2025</strong><br>
                                <small>Sistem notice: Sila lengkapkan MAKLUMAT PERIBADI di PROFIL</small></p>
                                <p><strong>NAMA</strong>: NUR AFRINA BINTI MUSTAFA<br>
                                <strong>NO. PELAJAR</strong>: 2021******<br>
                                <strong>NO. KP</strong>: 030115-**-****</p>
                                <div class="mb-3">
                                    <label>Adakah anda menerima bantuan kewangan (PTPTN, JPA dll)?</label><br>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="bantuan" id="bantuanYa" value="YA" required>
                                        <label class="form-check-label" for="bantuanYa">YA</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="bantuan" id="bantuanTidak" value="TIDAK" required>
                                        <label class="form-check-label" for="bantuanTidak">TIDAK</label>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="nyatakan">Jika ada, nyatakan.</label>
                                    <input type="text" class="form-control" id="nyatakan">
                                </div>
                                <div class="mb-3">
                                    <label for="cgpa">Keputusan Terkini CGPA</label>
                                    <input type="text" class="form-control" id="cgpa" required>
                                </div>
                                <div class="mb-3">
                                    <label>Tujuan memohon zakat</label><br>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" id="yuranPengajian" value="Yuran Pengajian" required>
                                        <label class="form-check-label" for="yuranPengajian">Yuran Pengajian</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" id="bantuanSaraHidup" value="Bantuan Sara Hidup" required>
                                        <label class="form-check-label" for="bantuanSaraHidup">Bantuan Sara Hidup</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" id="lainLain" value="Lain-Lain" required>
                                        <label class="form-check-label" for="lainLain">Lain-Lain</label>
                                    </div>
                                    <input type="text" class="form-control mt-2" id="lainLainNyatakan" placeholder="nyatakan, jika memilih lain-lain">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <div class="card mb-4">
                            <div class="card-header">
                                Dokumen Sokongan
                            </div>
                            <div class="card-body">
                                <p>Hanya fail PDF sahaja yang diterima.</p>
                                <p><strong>Dokumen wajib:</strong></p>
                                <table class="invisible-table">
                                    <tr>
                                        <td>1. Salinan Kad Pengenalan Ibu dan Bapa / Penjaga.</td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>2. Pengesahan Pendapatan / Slip gaji.</td>
                                        <td><a href="#">slip_gaji_mac.pdf</a></td>
                                        <td><button class="btn btn-danger btn-sm"><i class="fas fa-times"></i> BUANG</button></td>
                                    </tr>
                                    <tr>
                                        <td>3. Salinan Kad Matrik Pelajar.</td>
                                        <td><a href="#">kad_matriks.pdf</a></td>
                                        <td><button class="btn btn-primary btn-sm"><i class="fas fa-upload"></i> MUAT NAIK</button></td>
                                    </tr>
                                </table>
                                <p><strong>Sertakan jika perlu:</strong></p>
                                <table class="invisible-table">
                                    <tr>
                                        <td>1. Sijil Kematian 1.</td>
                                        <td></td>
                                        <td><button class="btn btn-secondary btn-sm">Pilih Fail</button></td>
                                    </tr>
                                    <tr>
                                        <td>2. Sijil Kematian 2.</td>
                                        <td></td>
                                        <td><button class="btn btn-secondary btn-sm">Pilih Fail</button></td>
                                    </tr>
                                    <tr>
                                        <td>3. Sijil Doktor.</td>
                                        <td></td>
                                        <td><button class="btn btn-secondary btn-sm">Pilih Fail</button></td>
                                    </tr>
                                </table>
                                <div class="form-check mt-3">
                                    <input class="form-check-input" type="checkbox" id="maklumatBenar" required>
                                    <label class="form-check-label" for="maklumatBenar">
                                        Saya akui maklumat yang diberi adalah benar.
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex justify-content-between mb-4">
                            <button class="btn btn-primary">KEMASKINI MAKLUMAT</button>
                            <button class="btn btn-danger" id="submitBtn">HANTAR PERMOHONAN</button>
                        </div>
                    </div>
                </div>
                <div class="pagination-dots">
                    <span class="dot active" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"></span>
                    <span class="dot" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"></span>
                </div>
            </div>
        </div>

        <div class="footer">
            @copyRight2020
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script>
            document.querySelectorAll('.pagination-dots .dot').forEach((dot, index) => {
                dot.addEventListener('click', () => {
                    document.querySelectorAll('.pagination-dots .dot').forEach(d => d.classList.remove('active'));
                    dot.classList.add('active');
                    const carousel = new bootstrap.Carousel(document.querySelector('#carouselExampleIndicators'));
                    carousel.to(index);
                });
            });

            document.querySelector('#carouselExampleIndicators').addEventListener('slide.bs.carousel', (event) => {
                document.querySelectorAll('.pagination-dots .dot').forEach(d => d.classList.remove('active'));
                document.querySelectorAll('.pagination-dots .dot')[event.to].classList.add('active');
            });

            document.querySelector('#submitBtn').addEventListener('click', (event) => {
                const checkboxes = document.querySelectorAll('input[type="checkbox"][required]');
                let allChecked = true;
                checkboxes.forEach(checkbox => {
                    if (!checkbox.checked) {
                        allChecked = false;
                    }
                });
                if (!allChecked) {
                    event.preventDefault();
                    alert('Sila pastikan semua kotak pilihan telah ditandakan.');
                }
            });
        </script>
    </body>
</html>
