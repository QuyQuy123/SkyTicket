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
                    <h5 class="mb-0">Add New Airline</h5>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item"><a href="viewListAirlines.jsp">Airlines</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Add Airline</li>
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

                            <form class="mt-4" action="${pageContext.request.contextPath}/addAirline" method="post" enctype="multipart/form-data">
                                <div class="row align-items-center">
                                    <div class="col-lg-5 col-md-4">
                                        <img id="previewImage" src="${pageContext.request.contextPath}/views/admin/assets/images/doctors/demo_img.jpg"
                                             class="avatar rounded shadow mt-3" width="280" alt="Airline Image">
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
                                            <label class="form-label">Airline Name: </label>
                                            <label for="name"></label><input name="name" id="name" type="text"
                                                                             class="form-control"
                                                                             placeholder="Airline name">
                                        </div>
                                    </div><!--end col-->


                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Status</label>
                                            <select class="form-control gender-name select2input" name="status">
                                                <option value="1">Active</option>
                                                <option value="0" selected>Deactive</option>
                                            </select>
                                        </div>
                                    </div><!--end col-->

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Capacity Class Vip: </label>
                                            <label for="classVip"></label><input name="classVip" id="classVip"
                                                                                 type="number" min="10" max="50"
                                                                                 class="form-control"
                                                                                 placeholder="Number of seat Vip">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Capacity Class Economy: </label>
                                            <label for="classEconomy"></label><input name="classEconomy"
                                                                                     id="classEconomy" type="number"
                                                                                     min="10" max="50"
                                                                                     class="form-control"
                                                                                     placeholder="Number of seats economy">
                                        </div>
                                    </div>


                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label class="form-label">Airline information</label>
                                            <label for="information"></label><textarea name="information"
                                                                                       id="information" rows="3"
                                                                                       class="form-control"
                                                                                       placeholder="Infor"></textarea>
                                        </div>
                                    </div>
                                </div><!--end row-->

                                <button type="submit" class="btn btn-primary">Add airline</button>
                                <button type="reset" class="btn btn-primary">Reset</button>
                            </form>
                        </div>
                    </div><!--end col-->

                    <div class="col-lg-4 mt-4">
                        <div class="card rounded border-0 shadow">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Doctors List</h5>
                            </div>

                            <ul class="list-unstyled mb-0 p-4" data-simplebar style="height: 664px;">
                                <li class="d-md-flex align-items-center text-center text-md-start">
                                    <img src="../assets/images/doctors/01.jpg"
                                         class="avatar avatar-medium rounded-md shadow" alt="">

                                    <div class="ms-md-3 mt-4 mt-sm-0">
                                        <a href="#" class="text-dark h6">Dr. Calvin Carlo</a>
                                        <p class="text-muted my-1">Cardiologist</p>
                                        <p class="text-muted mb-0">3 Years Experienced</p>
                                    </div>
                                </li>

                                <li class="d-md-flex align-items-center text-center text-md-start mt-4">
                                    <img src="../assets/images/doctors/02.jpg"
                                         class="avatar avatar-medium rounded-md shadow" alt="">

                                    <div class="ms-md-3 mt-4 mt-sm-0">
                                        <a href="#" class="text-dark h6">Dr. Alex Smith</a>
                                        <p class="text-muted my-1">Dentist</p>
                                        <p class="text-muted mb-0">1 Years Experienced</p>
                                    </div>
                                </li>

                                <li class="d-md-flex align-items-center text-center text-md-start mt-4">
                                    <img src="../assets/images/doctors/03.jpg"
                                         class="avatar avatar-medium rounded-md shadow" alt="">

                                    <div class="ms-md-3 mt-4 mt-sm-0">
                                        <a href="#" class="text-dark h6">Dr. Cristina Luly</a>
                                        <p class="text-muted my-1">Orthopedic</p>
                                        <p class="text-muted mb-0">5 Years Experienced</p>
                                    </div>
                                </li>

                                <li class="d-md-flex align-items-center text-center text-md-start mt-4">
                                    <img src="../assets/images/doctors/04.jpg"
                                         class="avatar avatar-medium rounded-md shadow" alt="">

                                    <div class="ms-md-3 mt-4 mt-sm-0">
                                        <a href="#" class="text-dark h6">Dr. Dwayen Maria</a>
                                        <p class="text-muted my-1">Gastrologist</p>
                                        <p class="text-muted mb-0">2 Years Experienced</p>
                                    </div>
                                </li>

                                <li class="d-md-flex align-items-center text-center text-md-start mt-4">
                                    <img src="../assets/images/doctors/05.jpg"
                                         class="avatar avatar-medium rounded-md shadow" alt="">

                                    <div class="ms-md-3 mt-4 mt-sm-0">
                                        <a href="#" class="text-dark h6">Dr. Jenelia Focia</a>
                                        <p class="text-muted my-1">Psychotherapist</p>
                                        <p class="text-muted mb-0">3 Years Experienced</p>
                                    </div>
                                </li>

                                <li class="mt-4">
                                    <a href="doctors.html" class="btn btn-primary">All Doctors</a>
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
