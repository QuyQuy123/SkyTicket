
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Reset Password Page</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Login.css">
</head>
<body>
<!--Header Bar here-->
<header>
    <jsp:include page="/views/layout/Header.jsp" />
</header>

<!--Reset Password Box here-->
<div class="login-box">
    <div class="login-content">
        <h2>Đặt lại mật khẩu</h2>
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null) { %>
        <p style="color: green;"><%= message %></p>
        <% } %>
        <form action="<%= request.getContextPath() %>/ResetPassordURL" method="POST">
            <input type="email" class="login-input, reset-email" name="email" autocomplete="off" placeholder="Email" required>
            <input type="submit" class="reset-submit" value="Gửi mã" name="sendEmail" /> <br>
            <h20 class="reset-label">(*) Hãy nhập email để chúng tôi sẽ gửi cho bạn một mã xác thực!</h20>
        </form>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <p style="color: red;"><%= error %></p>
        <% } %>
        <form action="#" method="POST">
            <br><br>
            <input type="text" class="login-input" name="resetCode" autocomplete="off" placeholder="Mã xác thực" required> <br>
            <input type="password" class="login-input" name="password" autocomplete="off" placeholder="Mật khẩu mới" required> <br>
            <input type="password" class="login-input" name="repassword" autocomplete="off" placeholder="Nhập lại mật khẩu" required> <br>
            <input type="submit" class="login-submit" value="Đặt lại mật khẩu"> <br>
        </form>
        <br><br>
        <a href="<%= request.getContextPath() %>/LoginURL">Quay lại</a>
    </div>
</div>
<%--Footer here--%>
<jsp:include page="/views/layout/Footer.jsp"/>
</body>
</html>
