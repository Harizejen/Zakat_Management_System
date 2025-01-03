<%@page import="java.util.List"%>
<%@page import="com.staff.model.staff"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/admin_dashboard.css">
    <title>Admin Dashboard</title>
</head>
<body>
    <!-- Top Navigation Bar -->
    <nav class="navbar navbar-expand-lg" style="background-color: #007bff;"> <!-- Change color here -->
        <div class="container-fluid">
            <a class="navbar-brand text-white" href="#">Admin Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="ms-auto">
                    <a class="btn btn-light" href="${pageContext.request.contextPath}/adminLogOutServlet" role="button">Logout</a>
                </div>
            </div>
        </div>
    </nav>
                
                

    <div class="container-fluid mt-4">
        <div class="row mt-4">
            <div class="col-md-4">
                <% 
                List<staff> HEAstaffList = (List<staff>) request.getAttribute("HEAstaffList");
                int HEAstaffCount = (HEAstaffList != null) ? HEAstaffList.size() : 0; 
                %>
                <div class="card text-center shadow-sm card-gradient">
                    <div class="card-body">
                        <h5 class="card-title">Total HEA Staff</h5>
                        <p class="card-text display-4" id="HEACount"><%= HEAstaffCount %></p>
                        <a href="adminServlet?action=viewHEAStaff" class="btn btn-primary">View Staff</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <% 
                List<staff> HEPstaffList = (List<staff>) request.getAttribute("HEPstaffList");
                int HEPstaffCount = (HEPstaffList != null) ? HEPstaffList.size() : 0; 
                %>
                <div class="card text-center shadow-sm card-gradient">
                    <div class="card-body">
                        <h5 class="card-title">Total HEP Staff</h5>
                        <p class="card-text display-4" id="HEPCount"><%= HEPstaffCount %></p>
                        <a href="adminServlet?action=viewHEPStaff" class="btn btn-primary">View Staff</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <% 
                List<staff> UZSWstaffList = (List<staff>) request.getAttribute("UZSWstaffList");
                int UZSWstaffCount = (UZSWstaffList != null) ? UZSWstaffList.size() : 0; 
                %>
                <div class="card text-center shadow-sm card-gradient">
                    <div class="card-body">
                        <h5 class="card-title">Total UZSW Staff</h5>
                        <p class="card-text display-4" id="UZSWCount"><%= UZSWstaffCount %></p>
                        <a href="adminServlet?action=viewUZSWStaff" class="btn btn-primary">View Staff</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="mt-5">
        <div class="text-center">
            <p>Copyright © 2024</p>
        </div>
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="script.js"></script>
</body>
</html>