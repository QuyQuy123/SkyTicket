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
    <style>
        .form-group {
            position: relative;
        }
        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            width: 20px;
            height: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 style="padding: 37px; padding-top: 10px;">Set New Password</h1>
    <form action="<%= request.getContextPath() %>/UpdatePasswordURL" method="post">
        <div class="form-group">
            <input type="password" name="newPassword" id="newPassword" required />
            <label>New Password:</label>
            <img src="https://cdn-icons-png.flaticon.com/512/159/159604.png"
                 class="toggle-password"
                 onclick="togglePassword('newPassword')"
                 alt="eye icon">
        </div>
        <div class="form-group">
            <input type="password" name="confirmPassword" id="confirmPassword" required />
            <label>Confirm Password:</label>
            <img src="https://cdn-icons-png.flaticon.com/512/159/159604.png"
                 class="toggle-password"
                 onclick="togglePassword('confirmPassword')"
                 alt="eye icon">
        </div>
        <h5 style="color: red">${requestScope.error}</h5><br>
        <div class="button">
            <input id="submit" type="submit" value="Update Password" /><br /><br />
        </div>
    </form>
</div>

<script>
    function togglePassword(inputId) {
        var input = document.getElementById(inputId);
        if (input.type === "password") {
            input.type = "text";
        } else {
            input.type = "password";
        }
    }
</script>

</body>
</html>