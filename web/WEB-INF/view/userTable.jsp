<%@page import="com.user.model.Student"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/adminTable.css">
    </head>
    <body>
        <!-- Top Navigation Bar -->
        <nav class="navbar navbar-expand-lg" style="background-color: #522E5C">
            <div class="container-fluid">
                <a class="navbar-brand text-white bold-text" href="adminServlet?action=home">Zakat Pendidikan Management System</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <div class="ms-auto">
                        <a class="btn btn-light" data-bs-toggle="modal" data-bs-target="#logoutModal" role="button" style="background-color: #6E1313; color: white; border: none;">Logout</a>
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
                List<Student> studentList = (List<Student>) request.getAttribute("userList");
                int count = (Integer) request.getAttribute("count");
                int currentPage = (Integer) request.getAttribute("currentPage");
                int totalPages = (Integer) request.getAttribute("totalPages");
                int itemsPerPage = (Integer) request.getAttribute("itemsPerPage");
            %>

            <h5>Jumlah Pengguna: <span class="text-primary"><%= count%></span></h5>
            <table class="table">
                <thead>
                    <tr>
                        <th>Bil.</th>
                        <th>Nama Pelajar</th>
                        <th>ID Pelajar</th>
                        <th>Emel</th>
                        <th>Kursus</th>
                        <th>Fakulti</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (studentList != null && !studentList.isEmpty()) {
                            for (int i = 0; i < studentList.size(); i++) {
                                Student student = studentList.get(i);
                                int rowNumber = (currentPage - 1) * itemsPerPage + i + 1;
                    %>
                    <tr>
                        <td class="text-center"><%= rowNumber%></td>
                        <td><%= student.getStudName()%></td>
                        <td><%= student.getStudID()%></td>
                        <td><%= student.getStudEmail()%></td>
                        <td><%= student.getStudCourse()%></td>
                        <td><%= student.getStudFaculty()%></td>
                    </tr>
                    <% }
                } else { %>
                    <tr>
                        <td colspan="6" class="text-center">Tiada Maklumat.</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>

            <!-- Pagination -->
            <nav>
                <ul class="pagination justify-content-center">
                    <li class="page-item <%= (currentPage <= 1) ? "disabled" : ""%>">
                        <a class="page-link" href="?action=viewUsers&page=<%= currentPage - 1%>">Sebelum</a>
                    </li>
                    <% for (int i = 1; i <= totalPages; i++) {%>
                    <li class="page-item <%= (currentPage == i) ? "active" : ""%>">
                        <a class="page-link" href="?action=viewUsers&page=<%= i%>"><%= i%></a>
                    </li>
                    <% }%>
                    <li class="page-item <%= (currentPage >= totalPages) ? "disabled" : ""%>">
                        <a class="page-link" href="?action=viewUsers&page=<%= currentPage + 1%>">Seterusnya</a>
                    </li>
                </ul>
            </nav>
            <!-- Logout Confirmation Modal -->
            <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content text-center" style="background-color: #522E5C; color: white;">
                        <div class="modal-body py-4">
                            <h5 id="logoutModalLabel" class="mb-4">Adakah anda ingin keluar?</h5>
                            <div class="d-flex justify-content-center gap-3">
                                <a href="${pageContext.request.contextPath}/adminLogOutServlet" class="btn btn-outline-light px-4">KELUAR</a>
                                <button type="button" class="btn btn-danger px-4"  data-bs-dismiss="modal">BATAL</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
