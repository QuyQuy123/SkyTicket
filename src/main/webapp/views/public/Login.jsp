
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Login Page</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Login.css">
</head>
<body>
<!--Header Bar here-->
<header>
    <jsp:include page="/views/layout/Header.jsp" />
</header>

<!--Login Box here-->
<div class="login-box">
    <div class="login-content">
        <form action="loginURL" method="POST">
            <h2>Đăng nhập</h2>
            <input type="text" class="login-input" name="username" autocomplete="off" placeholder="Email hoặc Tài khoản" required> <br>
            <input type="password" class="login-input" name="password" autocomplete="off" placeholder="Mật khẩu" required> <br>
            <input type="checkbox" class="checkbox" checked id="remember_me">
            <label for="remember_me">Ghi nhớ</label> <br>
            <input type="Submit" class="login-submit" value="Đăng nhập"> <br>
        </form>
        <h5>Bạn chưa có tài khoản? <a href="Register.jsp">Đăng ký ngay</a></h5>
        <a href="ResetPassword.jsp">Quên mật khẩu</a> <br><br>
    </div>
    <!--Login by Google-->
    <div class="login-by-google">
        <h4>Đăng nhập bằng Google</h4>
    </div>
</div>
<%--Footer here--%>
<jsp:include page="/views/layout/Footer.jsp"/>
</body>
</html>
