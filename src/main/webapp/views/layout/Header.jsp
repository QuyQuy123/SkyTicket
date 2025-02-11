<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Header.css">
</head>
<body>
<header class="header">


    <a href="<%= request.getContextPath() %>" style="text-decoration: none;">
        <div class="logo" style="cursor: pointer;">
            <img src="<%= request.getContextPath() %>/img/logo.jpg" alt="Online Booking">
            <span>Sky <span class="highlight">Ticket</span></span>
        </div>
    </a>


    <nav class="nav">
        <a href="<%= request.getContextPath() %>">TRANG CHỦ</a>
        <a href="IntroURL">GIỚI THIỆU</a>
<%--        <a href="#">VÉ NỘI ĐỊA</a>--%>
<%--        <a href="#">VÉ QUỐC TẾ</a>--%>
        <a href="NewsURL">TIN TỨC</a>
        <a href="home#contactSection">LIÊN HỆ</a>

    </nav>
    <!-- Thay phần contact bằng 2 nút -->


    <%
        // Lấy tên người dùng từ session
        String username = (String) session.getAttribute("username");
    %>


    <div class="auth-buttons">
        <% if (username != null) { %>
        <!-- Nếu người dùng đã đăng nhập, hiển thị tên và nút đăng xuất -->
        <span>Xin chào, <%= username %>!</span>
        <button class="btn-logout" onclick="location.href='<%= request.getContextPath() %>/logout.jsp'">Đăng xuất
        </button>
        <% } else { %>
        <!-- Nếu người dùng chưa đăng nhập, hiển thị nút đăng nhập và đăng ký -->
        <button class="btn-login" onclick="location.href='<%= request.getContextPath() %>/views/public/Login.jsp'">Đăng nhập</button>
        <button class="btn-register" onclick="location.href='<%= request.getContextPath() %>/views/public/Register.jsp'">Đăng ký
        </button>
        <% } %>
    </div>


    <style>
        .auth-buttons {
            /*display: flex;*/
            gap: 10px; /* Khoảng cách giữa hai nút */
        }


        .auth-buttons .btn-login,
        .auth-buttons .btn-register {
            padding: 10px 20px; /* Kích thước nút */
            font-size: 14px;
            border: none;
            border-radius: 25px; /* Bo tròn góc */
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s; /* Hiệu ứng mượt */;
        }


        .auth-buttons .btn-login {
            background-color: #f0ad4e; /* Màu nền gốc cho nút Đăng nhập */
            color: white;
        }


        .auth-buttons .btn-register {
            background-color: #5bc0de; /* Màu nền gốc cho nút Đăng ký */
            color: white;
        }


        /* Hiệu ứng khi rê chuột */
        .auth-buttons .btn-login:hover {
            background-color: #ec971f; /* Màu nền khi rê chuột vào nút Đăng nhập */
            transform: scale(1.05); /* Phóng to nhẹ */
        }


        .auth-buttons .btn-register:hover {
            background-color: #31b0d5; /* Màu nền khi rê chuột vào nút Đăng ký */
            transform: scale(1.05); /* Phóng to nhẹ */
        }


    </style>
</header>






</body>
</html>
