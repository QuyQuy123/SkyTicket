<%@ page import="model.Accounts" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Header.css">

</head>
<body>
<header class="header">
    <%
        Accounts account = (Accounts) request.getAttribute("account");
    %>


    <a href="<%= request.getContextPath() %>" style="text-decoration: none;">
        <div class="logo" style="cursor: pointer;">
            <img src="<%= request.getContextPath() %>/img/logo.jpg" alt="Online Booking">
            <span>Sky <span class="highlight">Ticket</span></span>
        </div>
    </a>


    <nav class="nav">
        <a href="home">TRANG CHỦ</a>
        <a href="IntroURL">GIỚI THIỆU</a>
        <a href="NewsURL">TIN TỨC</a>
        <a href="home#contactSection">LIÊN HỆ</a>

    </nav>


    <div class="auth-buttons">
        <% if (account != null) { %>
        <!-- Nếu người dùng đã đăng nhập, hiển thị tên và nút đăng xuất -->
        <div class="account-header">
            <div style="background-color: #0dcaf0" id="header-avatar" class="">
<%--                <img class="" src="<%=account.getImg()%>" alt="">--%>

            </div>

            <span style="color: red">Xin chào, <%=account.getFullName() %>!</span>
            <button class="btn-logout" onclick="location.href='<%= request.getContextPath() %>/LogoutURL'">Đăng xuất
            </button>

            <ul id="header-subnav" style="display: none;">
                <li><a href="#">Account Information</a></li>
                <li><a href="#">Change Password</a></li>
                <li><a style="color: red;" href="LogoutURL">Log out</a></li>
            </ul>


            <% } else { %>
            <!-- Nếu người dùng chưa đăng nhập, hiển thị nút đăng nhập và đăng ký -->
            <button class="btn-login" onclick="location.href='<%= request.getContextPath() %>/LoginURL'">Đăng nhập</button>
            <button class="btn-register" onclick="location.href='<%= request.getContextPath() %>/RegisterURL'">Đăng ký
            </button>

        </div>
        <% } %>


    </div>








    <style>
        .auth-buttons {
            /*display: flex;*/
            gap: 10px; /* Khoảng cách giữa hai nút */
        }
        .auth-buttons span {
            font-weight: bold;
            color: #333;
            font-size: 16px;
        }


        .auth-buttons .btn-login,
        .auth-buttons .btn-register,.btn-logout
        {
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

        .auth-buttons {
            display: flex;
            align-items: center;
            gap: 15px; /* Tăng khoảng cách giữa chữ và nút */
        }

        /* Chữ "Xin chào, ..." */
        .auth-buttons span {
            font-weight: bold;
            color: #333;
            font-size: 16px;
        }

        /* Nút Đăng xuất */
        .auth-buttons .btn-logout {
            padding: 8px 16px;
            font-size: 14px;
            border: none;
            border-radius: 20px;
            background-color: #d9534f; /* Màu đỏ nhẹ */
            color: white;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        /* Hiệu ứng hover */
        .auth-buttons .btn-logout:hover {
            background-color: #c9302c; /* Màu đậm hơn khi hover */
            transform: scale(1.05); /* Phóng to nhẹ */
        }



    </style>
</header>

</body>
</html>
