
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
        <form action="#" method="POST">
            <h2>Đặt lại mật khẩu</h2>
            <input type="text" class="login-input" name="email" autocomplete="off" placeholder="Email" required> <br>
            <input type="text" class="login-input, reset-code" name="resetCode" autocomplete="off" placeholder="Mã xác thực" required>
            <input type="submit" class="reset-submit" value="Gửi" name="sendEmail" /> <br>
            <input type="password" class="login-input" name="password" autocomplete="off" placeholder="Mật khẩu" required> <br>
            <input type="password" class="login-input" name="repassword" autocomplete="off" placeholder="Nhập lại mật khẩu" required> <br>
            <input type="Submit" class="login-submit" value="Đặt lại"> <br><br><br>
        </form>
        <a href="<%= request.getContextPath() %>/views/public/Login.jsp">Quay lại</a>
    </div>
</div>
<%--Footer here--%>
<jsp:include page="/views/layout/Footer.jsp"/>
</body>
</html>
