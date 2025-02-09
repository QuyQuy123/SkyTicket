
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
        <form action="LoginURL" method="POST">
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
    <div>
        <!-- Thêm Google Sign-In -->
        <script src="https://accounts.google.com/gsi/client" async defer></script>

        <!-- Button đăng nhập Google -->
        <div id="g_id_onload"
             data-client_id="777755283447-02f7nd81cid717l83hhcuofjrq3f08og.apps.googleusercontent.com"
<%--             Edit url --%>
             data-login_uri="<%= request.getContextPath() %>/views/public/Home.jsp"
             data-auto_prompt="false">
        </div>

        <div class="g_id_signin"
             data-type="standard"
             data-size="large">
        </div>
    </div>
</div>
<%--Footer here--%>
<jsp:include page="/views/layout/Footer.jsp"/>
</body>
</html>
