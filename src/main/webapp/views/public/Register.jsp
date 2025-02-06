
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
        <form action="login" method="POST">
            <h2>Đăng ký</h2>
            <input type="text" class="login-input" name="username" autocomplete="off" placeholder="Tài khoản" required>
            <input type="text" class="login-input" name="email" autocomplete="off" placeholder="Email" required> <br>
            <input type="password" class="login-input" name="password" autocomplete="off" placeholder="Mật khẩu" required> <br>
            <input type="password" class="login-input" name="rePassword" autocomplete="off" placeholder="Nhập lại mật khẩu" required> <br>

            <input type="Submit" class="login-submit" value="Đăng ký"> <br>
        </form>
        <h5>Bạn đã có tài khoản? <a href="Login.jsp">Đăng nhập ngay</a></h5>
    </div>
    <!--Login by Google-->
    <div class="login-by-google">
        <h4>Đăng ký bằng Google</h4>
    </div>
</div>
<%--Footer here--%>
<jsp:include page="/views/layout/Footer.jsp"/>
</body>
</html>
