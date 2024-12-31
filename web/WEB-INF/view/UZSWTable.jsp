<%-- 
    Document   : UZSWTable
    Created on : Dec 18, 2024, 3:28:57 AM
    Author     : nasru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.staff.model.staff"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Jumlah Staf HEA</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link rel="stylesheet" href="css/adminTable.css">
    </head>
    <body>
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <a href="javascript:window.history.back();" class="btn btn-link">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
            </div>
            <% 
                List<staff> staffList = (List<staff>) request.getAttribute("UZSWstaffList");
                int staffCount = (staffList != null) ? staffList.size() : 0; // Get the size safely
            %>
            <h5>Jumlah Staf UZSW <span class="text-primary"><%= staffCount %> Staf</span></h5>
            <table class="table">
                <thead>
                    <tr>
                        <th>Bil.</th>
                        <th>Nama</th>
                        <th>E-mel</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        if (staffList != null && !staffList.isEmpty()) {
                            for (int i = 0; i < staffList.size(); i++) {
                                staff staff = staffList.get(i);
                    %>
                    <tr>
                        <td><%= i + 1 %></td>
                        <td><%= staff.getStaffname() %><br>
                        <td><%= staff.getStaffemail() %></td>
                        <td>
                            <!-- Form for deleting staff -->
                            <form action="deleteStaffServlet" method="post" style="display:inline;">
                                <input type="hidden" id="staffId" name="staffId" value="<%= staff.getStaffid() %>"/> <!-- Hidden input for staffId -->
                                <button type="submit" class="btn btn-link" title="Delete">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </form>
                            <!-- Form for updating staff -->
                            <form action="updateStaffServlet" method="post" style="display:inline;">
                                <!-- Link for updating staff -->
                                <a href="updateStaffServlet?staffId=<%= staff.getStaffid()%>" class="btn btn-link" title="Edit">
                                    <i class="fas fa-edit"></i>
                                </a>
                            </form>
                        </td>
                    </tr>
                    <% 
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" class="text-center">Tiada data tersedia.</td>
                    </tr>
                    <% 
                        }
                    %>
                </tbody> <!-- Corrected closing tag -->
            </table>
            <div class="text-center">
                <a href="adminServlet?action=addStaff" class="btn btn-log">
                    <i class="fas fa-plus"></i> TAMBAH
                </a>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
