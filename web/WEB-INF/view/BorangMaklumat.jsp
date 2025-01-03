<%@page import="com.guard.model.guardian"%>
<%@page import="com.user.model.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    // Retrieve the student data from the session
    Student st = (Student) request.getSession().getAttribute("student_data"); 
    // Retrieve the guardian data from the session
    guardian gd1 = (guardian) request.getSession().getAttribute("guard_info"); 
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Borang Pemohonan Zakat Pendidikan Pelajar</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/form.css">
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
                <p class="profile-name"><%= st != null ? st.getStudName() : "Unknown" %></p>
            </div>
            <a href="<%= request.getContextPath() %>/user.do?action=dashboard" class="menu-item"><i class="bi bi-house"></i> ANJUNG</a>
            <a href="<%= request.getContextPath() %>/user.do?action=profile" class="menu-item"><i class="bi bi-person"></i> PROFIL</a>
            <a href="<%= request.getContextPath() %>/user.do?action=permohonan" class="menu-item"><i class="bi bi-file-earmark"></i> PERMOHONAN</a>
            <a href="<%= request.getContextPath() %>/user.do?action=records" class="menu-item"><i class="bi bi-clipboard"></i> REKOD</a>
            <a href="#" class="menu-item btn-logout"><i class="bi bi-box-arrow-right"></i> LOG KELUAR</a>
        </div>
    </aside>

    <div class="container">
        <h2 class="text-center mb-4 fw-bold">BORANG PERMOHONAN AGIHAN ZAKAT PENDIDIKAN PELAJAR</h2>
        <form action="borangMaklumat_kemaskini.do" method="post" id="form-paginated">
            <div class="card mb-4 form-step">
                <div class="card-header bg-dark text text-white">LANGKAH 1: MAKLUMAT PEMOHON & PELAJAR</div>
                <div class="card-body">
                    <h5 class="mb-3">A. MAKLUMAT PENGENALAN PEMOHON</h5>
                    <div class="mb-3">
                        <label for="stud_ic" class="form-label">No. Kad Pengenalan (Baru)</label>
                        <input type="text" class="form-control" id="stud_ic" name="stud_ic" placeholder="Tanpa '-'" value="<%= st != null ? st.getStudIC() : "" %>">
                    </div>
                    <div class="mb-3">
                        <label for="stud_name" class="form-label">Nama Penuh (Seperti Dalam K/P)</label>
                        <input type="text" class="form-control" id="stud_name" name="stud_name" value="<%= st != null ? st.getStudName() : "" %>">
                    </div>
                    <div class="mb-3">
                        <label for="stud_address" class="form-label">Alamat</label>
                        <textarea class="form-control" id="stud_address" name="stud_address" rows="2"><%= st != null ? st.getStudAddress() : "" %></textarea>
                    </div>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="stud_zipcode" class="form-label">Poskod</label>
                            <input type="text" class="form-control" id="stud_zipcode" name="stud_zipcode" value="<%= st != null ? st.getStudZipCode() : "" %>">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="stud_state" class="form-label">Negeri</label>
                            <select class="form-select" id="stud_state" name="stud_state">
                                <option value="" disabled <%= st == null ? "selected" : "" %>>Pilih Negeri</option>
                                <option value="Johor" <%= st != null && "Johor".equals(st.getStudState()) ? "selected" : "" %>>Johor</option>
                                <option value="Kedah" <%= st != null && "Kedah".equals(st.getStudState()) ? "selected" : "" %>>Kedah</option>
                                <option value="Kelantan" <%= st != null && "Kelantan".equals(st.getStudState()) ? "selected" : "" %>>Kelantan</option>
                                <option value="Melaka" <%= st != null && "Melaka".equals(st.getStudState()) ? "selected" : "" %>>Melaka</option>
                                <option value="Negeri Sembilan" <%= st != null && "Negeri Sembilan".equals(st.getStudState()) ? "selected" : "" %>>Negeri Sembilan</option>
                                <option value="Pahang" <%= st != null && "Pahang".equals(st.getStudState()) ? "selected" : "" %>>Pahang</option>
                                <option value="Perak" <%= st != null && "Perak".equals(st.getStudState()) ? "selected" : "" %>>Perak</option>
                                <option value="Perlis" <%= st != null && "Perlis".equals(st.getStudState()) ? "selected" : "" %>>Perlis</option>
                                <option value="Pulau Pinang" <%= st != null && "Pulau Pinang".equals(st.getStudState()) ? "selected" : "" %>>Pulau Pinang</option>
                                <option value="Sabah" <%= st != null && "Sabah".equals(st.getStudState()) ? "selected" : "" %>>Sabah</option>
                                <option value="Sarawak" <%= st != null && "Sarawak".equals(st.getStudState()) ? "selected" : "" %>>Sarawak</option>
                                <option value="Selangor" <%= st != null && "Selangor".equals(st.getStudState()) ? "selected" : "" %>>Selangor</option>
                                <option value="Terengganu" <%= st != null && "Terengganu".equals(st.getStudState()) ? "selected" : "" %>>Terengganu</option>
                                <option value="Wilayah Persekutuan Kuala Lumpur" <%= st != null && "Wilayah Persekutuan Kuala Lumpur".equals(st.getStudState()) ? "selected" : "" %>>Wilayah Persekutuan Kuala Lumpur</option>
                                <option value="Wilayah Persekutuan Labuan" <%= st != null && "Wilayah Persekutuan Labuan".equals(st.getStudState()) ? "selected" : "" %>>Wilayah Persekutuan Labuan</option>
                                <option value="Wilayah Persekutuan Putrajaya" <%= st != null && "Wilayah Persekutuan Putrajaya".equals(st.getStudState()) ? "selected" : "" %>>Wilayah Persekutuan Putrajaya</option>
                            </select>
                        
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="stud_phoneNum" class="form-label">No. Telefon</label>
                            <input type="text" class="form-control" id="stud_phoneNum" name="stud_phoneNum" value="<%= st != null ? st.getStudPhoneNum() : "" %>">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Jantina</label>
                            <div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="stud_gender" id="lelaki" value="L" <%= st != null && st.getStudGender() == 'L' ? "checked" : "" %>>
                                    <label class="form-check-label" for="lelaki">Lelaki</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="stud_gender" id="perempuan" value="P" <%= st != null && st.getStudGender() == 'P' ? "checked" : "" %>>
                                    <label class="form-check-label" for="perempuan">Perempuan</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Status Perkahwinan</label>
                            <div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="stud_marriage" id="bujang" value="S" <%= st != null && st.getStudMarriage() == 'S' ? "checked" : "" %>>
                                    <label class="form-check-label" for="bujang">Bujang</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="stud_marriage" id="berkahwin" value="M" <%= st != null && st.getStudMarriage() == 'M' ? "checked" : "" %>>
                                    <label class="form-check-label" for="berkahwin">Berkahwin</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="stud_marriage" id="bercerai" value="D" <%= st != null && st.getStudMarriage() == 'D' ? "checked" : "" %>>
                                    <label class="form-check-label" for="bercerai">Bercerai</label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <h5 class="mt-4 mb-3">B. MAKLUMAT PELAJAR</h5>
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label for="stud_id" class="form-label">No. Matrik Pelajar</label>
                            <input type="text" class="form-control" id="stud_id" name="stud_id" value="<%= st != null ? st.getStudID() : "" %>">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="stud_course" class="form-label">Kod Program</label>
                            <input type="text" class="form-control" id="stud_course" name="stud_course" value="<%= st != null ? st.getStudCourse() : "" %>">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="stud_faculty" class="form-label">Fakulti</label>
                            <input type="text" class="form-control" id="stud_faculty" name="stud_faculty" value="<%= st != null ? st.getStudFaculty() : "" %>">
                        </div>
                        <div class="col-md-3 mb-3">
                            <label for="stud_campus" class="form-label">Kampus</label>
                            <input type="text" class="form-control" id="stud_campus" name="stud_campus" value="<%= st != null ? st.getStudCampus() : "" %>">
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-4 form-step d-none">
                <div class="card-header bg-dark text-white">LANGKAH 2: MAKLUMAT BANK PEMOHON DAN MAKLUMAT IBU BAPA & PENJAGA</div>
                <div class="card-body">
                    <h5 class="mb-3">C. MAKLUMAT BANK PEMOHON</h5>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="stud_bankNum" class="form-label">No. Akaun Bank</label>
                            <input type="text" class="form-control" id="stud_bankNum" name="stud_bankNum" value="<%= st != null ? st.getStudBankNum() : "" %>">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="stud_bankName" class="form-label">Nama Bank</label>
                            <input type="text" class="form-control" id="stud_bankName" name="stud_bankName" value="<%= st != null ? st.getStudBankName() : "" %>">
                        </div>
                    </div>
                    <h5 class="mt-4 mb-3">D. MAKLUMAT IBU BAPA & PENJAGA</h5>
                    <div class="mb-3">
                        <label for="father_name" class="form-label">Nama Penuh Bapa (Seperti Dalam K/P)</label>
                        <input type="text" class="form-control" id="father_name" name="father_name" value="<%= gd1 != null ? gd1.getFather_name() : "" %>">
                    </div>
                    <div class="mb-3">
                        <label for="father_occupation" class="form-label">Pekerjaan</label>
                        <input type="text" class="form-control" id="father_occupation" name="father_occupation" value="<%= gd1 != null ? gd1.getFather_occupation() : "" %>">
                    </div>
                    <div class="mb-3">
                        <label for="father_income" class="form-label">Pendapatan</label>
                        <input type="text" class="form-control" id="father_income" name="father_income" value="<%= gd1 != null ? gd1.getFather_income() : "" %>">
                    </div>
                    <div class="mb-3">
                        <label for="father_address" class="form-label">Alamat</label>
                        <textarea class="form-control" id="father_address" name="father_address" rows="2"><%= gd1 != null ? gd1.getFather_Address() : "" %></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="father_phoneNum" class="form-label">No. Telefon</label>
                        <input type="text" class="form-control" id="father_phoneNum" name="father_phoneNum" value="<%= gd1 != null ? gd1.getFather_phoneNum() : "" %>">
                    </div>
                </div>
            </div>

            <div class="card mb-4 form-step d-none">
                <div class="card-header bg-dark text-white">LANGKAH 3: MAKLUMAT IBU BAPA & PENJAGA LANJUTAN</div>
                <div class="card-body">
                    <h5 class="mt-4 mb-3">D. MAKLUMAT IBU BAPA & PENJAGA LANJUTAN</h5>
                    <div class="mb-3">
                        <label for="mother_name" class="form-label">Nama Penuh Ibu (Seperti Dalam K/P)</label>
                        <input type="text" class="form-control" id="mother_name" name="mother_name" value="<%= gd1 != null ? gd1.getMother_name() : "" %>">
                    </div>
                    <div class="mb-3">
                        <label for="mother_occupation" class="form-label">Pekerjaan</label>
                        <input type="text" class="form-control" id="mother_occupation" name="mother_occupation" value="<%= gd1 != null ? gd1.getMother_occupation() : "" %>">
                    </div>
                    <div class="mb-3">
                        <label for="mother_income" class="form-label">Pendapatan</label>
                        <input type="text" class="form-control" id="mother_income" name="mother_income" value="<%= gd1 != null ? gd1.getMother_income() : "" %>">
                    </div>
                    <div class="mb-3">
                        <label for="mother_address" class="form-label">Alamat</label>
                        <textarea class="form-control" id="mother_address" name="mother_address" rows="2"><%= gd1 != null ? gd1.getMother_Address() : "" %></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="mother_phoneNum" class="form-label">No. Telefon</label>
                        <input type="text" class="form-control" id="mother_phoneNum" name="mother_phoneNum" value="<%= gd1 != null ? gd1.getMother_phoneNum() : "" %>">
                    </div>

                    <div class="mb-3">
                        <label for="guard_name" class="form-label">Nama Penuh Penjaga (Seperti Dalam K/P)</label>
                        <input type="text" class="form-control" id="guard_name" name="guard_name" value="<%= gd1 != null ? gd1.getGuard_name() : "" %>">
                    </div>
                    <div class="mb-3">
                        <label for="guard_occupation" class="form-label">Pekerjaan</label>
                        <input type="text" class="form-control" id="guard_occupation" name="guard_occupation" value="<%= gd1 != null ? gd1.getGuard_occupation() : "" %>">
                    </div>
                    <div class="mb-3">
                        <label for="guard_income" class="form-label">Pendapatan</label>
                        <input type="text" class="form-control" id="guard_income" name="guard_income" value="<%= gd1 != null ? gd1.getGuard_income() : "" %>">
                    </div>
                    <div class="mb-3">
                        <label for="guard_address" class="form-label">Alamat</label>
                        <textarea class="form-control" id="guard_address" name="guard_address" rows="2"><%= gd1 != null ? gd1.getGuard_address() : "" %></textarea>
                    </div>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label for="guard_postcode" class="form-label">Poskod</label>
                            <input type="text" class="form-control" id="guard_postcode" name="guard_postcode" value="<%= gd1 != null ? gd1.getGuard_postcode() : "" %>">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="guard_phoneNum" class="form-label">No. Telefon</label>
                            <input type="text" class="form-control" id="guard_phoneNum" name="guard_phoneNum" value="<%= gd1 != null ? gd1.getGuard_phoneNum() : "" %>">
                        </div>
                        <div class="col-md-4 mb-3">
                            <label for="guard_relation" class="form-label">Hubungan</label>
                            <input type="text" class="form-control" id="guard_relation" name="guard_relation" value="<%= gd1 != null ? gd1.getGuard_relation() : "" %>">
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Kewarganegaraan</label>
                        <div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="guard_residence" id="warganegara" value="R" <%= gd1 != null && "R".equals(gd1.getGuard_residence()) ? "checked" : "" %>>
                                <label class="form-check-label" for="warganegara">Warganegara</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="guard_residence" id="bukan_warganegara" value="N" <%= gd1 != null && "N".equals(gd1.getGuard_residence()) ? "checked" : "" %>>
                                <label class="form-check-label" for="bukan_warganegara">Bukan Warganegara</label>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="other_income" class="form-label">Lain-lain Pendapatan</label>
                        <input type="text" class="form-control" id="other_income" name="other_income" value="<%= gd1 != null ? gd1.getOther_income() : "" %>">
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