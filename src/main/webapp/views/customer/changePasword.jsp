<%--
  Created by IntelliJ IDEA.
  User: 84968
  Date: 2/13/2025
  Time: 6:16 AM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="controller.EncodeController"%>
<%@page import="static controller.EncodeController.SECRET_KEY" %>
<%@page import="model.Accounts"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Change Password</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Login.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body{
            background-image: none !important;
        }

        label {
            font-weight: 500 !important
        }
        .toggle-password {
            cursor: pointer;
            position: absolute;
             left: 260px;
            top: 50%;
            transform: translateY(-50%);
        }
        .form-group {
            position: relative;
        }

    </style>
</head>
<body>
<jsp:include page="/views/layout/Header.jsp"/>

<%--<%--%>
<%--    EncodeController ec = new EncodeController();--%>
<%--%>--%>



<div style="margin: 107px 0;margin-left: 41%;">

    <form action="changePaswordURL" method="post" style="margin: 100px 0;width: 26%  ">
        <% String currentP = ((Accounts)request.getAttribute("account")).getPassword(); %>
        <input type="hidden" name="currentPassword" id="currentPassword" value="<%= currentP %>"/>
        <input type="hidden" name="idAccount" value="${requestScope.account.getAccountId()}"/>

        <p style="color: red; margin-left: -6%;">${error}</p>
        <p style="color: red; margin-left: -6%;">${errorNew}</p>

        <div class="form-group">
            <input type="password" name="pass" id="password" required />
            <label>Current password</label>
            <i class="fa fa-eye-slash toggle-password" onclick="togglePassword('password', this)"></i>
        </div>

        <div class="form-group">
            <input type="password" name="newPass" id="newPass" oninput="checkLengthNewPass()" required />
            <label>New password</label>
            <i class="fa fa-eye-slash toggle-password" onclick="togglePassword('newPass', this)"></i>
        </div>

        <div class="form-group">
            <input type="password" name="newPass2" id="newPass2" required />
            <label>New password again</label>
            <i class="fa fa-eye-slash toggle-password" onclick="togglePassword('newPass2', this)"></i>
        </div>

        <div id="errorPass" style="color: red; display: none;">Password must be more than 6 characters</div>
        <div class="button">
            <input id="submit" type="submit" value="Đổi mật khẩu" style="width: 100%;"/><br /><br />
        </div>
    </form>




</div>
<script>
    function checkLengthNewPass() {
        var newPass = document.getElementById("newPass").value;
        var errorPass = document.getElementById("errorPass");
        if (newPass.length < 6) {
            errorPass.style.display = "inline";
            submit.disabled = true;
        } else {
            errorPass.style.display = "none";
            submit.disabled = false;
        }
    }

    function togglePassword(inputId, icon) {
        let input = document.getElementById(inputId);
        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        } else {
            input.type = "password";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        }
    }


</script>
</body>
</html>