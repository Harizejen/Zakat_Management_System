<%-- 
    Document   : newjsp
    Created on : Dec 15, 2024, 1:14:18 AM
    Author     : MY PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Permohonan Table</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
               body {
            background-color: #f8f9fa;
            font-size: 14px;
               }
           .main-container {
            background-color: #F6EEE1;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 0 auto;
            max-width: 1200px;
        }


        header {
            background-color: #001f4d;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }

        .notification-bell {
            margin-right: 20px;
            cursor: pointer;
        }

        .notification-bell i {
            font-size: 18px;
        }

        header a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }

        .table-container {
            margin: 20px auto;
            width: 90%;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background-color: #f8f9fa;
        }

        th, td {
            text-align: left;
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        
        .name-container {
            display: flex;
            align-items: center;
        }

        .circle {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #f4f0ff;
            color: #8c50ff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-right: 10px;
        }

        .download-icon {
            margin-left: 10px;
            color: #555;
            cursor: pointer;
            transition: color 0.3s;
        }

        .download-icon:hover {
            color: #000;
        }

        .status-container {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .status-circle {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
        }

        .approved {
            background-color: #28a745; /* Green for approved */
        }

        .waiting {
            background-color: #ffc107; /* Yellow for waiting */
        }

        .rejected {
            background-color: #dc3545; /* Red for rejected */
        }

        .status-text {
            font-size: 14px;
            color: #333;
        }

        button {
            background-color: #6E1313;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #6E1313;
        }

        select {
            padding: 6px;
            border-radius: 4px;
            border: 1px solid #ddd;
             }

        /* Pagination styles */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            padding: 10px 0;
        }

        .pagination button {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            padding: 6px 12px;
            margin: 0 4px;
            cursor: pointer;
            border-radius: 4px;
        }

        .pagination button:hover {
            background-color: #ddd;
        }

        .pagination .active {
            background-color: #28a745;
            color: white;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="notification-bell">
            <i class="fa-solid fa-bell"></i>
        </div>
        <a href="#">Log Keluar</a>
    </header>

    <!-- Table -->
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Bil</th>
                    <th>Disemak</th>
                    <th>Nama</th>
                    <th>No. Pelajar</th>
                    <th>Tarikh Mohon</th>
                    <th>Borang</th>
                    <th>Status</th>
                    <th>Tindakan</th>
                </tr>
            </thead>
            <tbody>
                <!-- Row 1 -->
                <tr>
                    <td>1</td>
                    <td><input type="checkbox"></td>
                    <td>
                        <div class="name-container">
                            <div class="circle">AA</div>
                            <div>Aris Aidil Bin Baharuddin</div>
                        </div>
                    </td>
                    <td>2023******</td>
                    <td>01/01/2025</td>
                    <td>
                        2023******_MAC250G00525.pdf
                        <span class="download-icon" title="Download">
                            <i class="fa-solid fa-cloud-arrow-down"></i>
                        </span>
                    </td>
                    <td>
                        <div class="status-container">
                            <span class="status-circle approved"></span>
                            <span class="status-text">Disahkan</span>
                        </div>
                    </td>
                    <td>
                        <select>
                             <option>Pilih</option>
                            <option>Disahkan</option>
                            <option>Disemak</option>
                             <option>Diluluskan</option>
                        </select>
                        <button>Serah</button>
                    </td>
                </tr>
                <!-- Row 2 -->
                <tr>
                    <td>2</td>
                    <td><input type="checkbox"></td>
                    <td>
                        <div class="name-container">
                            <div class="circle">AM</div>
                            <div>Ahmad Amirul Naim Bin Kamal</div>
                        </div>
                    </td>
                    <td>2023******</td>
                    <td>11/01/2025</td>
                    <td>
                        2023******_MAC250G00525.pdf
                        <span class="download-icon" title="Download">
                            <i class="fa-solid fa-cloud-arrow-down"></i>
                        </span>
                    </td>
                    <td>
                        <div class="status-container">
                            <span class="status-circle waiting"></span>
                            <span class="status-text">Menunggu</span>
                        </div>
                    </td>
                    <td>
                        <select>
                             <option>Pilih</option>
                             <option>Disahkan</option>
                            <option>Disemak</option>
                             <option>Diluluskan</option>
                        </select>
                        <button>Serah</button>
                    </td>
                </tr>
                <!-- Row 3 -->
                <tr>
                    <td>3</td>
                    <td><input type="checkbox"></td>
                    <td>
                        <div class="name-container">
                            <div class="circle">FH</div>
                            <div>Farah Sofea Binti Fasrul Hisham</div>
                        </div>
                    </td>
                    <td>2023******</td>
                    <td>12/02/2025</td>
                    <td>
                        2023******_MAC250G00525.pdf
                        <span class="download-icon" title="Download">
                            <i class="fa-solid fa-cloud-arrow-down"></i>
                        </span>
                    </td>
                    <td>
                        <div class="status-container">
                            <span class="status-circle rejected"></span>
                            <span class="status-text">Ditolak</span>
                        </div>
                    </td>
                    <td>
                        <select>
                             <option>Pilih</option>
                            <option>Disahkan</option>
                            <option>Disemak</option>
                             <option>Diluluskan</option>
                        </select>
                        <button>Serah</button>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <!-- Pagination -->
        <div class="pagination">
            <button class="prev">« Prev</button>
            <button class="active">1</button>
            <button>2</button>
            <button>3</button>
            <button class="next">Next »</button>
        </div>
    </div>

    <script>
        // Handle pagination click events
        const paginationButtons = document.querySelectorAll('.pagination button');
        paginationButtons.forEach(button => {
            button.addEventListener('click', (e) => {
                const currentButton = e.target;
                const pageNumber = currentButton.textContent;
                if (pageNumber !== 'Prev' && pageNumber !== 'Next') {
                    paginationButtons.forEach(btn => btn.classList.remove('active'));
                    currentButton.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>
