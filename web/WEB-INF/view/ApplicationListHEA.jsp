<%@page import="java.sql.*"%>
<%@page import="com.database.dbconn"%>
<%@page import="java.util.List"%>
<%@page import="com.ApplicationDetails.model.ApplicationDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hal Ehwal Akademik</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/stf.css">
    <link rel="stylesheet" href="css/staffDashboard.css">  
</head>
<body>
<!-- Navigation Bar -->
<nav class="navbar text-light mb-3" style="background-color: #112C55">
    <div class="container-fluid d-flex align-items-center">
         <!-- Back Arrow -->
        <a href="javascript:window.history.back();" class="btn btn-outline-light me-3">
            <i class="bi bi-arrow-left"></i> 
        </a>

        <!-- Right-aligned Section -->
        <div class="d-flex align-items-center ms-auto">
            <!-- Log Out -->
            <a href="#" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Log Keluar</a>
        </div>
    </div>
</nav>

<!-- Main Container -->
<div class="container">
    <!-- Tabs Navigation -->
    <ul class="nav nav-tabs mb-3" id="applicationTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active" id="total-tab" data-bs-toggle="tab" data-bs-target="#total" type="button" role="tab" aria-controls="total" aria-selected="true">Jumlah </button>
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
            int totalPages = (int) Math.ceil(( double) totalCount / itemsPerPage);

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
                        <form action="updateApplicationStatus" method="post" 
                            <%= (totalApp.getHeaReview() != null && totalApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                          <td>
                        <input type="hidden" id="appID" name="appID" value="<%= totalApp.getApplyId() %>"/> 
                        <div class="select-box">
                        <select name="selectedAction" 
                            <%= (totalApp.getHeaReview() != null && totalApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                            <% 
                            // Check if getHeaReview() is TRUE
                            if (totalApp.getHeaReview() != null && totalApp.getHeaReview().equalsIgnoreCase("TRUE")) {
                                // If TRUE, check getHeaStatus()
                                if ("LULUS".equalsIgnoreCase(totalApp.getAppStatHEA())) {
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
                                // If getHeaReview() is null, use CGPA to determine selection
                                if (totalApp.getApplyCgpa() <= 3.0) {
                            %>
                                <option value="GAGAL" selected>GAGAL</option>
                                <option value="LULUS">LULUS</option>
                            <% 
                                } else {
                            %>
                                <option value="GAGAL">GAGAL</option>
                                <option value="LULUS" selected>LULUS</option>
                            <% 
                                }
                            }
                            %>
                        </select>
                            </div>
                        </td>
                        <td>
                            <input type="checkbox" name="disemak" value="TRUE" 
                                <%= (totalApp != null && totalApp.getHeaReview() != null && totalApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "checked" : "" %> 
                                <%= (totalApp.getHeaReview() != null && totalApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                        </td>
                        <td>
                            <button type="submit" class="btn btn-danger btn-sm" 
                                <%= (totalApp.getHeaReview() != null && totalApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                                Serah
                            </button>
                        </td>
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
        
        <!--pending tab-->
        <div class="tab-pane fade" id="pending" role="tabpanel" aria-labelledby="pending-tab">
            <%
        int pendingItemsPerPage = 6;
        int pendingCurrentPage = 1; // Default to the first page
        String pendingPageParam = request.getParameter("pendingPage");
        if (pendingPageParam != null) {
            try {
                pendingCurrentPage = Integer.parseInt(pendingPageParam);
            } catch (NumberFormatException e) {
                pendingCurrentPage = 1; // Reset to first page if invalid
            }
        }

        List<ApplicationDetails> pendingList = (List<ApplicationDetails>) session.getAttribute("pendingList");
        int pendingCount = (pendingList != null) ? pendingList.size() : 0;
        int pendingTotalPages = (int) Math.ceil((double) pendingCount / pendingItemsPerPage);
        int pendingStartIndex = (pendingCurrentPage - 1) * pendingItemsPerPage;
        int pendingEndIndex = Math.min(pendingStartIndex + pendingItemsPerPage, pendingCount);
    %>
            <div class="jumlah-section mb-4">
                <span>Jumlah Permohonan: <span class="jumlah-count"><%= pendingCount %></span></span>
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
                        <th>Status</th>
                        <th>Disemak</th>
                        <th>Tindakan</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    if (pendingList != null && !pendingList.isEmpty()) {
                        for (int i = pendingStartIndex; i < pendingEndIndex; i++) {
                            ApplicationDetails pendingApp = pendingList.get(i);
                    %>
                    <tr>
                        <td><%= i + 1 %></td>
                        <td><%= pendingApp.getStudName() %></td>
                        <td><%= pendingApp.getStudId() %></td>
                        <td><%= pendingApp.getApplyDate() %></td>
                        <td>
                            <a href="#" class="text-decoration-none">
                                2023******_MAC25OGOS25.pdf
                                <i class="bi bi-download download-icon"></i>
                            </a>
                        </td>
                        <form action="updateApplicationStatus" method="post" 
                            <%= (pendingApp.getHeaReview() != null && pendingApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                          <td>
                        <input type="hidden" id="appID" name="appID" value="<%= pendingApp.getApplyId() %>"/> 
                        <div class="select-box">
                        <select name="selectedAction" 
                            <%= (pendingApp.getHeaReview() != null && pendingApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                            <% 
                            // Check if getHeaReview() is TRUE
                            if (pendingApp.getHeaReview() != null && pendingApp.getHeaReview().equalsIgnoreCase("TRUE")) {
                                // If TRUE, check getHeaStatus()
                                if ("LULUS".equalsIgnoreCase(pendingApp.getAppStatHEA())) {
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
                                // If getHeaReview() is null, use CGPA to determine selection
                                if (pendingApp.getApplyCgpa() <= 3.0) {
                            %>
                                <option value="GAGAL" selected>GAGAL</option>
                                <option value="LULUS">LULUS</option>
                            <% 
                                } else {
                            %>
                                <option value="GAGAL">GAGAL</option>
                                <option value="LULUS" selected>LULUS</option>
                            <% 
                                }
                            }
                            %>
                        </select>
                            </div>
                        </td>
                        <td>
                            <input type="checkbox" name="disemak" value="TRUE" 
                                <%= (pendingApp != null && pendingApp.getHeaReview() != null && pendingApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "checked" : "" %> 
                                <%= (pendingApp.getHeaReview() != null && pendingApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                        </td>
                        <td>
                            <button type="submit" class="btn btn-danger btn-sm" 
                                <%= (pendingApp.getHeaReview() != null && pendingApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                                Serah
                            </button>
                        </td>
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
        <li class="page-item <%= (pendingCurrentPage == 1) ? "disabled" : "" %>">
            <a class="page-link" href="?pendingPage=<%= pendingCurrentPage - 1 %>&tab=pending" tabindex="-1">Previous</a>
        </li>
        <% for (int i = 1; i <= pendingTotalPages; i++) { %>
            <li class="page-item <%= (i == pendingCurrentPage) ? "active" : "" %>">
                <a class="page-link" href="?pendingPage=<%= i %>&tab=pending"><%= i %></a>
            </li>
        <% } %>
        <li class="page-item <%= (pendingCurrentPage == pendingTotalPages) ? "disabled" : "" %>">
            <a class="page-link" href="?pendingPage=<%= pendingCurrentPage + 1 %>&tab=pending">Next</a>
        </li>
    </ul>
        </div>
        
        <!--rejected tab-->
        <div class="tab-pane fade" id="rejected" role="tabpanel" aria-labelledby="rejected-tab">
            <%
        int rejectedItemsPerPage = 6;
        int rejectedCurrentPage = 1; // Default to the first page
        String rejectedPageParam = request.getParameter("rejectedPage");
        if (rejectedPageParam != null) {
            try {
                rejectedCurrentPage = Integer.parseInt(rejectedPageParam);
            } catch (NumberFormatException e) {
                rejectedCurrentPage = 1; // Reset to first page if invalid
            }
        }

        List<ApplicationDetails> rejectedList = (List<ApplicationDetails>) session.getAttribute("rejectedList");
        int rejectedCount = (rejectedList != null) ? rejectedList.size() : 0;
        int rejectedTotalPages = (int) Math.ceil((double) rejectedCount / rejectedItemsPerPage);
        int rejectedStartIndex = (rejectedCurrentPage - 1) * rejectedItemsPerPage;
        int rejectedEndIndex = Math.min(rejectedStartIndex + rejectedItemsPerPage, rejectedCount);
    %>
            <div class="jumlah-section mb-4">
                <span>Jumlah Permohonan: <span class="jumlah-count"><%= rejectedCount %></span></span>
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
                        <th>Status</th>
                        <th>Disemak</th>
                        <th>Tindakan</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    if (rejectedList != null && !rejectedList.isEmpty()) {
                        for (int i = rejectedStartIndex; i < rejectedEndIndex; i++) {
                            ApplicationDetails rejectedApp = rejectedList.get(i);
                    %>
                    <tr>
                        <td><%= i + 1 %></td>
                        <td><%= rejectedApp.getStudName() %></td>
                        <td><%= rejectedApp.getStudId() %></td>
                        <td><%= rejectedApp.getApplyDate() %></td>
                        <td>
                            <a href="<%= request.getContextPath() %>/documentsRetrievalServlet?fileName=2023******_MAC25OGOS25.pdf&studentId=<%= totalApp.getStudId() %>" class="text-decoration-none">
                                2023******_MAC25OGOS25.pdf
                                <i class="bi bi-download download-icon"></i>
                            </a>
                        </td>
                        <form action="updateApplicationStatus" method="post" 
                            <%= (rejectedApp.getHeaReview() != null && rejectedApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                          <td>
                        <input type="hidden" id="appID" name="appID" value="<%= rejectedApp.getApplyId() %>"/> 
                        <div class="select-box">
                        <select name="selectedAction" 
                            <%= (rejectedApp.getHeaReview() != null && rejectedApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                            <% 
                            // Check if getHeaReview() is TRUE
                            if (rejectedApp.getHeaReview() != null && rejectedApp.getHeaReview().equalsIgnoreCase("TRUE")) {
                                // If TRUE, check getHeaStatus()
                                if ("LULUS".equalsIgnoreCase(rejectedApp.getAppStatHEA())) {
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
                                // If getHeaReview() is null, use CGPA to determine selection
                                if (rejectedApp.getApplyCgpa() <= 3.0) {
                            %>
                                <option value="GAGAL" selected>GAGAL</option>
                                <option value="LULUS">LULUS</option>
                            <% 
                                } else {
                            %>
                                <option value="GAGAL">GAGAL</option>
                                <option value="LULUS" selected>LULUS</option>
                            <% 
                                }
                            }
                            %>
                        </select>
                            </div>
                        </td>
                        <td>
                            <input type="checkbox" name="disemak" value="TRUE" 
                                <%= (rejectedApp != null && rejectedApp.getHeaReview() != null && rejectedApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "checked" : "" %> 
                                <%= (rejectedApp.getHeaReview() != null && rejectedApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                        </td>
                        <td>
                            <button type="submit" class="btn btn-danger btn-sm" 
                                <%= (rejectedApp.getHeaReview() != null && rejectedApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                                Serah
                            </button>
                        </td>
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
        <li class="page-item <%= (rejectedCurrentPage == 1) ? "disabled" : "" %>">
            <a class="page-link" href="?rejectedPage=<%= rejectedCurrentPage - 1 %>&tab=rejected" tabindex="-1">Previous</a>
        </li>
        <% for (int i = 1; i <= rejectedTotalPages; i++) { %>
            <li class="page-item <%= (i == rejectedCurrentPage) ? "active" : "" %>">
                <a class="page-link" href="?rejectedPage=<%= i %>&tab=rejected"><%= i %></a>
            </li>
        <% } %>
        <li class="page-item <%= (rejectedCurrentPage == rejectedTotalPages) ? "disabled" : "" %>">
            <a class="page-link" href="?rejectedPage=<%= rejectedCurrentPage + 1 %>&tab=rejected">Next</a>
        </li>
    </ul>
        </div>
     
       <!--approved tab --> 
        <div class="tab-pane fade show" id="approved" role="tabpanel" aria-labelledby="approved-tab">
            <%
                int approvedItemsPerPage = 6;
                int approvedCurrentPage = 1; // Default to the first page
                String approvedPageParam = request.getParameter("approvedPage");
                if (approvedPageParam != null) {
                    try {
                        approvedCurrentPage = Integer.parseInt(approvedPageParam);
                    } catch (NumberFormatException e) {
                        approvedCurrentPage = 1; // Reset to first page if invalid
                    }
                }

                List<ApplicationDetails> approvedList = (List<ApplicationDetails>) session.getAttribute("approvedList");
                int approvedCount = (approvedList != null) ? approvedList.size() : 0;
                int approvedTotalPages = (int) Math.ceil((double) approvedCount / approvedItemsPerPage);
                int approvedStartIndex = (approvedCurrentPage - 1) * approvedItemsPerPage;
                int approvedEndIndex = Math.min(approvedStartIndex + approvedItemsPerPage, approvedCount);
            %>
            <div class="jumlah-section mb-4">
                <span>Jumlah Permohonan: <span class="jumlah-count"><%= approvedCount %></span></span>
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
                        <th>Status</th>
                        <th>Disemak</th>
                        <th>Tindakan</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    if (approvedList != null && !approvedList.isEmpty()) {
                        for (int i = approvedStartIndex; i < approvedEndIndex; i++) {
                            ApplicationDetails approvedApp = approvedList.get(i);
                    %>
                    <tr>
                        <td><%= i + 1 %></td>
                        <td><%= approvedApp.getStudName() %></td>
                        <td><%= approvedApp.getStudId() %></td>
                        <td><%= approvedApp.getApplyDate() %></td>
                        <td>
                            <a href="#" class="text-decoration-none">
                                2023******_MAC25OGOS25.pdf
                                <i class="bi bi-download download-icon"></i>
                            </a>
                        </td>
                        <form action="updateApplicationStatus" method="post" 
                            <%= (approvedApp.getHeaReview() != null && approvedApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                          <td>
                        <input type="hidden" id="appID" name="appID" value="<%= approvedApp.getApplyId() %>"/> 
                        <div class="select-box">
                        <select name="selectedAction" 
                            <%= (approvedApp.getHeaReview() != null && approvedApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                            <% 
                            // Check if getHeaReview() is TRUE
                            if (approvedApp.getHeaReview() != null && approvedApp.getHeaReview().equalsIgnoreCase("TRUE")) {
                                // If TRUE, check getHeaStatus()
                                if ("LULUS".equalsIgnoreCase(approvedApp.getAppStatHEA())) {
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
                                // If getHeaReview() is null, use CGPA to determine selection
                                if (approvedApp.getApplyCgpa() <= 3.0) {
                            %>
                                <option value="GAGAL" selected>GAGAL</option>
                                <option value="LULUS">LULUS</option>
                            <% 
                                } else {
                            %>
                                <option value="GAGAL">GAGAL</option>
                                <option value="LULUS" selected>LULUS</option>
                            <% 
                                }
                            }
                            %>
                        </select>
                            </div>
                        </td>
                        <td>
                            <input type="checkbox" name="disemak" value="TRUE" 
                                <%= (approvedApp != null && approvedApp.getHeaReview() != null && approvedApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "checked" : "" %> 
                                <%= (approvedApp.getHeaReview() != null && approvedApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                        </td>
                        <td>
                            <button type="submit" class="btn btn-danger btn-sm" 
                                <%= (approvedApp.getHeaReview() != null && approvedApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : "" %> >
                                Serah
                            </button>
                        </td>
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
                <li class="page-item <%= (approvedCurrentPage == 1) ? "disabled" : "" %>">
                    <a class="page-link" href="?approvedTotalPages=<%= approvedCurrentPage - 1 %>&tab=approved" tabindex="-1">Previous</a>
                </li>
                <% for (int i = 1; i <= approvedTotalPages; i++) { %>
                    <li class="page-item <%= (i == approvedCurrentPage) ? "active" : "" %>">
                        <a class="page-link" href="?approvedTotalPages=<%= i %>&tab=approved"><%= i %></a>
                    </li>
                <% } %>
                <li class="page-item <%= (approvedCurrentPage == approvedTotalPages) ? "disabled" : "" %>">
                    <a class="page-link" href="?approvedTotalPages=<%= approvedCurrentPage + 1 %>&tab=approved">Next</a>
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

<%
    String successMessage = (String) request.getAttribute("message");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<script>
    <% if (successMessage != null) { %>
    alert("<%= successMessage %>");
    <% } %>
    <% if (errorMessage != null) { %>
    alert("<%= errorMessage %>");
    <% } %>
</script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3. 5.1.slim.min.js"></script>

<script>
function updateDropdown(index, action) {
    document.getElementById('selectedAction' + index).value = action;
}
</script>
<!-- Search Functionality -->
<script>
    function searchTable() {
        const input = document.getElementById("searchInput").value.toLowerCase();
        const rows = document.getElementById("applicationTable").getElementsByTagName("tr");

        for (let i = 0; i < rows.length; i++) {
            const rowData = rows[i].textContent.toLowerCase();
            if (rowData.includes(input)) {
                rows[i].style.display = "";
            } else {
                rows[i].style.display = "none";
            }
        }
    }
</script>
</body>
</html>