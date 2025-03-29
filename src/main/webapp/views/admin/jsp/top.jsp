<%@ page import="model.Accounts" %>
<%@ page import="dal.AccountDAO" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/10/2025
  Time: 1:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Header.css">
</head>
<body>
<%
    Integer idAccount = (Integer)session.getAttribute("id");
    int i = (idAccount == null) ? -1 : idAccount;
    AccountDAO accountDAO = new AccountDAO();
    Accounts account = accountDAO.getAccountsById(i);
%>
<div class="top-header">
    <div class="header-bar d-flex justify-content-between border-bottom">
        <div class="d-flex align-items-center">
            <a href="#" class="logo-icon">
                <img src="../assets/images/logo-icon.png" height="30" class="small" alt="">
                <span class="big">
                                    <img src="../assets/images/logo-dark.png" height="24" class="logo-light-mode"
                                         alt="">
                                    <img src="../assets/images/logo-light.png" height="24" class="logo-dark-mode"
                                         alt="">
                                </span>
            </a>
            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                <i class="uil uil-bars"></i>
            </a>
            <div style="margin-left: 250px !important; font-weight: bold; color: #40c18b; text-transform: uppercase; font-size: 24px;">
                Welcome to the Admin Dashboard!
            </div>

        </div>

        <div class="auth-buttons">
            <% if (account != null) { %>
            <div class="account-header" style="position: relative; right: 54px">
                <img id="avatar-img" style="
                    width: 40px;
                    height: 38px;
                    object-fit: cover;
                    border-radius: 58px;
                    cursor: pointer;
                    margin-left: 92px;
            "
                     src="<%= request.getContextPath() %>/views/customer/<%= (account.getImg() != null && !account.getImg().isEmpty()) ? account.getImg() : "account-demo.jpg" %>"
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
                        <% if (account.getRoleId() == 1) { %>
                        <li><a href="<%= request.getContextPath() %>/dashboardAdmin">Manager</a></li>
                        <%}%>
                        <li><a href="changePaswordURL">Change Password</a></li>
                        <% if (account.getRoleId() == 1) { %>
                        <li><a href="ticketHistoryURL">Ticket History</a></li>
                        <%}%>
                        <li><a style="color: red;" href="LogoutURL">Log out</a></li>
                    </ul>
                </div>


            </div>
            <% } else { %>

            <% } %>
        </div>


    </div>
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
</body>
</html>
