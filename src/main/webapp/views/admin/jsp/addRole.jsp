<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<%@ page import="javax.management.relation.Role" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <title>Skyticket - Add Role</title>
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
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/remixicon.css" rel="stylesheet" type="text/css"/>
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
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
    <%@include file="right.jsp"%>
    <!-- sidebar-wrapper  -->

    <!-- Start Page Content -->
    <main class="page-content bg-light">
        <%@include file="top.jsp"%>

        <div class="container-fluid">
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between">
                    <h5 class="mb-0">Add New Role</h5>
                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/views/admin/jsp/Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/rolesSearch">Roles</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Add Role</li>
                        </ul>
                    </nav>
                </div>

                <!-- Form và Note -->
                <div class="row">
                    <div class="col-lg-8 mt-4">
                        <div class="card border-0 p-4 rounded shadow">
                            <!-- Hiển thị thông báo nếu có -->
                            <c:if test="${not empty msg}">
                                <div class="alert alert-${msgType} alert-dismissible fade show" role="alert">
                                        ${msg}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </c:if>

                            <!-- Form thêm Role -->
                            <form class="mt-4" action="${pageContext.request.contextPath}/addRole" method="post">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label fw-semibold text-dark" for="roleId">Role ID</label>
                                            <input name="roleId" id="roleId" type="text" class="form-control" placeholder="Role ID" disabled>
                                        </div>
                                    </div><!--end col-->

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label fw-semibold text-dark" for="roleName">Name of Role</label>
                                            <input name="roleName" id="roleName" type="text" class="form-control" placeholder="Enter name of role...">
                                        </div>
                                    </div><!--end col-->
                                </div><!--end row-->

                                <!-- Nút Add và Reset -->
                                <div class="d-flex gap-2 mt-3">
                                    <button type="submit" class="btn btn-primary px-4">Add Role</button>
                                    <button type="reset" class="btn btn-outline-secondary px-4">Reset</button>
                                </div>
                            </form>
                        </div>
                    </div><!--end col-->

                    <div class="col-lg-4 mt-4">
                        <div class="card rounded border-0 shadow">
                            <div class="p-4 border-bottom d-flex align-items-center">
                                <i class="bi bi-pin-angle-fill text-danger me-2 fs-5"></i>
                                <h5 class="mb-0 text-dark">Note</h5>
                            </div>

                            <div class="p-4">
                                <p class="text-muted mb-3">
                                    <strong>Instructions:</strong><br>
                                    - Name of role must be unique and descriptive.<br>
                                    - Avoid using special characters or spaces.<br>
                                    - Role names should be between 3 and 50 characters.
                                </p>
                                <hr>
                                <p class="text-muted">
                                    For more details, please refer to the <a href="#" class="text-primary">Role Management Guide</a>.
                                </p>

                                <div class="text-center mt-4">
                                    <a href="#" class="btn btn-gradient px-4 py-2 rounded-pill shadow">
                                        <i class="bi bi-heart-fill text-danger"></i> Thank you <3
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end layout-specing-->
        </div><!--end container-->

        <!-- Footer Start -->
        <footer class="bg-light py-3 mt-auto">
            <div class="container-fluid text-center">
                <p class="mb-0 text-muted">2025 © SkyTicket. Fly with love by duybo.</p>
            </div>
        </footer>
        <!-- Footer End -->
    </main>
    <!--End page-content-->
</div>
<!-- page-wrapper -->

<!-- javascript -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/views/admin/assets/js/bootstrap.bundle.min.js"></script>
<!-- simplebar -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/simplebar.min.js"></script>
<!-- Icons -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/feather.min.js"></script>
<!-- Main Js -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/app.js"></script>
<script>
    setTimeout(function() {
        let alertBox = document.querySelector(".alert");
        if (alertBox) {
            alertBox.style.display = "none";
        }
    }, 5000);
</script>

</body>
</html>