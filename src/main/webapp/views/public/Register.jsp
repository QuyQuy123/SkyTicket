
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Register Page</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Login.css">
</head>
<body>
<!--Header Bar here-->
<header>
    <jsp:include page="/views/layout/Header.jsp" />
</header>

<!--Register Box here-->
<div class="login-box">
    <div class="login-content">
        <h2>Đăng ký</h2>
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <p style="color: red;"><%= error %></p>
        <% } %>
        <form action="<%= request.getContextPath() %>/RegisterURL" method="POST">
            <input type="text" class="login-input" name="name" autocomplete="off" placeholder="Họ và tên" required>
            <input type="date" class="login-input" name="dob" autocomplete="off" required>
            <input type="number" class="login-input" name="phone" autocomplete="off" placeholder="Số điện thoại" required>
            <input type="text" class="login-input" name="email" autocomplete="off" placeholder="Email" required> <br>
            <input type="password" class="login-input" name="password" autocomplete="off" placeholder="Mật khẩu" required> <br>
            <input type="password" class="login-input" name="rePassword" autocomplete="off" placeholder="Nhập lại mật khẩu" required> <br>

            <input type="Submit" class="login-submit" value="Đăng ký"> <br>
        </form>
        <h5>Bạn đã có tài khoản? <a href="<%= request.getContextPath() %>/LoginURL">Đăng nhập ngay</a></h5>
    </div>
</div>
<%--Footer here--%>
<jsp:include page="/views/layout/Footer.jsp"/>
</body>
</html>
