<%-- Document : register Created on : May 12, 2024, 5:49:30 PM Author : Admin
--%> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Reset Password</title>
    <link rel="shortcut icon" type="image/jpg" href="<%= request.getContextPath() %>/img/logo.jpg" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Login.css" type="text/css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">

</head>
<body>
<div class="container">
    <h1 style="margin-bottom: 30px">
        Reset Password<a
            style="
                    float: right;
                    font-size: 25px;
                    margin-top: 8px;
                    text-decoration: none;
                    color: rgb(71, 143, 192);
                    "
            href="home"
    ><i class="ti-home"></i
    ></a>
    </h1>

    <div>
        <a href="home" style="position: relative; left: -30px; top: -99px; transition: none; cursor: pointer;">
            <i style="font-size: 20px;color: #3c6e57;" class="bi bi-house"></i>
        </a>
    </div>
    <form action="<%= request.getContextPath() %>/ResetPasswordURL" method="post">
        <div class="form-group">
            <input type="email" name="email" required />
            <label >Your email:</label>

        </div>
        <p id="capslock-warning" style="display: none; margin-bottom: 30px">⚠️ Caps Lock is on</p>
        <h5 style="color: red">${requestScope.error}</h5><br>
        <div class="button">
            <input id="submit" type="submit" value="Continue" /><br /><br />
        </div>
        Did you remember the password? <a class="letDoIt" href="LoginURL">Login</a>
    </form>
</div>
<script>
    var p = document.getElementById("password");
    var cp = document.getElementById("confirmPassword");
    var text = document.getElementById("capslock-warning");

    function CapsCheck(event) {
        if (event.getModifierState("CapsLock")) {
            text.style.display = "block";
        } else {
            text.style.display = "none";
        }
    }

    p.addEventListener("keyup", CapsCheck);
    cp.addEventListener("keyup", CapsCheck);

</script>

</body>
</html>