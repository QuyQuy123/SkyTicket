<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/10/2025
  Time: 1:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <title>SkyTicket - Airlines management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template"/>
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health"/>
    <meta name="author" content="Shreethemes"/>
    <meta name="email" content="support@shreethemes.in"/>
    <meta name="website" content="${pageContext.request.contextPath}/views/admin/jsp/Dashboard.jsp"/>
    <meta name="Version" content="v1.2.0"/>
    <!-- favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/admin/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <!-- simplebar -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/simplebar.css" rel="stylesheet" type="text/css"/>
    <!-- Select2 -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/select2.min.css" rel="stylesheet"/>
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/remixicon.css" rel="stylesheet" type="text/css"/>
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt"/>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
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

        <c:set var="airl" value="${airline}" />

        <div class="container-fluid">
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between">
                    <h5 class="mb-0">Update Airline ID: ${airl.airlineId}</h5>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/listAirlines">Airlines</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Update Airline</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-lg-8 mt-4">
                        <div class="card border-0 p-4 rounded shadow">
                            <c:if test="${not empty msg}">
                                <div style="color: green; font-weight: bold;">
                                        ${msg}
                                </div>
                            </c:if>
                            <c:if test="${not empty err}">
                                <div style="color: red; font-weight: bold;">
                                        ${err}
                                </div>
                            </c:if>

                            <form class="mt-4" action="${pageContext.request.contextPath}/updateAirline" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="airlineId" value="${airl.airlineId}">
                                <input type="hidden" name="oldImage" value="${airl.image}">

                                <div class="row align-items-center">
                                    <div class="col-lg-5 col-md-4">
                                        <img id="previewImage" src="${pageContext.request.contextPath}/img/${airl.image}"
                                             class="avatar rounded shadow mt-3" width="280" alt="Airline">
                                        <hr>
                                        <input type="file" name="airlineImage" id="airlineImage" class="form-control">
                                    </div><!--end col-->

                                    <div class="col-lg-7 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                        <h5 class="">Upload picture</h5>
                                        <p class="text-muted mb-0">For best results, use an image at least 600px by
                                            600px in either .jpg or .png format</p>
                                    </div><!--end col-->


                                </div><!--end row-->

                                <br>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="name">Airline Name<span class="text-danger">*</span> : </label>
                                            <input name="name" id="name" type="text"
                                                                             class="form-control"
                                                                             value="${airl.airlineName != null? airl.airlineName:''}">
                                        </div>
                                    </div><!--end col-->


                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="we">Status<span class="text-danger">*</span> :</label>
                                            <select class="form-control gender-name select2input" name="status" id="we">
                                                <option value="1" ${airl.status == 1 ? 'selected' : ''}>Active</option>
                                                <option value="0" ${airl.status == 0 ? 'selected' : ''}>Deactive</option>
                                            </select>
                                        </div>
                                    </div><!--end col-->

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="vipRow">Number of seats on Vip row<span class="text-danger">*</span> : </label>
                                            <input name="numberOfSeatsOnVipRow" id="vipRow"
                                                   type="number" min="1" max="4"
                                                   class="form-control"
                                                   value="${airl.numberOfSeatsOnVipRow != null? airl.numberOfSeatsOnVipRow:''}">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="vipCol">Number of seats on Vip column<span class="text-danger">*</span> : </label>
                                            <input name="numberOfSeatsOnVipColumn" id="vipCol"
                                                   type="number" min="1" max="10"
                                                   class="form-control"
                                                   value="${airl.numberOfSeatsOnVipColumn != null? airl.numberOfSeatsOnVipColumn:''}">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="ecoRow">Number of seats on Economy row<span class="text-danger">*</span> : </label>
                                            <input name="numberOfSeatsOnEcoRow"
                                                   id="ecoRow" type="number"
                                                   min="1" max="10"
                                                   class="form-control"
                                                   value="${airl.numberOfSeatsOnEconomyRow != null? airl.numberOfSeatsOnEconomyRow:''}">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="ecoCol">Number of seats on Economy column<span class="text-danger">*</span> : </label>
                                            <input name="numberOfSeatsOnEcoColumn"
                                                   id="ecoCol" type="number"
                                                   min="10" max="50"
                                                   class="form-control"
                                                   value="${airl.numberOfSeatsOnEconomyColumn != null? airl.numberOfSeatsOnEconomyColumn:''}">
                                        </div>
                                    </div>


                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label class="form-label" for="information">Airline information</label>
                                            <textarea name="information" id="information" rows="3" class="form-control">${airl.information != null ? airl.information : ''}</textarea>

                                        </div>
                                    </div>
                                </div><!--end row-->

                                <button type="submit" class="btn btn-primary">Update airline</button>
                                <a href="${pageContext.request.contextPath}/listAirlines" class="btn btn-danger">Cancel</a>
                            </form>
                        </div>
                    </div><!--end col-->

                    <div class="col-lg-4 mt-4">
                        <div class="card rounded border-0 shadow">
                            <div class="p-4 border-bottom d-flex align-items-center">
                                <i class="bi bi-pin-angle-fill text-danger me-2"></i> <!-- Biểu tượng Note -->
                                <h5 class="mb-0">Note</h5>
                            </div>

                            <ul class="list-unstyled mb-0 p-4" data-simplebar style="height: 664px;">
                                <div>
                                    Airline name must be ...
                                    <hr>
                                    Capacity of class VIP must be...
                                    <hr>
                                    Capacity of class economy must be...
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
    <!--End page-content" -->
</div>
<!-- page-wrapper -->


<!-- javascript -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/views/admin/assets/js/bootstrap.bundle.min.js"></script>
<!-- simplebar -->
<script src="${pageContext.request.contextPath}/views/admin//assets/js/simplebar.min.js"></script>
<!-- Select2 -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/select2.min.js"></script>
<script src="${pageContext.request.contextPath}/views/admin/assets/js/select2.init.js"></script>
<!-- Icons -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/feather.min.js"></script>
<!-- Main Js -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/app.js"></script>

<script>
    document.getElementById('airlineImage').addEventListener('change', function (event) {
        let reader = new FileReader();
        reader.onload = function () {
            document.getElementById('previewImage').src = reader.result;
        };
        reader.readAsDataURL(event.target.files[0]);
    });
</script>

</body>
</html>
