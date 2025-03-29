<%--
 Created by IntelliJ IDEA.
 User: Administrator
 Date: 2/8/2025
 Time: 4:11 PM
 To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="utf-8"/>
    <title>SkyTicket - Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template"/>
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health"/>
    <meta name="author" content="Shreethemes"/>
    <meta name="email" content="support@shreethemes.in"/>

    <meta name="Version" content="v1.2.0"/>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/admin/assets/images/favicon.ico.png"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/simplebar.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/select2.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/remixicon.css" rel="stylesheet" type="text/css"/>
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/tiny-slider.css" rel="stylesheet"/>
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
    <%@ include file="right.jsp"%>


    <!-- Start Page Content -->
    <main class="page-content bg-light">


        <%@ include file="top.jsp"%>


        <div class="container-fluid">
            <div class="layout-specing">
                <h5 class="mb-0">Dashboard</h5>


                <div class="row">
                    <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                        <div class="card features feature-primary rounded border-0 shadow p-4">
                            <div class="d-flex align-items-center">
                                <div class="icon text-center rounded-md">
                                    <i class="uil uil-bed h3 mb-0"></i>
                                </div>
                                <div class="flex-1 ms-2">
                                    <h5 class="mb-0">558</h5>
                                    <p class="text-muted mb-0">Patients</p>
                                </div>
                            </div>
                        </div>
                    </div><!--end col-->


                    <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                        <div class="card features feature-primary rounded border-0 shadow p-4">
                            <div class="d-flex align-items-center">
                                <div class="icon text-center rounded-md">
                                    <i class="uil uil-file-medical-alt h3 mb-0"></i>
                                </div>
                                <div class="flex-1 ms-2">
                                    <h5 class="mb-0">$2164</h5>
                                    <p class="text-muted mb-0">Avg. costs</p>
                                </div>
                            </div>
                        </div>
                    </div><!--end col-->


                    <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                        <div class="card features feature-primary rounded border-0 shadow p-4">
                            <div class="d-flex align-items-center">
                                <div class="icon text-center rounded-md">
                                    <i class="uil uil-social-distancing h3 mb-0"></i>
                                </div>
                                <div class="flex-1 ms-2">
                                    <h5 class="mb-0">112</h5>
                                    <p class="text-muted mb-0">Staff Members</p>
                                </div>
                            </div>
                        </div>
                    </div><!--end col-->


                    <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                        <div class="card features feature-primary rounded border-0 shadow p-4">
                            <div class="d-flex align-items-center">
                                <div class="icon text-center rounded-md">
                                    <i class="uil uil-ambulance h3 mb-0"></i>
                                </div>
                                <div class="flex-1 ms-2">
                                    <h5 class="mb-0">16</h5>
                                    <p class="text-muted mb-0">Vehicles</p>
                                </div>
                            </div>


                        </div>
                    </div><!--end col-->


                    <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                        <div class="card features feature-primary rounded border-0 shadow p-4">
                            <div class="d-flex align-items-center">
                                <div class="icon text-center rounded-md">
                                    <i class="uil uil-medkit h3 mb-0"></i>
                                </div>
                                <div class="flex-1 ms-2">
                                    <h5 class="mb-0">220</h5>
                                    <p class="text-muted mb-0">Appointment</p>
                                </div>
                            </div>
                        </div>
                    </div><!--end col-->


                    <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                        <div class="card features feature-primary rounded border-0 shadow p-4">
                            <div class="d-flex align-items-center">
                                <div class="icon text-center rounded-md">
                                    <i class="uil uil-medical-drip h3 mb-0"></i>
                                </div>
                                <div class="flex-1 ms-2">
                                    <h5 class="mb-0">10</h5>
                                    <p class="text-muted mb-0">Operations</p>
                                </div>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->


                <div class="row">
                    <div class="col-xl-8 col-lg-7 mt-4">
                        <div class="card shadow border-0 p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h6 class="align-items-center mb-0">Patients visit by Gender</h6>


                                <div class="mb-0 position-relative">
                                    <select class="form-select form-control" id="yearchart">
                                        <option selected>2020</option>
                                        <option value="2019">2019</option>
                                        <option value="2018">2018</option>
                                    </select>
                                </div>
                            </div>
                            <div id="dashboard" class="apex-chart"></div>
                        </div>
                    </div><!--end col-->


                    <div class="col-xl-4 col-lg-5 mt-4">
                        <div class="card shadow border-0 p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h6 class="align-items-center mb-0">Patients by Department</h6>


                                <div class="mb-0 position-relative">
                                    <select class="form-select form-control" id="dailychart">
                                        <option selected>Today</option>
                                        <option value="2019">Yesterday</option>
                                    </select>
                                </div>
                            </div>
                            <div id="department" class="apex-chart"></div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->


            </div>
        </div><!--end container-->


        <%@ include file="bottom.jsp"%>
        <!-- End -->
    </main>

</div>
<!-- page-wrapper -->


<!-- Offcanvas Start -->
<div class="offcanvas offcanvas-end bg-white shadow" tabindex="-1" id="offcanvasRight"
     aria-labelledby="offcanvasRightLabel">
    <div class="offcanvas-header p-4 border-bottom">
        <h5 id="offcanvasRightLabel" class="mb-0">
            <img src="${pageContext.request.contextPath}/views/admin/assets/images/logo-dark.png" height="24" class="light-version" alt="">
            <img src="${pageContext.request.contextPath}/views/admin/assets/images/logo-light.png" height="24" class="dark-version" alt="">
        </h5>
        <button type="button" class="btn-close d-flex align-items-center text-dark" data-bs-dismiss="offcanvas"
                aria-label="Close"><i class="uil uil-times fs-4"></i></button>
    </div>
    <div class="offcanvas-body p-4 px-md-5">
        <div class="row">
            <div class="col-12">
                <!-- Style switcher -->
                <div id="style-switcher">
                    <div>
                        <ul class="text-center list-unstyled mb-0">
                            <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light"
                                                  onclick="setTheme('style-rtl')"><img
                                    src="${pageContext.request.contextPath}/views/admin/assets/images/layouts/light-dash-rtl.png"
                                    class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                    class="text-muted mt-2 d-block">RTL Version</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light"
                                                  onclick="setTheme('style')"><img
                                    src="${pageContext.request.contextPath}/views/admin/assets/images/layouts/light-dash.png"
                                    class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                    class="text-muted mt-2 d-block">LTR Version</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark"
                                                  onclick="setTheme('style-dark-rtl')"><img
                                    src="${pageContext.request.contextPath}/views/admin/assets/images/layouts/dark-dash-rtl.png"
                                    class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                    class="text-muted mt-2 d-block">RTL Version</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark"
                                                  onclick="setTheme('style-dark')"><img
                                    src="${pageContext.request.contextPath}/views/admin/assets/images/layouts/dark-dash.png"
                                    class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                    class="text-muted mt-2 d-block">LTR Version</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4"
                                                  onclick="setTheme('style-dark')"><img
                                    src="${pageContext.request.contextPath}/views/admin/assets/images/layouts/dark-dash.png"
                                    class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                    class="text-muted mt-2 d-block">Dark Version</span></a></li>
                            <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4"
                                                  onclick="setTheme('style')"><img
                                    src="${pageContext.request.contextPath}/views/admin/assets/images/layouts/light-dash.png"
                                    class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                    class="text-muted mt-2 d-block">Light Version</span></a></li>
                            <li class="d-grid"><a href="${pageContext.request.contextPath}/views/admin/landing/index.html" target="_blank" class="mt-4"><img
                                    src="${pageContext.request.contextPath}/views/admin/assets/images/layouts/landing-light.png"
                                    class="img-fluid rounded-md shadow-md d-block" alt=""><span
                                    class="text-muted mt-2 d-block">Landing Demos</span></a></li>
                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </div>


    <div class="offcanvas-footer p-4 border-top text-center">
        <ul class="list-unstyled social-icon mb-0">
            <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank"
                                                 class="rounded"><i class="uil uil-shopping-cart align-middle"
                                                                    title="Buy Now"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank"
                                                 class="rounded"><i class="uil uil-dribbble align-middle"
                                                                    title="dribbble"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank"
                                                 class="rounded"><i class="uil uil-facebook-f align-middle"
                                                                    title="facebook"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank"
                                                 class="rounded"><i class="uil uil-instagram align-middle"
                                                                    title="instagram"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank" class="rounded"><i
                    class="uil uil-twitter align-middle" title="twitter"></i></a></li>
            <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i
                    class="uil uil-envelope align-middle" title="email"></i></a></li>
            <li class="list-inline-item mb-0"><a href="../../../index.html" target="_blank" class="rounded"><i
                    class="uil uil-globe align-middle" title="website"></i></a></li>
        </ul>
    </div>
</div>
<!-- Offcanvas End -->


<!-- javascript -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/bootstrap.bundle.min.js"></script>
<!-- simplebar -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/simplebar.min.js"></script>
<!-- Chart -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/apexcharts.min.js"></script>
<script src="${pageContext.request.contextPath}/views/admin/assets/js/columnchart.init.js"></script>
<!-- Icons -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/feather.min.js"></script>
<!-- Main Js -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/app.js"></script>


</body>
</html>

