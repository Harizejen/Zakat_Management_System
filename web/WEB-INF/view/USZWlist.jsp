<%@page import="java.sql.*"%>
<%@page import="com.database.dbconn"%>
<%@page import="java.util.List"%>
<%@page import="com.ApplicationDetails.model.ApplicationDetails"%>
<%@page import="com.interview.model.interview"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Correctly retrieve 'tab' and 'pages' from request parameters
    String tab = request.getParameter("tab");
    String pages = request.getParameter("pages");
    if (tab == null || tab.isEmpty()) {
        tab = "total"; // Default tab
    }
    if (pages == null || pages.isEmpty()) {
        pages = "1"; // Default page
    }
%>
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
                <a href="goUZSWdashboard" class="btn btn-outline-light me-3">
                    <i class="bi bi-arrow-left"></i> 
                </a>
                <!-- Brand Name with Increased Left Margin -->
                <span class="navbar-brand fw-bold ms-2" style="color: white; font-size: 1.5rem;">Zakat Pendidikan Management System</span>

                <!-- Right-aligned Section -->
                <div class="d-flex align-items-center ms-auto">
                    <!-- Log Out -->
                    <a href="#" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Log Keluar</a>
                </div>
            </div>
        </nav

        <!-- Main Container -->
        <div class="container">
            <!-- Display Error Messages -->
            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger">
                <%= request.getAttribute("error")%>
            </div>
            <% } %>
            <% if (request.getAttribute("success") != null) {%>
            <div class="alert alert-success">
                <%= request.getAttribute("success")%>
            </div>
            <% }%>

            <!-- Tabs Navigation -->
            <ul class="nav nav-tabs mb-3" id="applicationTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link <%= (tab.equals("total")) ? "active" : ""%>" 
                            id="total-tab" data-bs-toggle="tab" data-bs-target="#total" 
                            type="button" role="tab" aria-controls="total" 
                            aria-selected="<%= (tab.equals("total")) ? "true" : "false"%>">
                        Keseluruhan
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link <%= (tab.equals("approved")) ? "active" : ""%>" 
                            id="approved-tab" data-bs-toggle="tab" data-bs-target="#approved" 
                            type="button" role="tab" aria-controls="approved" 
                            aria-selected="<%= (tab.equals("approved")) ? "true" : "false"%>">
                        Diluluskan
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link <%= (tab.equals("pending")) ? "active" : ""%>" 
                            id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" 
                            type="button" role="tab" aria-controls="pending" 
                            aria-selected="<%= (tab.equals("pending")) ? "true" : "false"%>">
                        Dalam Proses
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link <%= (tab.equals("rejected")) ? "active" : ""%>" 
                            id="rejected-tab" data-bs-toggle="tab" data-bs-target="#rejected" 
                            type="button" role="tab" aria-controls="rejected" 
                            aria-selected="<%= (tab.equals("rejected")) ? "true" : "false"%>">
                        Digagalkan
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link <%= (tab.equals("search")) ? "active" : ""%>" 
                            id="search-tab" data-bs-toggle="tab" data-bs-target="#search" 
                            type="button" role="tab" aria-controls="search" 
                            aria-selected="<%= (tab.equals("search")) ? "true" : "false"%>">
                        Carian
                    </button>
                </li>
            </ul>

            <!-- Tabs Content -->
            <div class="tab-content" id="applicationTabsContent">
                <!-- Total Tab -->
                <div class="tab-pane fade <%= (tab.equals("total")) ? "show active" : ""%>" id="total" role="tabpanel" aria-labelledby="total-tab">
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
                        <span>Jumlah  Keseluruhan Permohonan Yang Diterima: <span class="jumlah-count"><%= totalCount%></span></span>
                    </div>
                    <div class="form-group">
                        <input type="text" id="searchTotal" class="form-control" placeholder="Search application..." onkeyup="searchTotal()">
                    </div>
                    <br>
                    <table class="table table-hover align-middle" id="totalTable">
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
                                <td><%= i + 1%></td>
                                <td><%= totalApp.getStudName()%></td>
                                <td><%= totalApp.getStudId()%></td>
                                <td><%= totalApp.getApplyDate()%></td>
                                <td>
                                    <a href="<%= request.getContextPath()%>/cetakBorangServlet?stud_id=<%= totalApp.getStudId()%>" class="text-decoration-none">
                                        <%=totalApp.getStudId()%>_<%=totalApp.getApplySession()%>.pdf
                                        <i class="bi bi-download download-icon"></i>
                                    </a>
                                </td>
                                <td>
                                    <form action="updateInterviewServlet" method="post" class="d-flex align-items-center">
                                        <input type="hidden" id="appID" name="appID" value="<%= totalApp.getApplyId()%>"/>
                                        <input type="hidden" name="tab" value="<%= tab%>"> <!-- Preserve the current tab -->
                                        <input type="hidden" name="pages" value="<%= pages%>"> <!-- Preserve the current page -->
                                        <div class="d-flex justify-content-center">
                                            <input type="date" name="tarikhTemuduga" class="form-control" 
                                                   value="<%= (totalApp.getInterviewDate() != null) ? totalApp.getInterviewDate().toString() : ""%>" required>
                                        </div>
                                        <button type="submit" class="btn btn-danger btn-sm">Serah</button>
                                    </form>
                                </td>
                                <td>
                                    <form action="updateApplicationStatus" method="post">
                                        <input type="hidden" id="appID" name="appID" value="<%= totalApp.getApplyId()%>"/> 
                                        <input type="hidden" name="tab" value="<%= tab%>"> <!-- Preserve the current tab -->
                                        <input type="hidden" name="pages" value="<%= pages%>"> <!-- Preserve the current page -->
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
                                           <%= (totalApp != null && totalApp.getUzswReview() != null && totalApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "checked" : ""%> 
                                           <%= (totalApp.getUzswReview() != null && totalApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> required>
                                </td>
                                <td>
                                    <button type="submit" class="btn btn-danger btn-sm" 
                                            <%= (totalApp.getUzswReview() != null && totalApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
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
                        <li class="page-item <%= (currentPage == 1) ? "disabled" : ""%>">
                            <a class="page-link" href="?tab=total&totalPage=<%= currentPage - 1%>" tabindex="-1">Kembali</a>
                        </li>
                        <% for (int i = 1; i <= totalPages; i++) {%>
                        <li class="page-item <%= (i == currentPage) ? "active" : ""%>">
                            <a class="page-link" href="?tab=total&totalPage=<%= i%>"><%= i%></a>
                        </li>
                        <% }%>
                        <li class="page-item <%= (currentPage == totalPages) ? "disabled" : ""%>">
                            <a class="page-link" href="?tab=total&totalPage=<%= currentPage + 1%>">Seterusnya</a>
                        </li>
                    </ul>
                </div>

                <!-- Pending Tab -->
                <div class="tab-pane fade <%= (tab.equals("pending")) ? "show active" : ""%>" id="pending" role="tabpanel" aria-labelledby="pending-tab">
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
                        <span>Jumlah Permohonan Yang Masih Dalam Proses Pengesahan: <span class="jumlah-count"><%= pendingCount%></span></span>
                    </div>
                    <div class="form-group">
                        <input type="text" id="searchPending" class="form-control" placeholder="Search application..." onkeyup="searchPending()">
                    </div>
                    <br>
                    <table class="table table-hover align-middle" id="pendingTable">
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
                                if (pendingList != null && !pendingList.isEmpty()) {
                                    for (int i = pendingStartIndex; i < pendingEndIndex; i++) {
                                        ApplicationDetails pendingApp = pendingList.get(i);
                            %>
                            <tr>
                                <td><%= i + 1%></td>
                                <td><%= pendingApp.getStudName()%></td>
                                <td><%= pendingApp.getStudId()%></td>
                                <td><%= pendingApp.getApplyDate()%></td>
                                <td>
                                    <a href="<%= request.getContextPath()%>/cetakBorangServlet?stud_id=<%= pendingApp.getStudId()%>" class="text-decoration-none">
                                        <%=pendingApp.getStudId()%>_<%=pendingApp.getApplySession()%>.pdf
                                        <i class="bi bi-download download-icon"></i>
                                    </a>
                                </td>
                                <td>
                                    <form action="<%= request.getContextPath()%>/updateInterviewServlet" method="post" class="d-flex align-items-center">
                                        <input type="hidden" id="appID" name="appID" value="<%= pendingApp.getApplyId()%>"/>
                                        <div class="d-flex justify-content-center">
                                            <input type="date" name="tarikhTemuduga" class="form-control" 
                                                   value="<%= (pendingApp.getInterviewDate() != null) ? pendingApp.getInterviewDate().toString() : ""%>" required>
                                        </div>
                                        <button type="submit" class="btn btn-danger btn-sm">Serah</button>
                                    </form>
                                </td>
                                <td>
                                    <form action="updateApplicationStatus" method="post">
                                        <input type="hidden" id="appID" name="appID" value="<%= pendingApp.getApplyId()%>"/>
                                        <input type="hidden" name="tab" value="<%= tab%>"> <!-- Preserve the current tab -->
                                        <input type="hidden" name="pages" value="<%= pages%>"> <!-- Preserve the current page -->
                                        <div class="select-box">
                                            <select name="selectedAction">
                                                <%
                                                    // Check if getUzswReview() is TRUE
                                                    if (pendingApp.getUzswReview() != null && pendingApp.getUzswReview().equalsIgnoreCase("TRUE")) {
                                                        // If TRUE, check getAppStatUZSW()
                                                        if ("LULUS".equalsIgnoreCase(pendingApp.getAppStatUZSW())) {
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
                                           <%= (pendingApp != null && pendingApp.getUzswReview() != null && pendingApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "checked" : ""%> 
                                           <%= (pendingApp.getUzswReview() != null && pendingApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                                </td>
                                <td>
                                    <button type="submit" class="btn btn-danger btn-sm" 
                                            <%= (pendingApp.getUzswReview() != null && pendingApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
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
                        <li class="page-item <%= (pendingCurrentPage == 1) ? "disabled" : ""%>">
                            <a class="page-link" href="?tab=pending&pendingPage=<%= pendingCurrentPage - 1%>" tabindex="-1">Kembali</a>
                        </li>
                        <% for (int i = 1; i <= pendingTotalPages; i++) {%>
                        <li class="page-item <%= (i == pendingCurrentPage) ? "active" : ""%>">
                            <a class="page-link" href="?tab=pending&pendingPage=<%= i%>"><%= i%></a>
                        </li>
                        <% }%>
                        <li class="page-item <%= (pendingCurrentPage == pendingTotalPages) ? "disabled" : ""%>">
                            <a class="page-link" href="?tab=pending&pendingPage=<%= pendingCurrentPage + 1%>">Seterusnya</a>
                        </li>
                    </ul>
                </div>

                <!-- Rejected Tab -->
                <div class="tab-pane fade <%= (tab.equals("rejected")) ? "show active" : ""%>" id="rejected" role="tabpanel" aria-labelledby="rejected-tab">
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
                        <span>Jumlah Permohonan Yang Telah Digagalkan: <span class="jumlah-count"><%= rejectedCount%></span></span>
                    </div>
                    <div class="form-group">
                        <input type="text" id="searchRejected" class="form-control" placeholder="Search application..." onkeyup="searchRejected()">
                    </div>
                    <br>
                    <table class="table table-hover align-middle" id="rejectedTable">
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
                                if (rejectedList != null && !rejectedList.isEmpty()) {
                                    for (int i = rejectedStartIndex; i < rejectedEndIndex; i++) {
                                        ApplicationDetails rejectedApp = rejectedList.get(i);
                            %>
                            <tr>
                                <td><%= i + 1%></td>
                                <td><%= rejectedApp.getStudName()%></td>
                                <td><%= rejectedApp.getStudId()%></td>
                                <td><%= rejectedApp.getApplyDate()%></td>
                                <td>
                                    <a href="<%= request.getContextPath()%>/cetakBorangServlet?stud_id=<%= rejectedApp.getStudId()%>" class="text-decoration-none">
                                        <%= rejectedApp.getStudId()%>_<%= rejectedApp.getApplySession()%>.pdf
                                        <i class="bi bi-download download-icon"></i>
                                    </a>
                                </td>
                                <td>
                                    <form action="<%= request.getContextPath()%>/updateInterviewServlet" method="post" class="d-flex align-items-center">
                                        <input type="hidden" id="appID" name="appID" value="<%= rejectedApp.getApplyId()%>"/>
                                        <div class="d-flex justify-content-center">
                                            <input type="date" name="tarikhTemuduga" class="form-control" 
                                                   value="<%= (rejectedApp.getInterviewDate() != null) ? rejectedApp.getInterviewDate().toString() : ""%>" required>
                                        </div>
                                        <button type="submit" class="btn btn-danger btn-sm">Serah</button>
                                    </form>
                                </td>
                                <td>
                                    <form action="updateApplicationStatus" method="post">
                                        <input type="hidden" id="appID" name="appID" value="<%= rejectedApp.getApplyId()%>"/> 
                                        <input type="hidden" name="tab" value="<%= tab%>"> <!-- Preserve the current tab -->
                                        <input type="hidden" name="pages" value="<%= pages%>"> <!-- Preserve the current page -->
                                        <div class="select-box">
                                            <select name="selectedAction">
                                                <%
                                                    // Check if getUzswReview() is TRUE
                                                    if (rejectedApp.getUzswReview() != null && rejectedApp.getUzswReview().equalsIgnoreCase("TRUE")) {
                                                        // If TRUE, check getAppStatUZSW()
                                                        if ("LULUS".equalsIgnoreCase(rejectedApp.getAppStatUZSW())) {
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
                                           <%= (rejectedApp != null && rejectedApp.getUzswReview() != null && rejectedApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "checked" : ""%> 
                                           <%= (rejectedApp.getUzswReview() != null && rejectedApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                                </td>
                                <td>
                                    <button type="submit" class="btn btn-danger btn-sm" 
                                            <%= (rejectedApp.getUzswReview() != null && rejectedApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
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
                        <li class="page-item <%= (rejectedCurrentPage == 1) ? "disabled" : ""%>">
                            <a class="page-link" href="?tab=rejected&rejectedPage=<%= rejectedCurrentPage - 1%>" tabindex="-1">Kembali</a>
                        </li>
                        <% for (int i = 1; i <= rejectedTotalPages; i++) {%>
                        <li class="page-item <%= (i == rejectedCurrentPage) ? "active" : ""%>">
                            <a class="page-link" href="?tab=rejected&rejectedPage=<%= i%>"><%= i%></a>
                        </li>
                        <% }%>
                        <li class="page-item <%= (rejectedCurrentPage == rejectedTotalPages) ? "disabled" : ""%>">
                            <a class="page-link" href="?tab=rejected&rejectedPage=<%= rejectedCurrentPage + 1%>">Seterusnya</a>
                        </li>
                    </ul>
                </div>

                <!-- Approved Tab -->
                <div class="tab-pane fade <%= (tab.equals("approved")) ? "show active" : ""%>" id="approved" role="tabpanel" aria-labelledby="approved-tab">
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
                        <span>Jumlah Permohonan Yang Telah Diluluskan: <span class="jumlah-count"><%= approvedCount%></span></span>
                    </div>
                    <div class="form-group">
                        <input type="text" id="searchApproved" class="form-control" placeholder="Search application..." onkeyup="searchApproved()">
                    </div>
                    <br>
                    <table class="table table-hover align-middle" id="approvedTable">
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
                                if (approvedList != null && !approvedList.isEmpty()) {
                                    for (int i = approvedStartIndex; i < approvedEndIndex; i++) {
                                        ApplicationDetails approvedApp = approvedList.get(i);
                            %>
                            <tr>
                                <td><%= i + 1%></td>
                                <td><%= approvedApp.getStudName()%></td>
                                <td><%= approvedApp.getStudId()%></td>
                                <td><%= approvedApp.getApplyDate()%></td>
                                <td>
                                    <a href="<%= request.getContextPath()%>/cetakBorangServlet?stud_id=<%= approvedApp.getStudId()%>" class="text-decoration-none">
                                        <%=approvedApp.getStudId()%>_<%=approvedApp.getApplySession()%>.pdf
                                        <i class="bi bi-download download-icon"></i>
                                    </a>
                                </td>
                                <td>
                                    <form action="<%= request.getContextPath()%>/updateInterviewServlet" method="post" class="d-flex align-items-center">
                                        <input type="hidden" id="appID" name="appID" value="<%= approvedApp.getApplyId()%>"/>
                                        <input type="hidden" name="tab" value="<%= tab%>"> <!-- Preserve the current tab -->
                                        <input type="hidden" name="pages" value="<%= pages%>"> <!-- Preserve the current page -->
                                        <div class="d-flex justify-content-center">
                                            <input type="date" name="tarikhTemuduga" class="form-control" 
                                                   value="<%= (approvedApp.getInterviewDate() != null) ? approvedApp.getInterviewDate().toString() : ""%>" required>
                                        </div>
                                        <button type="submit" class="btn btn-danger btn-sm">Serah</button>
                                    </form>
                                </td>
                                <td>
                                    <form action="updateApplicationStatus" method="post">
                                        <input type="hidden" id="appID" name="appID" value="<%= approvedApp.getApplyId()%>"/> 
                                        <div class="select-box">
                                            <select name="selectedAction">
                                                <%
                                                    // Check if getUzswReview() is TRUE
                                                    if (approvedApp.getUzswReview() != null && approvedApp.getUzswReview().equalsIgnoreCase("TRUE")) {
                                                        // If TRUE, check getAppStatUZSW()
                                                        if ("LULUS".equalsIgnoreCase(approvedApp.getAppStatUZSW())) {
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
                                           <%= (approvedApp != null && approvedApp.getUzswReview() != null && approvedApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "checked" : ""%> 
                                           <%= (approvedApp.getUzswReview() != null && approvedApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                                </td>
                                <td>
                                    <button type="submit" class="btn btn-danger btn-sm" 
                                            <%= (approvedApp.getUzswReview() != null && approvedApp.getUzswReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
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
                        <li class="page-item <%= (approvedCurrentPage == 1) ? "disabled" : ""%>">
                            <a class="page-link" href="?tab=approved&approvedPage=<%= approvedCurrentPage - 1%>" tabindex="-1">Kembali</a>
                        </li>
                        <% for (int i = 1; i <= approvedTotalPages; i++) {%>
                        <li class="page-item <%= (i == approvedCurrentPage) ? "active" : ""%>">
                            <a class="page-link" href="?tab=approved&approvedPage=<%= i%>"><%= i%></a>
                        </li>
                        <% }%>
                        <li class="page-item <%= (approvedCurrentPage == approvedTotalPages) ? "disabled" : ""%>">
                            <a class="page-link" href="?tab=approved&approvedPage=<%= approvedCurrentPage + 1%>">Seterusnya</a>
                        </li>
                    </ul>
                </div>
                <div class="tab-pane fade <%= (tab.equals("search")) ? "show active" : ""%>" id="search" role="tabpanel" aria-labelledby="search-tab">
                    <%
                        int searchItemsPerPage = 6;
                        int searchCurrentPage = 1; // Default to the first page
                        String searchPageParam = request.getParameter("searchPage");
                        if (searchPageParam != null) {
                            try {
                                searchCurrentPage = Integer.parseInt(searchPageParam);
                            } catch (NumberFormatException e) {
                                searchCurrentPage = 1; // Reset to first page if invalid
                            }
                        }

                        List<ApplicationDetails> searchList = (List<ApplicationDetails>) session.getAttribute("searchList");
                        int searchCount = (searchList != null) ? searchList.size() : 0;
                        int searchTotalPages = (int) Math.ceil((double) searchCount / searchItemsPerPage);
                        int searchStartIndex = (searchCurrentPage - 1) * searchItemsPerPage;
                        int searchEndIndex = Math.min(searchStartIndex + searchItemsPerPage, searchCount);
                    %>
                    <form action="searchApp" method="get" class="d-flex align-items-center mb-3">
                        <input type="hidden" name="tab" value="search"> <!-- Ensure the tab parameter is set -->
                        <input type="hidden" name="pages" value="<%= pages%>"> <!-- Preserve the current page -->
                        <!-- Search Input with Icon -->
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-white border-right-0">
                                    <i class="bi bi-search"></i> 
                                </span>
                            </div>
                            <input type="text" name="query" id="searchInput" class="form-control border-left-0" placeholder="Nyatakan nama, no. pelajar, atau tarikh mohon">
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="btn btn-primary ml-2">Search</button>
                    </form>
                    <br>
                    <table class="table table-hover align-middle" id="approvedTable">
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
                                if (searchList != null && !searchList.isEmpty()) {
                                    for (int i = searchStartIndex; i < searchEndIndex; i++) {
                                        ApplicationDetails searchApp = searchList.get(i);
                            %>
                            <tr>
                                <td><%= i + 1%></td>
                                <td><%= searchApp.getStudName()%></td>
                                <td><%= searchApp.getStudId()%></td>
                                <td><%= searchApp.getApplyDate()%></td>
                                <td>
                                    <a href="#" class="text-decoration-none">
                                        <%= searchApp.getStudId()%>_<%=searchApp.getApplySession()%>.pdf
                                        <i class="bi bi-download download-icon"></i>
                                    </a>
                                </td>
                        <form action="updateApplicationStatus" method="post" 
                              <%= (searchApp.getHeaReview() != null && searchApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                            <td>
                                <input type="hidden" id="appID" name="appID" value="<%= searchApp.getApplyId()%>"/> 
                                <input type="hidden" name="tab" value="search"> <!-- Preserve the current tab -->
                                <input type="hidden" name="pages" value="<%= pages%>"> <!-- Preserve the current page -->
                                <div class="select-box">
                                    <select name="selectedAction" 
                                            <%= (searchApp.getHeaReview() != null && searchApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                                        <%
                                            // Check if getHeaReview() is TRUE
                                            if (searchApp.getHeaReview() != null && searchApp.getHeaReview().equalsIgnoreCase("TRUE")) {
                                                // If TRUE, check getHeaStatus()
                                                if ("LULUS".equalsIgnoreCase(searchApp.getAppStatHEA())) {
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
                                            if (searchApp.getApplyCgpa() <= 3.0) {
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
                                       <%= (searchApp != null && searchApp.getHeaReview() != null && searchApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "checked" : ""%> 
                                       <%= (searchApp.getHeaReview() != null && searchApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                            </td>
                            <td>
                                <button type="submit" class="btn btn-danger btn-sm" 
                                        <%= (searchApp.getHeaReview() != null && searchApp.getHeaReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
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
                        <li class="page-item <%= (searchCurrentPage == 1) ? "disabled" : ""%>">
                            <a class="page-link" href="?tab=search&searchPage=<%= searchCurrentPage - 1%>" tabindex="-1">Kembali</a>
                        </li>
                        <% for (int i = 1; i <= searchTotalPages; i++) {%>
                        <li class="page-item <%= (i == searchCurrentPage) ? "active" : ""%>">
                            <a class="page-link" href="?tab=search&searchPage=<%= i%>"><%= i%></a>
                        </li>
                        <% }%>
                        <li class="page-item <%= (searchCurrentPage == searchTotalPages) ? "disabled" : ""%>">
                            <a class="page-link" href="?tab=search&searchPage=<%= searchCurrentPage + 1%>">Seterusnya</a>
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
            <script>
                // Search function for Total tab
                function searchTotal() {
                    const input = document.getElementById("searchTotal").value.toLowerCase();
                    const rows = document.getElementById("totalTable").getElementsByTagName("tr");

                    for (let i = 0; i < rows.length; i++) {
                        const rowData = rows[i].textContent.toLowerCase();
                        rows[i].style.display = rowData.includes(input) ? "" : "none";
                    }
                }

                // Search function for Pending tab
                function searchPending() {
                    const input = document.getElementById("searchPending").value.toLowerCase();
                    const rows = document.getElementById("pendingTable").getElementsByTagName("tr");

                    for (let i = 0; i < rows.length; i++) {
                        const rowData = rows[i].textContent.toLowerCase();
                        rows[i].style.display = rowData.includes(input) ? "" : "none";
                    }
                }

                // Search function for Rejected tab
                function searchRejected() {
                    const input = document.getElementById("searchRejected").value.toLowerCase();
                    const rows = document.getElementById("rejectedTable").getElementsByTagName("tr");

                    for (let i = 0; i < rows.length; i++) {
                        const rowData = rows[i].textContent.toLowerCase();
                        rows[i].style.display = rowData.includes(input) ? "" : "none";
                    }
                }

                // Search function for Approved tab
                function searchApproved() {
                    const input = document.getElementById("searchApproved").value.toLowerCase();
                    const rows = document.getElementById("approvedTable").getElementsByTagName("tr");

                    for (let i = 0; i < rows.length; i++) {
                        const rowData = rows[i].textContent.toLowerCase();
                        rows[i].style.display = rowData.includes(input) ? "" : "none";
                    }
                }
            </script>
            <script>
                // Function to set the minimum date for all date inputs
                function setMinDate() {
                    const today = new Date().toISOString().split('T')[0]; // Get today's date in YYYY-MM-DD format
                    const dateInputs = document.querySelectorAll('input[type="date"]');

                    dateInputs.forEach(input => {
                        input.setAttribute('min', today); // Set the min attribute to today's date
                    });
                }

                // Call the function when the page loads
                window.onload = setMinDate;
            </script>
    </body>
</html>