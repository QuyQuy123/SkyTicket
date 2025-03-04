<%--
  Created by IntelliJ IDEA.
  User: 84968
  Date: 3/4/2025
  Time: 1:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Set New Password</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Login.css" type="text/css" />
</head>
<body>
<div class="container">
    <h1>Set New Password</h1>
    <form action="<%= request.getContextPath() %>/UpdatePasswordURL" method="post">
        <div class="form-group">
            <input type="password" name="newPassword" required />
            <label>New Password:</label>
        </div>
        <div class="form-group">
            <input type="password" name="confirmPassword" required />
            <label>Confirm Password:</label>
        </div>
        <h5 style="color: red">${requestScope.error}</h5><br>
        <div class="button">
            <input id="submit" type="submit" value="Update Password" /><br /><br />
        </div>
    </form>
</div>
</body>
</html>
