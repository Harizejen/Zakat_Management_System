<%-- 
    Document   : printForm
    Created on : Jan 9, 2025, 10:47:07 AM
    Author     : nasru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Official Zakat Form</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            .form-container {
                border: 1px solid #000;
                padding: 20px;
                width: 600px;
            }
            h1 {
                text-align: center;
            }
            label {
                display: block;
                margin: 10px 0 5px;
            }
            input, select {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h1>Official Zakat Form</h1>
            <form action="submit.jsp" method="post"> 
                <h2>A. MAKLUMAT PENGENALAN PEMOHON</h2> 
                <label for="no_kad_pengenalan">NO. KAD PENGENALAN (BARU) :</label> 
                <input type="text" id="no_kad_pengenalan" name="no_kad_pengenalan"><br><br>
                <label for="nama_penuh">NAMA PENUH (SEPERTI DALAM K/P):</label>
                <input type="text" id="nama_penuh" name="nama_penuh"><br><br>

                <label for="alamat">ALAMAT:</label><br>
                <textarea id="alamat" name="alamat"></textarea><br><br>

                <label for="poskod">POSKOD:</label>
                <input type="text" id="poskod" name="poskod"><br><br>

                <label for="e_mel">E-MEL:</label>
                <input type="email" id="e_mel" name="e_mel"><br><br>

                <label for="negeri">NEGERI:</label>
                <input type="text" id="negeri" name="negeri"><br><br>

                <label for="no_telefon">NO. TELEFON:</label>
                <input type="text" id="no_telefon" name="no_telefon"><br><br>

                <label for="jantina">JANTINA:</label>
                <input type="radio" id="lelaki" name="jantina" value="Lelaki">
                <label for="lelaki">LELAKI</label> <input type="radio" id="perempuan" name="jantina" value="Perempuan">
                <label for="perempuan">PEREMPUAN</label><br><br>

                <h2>B. MAKLUMAT PELAJAR</h2>
                <label for="student_id">ID PELAJAR:</label>
                <input type="text" id="student_id" name="student_id"><br><br>

                <label for="faculty">FAKULTI:</label>
                <input type="text" id="faculty" name="faculty"><br><br>

                <label for="program_code">KOD PROGRAM:</label>
                <input type="text" id="program_code" name="program_code"><br><br>

                <label for="campus">KAMPUS:</label>
                <input type="text" id="campus" name="campus"><br><br>

                <h2>C. MAKLUMAT BANK PEMOHON</h2>
                <label for="bank_account_no">NO. AKAUN BANK:</label>
                <input type="text" id="bank_account_no" name="bank_account_no"><br><br>

                <label for="bank_name">NAMA BANK:</label>
                <input type="text" id="bank_name" name="bank_name"><br><br>

                <h2>D. MAKLUMAT IBU BAPA & PENJAGA</h2>

                <h3>1. MAKLUMAT BAPA</h3>
                <label for="father_name">NAMA PENUH (SEPERTI DALAM K/P):</label>
                <input type="text" id="father_name" name="father_name"><br><br>

                <label for="father_occupation">PEKERJAAN:</label>
                <input type="text" id="father_occupation" name="father_occupation"><br><br>

                <label for="father_address">ALAMAT:</label><br>
                <textarea id="father_address" name="father_address"></textarea><br><br>

                <label for="father_phone">NO. TELEFON:</label>
                <input type="text" id="father_phone" name="father_phone"><br><br>

                <label for="father_income">PENDAPATAN:</label>
                <input type="text" id="father_income" name="father_income"><br><br>

                <h3>2. MAKLUMAT IBU</h3>
                <label for="mother_name">NAMA PENUH (SEPERTI DALAM K/P):</label>
                    <input type="text" id="mother_name" name="mother_name"><br><br>

                    <label for="mother_occupation">PEKERJAAN:</label>
                    <input type="text" id="mother_occupation" name="mother_occupation"><br><br>

                    <label for="mother_address">ALAMAT:</label><br>
                    <textarea id="mother_address" name="mother_address"></textarea><br><br>

                    <label for="mother_phone">NO. TELEFON:</label>
                    <input type="text" id="mother_phone" name="mother_phone"><br><br>

                    <label for="mother_income">PENDAPATAN:</label>
                    <input type="text" id="mother_income" name="mother_income"><br><br>

                    <h3>3. MAKLUMAT PENJAGA</h3>
                    <label for="guardian_name">NAMA PENUH (SEPERTI DALAM K/P):</label>
                    <input type="text" id="guardian_name" name="guardian_name"><br><br>

                    <label for="guardian_occupation">PEKERJAAN:</label>
                    <input type="text" id="guardian_occupation" name="guardian_occupation"><br><br>

                    <label for="guardian_address">ALAMAT:</label><br>
                    <textarea id="guardian_address" name="guardian_address"></textarea><br><br>

                    <label for="guardian_phone">NO. TELEFON:</label>
                    <input type="text" id="guardian_phone" name="guardian_phone"><br><br>

                    <label for="guardian_relationship">HUBUNGAN:</label>
                    <input type="text" id="guardian_relationship" name="guardian_relationship"><br><br>

                    <label for="guardian_income">PENDAPATAN:</label>
                    <input type="text" id="guardian_income" name="guardian_income"><br><br>

                    <label for="other_income">PENDAPATAN LAIN:</label>
                    <input type="text" id="other_income" name="other_income"><br><br>

                    <label for="citizenship">KETURUNAN:</label>
                    <input type="text" id="citizenship" name="citizenship"><br><br>
                    <button type="button" onclick="window.print()">Print</button>
            </form>
        </div>
    </body>
</html>
