<%@ page import="model.Refund" %>
<%@ page import="model.Tickets" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <title>SkyTicket - Refund Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/admin/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!-- simplebar -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/simplebar.css" rel="stylesheet" type="text/css"/>
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/remixicon.css" rel="stylesheet" type="text/css"/>
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <!-- Css -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt"/>

    <style>
        .btn-gradient {
            background: linear-gradient(45deg, #ff416c, #ff4b2b);
            color: white;
            border: none;
            transition: 0.3s;
        }
        .btn-gradient:hover {
            background: linear-gradient(45deg, #ff4b2b, #ff416c);
            transform: scale(1.05);
        }
        .error-message {
            color: red;
            font-size: 0.9em;
            display: none;
        }
    </style>
</head>

<body>
<!-- Loader -->
<div id="preloader">
    <div id="status">
        <div class="spinner">
            <div class="double-bounce1"></div>
            <div class="double-bounce2"></div>
        </div>
    </div>
</div>
<!-- Loader -->

<div class="page-wrapper doctris-theme toggled">
    <%@include file="right.jsp" %>

    <!-- Start Page Content -->
    <main class="page-content bg-light">
        <%@ include file="top.jsp" %>

        <div class="container-fluid">
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between">
                    <h5 class="mb-0">Add New Refund</h5>
                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/listRefund?action=list">Refunds</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Add Refund</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-lg-8 mt-4">
                        <div class="card border-0 p-4 rounded shadow">
                            <c:if test="${not empty msg}">
                                <div class="alert alert-success" role="alert">${msg}</div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">${error}</div>
                            </c:if>

                            <form class="mt-4" action="${pageContext.request.contextPath}/addRefund" method="post" onsubmit="return basicValidate()">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="name">Refund Id</label>
                                            <input name="name" id="name" type="text" class="form-control" placeholder="Refund Id" disabled>
                                        </div>
                                    </div><!--end col-->

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="ticketCode">Ticket Code</label>
                                            <input name="ticketCode" id="ticketCode" type="text" class="form-control" placeholder="Enter Ticket Code (e.g., TK004)">
                                            <span id="ticketCodeError" class="error-message">Ticket Code is required</span>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="BankAccount">Bank Account</label>
                                            <input name="BankAccount" id="BankAccount" class="form-control" placeholder="Enter Bank Account...">
                                            <span id="bankAccountError" class="error-message">Bank Account is required</span>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="BankName">Bank Name</label>
                                            <input name="BankName" id="BankName" class="form-control" placeholder="Enter Bank Name...">
                                            <span id="bankNameError" class="error-message">Bank Name is required</span>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="RequestDate">Request Date</label>
                                            <input type="date" name="RequestDate" id="RequestDate" class="form-control">
                                            <span id="requestDateError" class="error-message">Request Date is required</span>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="RefundDate">Refund Date</label>
                                            <input type="date" name="RefundDate" id="RefundDate" class="form-control">
                                            <span id="refundDateError" class="error-message">Refund Date must be after Request Date</span>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="RefundPrice">Refund Price</label>
                                            <input name="RefundPrice" id="RefundPrice" type="text" class="form-control" placeholder="Enter Refund Price">
                                            <span id="refundPriceError" class="error-message">Refund Price is required</span>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Status</label>
                                            <select class="form-control gender-name select2input" name="status">
                                                <option value="1">Pending</option>
                                                <option value="2" selected>Success</option>
                                                <option value="3">Failed</option>
                                            </select>
                                        </div>
                                    </div><!--end col-->
                                </div><!--end row-->

                                <button type="submit" class="btn btn-primary">Add Refund</button>
                                <button type="reset" class="btn btn-primary">Reset</button>
                            </form>
                        </div>
                    </div><!--end col-->

                    <div class="col-lg-4 mt-4">
                        <div class="card rounded border-0 shadow">
                            <div class="p-4 border-bottom d-flex align-items-center">
                                <i class="bi bi-pin-angle-fill text-danger me-2"></i>
                                <h5 class="mb-0">Note</h5>
                            </div>
                            <ul class="list-unstyled mb-0 p-4" data-simplebar style="height: 664px;">
                                <div>
                                    - Ticket Code must be valid (e.g., TK004).<br>
                                    - Bank Account: 8-20 digits, numbers only.<br>
                                    - Bank Name: Letters only, no numbers or special characters.<br>
                                    - Refund Date must be after Request Date.<br>
                                    - Refund Price must be a positive number.
                                    <hr>
                                </div>
                                <li class="mt-4 text-center">
                                    <a href="#" class="btn btn-gradient px-4 py-2 rounded-pill shadow">
                                        <i class="bi bi-heart-fill text-danger"></i> Thank you <3
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div><!--end row-->
            </div>
        </div><!--end container-->
        <%@include file="bottom.jsp" %>
    </main>
</div>

<!-- javascript -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/views/admin/assets/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/views/admin/assets/js/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/views/admin/assets/js/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/views/admin/assets/js/app.js"></script>

<script>
    setTimeout(function() {
        let alertBox = document.querySelector(".alert");
        if (alertBox) {
            alertBox.style.display = "none";
        }
    }, 5000);

    function basicValidate() {
        let isValid = true;
        document.querySelectorAll(".error-message").forEach(error => error.style.display = "none");

        let ticketCode = document.getElementById("ticketCode").value.trim();
        if (!ticketCode) {
            document.getElementById("ticketCodeError").style.display = "block";
            isValid = false;
        }

        let bankAccount = document.getElementById("BankAccount").value.trim();
        if (!bankAccount) {
            document.getElementById("bankAccountError").style.display = "block";
            isValid = false;
        }

        let bankName = document.getElementById("BankName").value.trim();
        if (!bankName) {
            document.getElementById("bankNameError").style.display = "block";
            isValid = false;
        }

        let requestDate = document.getElementById("RequestDate").value;
        if (!requestDate) {
            document.getElementById("requestDateError").style.display = "block";
            isValid = false;
        }

        let refundDate = document.getElementById("RefundDate").value;
        if (refundDate && requestDate && new Date(refundDate) <= new Date(requestDate)) {
            document.getElementById("refundDateError").style.display = "block";
            isValid = false;
        }

        let refundPrice = document.getElementById("RefundPrice").value.trim();
        if (!refundPrice) {
            document.getElementById("refundPriceError").style.display = "block";
            isValid = false;
        }

        return isValid;
    }
</script>
</body>
</html>