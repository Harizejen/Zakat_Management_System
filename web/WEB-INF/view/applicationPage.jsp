<%@page import="com.user.model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Retrieve the student data from the session
    Student st = (Student) request.getSession().getAttribute("student_data");

    //Retrive err message
    String err = (String) request.getAttribute("error");
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
                    <img src="${pageContext.request.contextPath}/images/logo_system.png" style="width: 80px; height: auto; border-radius: 50% " alt="Profile Picture">
                    <p class="profile-name"><%= st.getStudName()%></p>
                </div>
                <a href="<%= request.getContextPath()%>/user.do?action=dashboard" class="menu-item"><i class="bi bi-house"></i> ANJUNG</a>
                <a href="<%= request.getContextPath()%>/user.do?action=profile" class="menu-item"><i class="bi bi-person"></i> PROFIL</a>
                <a href="<%= request.getContextPath()%>/user.do?action=permohonan" class="menu-item"><i class="bi bi-file-earmark"></i> PERMOHONAN</a>
                <a href="<%= request.getContextPath()%>/user.do?action=records" class="menu-item"><i class="bi bi-clipboard"></i> REKOD</a>
                <a href="#" class="menu-item btn-logout"><i class="bi bi-box-arrow-right"></i> LOG KELUAR</a>
            </div>
        </aside>

        <div class="pt-4 mb-4 container form-steps">
            <form id="file-upload-form" action="add_application.do" method="post" enctype="multipart/form-data">
                <h4 class="text-center">PERMOHONAN</h4>

                <!-- Step 1 -->
                <div class="card form-step">
                    <div class="card-header">Borang Permohonan Zakat</div>
                    <div class="card-body">
                        <div class="customInfo1">
                            <p><strong>SESI ZAKAT: MAC2025/OGOS2025</strong></p>
                            <p><strong>NAMA:</strong> <span id="student-name"><%= st.getStudName()%></span></p>
                            <p><strong>NO. PELAJAR:</strong> <%= st.getStudID()%></p>
                            <p><strong>NO. KP:</strong> <%= st.getStudIC()%></p>
                        </div>


                        <div class="customInfo2">
                            <label>Adakah anda menerima bantuan makanan?</label><br>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="apply_foodIncentive" id="bantuanMakananYa" value="YA" required>
                                <label class="form-check-label" for="bantuanMakananYa">YA</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="apply_foodIncentive" id="bantuanMakananTidak" value="TIDAK" required>
                                <label class="form-check-label" for="bantuanMakananTidak">TIDAK</label>
                            </div>
                        </div>

                        <div class="customInfo2">
                            <label>Menerima bantuan lain (PTPTN, JPA dll)?</label><br>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="apply_otherSupport" id="bantuanLainYa" value="YA" required>
                                <label class="form-check-label" for="bantuanLainYa">YA</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="apply_otherSupport" id="bantuanLainTidak" value="TIDAK" required>
                                <label class="form-check-label" for="bantuanLainTidak">TIDAK</label>
                            </div>
                        </div>

                        <div class="customInfo2" id="bantuanLainDetails" style="display: none;">
                            <label for="namaBantuanLain" class="col-form-label">Nama Bantuan:</label>
                            <input type="text" class="form-control" id="namaBantuanLain" name="apply_otherSupportName" placeholder="Masukkan nama bantuan">
                            <label for="jumlahBantuanLain" class="col-form-label">Jumlah Bantuan:</label>
                            <input type="text" class="form-control" id="jumlahBantuanLain" name="apply_otherSupportAmount" placeholder="Masukkan jumlah bantuan (RM)">
                        </div>

                        <div class="row customInfo2">
                            <label for="semester" class="col-sm-2 col-form-label">Semester Semasa:</label>
                            <div class="col-sm-2">
                                <input type="number" class="form-control" id="semester" name="apply_part" placeholder="Contoh: 1" min="1" max="10" required>
                            </div>
                            <label for="gpa" class="col-sm-2 col-form-label">GPA:</label>
                            <div class="col-sm-2">
                                <input type="text" class="form-control" id="gpa" name="apply_gpa" placeholder="Contoh: 3.50" required>
                            </div>
                            <label for="cgpa" class="col-sm-1 col-form-label">CGPA:</label>
                            <div class="col-sm-2">
                                <input type="text" class="form-control" id="cgpa" name="apply_cgpa" placeholder="Contoh: 3.75" required>
                            </div>
                        </div>

                        <div class="customInfo2">
                            <label>Tujuan memohon zakat</label><br>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="apply_purpose" id="yuranPengajian" value="Yuran Pengajian" required>
                                <label class="form-check-label" for="yuranPengajian">Yuran Pengajian</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="apply_purpose" id="bantuanSaraHidup" value="Bantuan Sara Hidup" required>
                                <label class="form-check-label" for="bantuanSaraHidup">Bantuan Sara Hidup</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="apply_purpose" id="lainLain" value="Lain-Lain" required>
                                <label class="form-check-label" for="lainLain">Lain-Lain</label>
                            </div>
                            <div id="lainLainNyatakanContainer" style="display: none;">
                                <input type="text" class="form-control mt-2" id="lainLainNyatakan" name="lainLainNyatakan" placeholder="nyatakan, jika memilih lain-lain">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Step 2 -->
                <div class="card form-step d-none">
                    <div class="card-header">Dokumen Sokongan</div>
                    <div class="customInfo2 card-body">
                        <p>Hanya fail PDF sahaja yang diterima.</p>
                        <p><strong>Dokumen wajib:</strong></p>
                        <table class="invisible-table">
                            <tr>
                                <td><label for="kadPengenalan">1. Salinan Kad Pengenalan Ibu dan Bapa / Penjaga.</label></td>
                                <td><input type="file" id="kadPengenalan" name="kadPengenalan" accept=".pdf" required></td>
                            </tr>
                            <tr>
                                <td><label for="slipGaji">2. Pengesahan Pendapatan / Slip gaji.</label></td>
                                <td><input type="file" id="slipGaji" name="slipGaji" accept=".pdf" required></td>
                            </tr>
                            <tr>
                                <td><label for="kadMatrik">3. Salinan Kad Matrik Pelajar.</label></td>
                                <td><input type="file" id="kadMatrik" name="kadMatrik" accept=".pdf" required></td>
                            </tr>
                        </table>
                        <p><strong>Sertakan jika perlu:</strong></p>
                        <table class="invisible-table">
                            <tr>
                                <td>1. Sijil Kematian 1.</td>
                                <td><input type="file" name="sijilKematian1" accept=".pdf"></td>
                            </tr>
                            <tr>
                                <td>2. Sijil Kematian 2.</td>
                                <td><input type="file" name="sijilKematian2" accept=".pdf"></td>
                            </tr>
                            <tr>
                                <td>3. Sijil Doktor.</td>
                                <td><input type="file" name="sijilDoktor" accept=".pdf"></td>
                            </tr>
                        </table>
                        <div class="form-check mt-3">
                            <input class="form-check-input" type="checkbox" id="maklumatBenar" name="maklumatBenar" required>
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
                    <button class="btn btn-danger d-none" id="submitBtn" type="submit" disabled>HANTAR PERMOHONAN</button>
                </div>
            </form>
        </div>

        <!-- Modal structure -->
        <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title" id="errorModalLabel">Error</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <%= err != null ? err : ""%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Elements for form steps
                const steps = document.querySelectorAll('.form-step');
                const prevBtn = document.getElementById('prevBtn');
                const nextBtn = document.getElementById('nextBtn');
                const submitBtn = document.getElementById('submitBtn');
                let currentStep = 0;

                // Elements for "bantuan lain" details toggle
                const bantuanLainDetails = document.getElementById('bantuanLainDetails');
                const bantuanLainYa = document.getElementById('bantuanLainYa');
                const bantuanLainTidak = document.getElementById('bantuanLainTidak');

                // Elements for "Lain-Lain" input toggle
                const lainLainRadio = document.getElementById('lainLain');
                const lainLainNyatakanContainer = document.getElementById('lainLainNyatakanContainer');
                const lainLainNyatakanInput = document.getElementById('lainLainNyatakan');
                const radioButtons = document.querySelectorAll("input[name='apply_purpose']");

                // Elements for file name validation
                const studentName = "<%= st.getStudName()%>";
                const requiredFiles = {
                    "kadPengenalan": `${studentName}_Salinan Kad Pengenalan Ibu dan Bapa_Penjaga.pdf`,
                    "slipGaji": `${studentName}_Pengesahan Pendapatan.pdf`,
                    "kadMatrik": `${studentName}_Salinan Kad Matrik Pelajar.pdf`
                };

                const form = document.querySelector("form");
                form.addEventListener("submit", function (event) {
                    let valid = true; // Flag to track overall validity

                    // Check file types and names
                    Object.keys(requiredFiles).forEach(fileInputName => {
                        const fileInput = document.querySelector(`input[name="${fileInputName}"]`);
                        if (fileInput) {
                            const file = fileInput.files[0];
                            if (!file) {
                                valid = false;
                                alert(`Please upload the required file for '${fileInputName}'.`);
                                return;
                            }
                            // Check file type
                            if (!file.type.match(/application\/pdf/)) {
                                valid = false;
                                alert(`Only PDF files are allowed for '${fileInputName}'.`);
                                return;
                            }
                            // Check file name
                            const uploadedFileName = file.name.toLowerCase();
                            const expectedFileName = requiredFiles[fileInputName].toLowerCase();
                            if (uploadedFileName !== expectedFileName) {
                                valid = false;
                                alert(`File name mismatch for '${fileInputName}'. Uploaded: '${uploadedFileName}', Expected: '${expectedFileName}'`);
                            }
                        }
                    });

                    // Validate "Lain-Lain" input
                    const lainLainRadio = document.getElementById('lainLain');
                    const lainLainInput = document.getElementById('lainLainNyatakan');
                    if (lainLainRadio.checked && (lainLainInput.value === null || lainLainInput.value.trim() === "")) {
                        valid = false;
                        alert("Please provide details for 'Lain-Lain' purpose.");
                    }

                    // Check for required fields
                    const requiredFields = form.querySelectorAll("[required]");
                    requiredFields.forEach(field => {
                        if (field.value === null || field.value.trim() === "") {
                            valid = false;
                            alert(`Please fill in the required field: ${field.placeholder || field.name}`);
                        }
                    });

                    if (!valid) {
                        event.preventDefault(); // Prevent form submission if validation fails
                    }
                });

                // Update form steps
                function updateFormSteps() {
                    steps.forEach((step, index) => {
                        step.classList.toggle('d-none', index !== currentStep);
                    });

                    prevBtn.disabled = currentStep === 0;
                    nextBtn.classList.toggle('d-none', currentStep === steps.length - 1);
                    submitBtn.classList.toggle('d-none', currentStep !== steps.length - 1);
                }

                // Toggle "bantuan lain" details
                function toggleBantuanLainDetails() {
                    bantuanLainDetails.style.display = bantuanLainYa.checked ? 'block' : 'none';
                }

                // Toggle "Lain-Lain" input
                function toggleLainLainInput() {
                    if (lainLainRadio.checked) {
                        lainLainNyatakanContainer.style.display = 'block';
                        lainLainNyatakanInput.required = true;
                        lainLainNyatakanInput.name = "apply_purpose"; // Use as apply_purpose
                    } else {
                        lainLainNyatakanContainer.style.display = 'none';
                        lainLainNyatakanInput.required = false;
                        lainLainNyatakanInput.name = "lainLainNyatakan"; // Reset name
                    }
                }

                // Event listeners for navigation buttons
                nextBtn.addEventListener('click', () => {
                    if (currentStep < steps.length - 1)
                        currentStep++;
                    updateFormSteps();
                });

                prevBtn.addEventListener('click', () => {
                    if (currentStep > 0)
                        currentStep--;
                    updateFormSteps();
                });

                // Event listeners for "bantuan lain" toggle
                bantuanLainYa.addEventListener('change', toggleBantuanLainDetails);
                bantuanLainTidak.addEventListener('change', toggleBantuanLainDetails);

                // Event listeners for "Lain-Lain" toggle
                radioButtons.forEach(radio => {
                    radio.addEventListener('change', toggleLainLainInput);
                });

                // Initialize form
                updateFormSteps();
                toggleBantuanLainDetails();
                toggleLainLainInput();
            });
        </script>
        <script>
            const inputKadPengenalan = document.querySelector('#kadPengenalan');
            const inputSlipGaji = document.querySelector('#slipGaji');
            const inputKadMatrik = document.querySelector('#kadMatrik');
            const studentName = document.querySelector('#student-name').textContent.trim();
            const submitButton = document.querySelector('#submitBtn');

            // Validation flags
            let isKadPengenalanValid = false;
            let isSlipGajiValid = false;
            let isKadMatrikValid = false;

            // Update submit button state
            function updateSubmitButtonState() {
                submitButton.disabled = !(isKadPengenalanValid && isSlipGajiValid && isKadMatrikValid);
            }

            inputKadPengenalan.addEventListener('change', () => {
                validateFileKadPengenalan();
            }
            );
            //Validate file Kad Pengenalan
            function validateFileKadPengenalan() {
                const file = inputKadPengenalan.files[0];
                if (!file) {
                    alert("No file selected");
                    isKadPengenalanValid = false;
                }

                const expectedFileName = studentName + "_Salinan Kad Pengenalan Ibu dan Bapa_Penjaga.pdf";
                const uploadedFileName = file.name;
                if (uploadedFileName !== expectedFileName) {
    //                console.log(studentName);
    //                console.log(uploadedFileName);
    //                console.log(expectedFileName);
                    alert("Expected filename is " + expectedFileName + " but receive " + uploadedFileName);
                    isKadPengenalanValid = false;
                    // Clear the file input
                    inputKadPengenalan.value = "";
                } else {
                    console.log("Receive " + uploadedFileName);
                    isKadPengenalanValid = true;
                }
                updateSubmitButtonState();
            }
            ;

            //Validate file Slip Gaji
            inputSlipGaji.addEventListener('change', () => {
                validateFileSlipGaji();
            });

            function validateFileSlipGaji() {
                const file = inputSlipGaji.files[0];
                if (!file) {
                    alert("No file selected");
                    isSlipGajiValid = false;
                }

                const expectedFileName = studentName + "_Pengesahan Pendapatan.pdf";
                const uploadedFileName = file.name;
                if (uploadedFileName !== expectedFileName) {
    //                console.log(studentName);
    //                console.log(uploadedFileName);
    //                console.log(expectedFileName);
                    alert("Expected filename is " + expectedFileName + " but receive " + uploadedFileName);
                    isSlipGajiValid = false;
                    inputSlipGaji.value = "";
                } else {
                    console.log("Receive " + uploadedFileName);
                    isSlipGajiValid = true;
                }
                updateSubmitButtonState();
            }
            ;

            inputKadMatrik.addEventListener('change', () => {
                validateFileKadMatrik();
            });

            function validateFileKadMatrik() {
                const file = inputKadMatrik.files[0];
                if (!file) {
                    alert("No file selected");
                    isKadMatrikValid = false;
                }

                const expectedFileName = studentName + "_KadMatrik_Student.pdf";
                const uploadedFileName = file.name;
                if (uploadedFileName !== expectedFileName) {
    //                console.log(studentName);
    //                console.log(uploadedFileName);
    //                console.log(expectedFileName);
                    alert("Expected filename is " + expectedFileName + " but receive " + uploadedFileName);
                    isKadMatrikValid = false;
                    inputKadMatrik.value = "";
                } else {
                    console.log("Receive " + uploadedFileName);
                    isKadMatrikValid = true;
                }
                updateSubmitButtonState();
            }
            ;

            // Form submission handler
            const form = document.querySelector('#file-upload-form');
            form.addEventListener('submit', (event) => {
                if (!(isKadPengenalanValid && isSlipGajiValid && isKadMatrikValid)) {
                    alert("Please upload all required files with the correct filenames before submitting.");
                    event.preventDefault(); // Prevent form submission
                }
            });
        </script>
        <!-- JavaScript to trigger modal -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Check if the error message exists
                const errorMessage = '<%= err != null ? err : ""%>';
                if (errorMessage.trim().length > 0) {
                    const errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
                    errorModal.show();
                }
            });
        </script>
    </body>
</html>