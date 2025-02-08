<%-- 
    Document   : sidebar
    Created on : Feb 7, 2025, 10:32:05 PM
    Author     : nasru
--%>

<!-- sidebar.jsp -->
<div class="sidebar" style="height: 100vh; position: fixed; width: 250px; padding-top: 20px; background-color: #522E5C;">
    <h4 class="text-center" style="color: #F2EBDD; margin-bottom: 20px;">Navigation</h4>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link active" href="adminServlet?action=dashboard" style="color: #F2EBDD; padding: 10px 20px; transition: background-color 0.3s ease;">
                Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="adminServlet?action=viewHEAStaff" style="color: #F2EBDD; padding: 10px 20px; transition: background-color 0.3s ease;">
                HEA Staff
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="adminServlet?action=viewHEPStaff" style="color: #F2EBDD; padding: 10px 20px; transition: background-color 0.3s ease;">
                HEP Staff
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="adminServlet?action=viewUZSWStaff" style="color: #F2EBDD; padding: 10px 20px; transition: background-color 0.3s ease;">
                UZSW Staff
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/adminLogOutServlet" style="color: #F2EBDD; padding: 10px 20px; transition: background-color 0.3s ease;">
                Logout
            </a>
        </li>
    </ul>
</div>

<style>
    .sidebar {
        background-color: #522E5C; /* Dark purple background */
    }
    .sidebar .nav-link {
        color: #F2EBDD; /* Light beige text */
        padding: 10px 20px;
        transition: background-color 0.3s ease; /* Smooth hover effect */
    }
    .sidebar .nav-link:hover {
        background-color: #6E1313; /* Dark red on hover */
    }
    .sidebar .nav-link.active {
        background-color: #8B1A1A; /* Slightly lighter red for active link */
    }
    @media (max-width: 768px) {
        .sidebar {
            width: 100%; /* Full width on smaller screens */
            height: auto; /* Auto height on smaller screens */
            position: relative; /* Static position on smaller screens */
        }
        .sidebar .nav-link {
            text-align: center; /* Center align links on smaller screens */
        }
    }
</style>