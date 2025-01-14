<%@page import="java.sql.*"%>
<%@page import="com.database.dbconn"%>
<%@page import="java.util.List"%>
<%@page import="com.ApplicationDetails.model.ApplicationDetails"%>
<%@page import="com.interview.model.interview"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unit Zakat, Sedekah Dan Wakaf</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/stf.css">
    <link rel="stylesheet" href="css/staffDashboard.css"> 
</head>

<body>   
<!-- Navigation Bar -->
<nav class="navbar text-light mb-3" style="background-color: #112C55">
    <div class="container-fluid d-flex align-items-center">
        <a href="javascript:window.history.back();" class="btn btn-outline-light me-3">
            <i class="bi bi-arrow-left"></i> 
        </a>
        <div class="d-flex align-items-center ms-auto">
            <a href="#" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Log Keluar</a>
        </div>
    </div>
</nav>

<!-- Main Container -->
<div class="container">
    <!-- Display Error Messages -->
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>
    <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            <%= request.getAttribute("success") %>
        </div>
    <% } %>

    <!-- Tabs Navigation -->
    <ul class="nav nav-tabs mb-3" id="applicationTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="total-tab" data-bs-toggle="tab" data-bs-target="#total" type="button" role="tab" aria-controls="total" aria-selected="true">Jumlah</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="approved-tab" data-bs-toggle="tab" data-bs-target="#approved" type="button" role="tab" aria-controls="approved" aria-selected="false">Disahkan</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" type="button" role="tab" aria-controls="pending" aria-selected="false">Menunggu</button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link" id="rejected-tab" data-bs-toggle="tab" data-bs-target="#rejected" type="button" role="tab" aria-controls="rejected" aria-selected="false">Ditolak</button>
        </li>
    </ul>

    <!-- Tabs Content -->
    <div class="tab-content" id="applicationTabsContent">
        <!-- Total Tab -->
        <div class="tab-pane fade show active" id="total" role="tabpanel" aria-labelledby="total-tab">
            <%
                int itemsPerPage = 6;
                int currentPage = 1; // Default to the first page
                String pageParam = request.getParameter("totalPage");
                if (pageParam != null) {
                    try {
 currentPage = Integer.parseInt(pageParam);
                    } catch (NumberFormatException e) {
                        currentPage = 1; // Reset to first page if invalid
                    }
                }

                // Total list for the current tab
                List<ApplicationDetails> totalList = (List<ApplicationDetails>) session.getAttribute("totalList");
                int totalCount = (totalList != null) ? totalList.size() : 0;
                int totalPages = (int) Math.ceil((double) totalCount / itemsPerPage);

                // Calculate start and end index for the current page
                int startIndex = (currentPage - 1) * itemsPerPage;
                int endIndex = Math.min(startIndex + itemsPerPage, totalCount);
            %>
            <div class="jumlah-section mb-4">
                <span>Jumlah Permohonan: <span class="jumlah-count"><%= totalCount %></span></span>
            </div>
            <div class="form-group">
                <input type="text" id="searchInput" class="form-control" placeholder="Search application..." onkeyup="searchTable()">
            </div>
            <br>
            <table class="table table-hover align-middle" id="applicationTable">
                <thead class="table-light">
                    <tr>
                        <th>Bil</th>
                        <th>Nama</th>
                        <th>No. Pelajar</th>
                        <th>Tarikh Mohon</th>
                        <th>Borang</th>
                        <th>Tarikh Temuduga</th>
                        <th>Status</th>
                        <th>Disemak</th>
                        <th>Tindakan</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    if (totalList != null && !totalList.isEmpty()) {
                        for (int i = startIndex; i < endIndex; i++) {
                            ApplicationDetails totalApp = totalList.get(i);
                    %>
                    <tr>
                        <td><%= i + 1 %></td>
                        <td><%= totalApp.getStudName() %></td>
                        <td><%= totalApp.getStudId() %></td>
                        <td><%= totalApp.getApplyDate() %></td>
                        <td>
                            <a href="#" class="text-decoration-none">
                                2023******_MAC25OGOS25.pdf
                                <i class="bi bi-download download-icon"></i>
                            </a>
                        </td>
                        <td>
                            <form action="updateInterviewDate" method="post" class="d-flex align-items-center">
                                <input type="hidden" id="appID" name="appID" value="<%= totalApp.getApplyId() %>"/>
                                <div class="d-flex justify-content-center">
                                    <input type="date" name="tarikhTemuduga" class="form-control" required>
                                </div>
                                <button type="submit" class="btn btn-danger btn-sm">Serah</button>
                            </form>
                        </td>
                        <td>
                            <form action="updateApplicationStatus" method="post">
                                <input type="hidden" id="appID" name="appID" value="<%= totalApp.getApplyId() %>"/> 
                                <div class="select-box">
                                    <select name="selectedAction">
                                        <% 
                                        // Check if getUzswReview() is TRUE
                                        if (totalApp.getUzswReview() != null && totalApp.getUzswReview().equalsIgnoreCase("TRUE")) {
                                            // If TRUE, check getAppStatUZSW()
                                            if ("LULUS".equalsIgnoreCase(totalApp.getAppStatUZSW())) {
                                        %>
                                            <option value="GAGAL">GAGAL</option>
                                            <option value="LULUS" selected>LULUS</option>
                                        <% 
                                            } else {
                                        %>
                                            <option value="GAGAL" selected>GAGAL</option>
                                            <option value="LULUS">LULUS</option>
                                        <% 
                                            }
                                        } else {
                                        %>
                                            <option value="GAGAL" selected>GAGAL</option>
                                            <option value="LULUS">LULUS</option>
                                        <% 
                                        } 
                                        %>
                                    </select>
                                </div>
                        </td>
                        <td>
                            <input type="checkbox" name="disemak" value="TRUE" 
                                <%= (totalApp != null && totalApp.getUzswReview() != null && totalApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "checked" : "" %> 
                                <%= (totalApp.getUzswReview() != null && totalApp .getUzswReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                        </td>
                        <td>
                            <button type="submit" class="btn btn-danger btn-sm" 
                                <%= (totalApp.getUzswReview() != null && totalApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                                Serah
                            </button>
                            </form>
                        </td>
                    </tr>
                    <% 
                        } // End of for loop
                    } // End of if statement
                    %>
                </tbody>
            </table>

            <ul class="pagination justify-content-end">
                <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
                    <a class="page-link" href="?totalPage=<%= currentPage - 1 %>&tab=total" tabindex="-1">Previous</a>
                </li>
                <% for (int i = 1; i <= totalPages; i++) { %>
                    <li class="page-item <%= (i == currentPage) ? "active" : "" %>">
                        <a class="page-link" href="?totalPage=<%= i %>&tab=total"><%= i %></a>
                    </li>
                <% } %>
                <li class="page-item <%= (currentPage == totalPages) ? "disabled" : "" %>">
                    <a class="page-link" href="?totalPage=<%= currentPage + 1 %>&tab=total">Next</a>
                </li>
            </ul>
        </div>
    </div>

    <!-- Logout Confirmation Modal -->
    <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content text-center" style="background-color: #112C55; color: white;">
                <div class="modal-body py-4">
                    <h5 id="logoutModalLabel" class="mb-4">Adakah anda ingin keluar?</h5>
                    <div class="d-flex justify-content-center gap-3">
                        <a href="staff_logout.do" class="btn btn-outline-light px-4">KELUAR</a>
                        <button type="button" class="btn btn-danger px-4" data-bs-dismiss="modal">BATAL</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <script src="/Zakat_Management_System/js/staffDashboard.js"></script>

    <!-- JavaScript to Update Dropdown -->
    <script>
        function updateDropdown(element) {
            const dropdownButton = element.closest('.dropdown').querySelector('.dropdown-toggle');
            dropdownButton.textContent = element.textContent;
        }
    </script>
</body>
</html>