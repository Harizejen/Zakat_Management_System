<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.user.model.Student"%>
<%@page import="com.guard.model.guardian"%>
<!DOCTYPE html>
<html>
    <head>
        <link crossorigin="anonymous" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <style>
            body {
                font-family: Arial, sans-serif;
                font-size: 8px;
            }

            h6 {
                font-size: 7px;
            }
            .section-header {
                background-color: #333;
                color: white;
                padding: 5px;
                margin-bottom: 10px;
            }
            .form-section {
                border: 1px solid #333;
                padding: 10px;
                margin-bottom: 10px;
            }
            .form-section h5 {
                background-color: #333;
                color: white;
                padding: 5px;
                margin: -10px -10px 10px -10px;
                font-size: 10px;
            }
            .form-group {
                margin-bottom: 5px;
            }
            .form-check-inline {
                margin-right: 10px;
            }
            .form-control {
                border: none;
                white-space: nowrap; /* Prevent text wrapping */
                overflow: hidden; /* Hide overflow text */
                text-overflow: ellipsis; /* Show ellipsis for overflow text */

            }
            textarea.form-control {
                height: 30px;
            }
            .form-label {
                font-weight: bold;
                border: none;
            }
            .valueText {
                position: relative;
                font-size: 9px;
                align-self: center;
                padding: 5px;
            }
            .custom {
                position: absolute;
                top: 30px;
                margin: 20px;
                padding-bottom: 3px;
                padding-top: 3px;
                padding-left: 8px;
                padding-right: 8px;
                border-radius: 5px;

            }
            
            .custom1 {
                position: absolute;
                top: 30px;
                left: 190px;
                margin: 20px;
                padding-bottom: 3px;
                padding-top: 3px;
                padding-left: 8px;
                padding-right: 8px;
                border-radius: 5px;

            }

            @media print {
                body {
                    width: 100%;
                    font-size: 7px; /* Adjust font size as needed */
                    margin-right: 0.05cm;    /* Set page margins */
                    margin-bottom: 0;
                    margin-left: 0;
                    margin-top: 0;
                }
                .form-section {
                    width: 100%;    /* Control section width */
                    margin: 0;  /* Center sections */
                }
                .form-group {
                    margin-bottom: 0.5px; /* Reduce spacing between elements */
                }
                /* Other style overrides as needed */
                
                /* Hide elements that should not be printed */
                .no-print {
                    display: none;
                }
                .custom, .custom1 {
                    display: none;
                }
            }


        </style>
    </head>
    <body>
        <%
            // Retrieve the student data from the request
            guardian gd = (guardian) request.getAttribute("guard");
            Student student = (Student) request.getAttribute("student");

            // Check if student data is available
            if (student == null) {
                out.println("<p>Error: Student information is not available .</p>");
                return; // Exit if student information is not available
            }

            // Retrieve the merged PDF path from the request
            String mergedPdfPath = (String) request.getAttribute("mergedPdfPath");
        %>
        <div class="container">
            <button class="btn btn-secondary custom" onclick="window.print()">CETAK</button>
            <a href="${pageContext.request.contextPath}/downloadDocServlet?mergedPdfPath=${mergedPdfPath}" class="custom1 btn btn-secondary" target="_blank">CETAK DOKUMEN SOKONGAN</a>
            <div class="text-center my-2">
                <img alt="Logo" class="mb-2" src="${pageContext.request.contextPath}/images/logo_system.png" style="width : 50px; height : auto"/>
                <h4 class="fw-bold" style="font-size: 12px;">
                    BORANG PEMOHONAN AGIHAN ZAKAT PENDIDIKAN PELAJAR
                </h4>

            </div>
            <div class="form-section">
                <h5>
                    A. MAKLUMAT PENGENALAN PEMOHON
                </h5>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label form-label" for="no-kad-pengenalan">
                        NO. KAD PENGENALAN (BARU) :
                    </label>

                    <div class="col-sm-9">
                        <input type="text" class="form-control valueText" id="no-kad-pengenalan" name="no-kad-pengenalan" value="${student.studIC}">
                    </div>

                </div>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label form-label" for="nama-penuh">
                        NAMA PENUH (SEPERTI DALAM K/P) :
                    </label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control valueText" id="nama-penuh" name="nama-penuh" value="${student.studName}">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label form-label" for="alamat">
                        ALAMAT :
                    </label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control valueText" id="alamat" name="alamat" value="${student.studAddress}">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label form-label" for="poskod">
                        POSKOD :
                    </label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control valueText" id="poskod" name="poskod" value="${student.studZipCode}">
                    </div>
                    <label class="col-sm-3 col-form-label form-label" for="negeri">
                        NEGERI :
                    </label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control valueText" id="negeri" name="negeri" value="${student.studState}">
                    </div>
                    <label class="col-sm-3 col-form-label form-label" for="email">
                        E-MEL :
                    </label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control valueText" id="email" name="email" value="${student.studEmail}">
                    </div>
                    <label class="col-sm-3 col-form-label form-label" for="no-telefon">
                        NO. TELEFON :
                    </label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control valueText" id="no-telefon" name="no-telefon" value="${student.studPhoneNum}">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label form-label">
                        JANTINA :
                    </label>
                    <div class="col-sm-3">
                        <div>
                            <input type="text" class="form-control valueText" id="nama-penuh" name="nama-penuh" value="${student.getGenderDisplay()}">
                        </div>
                    </div>
                    <label class="col-sm-3 col-form-label form-label">
                        STATUS PERKAHWINAN :
                    </label>
                    <div class="col-sm-3">
                        <div>
                            <input type="text" class="form-control valueText" id="status-kahwin" name="status-kahwin" value="${student.getMarriageDisplay()}">
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-section">
                <h5>
                    B. MAKLUMAT PELAJAR
                </h5>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label form-label" for="no-matrik">
                        NO. MATRIK PELAJAR :
                    </label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control valueText" id="no-matrik" name="no-matrik" value="${student.studID}">
                    </div>
                    <label class="col-sm-3 col-form-label form-label" for="kod-program">
                        KOD PROGRAM :
                    </label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control valueText" id="kod-program" name="kod-program" value="${student.studCourse}">
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label form-label" for="fakulti">
                        FAKULTI :
                    </label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control valueText" id="fakulti" name="fakulti" value="${student.studFaculty}">
                    </div>
                    <label class="col-sm-3 col-form-label form-label" for="kampus">
                        KAMPUS :
                    </label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control valueText" id="kampus" name="kampus" value="${student.studCampus}">
                    </div>
                </div>
            </div>
            <div class="form-section">
                <h5>
                    C. MAKLUMAT BANK PEMOHON
                </h5>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label form-label" for="no-akaun">
                        NO. AKAUN BANK :
                    </label>
                    <div class="col-sm-3">
                        <div>
                            <input type="text" class="form-control valueText" id="no-akaun" name="no-akaun" value="${student.getStudBankNum()}">
                        </div>
                    </div>
                    <label class="col-sm-3 col-form-label form-label" for="nama-bank">
                        NAMA BANK :
                    </label>
                    <div class="col-sm-3">
                        <div>
                            <input type="text" class="form-control valueText" id="nama-bank" name="nama-bank" value="${student.getStudBankName()}">
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-section">
                <h5>
                    D. MAKLUMAT IBU BAPA &amp; PENJAGA
                </h5>
                <div class="form-group">
                    <h6 class="form-label">
                        MAKLUMAT BAPA
                    </h6>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-label" for="nama-bapa">
                            NAMA PENUH (SEPERTI DALAM K/P) :
                        </label>
                        <div class="col-sm-3">
                            <div>
                                <input type="text" class="form-control valueText" id="nama-bapa" name="nama-bapa" value="<%= gd.getFather_name()%>">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-label" for="pekerjaan-bapa">
                            PEKERJAAN :
                        </label>
                        <div class="col-sm-3">
                            <div>
                                <input type="text" class="form-control valueText" id="pekerjaan-bapa" name="pekerjaan-bapa" value="<%= gd.getFather_occupation()%>">
                            </div>
                        </div>
                        <label class="col-sm-3 col-form-label form-label" for="pendapatan-bapa">
                            PENDAPATAN :
                        </label>
                        <div class="col-sm-3">
                            <div>
                                <input type="text" class="form-control valueText" id="pendapatan-bapa" name="pendapatan-bapa" 
                                       value="RM <%= gd.getFather_income() != 0.0 ? gd.getFather_income() : gd.getFather_income() + " (TIADA)"%>">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-label" for="alamat-bapa">
                            ALAMAT :
                        </label>
                        <div class="col-sm-9">
                            <div>
                                <input type="text" class="form-control valueText" id="pendapatan-bapa" name="alamat-bapa" value="<%= gd.getFather_Address()%>">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-label" for="telefon-bapa">
                            NO. TELEFON :
                        </label>
                        <div class="col-sm-3">
                            <div>
                                <input type="text" class="form-control valueText" id="telefon-bapa" name="telefon-bapa" value="<%= gd.getFather_phoneNum()%>">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <h6 class="form-label">
                        MAKLUMAT IBU
                    </h6>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-label" for="nama-ibu">
                            NAMA PENUH (SEPERTI DALAM K/P) :
                        </label>
                        <div class="col-sm-9">
                            <div>
                                <input type="text" class="form-control valueText" id="nama-ibu" name="nama-ibu" value="<%= gd.getMother_name()%>">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-label" for="pekerjaan-ibu">
                            PEKERJAAN :
                        </label>
                        <div class="col-sm-3">
                            <div>
                                <input type="text" class="form-control valueText" id="pekerjaan-ibu" name="pekerjaan-ibu" value="<%= gd.getMother_occupation()%>">
                            </div>
                        </div>
                        <label class="col-sm-3 col-form-label form-label" for="pendapatan-ibu">
                            PENDAPATAN :
                        </label>
                        <div class="col-sm-3">
                            <div>
                                <input type="text" class="form-control valueText" id="pendapatan-ibu" name="pendapatan-ibu" 
                                       value="RM <%= gd.getMother_income() != 0.0 ? gd.getMother_income() : gd.getMother_income() + " (TIADA)"%>">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-label" for="alamat-ibu">
                            ALAMAT :
                        </label>
                        <div class="col-sm-9">
                            <div>
                                <input type="text" class="form-control valueText" id="alamat-ibu" name="alamat-ibu" value="<%= gd.getMother_Address()%>">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-label" for="telefon-ibu">
                            NO. TELEFON :
                        </label>
                        <div class="col-sm-3">
                            <div>
                                <input type="text" class="form-control valueText" id="telefon-ibu" name="telefon-ibu" value="<%= gd.getMother_phoneNum()%>">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <h6 class="form-label">
                        MAKLUMAT PENJAGA
                    </h6>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-label" for="nama-penjaga">
                            NAMA PENUH (SEPERTI DALAM K/P) :
                        </label>
                        <div class="col-sm-9">
                            <div>
                                <input type="text" class="form-control valueText" id="nama-penjaga" name="nama-penjaga" value="<%= gd.getGuard_name()%>">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-label" for="pekerjaan-penjaga">
                            PEKERJAAN :
                        </label>
                        <div class="col-sm-3">
                            <div>
                                <input type="text" class="form-control valueText" id="pekerjaan-penjaga" name="pekerjaan-penjaga" value="<%= gd.getGuard_occupation()%>">
                            </div>
                        </div>
                        <label class="col-sm-3 col-form-label form-label" for="pendapatan-penjaga">
                            PENDAPATAN :
                        </label>
                        <div class="col-sm-3">
                            <div>
                                <input type="text" class="form-control valueText" id="pendapatan-penjaga" name="pendapatan-penjaga" 
                                       value="RM <%= gd.getGuard_income() != 0.0 ? gd.getGuard_income() : gd.getGuard_income() + " (TIADA)"%>">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-label" for="alamat-penjaga">
                            ALAMAT :
                        </label>
                        <div class="col-sm-9">
                            <div>
                                <input type="text" class="form-control valueText" id="alamat-penjaga" name="alamat-penjaga" value="<%= gd.getGuard_address()%>">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 col-form-label form-label" for="telefon-penjaga">
                            NO. TELEFON :
                        </label>
                        <div class="col-sm-3">
                            <div>
                                <input type="text" class="form-control valueText" id="telefon-penjaga" name="telefon-penjaga" value="<%= gd.getGuard_phoneNum()%>">
                            </div>
                        </div>
                        <label class="col-sm-3 col-form-label form-label" for="hubungan">
                            HUBUNGAN :
                        </label>
                        <div class="col-sm-3">
                            <div>
                                <input type="text" class="form-control valueText" id="hubungan" name="hubungan" value="<%= gd.getGuard_relation()%>">
                            </div>
                        </div>
                        <label class="col-sm-3 col-form-label form-label" for="warganegara">
                            WARGANEGARA :
                        </label>
                        <div class="col-sm-3">
                            <div>
                                <input type="text" class="form-control valueText" id="warganegara" name="warganegara" value="<%= gd.getResidenceDisplay()%>">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group row">
                    <label class="col-sm-3 col-form-label form-label" for="lain-lain-pendapatan">
                        LAIN-LAIN PENDAPATAN :
                    </label>
                    <div class="col-sm-9">
                        <div>
                            <input type="text" class="form-control valueText" id="lain-lain-pendapatan" name="lain-lain-pendapatan" 
                                   value="RM <%= gd.getOther_income() != 0.0 ? gd.getOther_income() : gd.getOther_income() + " (TIADA)"%>">
                        </div>
                    </div>


                </div>
            </div>
        </div>

    </body>
</html>