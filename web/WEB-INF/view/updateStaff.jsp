<%-- 
    Document   : updateStaff
    Created on : Dec 27, 2024, 7:43:34 PM
    Author     : nasru
--%>

<%@page import="com.staff.model.staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>Kemaskini Staf</title>
    <link crossorigin="anonymous" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
    <div class="header">
        <a href="adminServlet?action=viewHEAStaff"> <!-- Link back to the staff list -->
            <i class="fas fa-arrow-left fa-2x" style="border: 2px solid white; border-radius: 50%; padding: 5px;"></i>
        </a>
    </div>
    <div class="container">
        <h2 class="text-center">KEMASKINI STAF</h2>
        
        <% 
            // Retrieve the staff object from the request
            staff staffMember = (staff) request.getAttribute("staffMember");
        %>
        
        <form action="${pageContext.request.contextPath}/updateStaffServlet" method="POST">
            <input type="hidden" name="staffId" value="<%= staffMember.getStaffid() %>"/>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label" for="namaStaf">Nama Staf :</label>
                <div class="col-sm-10">
                    <input class="form-control" id="namaStaf" name="namaStaf" type="text" value="${staffMember.staffname}" required/> <!-- Pre-fill with staff name -->
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label" for="password">Password :</label>
                <div class="col-sm-10">
                    <input class="form-control" id="password" name="password" type="password" value="${staffMember.staffpassword}" required/> <!-- Pre-fill with staff password -->
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label" for="stafEmail">Staf E-mel :</label>
                <div class="col-sm-10">
                    <input class="form-control" id="stafEmail" name="stafEmail" type="email" value="${staffMember.staffemail}" required/> <!-- Pre-fill with staff email -->
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-2 col-form-label" for="kategoriStaf">Kategori Staf :</label>
                <div class="col-sm-10">
                    <select class="form-select" id="kategoriStaf" name="kategoriStaf" required>
                        <option value="" disabled>Jenis Kategori Staf</option>
                        <option value="HEA" <c:if test="${staffMember.staffrole == 'HEA'}">selected</c:if>>HEA</option>
                        <option value="HEP" <c:if test="${staffMember.staffrole == 'HEP'}">selected</c:if>>HEP</option>
                        <option value="UZSW" <c:if test="${staffMember.staffrole == 'UZSW'}">selected</c:if>>UZSW</option>
                    </select>
                </div>
            </div>
            <div class="text-end">
                <button class="btn btn-outline-custom me-2" type="button" onclick="window.location.href='adminServlet?action=viewHEAStaff'"> <!-- Redirect to staff list -->
                    BATAL
                </button>
                <button class="btn btn-custom" type="submit">
                    KEMASKINI
                </button>
            </div>
        </form>
    </div>
    <div class="footer">
        @copyRight2020
    </div>
</body>
</html