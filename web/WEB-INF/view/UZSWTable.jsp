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
        <!-- Top Navigation Bar -->
        <nav class="navbar navbar-expand-lg" style="background-color: #522E5C">
            <div class="container-fluid">
                <a class="navbar-brand text-white" href="adminServlet?action=home">Admin Dashboard</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <div class="ms-auto">
                        <a class="btn btn-light" 
                           data-bs-toggle="modal" data-bs-target="#logoutModal"
                           role="button" 
                           style="background-color: #6E1313; color: white; border: none;">
                            Logout
                        </a>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <a href="adminServlet?action=home" class="btn btn-link">
                    <i class="fas fa-arrow-left"></i> Kembali
                </a>
            </div>
            <%
                List<staff> staffList = (List<staff>) request.getAttribute("UZSWstaffList");
                int count = (Integer) request.getAttribute("count");
                int currentPage = (Integer) request.getAttribute("currentPage");
                int totalPages = (Integer) request.getAttribute("totalPages");
                int itemsPerPage = (Integer) request.getAttribute("itemsPerPage");
            %>
            <h5>Jumlah Staf UZSW <span class="text-primary"><%= count%> Staf</span></h5>
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
                                int rowNumber = (currentPage - 1) * itemsPerPage + i + 1;
                    %>
                    <tr>
                        <td class="text-center"><%= rowNumber%></td>
                        <td><%= staff.getStaffname()%></td>
                        <td><%= staff.getStaffemail()%></td>
                        <td>
                            <!-- Form for deleting staff -->
                            <form action="deleteStaffServlet" method="post" style="display:inline;">
                                <input type="hidden" name="staffId" value="<%= staff.getStaffid()%>"/> <!-- Hidden input for staffId -->
                                <button type="submit" class="btn btn-link" title="Delete">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </form>
                            <!-- Link for updating staff -->
                            <a href="updateStaffServlet?staffId=<%= staff.getStaffid()%>" class="btn btn-link" title="Edit">
                                <i class="fas fa-edit"></i>
                            </a>
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
                </tbody>
            </table>
            <nav>
                <ul class="pagination justify-content-center">
                    <!-- Previous Button -->
                    <li class="page-item <%= (currentPage <= 1) ? "disabled" : ""%>">
                        <a class="page-link" href="?action=viewUZSWStaff&page=<%= currentPage - 1%>">Sebelum</a>
                    </li>

                    <!-- Page Numbers -->
                    <% for (int i = 1; i <= totalPages; i++) {%>
                    <li class="page-item <%= (currentPage == i) ? "active" : ""%>">
                        <a class="page-link" href="?action=viewUZSWStaff&page=<%= i%>"><%= i%></a>
                    </li>
                    <% }%>

                    <!-- Next Button -->
                    <li class="page-item <%= (currentPage >= totalPages) ? "disabled" : ""%>">
                        <a class="page-link" href="?action=viewUZSWStaff&page=<%= currentPage + 1%>">Seterusnya</a>
                    </li>
                </ul>
            </nav>
            <div class="text-center">
                <a href="adminServlet?action=addStaff" class="btn btn-log">
                    <i class="fas fa-plus"></i> TAMBAH
                </a>
            </div>
        </div>
        <!-- Logout Confirmation Modal -->
        <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content text-center" style="background-color: #522E5C; color: white;">
                    <!-- Modal Body -->
                    <div class="modal-body py-4">
                        <h5 id="logoutModalLabel" class="mb-4">Adakah anda ingin keluar?</h5>
                        <!-- Buttons -->
                        <div class="d-flex justify-content-center gap-3">
                            <a href="${pageContext.request.contextPath}/adminLogOutServlet" class="btn btn-outline-light px-4">KELUAR</a>
                            <button type="button" class="btn btn-danger px-4" data-bs-dismiss="modal">BATAL</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
