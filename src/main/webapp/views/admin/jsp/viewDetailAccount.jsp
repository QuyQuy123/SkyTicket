<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    </style>
</head>

<body>

<div class="page-wrapper doctris-theme toggled">
    <%@ include file="right.jsp"%>

    <c:set var="ac" value="${account}" />

    <!-- Start Page Content -->
    <main class="page-content bg-light">
        <%@include file="top.jsp"%>

        <div class="container-fluid">
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between">
                    <h5 class="mb-0">Update Account ID: ${ac.accountId}</h5>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/views/admin/jsp/Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/manageAccount?action=view">List Accounts</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Update Account</li>
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

                            <form class="mt-4" action="${pageContext.request.contextPath}/manageAccount?action=update" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="accountId" value="${ac.accountId}">
                                <input type="hidden" name="oldImage" value="${ac.img}">

                                <div class="row align-items-center">
                                    <div class="col-lg-5 col-md-4">
                                        <img src="${pageContext.request.contextPath}/img/${ac.img!=null?ac.img:''}"
                                             class="avatar rounded shadow mt-3" height="250" width="250" alt="Account Lyly " >
                                        <hr>
                                    </div><!--end col-->

                                </div> <!--end row-->

                                <br>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="fullName">Full Name: </label>
                                            <input name="fullName" id="fullName" type="text"
                                                   class="form-control"
                                                   placeholder="Enter your name" value="${ac.fullName!=null?ac.fullName:''}" disabled>
                                        </div>
                                    </div>


                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="dob">Date of birth: </label>
                                            <input type="date" name="dob" id="dob"
                                                   class="form-control" value="${ac.dob!=null?ac.dob:''}" disabled>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="email">Email: </label>
                                            <input name="email" id="email" type="text"
                                                   class="form-control"
                                                   placeholder="Enter your email" value="${ac.email!=null?ac.email:''}" disabled>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="password">Password: </label>
                                            <input name="password" id="password" type="text"
                                                   class="form-control"
                                                   placeholder="" value="" disabled>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="phone">Phone: </label>
                                            <input name="phone" id="phone" type="text"
                                                   class="form-control"
                                                   placeholder="Phone number" value="${ac.phone!=null?ac.phone:''}" disabled>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="address">Address: </label>
                                            <input name="address" id="address" type="text"
                                                   class="form-control"
                                                   placeholder="Enter your address" value="${ac.address!=null?ac.address:''}" disabled>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="status">Status</label>
                                            <select class="form-control gender-name select2input" name="status" id="status" disabled>
                                                <option value="1" ${ac.status == 1 ? 'selected' : ''} >Active</option>
                                                <option value="0" ${ac.status == 0 ? 'selected' : ''} >Deactive</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="roleId">Role: </label>

                                            <select class="form-control gender-name select2input" name="roleId" id="roleId" disabled>
                                                <c:forEach var="role" items="${rolesList}">
                                                    <option value="${role.roleId}" ${param.roleId == role.roleId?'selected' : ''} >${role.roleName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>



                                </div> <!--end row-->

                                <a  class="btn btn-primary" href="${pageContext.request.contextPath}/manageAccount?action=view">Back</a>
                            </form>
                        </div>
                    </div> <!--end col-->

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
                                        <i class="bi bi-heart-fill text-danger"> </i> Thank you <3
                                    </a>
                                </li>
                            </ul>
                        </div>



                    </div>
                </div> <!--end row-->
            </div>
        </div> <!--end container-->

        <!-- Footer Start -->
        <%@ include file="bottom.jsp"%>
        <!-- End -->
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


</body>

</html>