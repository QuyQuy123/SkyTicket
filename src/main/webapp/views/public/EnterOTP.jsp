<%--
  Created by IntelliJ IDEA.
  User: 84968
  Date: 3/4/2025
  Time: 1:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Enter OTP</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Login.css" type="text/css" />

</head>
<body>
<div class="container">
    <h1 style="padding: 57px;
    padding-top: 10px;">Nhập OTP</h1>
    <p style="margin-bottom: 26px;color: red">Vui lòng nhập OTP được gửi đến email của bạn.</p>
    <form action="<%= request.getContextPath() %>/VerifyOTPURL" method="post">
        <div class="form-group">
            <input type="text" name="otp" required />
            <label>OTP:</label>
        </div>
        <h5 style="color: red">${requestScope.error}</h5><br>
        <div class="button">
            <input id="submit" type="submit" value="Verify OTP" /><br /><br />
        </div>
    </form>
</div>
</body>
</html>
