<%@page import="com.ApplicationDetails.model.ApplicationDetails"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
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
            List<ApplicationDetails> applicationList = (List<ApplicationDetails>) request.getAttribute("ApplicationList");
            int count = (Integer) request.getAttribute("count");
            int currentPage = (Integer) request.getAttribute("currentPage");
            int totalPages = (Integer) request.getAttribute("totalPages");
            int itemsPerPage = (Integer) request.getAttribute("itemsPerPage");
        %>

        <h5>Pemohonan: <span class="text-primary"><%= count%> Pemohonan</span></h5>
        <table class="table">
            <thead>
                <tr>
                    <th>Bil.</th>
                    <th>Nama Pelajar</th>
                    <th>ID Pemohonan</th>
                    <th>Tarikh Mohon</th>
                    <th>Status</th>
                    <th>Tarikh Temuduga</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (applicationList != null && !applicationList.isEmpty()) {
                        for (int i = 0; i < applicationList.size(); i++) {
                            ApplicationDetails applications = applicationList.get(i);
                            int rowNumber = (currentPage - 1) * itemsPerPage + i + 1;
                %>
                <tr>
                    <td class="text-center"><%= rowNumber %></td>
                    <td><%= applications.getStudName() %></td>
                    <td><%= applications.getApplyId() %></td>
                    <td><%= applications.getApplyDate() %></td>
                    <td class="status-<%= applications.getApproveStatus().toLowerCase() %>">
                        <%= applications.getApproveStatus() %>
                    </td>
                    <td><%= (applications.getInterviewDate() != null) ? applications.getInterviewDate() : "N/A" %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6" class="text-center">No data available.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <!-- Pagination -->
        <nav>
            <ul class="pagination justify-content-center">
                <!-- Previous Button -->
                <li class="page-item <%= (currentPage <= 1) ? "disabled" : ""%>">
                    <a class="page-link" href="?action=viewApplication&page=<%= currentPage - 1%>">Previous</a>
                </li>

                <!-- Page Numbers -->
                <% for (int i = 1; i <= totalPages; i++) { %>
                <li class="page-item <%= (currentPage == i) ? "active" : ""%>">
                    <a class="page-link" href="?action=viewApplication&page=<%= i%>"><%= i%></a>
                </li>
                <% } %>

                <!-- Next Button -->
                <li class="page-item <%= (currentPage >= totalPages) ? "disabled" : ""%>">
                    <a class="page-link" href="?action=viewApplication&page=<%= currentPage + 1%>">Next</a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Logout Confirmation Modal -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content text-center" style="background-color: #522E5C; color: white;">
                <div class="modal-body py-4">
                    <h5 id="logoutModalLabel" class="mb-4">Are you sure you want to logout?</h5>
                    <div class="d-flex justify-content-center gap-3">
                        <a href="${pageContext.request.contextPath}/adminLogOutServlet" class="btn btn-outline-light px-4">LOGOUT</a>
                        <button type="button" class="btn btn-danger px-4" data-bs-dismiss="modal">CANCEL</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>