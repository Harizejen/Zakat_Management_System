<%@page import="java.sql.*"%>
<%@page import="com.database.dbconn"%>
<%@page import="java.util.List"%>
<%@page import="com.ApplicationDetails.model.ApplicationDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "total"; // Default tab
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hal Ehwal Pelajar</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="css/stf.css">
        <link rel="stylesheet" href="css/staffDashboard.css"> 


    </head>
    <body>

        <!-- Navigation Bar -->
        <nav class="navbar text-light mb-3" style="background-color: #112C55">
            <div class="container-fluid d-flex align-items-center">
                <a href="goHEPDashboard" class="btn btn-outline-light me-3">
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
        </nav>

        <!-- Main Container -->
        <div class="container">
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
                            id="rejected-tab" data-bs-toggle="tab" data-bs-target="#search" 
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
                        <span>Jumlah Keseluruhan Permohonan Yang Diterima: <span class="jumlah-count"><%= totalCount%></span></span>
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
                        <form action="updateApplicationStatus" method="post" 
                              <%= (totalApp.getHepReview() != null && totalApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                            <td>
                                <input type="hidden" id="appID" name="appID" value="<%= totalApp.getApplyId()%>"/> 
                                <div class="select-box">
                                    <select name="selectedAction" 
                                            <%= (totalApp.getHepReview() != null && totalApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                                        <%
                                            // Check if getHepReview() is TRUE
                                            if (totalApp.getHepReview() != null && totalApp.getHepReview().equalsIgnoreCase("TRUE")) {
                                                // If TRUE, check getHepStatus()
                                                if ("LULUS".equalsIgnoreCase(totalApp.getAppStatHEP())) {
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
                                            // If getHepReview() is null, use total salary to determine selection
                                            if (totalApp.getGuardIncome() + totalApp.getMotherIncome() + totalApp.getFatherIncome() >= 5000) {
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
                                       <%= (totalApp != null && totalApp.getHepReview() != null && totalApp.getHepReview().equalsIgnoreCase("TRUE")) ? "checked" : ""%> 
                                       <%= (totalApp.getHepReview() != null && totalApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> required>
                            </td>
                            <td>
                                <button type="submit" class="btn btn-danger btn-sm" 
                                        <%= (totalApp.getHepReview() != null && totalApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
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
                        <li class="page-item <%= (currentPage == 1) ? "disabled" : ""%>">
                            <a class="page-link" href="?totalPage=<%= currentPage - 1%>&tab=total" tabindex="-1">Kembali</a>
                        </li>
                        <% for (int i = 1; i <= totalPages; i++) {%>
                        <li class="page-item <%= (i == currentPage) ? "active" : ""%>">
                            <a class="page-link" href="?totalPage=<%= i%>&tab=total"><%= i%></a>
                        </li>
                        <% }%>
                        <li class="page-item <%= (currentPage == totalPages) ? "disabled" : ""%>">
                            <a class="page-link" href="?totalPage=<%= currentPage + 1%>&tab=total">Seterusnya</a>
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
                                    <form action="updateApplicationStatus" method="post" class="d-flex align-items-center"> 
                                        <%= (pendingApp.getHepReview() != null && pendingApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%>

                                        <input type="hidden" id="appID" name="appID" value="<%= pendingApp.getApplyId()%>"/> 
                                        <div class="select-box">
                                            <select name="selectedAction" 
                                                    <%= (pendingApp.getHepReview() != null && pendingApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                                                    <%
                                                        // Check if getHepReview() is TRUE
                                                        if (pendingApp.getHepReview() != null && pendingApp.getHepReview().equalsIgnoreCase("TRUE")) {
                                                            // If TRUE, check getHepStatus()
                                                            if ("LULUS".equalsIgnoreCase(pendingApp.getAppStatHEP())) {
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
                                                    // If getHepReview() is null, use salary to determine selection
                                                    if (pendingApp.getGuardIncome() + pendingApp.getMotherIncome() + pendingApp.getFatherIncome() >= 5000) {
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
                                           <%= (pendingApp != null && pendingApp.getHepReview() != null && pendingApp.getHepReview().equalsIgnoreCase("TRUE")) ? "checked" : ""%> 
                                           <%= (pendingApp.getHepReview() != null && pendingApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                                </td>
                                <td>
                                    <button type="submit" class="btn btn-danger btn-sm" 
                                            <%= (pendingApp.getHepReview() != null && pendingApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
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
                        <li class="page-item <%= (pendingCurrentPage == 1) ? "disabled" : ""%>">
                            <a class="page-link" href="?pendingPage=<%= pendingCurrentPage - 1%>&tab=pending" tabindex="-1">Kembali</a>
                        </li>
                        <% for (int i = 1; i <= pendingTotalPages; i++) {%>
                        <li class="page-item <%= (i == pendingCurrentPage) ? "active" : ""%>">
                            <a class="page-link" href="?pendingPage=<%= i%>&tab=pending"><%= i%></a>
                        </li>
                        <% }%>
                        <li class="page-item <%= (pendingCurrentPage == pendingTotalPages) ? "disabled" : ""%>">
                            <a class="page-link" href="?pendingPage=<%= pendingCurrentPage + 1%>&tab=pending">Seterusnya</a>
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
                        <form action="updateApplicationStatus" method="post" 
                              <%= (rejectedApp.getHepReview() != null && rejectedApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                            <td>
                                <input type="hidden" id="appID" name="appID" value="<%= rejectedApp.getApplyId()%>"/> 
                                <div class="select-box">
                                    <select name="selectedAction" 
                                            <%= (rejectedApp.getHepReview() != null && rejectedApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                                        <%
                                            // Check if getHepReview() is TRUE
                                            if (rejectedApp.getHepReview() != null && rejectedApp.getHepReview().equalsIgnoreCase("TRUE")) {
                                                // If TRUE, check getHepStatus()
                                                if ("LULUS".equalsIgnoreCase(rejectedApp.getAppStatHEP())) {
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
                                            // If getHepReview() is null, use CGPA to determine selection
                                            if (rejectedApp.getGuardIncome() + rejectedApp.getMotherIncome() + rejectedApp.getFatherIncome() >= 5000) {
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
                                       <%= (rejectedApp != null && rejectedApp.getHepReview() != null && rejectedApp.getHepReview().equalsIgnoreCase("TRUE")) ? "checked" : ""%> 
                                       <%= (rejectedApp.getHepReview() != null && rejectedApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                            </td>
                            <td>
                                <button type="submit" class="btn btn-danger btn-sm" 
                                        <%= (rejectedApp.getHepReview() != null && rejectedApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
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
                        <li class="page-item <%= (rejectedCurrentPage == 1) ? "disabled" : ""%>">
                            <a class="page-link" href="?rejectedPage=<%= rejectedCurrentPage - 1%>&tab=rejected" tabindex="-1">Kembali</a>
                        </li>
                        <% for (int i = 1; i <= rejectedTotalPages; i++) {%>
                        <li class="page-item <%= (i == rejectedCurrentPage) ? "active" : ""%>">
                            <a class="page-link" href="?rejectedPage=<%= i%>&tab=rejected"><%= i%></a>
                        </li>
                        <% }%>
                        <li class="page-item <%= (rejectedCurrentPage == rejectedTotalPages) ? "disabled" : ""%>">
                            <a class="page-link" href="?rejectedPage=<%= rejectedCurrentPage + 1%>&tab=rejected">Seterusnya</a>
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
                        <form action="updateApplicationStatus" method="post" 
                              <%= (approvedApp.getHepReview() != null && approvedApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                            <td>
                                <input type="hidden" id="appID" name="appID" value="<%= approvedApp.getApplyId()%>"/> 
                                <div class="select-box">
                                    <select name="selectedAction" 
                                            <%= (approvedApp.getHepReview() != null && approvedApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                                        <%
                                            // Check if getHepReview() is TRUE
                                            if (approvedApp.getHepReview() != null && approvedApp.getHepReview().equalsIgnoreCase("TRUE")) {
                                                // If TRUE, check getHepStatus()
                                                if ("LULUS".equalsIgnoreCase(approvedApp.getAppStatHEP())) {
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
                                            // If getHePReview() is null, use CGPA to determine selection
                                            if (approvedApp.getGuardIncome() + approvedApp.getMotherIncome() + approvedApp.getFatherIncome() >= 5000) {
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
                                       <%= (approvedApp != null && approvedApp.getHepReview() != null && approvedApp.getHepReview().equalsIgnoreCase("TRUE")) ? "checked" : ""%> 
                                       <%= (approvedApp.getHepReview() != null && approvedApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
                            </td>
                            <td>
                                <button type="submit" class="btn btn-danger btn-sm" 
                                        <%= (approvedApp.getHepReview() != null && approvedApp.getHepReview().equalsIgnoreCase("TRUE")) ? "disabled" : ""%> >
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
                        <li class="page-item <%= (approvedCurrentPage == 1) ? "disabled" : ""%>">
                            <a class="page-link" href="?approvedPage=<%= approvedCurrentPage - 1%>&tab=approved" tabindex="-1">Kembali</a>
                        </li>
                        <% for (int i = 1; i <= approvedTotalPages; i++) {%>
                        <li class="page-item <%= (i == approvedCurrentPage) ? "active" : ""%>">
                            <a class="page-link" href="?approvedPage=<%= i%>&tab=approved"><%= i%></a>
                        </li>
                        <% }%>
                        <li class="page-item <%= (approvedCurrentPage == approvedTotalPages) ? "disabled" : ""%>">
                            <a class="page-link" href="?approvedPage=<%= approvedCurrentPage + 1%>&tab=approved">Seterusnya</a>
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
                            <a class="page-link" href="?searchPage=<%= searchCurrentPage - 1%>&tab=search" tabindex="-1">Kembali</a>
                        </li>
                        <% for (int i = 1; i <= searchTotalPages; i++) {%>
                        <li class="page-item <%= (i == searchCurrentPage) ? "active" : ""%>">
                            <a class="page-link" href="?searchPage=<%= i%>&tab=search"><%= i%></a>
                        </li>
                        <% }%>
                        <li class="page-item <%= (searchCurrentPage == searchTotalPages) ? "disabled" : ""%>">
                            <a class="page-link" href="?searchPage=<%= searchCurrentPage + 1%>&tab=search">Seterusnya</a>
                        </li>
                    </ul>
                </div> 
            </div> 



            <!-- Logout Confirmation Modal -->
            <div class="modal fade" id="logoutModal" tabindex="-1" aria-labelledby="logoutModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content text-center" style="background-color: #112C55; color: white;">
                        <!-- Modal Body -->
                        <div class="modal-body py-4">
                            <h5 id="logoutModalLabel" class="mb-4">Adakah anda ingin keluar?</h5>
                            <!-- Buttons -->
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
            <script src="https://code.jquery.com/jquery-3. 5.1.slim.min.js"></script>

            <script>
                            function updateDropdown(index, action) {
                                document.getElementById('selectedAction' + index).value = action;
                            }
            </script>
            <!-- Search Functionality -->
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
                <%
                    String errorMessage = (String) session.getAttribute("error");
                    if (errorMessage != null) {
                        // Clear the error message from the session after displaying it
                        session.removeAttribute("error");
                %>
                alert('<%= errorMessage%>');
                <%
                    }
                %>

                // Check if there is a success message in the session
                <%
                    String successMessage = (String) session.getAttribute("success");
                    if (successMessage != null) {
                        // Clear the success message from the session after displaying it
                        session.removeAttribute("success");
                %>
                alert('<%= successMessage%>');
                <%
                    }
                %>
            </script>
    </body>
</html>
