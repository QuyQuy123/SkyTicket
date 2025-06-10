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
        <% if (account!= null) { %>
        <div class="account-header" style="position: relative; right: 54px">
            <img id="avatar-img" style="
                    width: 40px;
                    height: 38px;
                    object-fit: cover;
                    border-radius: 58px;
                    cursor: pointer;
                    margin-left: 92px;
            " src="<%= request.getContextPath() %>/views/customer/<%= (account.getImg() != null && !account.getImg().isEmpty()) ? account.getImg() : "account-demo.jpg" %>"
                   alt="User">

            <div class="account-infor">
                <ul id="header-subnav" style="
                    display: none;
                    position: absolute;
                    top: 100%;
                    left: 50px;
                    background: white;
                    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
                    border-radius: 8px;
                    padding: 10px;
                    min-width: 178px;
                    z-index: 100;
                    margin-top: 2px;
            ">
                    <li><a href="Infor">Account Information</a></li>
                    <% if(account.getRoleId()==1){ %>
                    <li><a href="<%= request.getContextPath() %>/dashboardAdmin">Manager</a></li>
                    <%}%>
                    <li><a href="changePaswordURL">Change Password</a></li>
                    <% if(account.getRoleId()==2){ %>
                    <li><a href="ticketHistoryURL?status=<%= account.getStatus() %>">Ticket History</a></li>
                    <%}%>
                    <li><a style="color: red;" href="LogoutURL">Log out</a></li>
                </ul>
            </div>


        </div>
        <% } else { %>
        <button class="btn-login" onclick="location.href='<%= request.getContextPath() %>/LoginURL'">Đăng nhập</button>
        <button class="btn-register" onclick="location.href='<%= request.getContextPath() %>/RegisterURL'">Đăng ký</button>
        <% } %>
    </div>


    <script>
        document.getElementById("avatar-img").addEventListener("click", function (event) {
            event.stopPropagation(); // Ngăn chặn sự kiện lan ra ngoài
            var menu = document.getElementById("header-subnav");
            menu.style.display = (menu.style.display === "none" || menu.style.display === "") ? "block" : "none";
        });

        // Ẩn menu khi click ra ngoài
        document.addEventListener("click", function (event) {
            var menu = document.getElementById("header-subnav");
            if (menu.style.display === "block") {
                menu.style.display = "none";
            }
        });
    </script>


</header>

</body>
</html>
