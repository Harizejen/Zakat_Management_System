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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/applyPage.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-md">
        <div class="container-fluid">
            <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasMenu" aria-controls="offcanvasMenu">
                 <i class="bi bi-list" style="color: white;"></i>
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
            <div class="profile-section">
                <img src="https://via.placeholder.com/80" alt="Profile Picture">
                <p class="profile-name"><%= st.getStudName() %></p>
            </div>
            <a href="<%= request.getContextPath() %>/user.do?action=dashboard" class="menu-item"><i class="bi bi-house"></i> ANJUNG</a>
            <a href="<%= request.getContextPath() %>/user.do?action=profile" class="menu-item"><i class="bi bi-person"></i> PROFIL</a>
            <a href="<%= request.getContextPath() %>/user.do?action=permohonan" class="menu-item"><i class="bi bi-file-earmark"></i> PERMOHONAN</a>
            <a href="<%= request.getContextPath() %>/user.do?action=records" class="menu-item"><i class="bi bi-clipboard"></i> REKOD</a>
            <a href="#" class="menu-item btn-logout"><i class="bi bi-box-arrow-right"></i> LOG KELUAR</a>
        </div>
    </aside>

    <div class="container form-steps">
        <form action="" method="post" enctype="multipart/form-data">
        <h2 class="text-center my-4">PERMOHONAN</h2>
        
        <!-- Step 1 -->
        <div class="card mb-4 form-step">
            <div class="card-header">Borang Permohonan Zakat</div>
            <div class="card-body">
                <p><strong>SESI ZAKAT: MAC2025/OGOS2025</strong></p>
                <p><strong>NAMA:</strong> <%= st.getStudName() %></p>
                <p><strong>NO. PELAJAR:</strong> <%= st.getStudID() %></p>
                <p><strong>NO. KP:</strong> <%= st.getStudIC() %></p>
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
                <div class="mb-3 d-none" id="nyatakanContainer">
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
                        <input class="form-check-input" type="radio" name="tujuanZakat" id="yuranPengajian" value="Yuran Pengajian" required>
                        <label class="form-check-label" for="yuranPengajian">Yuran Pengajian</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="tujuanZakat" id="bantuanSaraHidup" value="Bantuan Sara Hidup" required>
                        <label class="form-check-label" for="bantuanSaraHidup">Bantuan Sara Hidup</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="tujuanZakat" id="lainLain" value="Lain-Lain" required>
                        <label class="form-check-label" for="lainLain">Lain-Lain</label>
                    </div>
                    <div class="d-none" id="lainLainContainer">
                        <input type="text" class="form-control mt-2" id="lainLainNyatakan" placeholder="nyatakan, jika memilih lain-lain">   
                    </div>
                </div>
            </div>
        </div>

        <!-- Step 2 -->
        <div class="card mb-4 form-step d-none">
            <div class="card-header">Dokumen Sokongan</div>
            <div class="card-body">
                <p>Hanya fail PDF sahaja yang diterima.</p>
                <p><strong>Dokumen wajib:</strong></p>
                <table class="invisible-table">
                    <tr>
                        <td>1. Salinan Kad Pengenalan Ibu dan Bapa / Penjaga.</td>
                        <td><input type="file" class="form-control" name="dokumen1" accept=".pdf" required></td>
                    </tr>
                    <tr>
                        <td>2. Pengesahan Pendapatan / Slip gaji.</td>
                        <td><input type="file" class="form-control" name="dokumen2" accept=".pdf" required></td>
                    </tr>
                    <tr>
                        <td>3. Salinan Kad Matrik Pelajar.</td>
                        <td><input type="file" class="form-control" name="dokumen3" accept=".pdf" required></td>
                    </tr>
                </table>
                <p><strong>Sertakan jika perlu:</strong></p>
                <table class="invisible-table">
                    <tr>
                        <td>1. Sijil Kematian 1.</td>
                        <td><input type="file" class="form-control" name="dokumenOpsyenal1" accept=".pdf"></td>
                    </tr>
                    <tr>
                        <td>2. Sijil Kematian 2.</td>
                        <td><input type="file" class="form-control" name="dokumenOpsyenal2" accept=".pdf"></td>
                    </tr>
                    <tr>
                        <td>3. Sijil Doktor.</td>
                        <td><input type="file" class="form-control" name="dokumenOpsyenal3" accept=".pdf"></td>
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
        
        <!-- Navigation buttons -->
        <div class="d-flex justify-content-between mb-4">
            <button class="btn btn-secondary" id="prevBtn" type="button">Kembali</button>
            <button class="btn btn-primary" id="nextBtn" type="button">Seterusnya</button>
            <button class="btn btn-danger d-none" id="submitBtn" type="submit">HANTAR PERMOHONAN</button>
        </div>
        </form>
    </div>

    <footer class="footer">
        @copyRight2020
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const steps = document.querySelectorAll('.form-step');
            const prevBtn = document.getElementById('prevBtn');
            const nextBtn = document.getElementById('nextBtn');
            const submitBtn = document.getElementById('submitBtn');
            const nyatakanContainer = document.getElementById('nyatakanContainer');
            const bantuanYa = document.getElementById('bantuanYa');
            const bantuanTidak = document.getElementById('bantuanTidak');
            const lainLainContainer = document.getElementById('lainLainContainer');
            const lainLain = document.getElementById('lainLain');
            let currentStep = 0;

            function updateFormSteps() {
                steps.forEach((step, index) => {
                    step.classList.toggle('d-none', index !== currentStep);
                });

                prevBtn.disabled = currentStep === 0;
                nextBtn.classList.toggle('d-none', currentStep === steps.length - 1);
                submitBtn.classList.toggle('d-none', currentStep !== steps.length - 1);
            }

            nextBtn.addEventListener('click', () => {
                if (currentStep < steps.length - 1) currentStep++;
                updateFormSteps();
            });

            prevBtn.addEventListener('click', () => {
                if (currentStep > 0) currentStep--;
                updateFormSteps();
            });

            updateFormSteps();

            function toggleNyatakanInput() {
                nyatakanContainer.classList.toggle('d-none', !bantuanYa.checked);
            }

            function toggleLainLainInput() {
                lainLainContainer.classList.toggle('d-none', !lainLain.checked);
            }

            bantuanYa.addEventListener('change', toggleNyatakanInput);
            bantuanTidak.addEventListener('change', toggleNyatakanInput);
            lainLain.addEventListener('change', toggleLainLainInput);

            toggleNyatakanInput();
            toggleLainLainInput();
        });
    </script>
</body>
</html>
