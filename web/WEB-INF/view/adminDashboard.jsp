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
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
    
            <a class="navbar-brand text-white" href="adminServlet?action=login">Admin Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <div class="ms-auto">
                  <a class="btn btn-light" 
   href="${pageContext.request.contextPath}/adminLogOutServlet" 
   role="button" 
   style="background-color: #6E1313; color: white; border: none;">
   Logout
</a>
   
                </div>
            </div>
        </div>
   
    </nav>
   
              <div class="welcome-container mb-4" style="margin-top: 10px;">
    <h1 class="fw-bold text-center">STAF TERKINI</h1>
</div>
     
   
   
   <div class="container-fluid mt-3">
    <div class="row mt-3 justify-content-center">
        <div class="col-md-3">
            <% 
            List<staff> HEAstaffList = (List<staff>) request.getAttribute("HEAstaffList");
            int HEAstaffCount = (HEAstaffList != null) ? HEAstaffList.size() : 0; 
            %>
            <div class="card text-center shadow-sm card-gradient">
                <div class="card-body">
                    <h5 class="card-title">Jumlah Staf HEA</h5>
                    <p class="card-text display-4" id="HEACount"><%= HEAstaffCount %></p>
                    <a href="adminServlet?action=viewHEAStaff&page=1" class="btn btn-primary">Lihat Staf</a>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <% 
            List<staff> HEPstaffList = (List<staff>) request.getAttribute("HEPstaffList");
            int HEPstaffCount = (HEPstaffList != null) ? HEPstaffList.size() : 0; 
            %>
            <div class="card text-center shadow-sm card-gradient">
                <div class="card-body">
                    <h5 class="card-title">Jumlah Staf HEP </h5>
                    <p class="card-text display-4" id="HEPCount"><%= HEPstaffCount %></p>
                    <a href="adminServlet?action=viewHEPStaff" class="btn btn-primary">Lihat Staf</a>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <% 
            List<staff> UZSWstaffList = (List<staff>) request.getAttribute("UZSWstaffList");
            int UZSWstaffCount = (UZSWstaffList != null) ? UZSWstaffList.size() : 0; 
            %>
            <div class="card text-center shadow-sm card-gradient">
                <div class="card-body">
                    <h5 class="card-title">Jumlah Staf UZSW</h5>
                    <p class="card-text display-4" id="UZSWCount"><%= UZSWstaffCount %></p>
                    <a href="adminServlet?action=viewUZSWStaff" class="btn btn-primary">Lihat Staf</a>
                </div>
            </div>
        </div>
    </div>
</div>

    </div>
  <footer  style="background-color: #522E5C; color: white; padding: 5px 0; position: fixed; bottom: 0; width: 100%;">
    <div class="text-center">
        <p style="margin: 0;">Copyright © 2024</p>
    </div>
</footer>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="script.js"></script>
</body>
</html>