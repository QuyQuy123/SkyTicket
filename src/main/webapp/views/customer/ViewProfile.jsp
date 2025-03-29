<%--
  Created by IntelliJ IDEA.
  User: 84968
  Date: 2/12/2025
  Time: 4:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%-- Document : infor Created on : May 12, 2024, 9:59:46 PM Author : Admin --%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<%@page import="model.Accounts" %>
<%@page import="dal.RolesDAO" %>
<%
    RolesDAO rd = new RolesDAO();
    Accounts a = (Accounts) request.getAttribute("account");
%>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>Account Information</title>
    <link rel="shortcut icon" type="image/png" href="<%= request.getContextPath() %>/img/logo.jpg"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Infor.css"/>
    <script src="<%= request.getContextPath() %>/js/Validation.js"></script>
    <%--    <link rel="stylesheet" href="icon/themify-icons/themify-icons.css" />--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

</head>
<body>
<jsp:include page="/views/layout/Header.jsp"/>

<div class="row" id="info">
    <div class="col-md-6">
        <div id="info-banner">
            <div id="info-avatar">
                <img id="info-avatar-pic" src="${pageContext.request.contextPath}/views/customer/${requestScope.account.img}"/>
            </div>
        </div>

        <div id="info-in4">
            <strong>Full Name:</strong>
            <p>${requestScope.account.fullName}</p>
            <strong>Date of birth:</strong>
            <p>${requestScope.account.dob}</p>
            <strong>Email:</strong>
            <p>${requestScope.account.email}</p>
            <strong>Phone Number:</strong>
            <p>${requestScope.account.phone}</p>
            <strong>Address:</strong>
            <p>${requestScope.account.address}</p>

            <div class="info-buttons">
                <button class="btn btn-success" data-toggle="modal"
                        data-target="#myModal-${requestScope.account.getAccountId()}">Update profile
                </button>
                <button class="btn btn-danger" onclick="window.location.href = 'home'">Home</button>
            </div>
        </div>
    </div>
</div>


<div id="myModal-${requestScope.account.getAccountId()}" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title" style="font-weight:bold;">Update profile</h4>
            </div>
            <div class="modal-body">


                <form action="updateURL" method="post" onsubmit="return validateNameInput()" enctype="multipart/form-data">
                    <% String successMessage = (String) request.getAttribute("successMessage"); %>
                    <% if (successMessage != null) { %>
                    <div class="alert alert-success" style="color: green;">
                        <%= successMessage %>
                    </div>
                    <% } %>


                    <div class="row">
                        <div class="form-group col-md-6">
                            <label class="control-label">Avatar</label>
                            <%----%>

                            <img src="${pageContext.request.contextPath}/views/customer/${account.img!=null?account.img:'account-demo.jpg'}"
                                 class="avatar rounded shadow mt-3" height="250" width="250" alt="account ">
                            <input type="file" name="image" class="form-control">
                        </div>

                        <%--                        --%>
                    </div>
                    <input type="hidden" name="id" value="${requestScope.account.accountId}"/>
                    <!-- Full Name -->
                    <div class="form-group">
                        <label class="control-label">Full name:</label>
                        <%
                            java.util.Calendar calendar = java.util.Calendar.getInstance();
                            calendar.add(java.util.Calendar.YEAR, 0);
                            String maxDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
                        %>
                        <input type="text" name="name" value="${requestScope.account.fullName}" class="form-control"
                               pattern="^[\p{L}\s]+$" id="nameInput" required/>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Date of birth:</label>
                        <input type="date" name="birth" value="${requestScope.account.dob}" class="form-control"
                               required max="<%=maxDate%>" onkeydown="return false;"/>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Email:</label>
                        <input type="email" name="email" value="${requestScope.account.email}" class="form-control"
                               readonly=""/>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Phone number:</label>
                        <input type="text" name="phone" value="${requestScope.account.phone}" class="form-control"
                               pattern="^\d{10}$" required oninput="validatePhone(this)"/>
                    </div>
                    <div class="form-group">
                        <label class="control-label">Address:</label>
                        <textarea name="address" class="form-control" pattern="/^[\p{L}\s]+$"
                                  rows="3">${requestScope.account.address}</textarea>
                    </div>
                    <div class="form-group text-right">
                        <button type="submit" class="btn btn-success">Update</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    </div>
                </form>
            </div>
        </div>


    </div>
</div>
<script>

    document.addEventListener("DOMContentLoaded", function () {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('success')) {
            const modalId = "myModal-${requestScope.account.accountId}";
            $("#" + modalId).modal("show"); // Mở modal tự động
        }
    });


    function validateNameInput() {
        const nameInput = document.getElementById("nameInput").value.trim();

        if (nameInput === "") {
            alert("Please enter valid content. Do not enter spaces only.");
            return false;
        }
        return true;
    }


    document.getElementById('accountImg').addEventListener('change', function (event) {
        let reader = new FileReader();
        reader.onload = function () {
            document.getElementById('previewImage').src = reader.result;
        };
        reader.readAsDataURL(event.target.files[0]);
    });


</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>

