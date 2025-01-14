<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link rel=" stylesheet" href="${pageContext.request.contextPath}/css/success.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pemohonan Berjaya</title>
    </head>
    <body>
        <div class="notification-box">
            <div class="notification-header">
                <img alt="Logo" height="24" src="${pageContext.request.contextPath}/images/logo_system.png" width="24"/>
                <h5>Notifikasi</h5>
                <a style="color: black" href="<%= request.getContextPath()%>/user.do?action=profile"><i class="fas fa-times"></i></a>
            </div>
            <div class="notification-body">
                <p>PERMOHONAN ANDA BERJAYA!</p>
                <p>TUNGGU ARAHAN SELANJUTNYA SETELAH PERMOHONAN SELESAI DIPROSES!</p>
            </div>
            <div class="notification-footer">
                <button class="btn btn-outline-danger" onclick="window.location.href='<%= request.getContextPath() %>/cetakBorangServlet'">
                    CETAK PERMOHONAN
                </button>
                <button class="btn btn-danger">
                    <a href="<%= request.getContextPath()%>/user.do?action=profile">LAMAN UTAMA</a>
                </button>
            </div>
        </div>
        <div class="footer-text">
            @copyRight2020
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
    </body>
</html>