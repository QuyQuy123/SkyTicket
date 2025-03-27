<%@ page import="dal.TicketsDAO" %>
<%@ page import="dal.AccountDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="dal.FlightsDAO" %><%--
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

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/admin/assets/images/favicon.ico.png">
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/simplebar.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/select2.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/remixicon.css" rel="stylesheet" type="text/css"/>
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/tiny-slider.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/custom.css" rel="stylesheet"/>


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
    <%

        TicketsDAO td = new TicketsDAO();
        AccountDAO ad = new AccountDAO();
        double price = td.getTotalPrice();
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        String formattedPrice = currencyFormat.format(price);
        FlightsDAO fd = new FlightsDAO();
        int flight = fd.getFlightCountByStatus();

    %>


    <!-- Start Page Content -->
    <main class="page-content bg-light">

        <%@ include file="top.jsp"%>

        <div class="container-fluid">
            <div class="layout-specing">
                <h5 class="mb-0">Dashboard</h5>


                <div class="row">
                    <div class="col-xl-2 col-lg-4 col-md-4 mt-4" style="width: max-content;">
                       <a href="${pageContext.request.contextPath}/manageticket" style="text-decoration: none;">
                        <div class="card">
                            <div class="d-flex align-items-center">
                                <div class="icon text-center rounded-md">
                                    <i class="ri-ticket-2-line"></i>
                                </div>
                                <div class="flex-1 ms-2">
                                    <h5 class="mb-0"><%=td.countNumberTicketSuccess()%></h5>
                                    <p class="text-muted mb-0">Tickets</p>
                                </div>
                            </div>
                        </div>
                       </a>
                    </div><!--end col-->

                    <div class="col-xl-2 col-lg-4 col-md-4 mt-4" style="width: max-content;">
                        <a href="${pageContext.request.contextPath}/manageAccount?action=view" style="text-decoration: none;">
                            <div class="card">
                                <div class="d-flex align-items-center">
                                    <div class="icon text-center rounded-md">
                                        <i class="uil uil-social-distancing h3 mb-0"></i>
                                    </div>
                                    <div class="flex-1 ms-2">
                                        <h5 class="mb-0"><%=ad.countStaff() %></h5>
                                        <p class="text-muted mb-0">Staff Members</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div><!--end col-->

                    <div class="col-xl-2 col-lg-4 col-md-4 mt-4"style="width: max-content;">
                        <a href="${pageContext.request.contextPath}/listBookingsURL" style="text-decoration: none;">
                        <div class="card">
                            <div class="d-flex align-items-center">
                                <div class="icon text-center rounded-md">
                                    <i class="ri-money-dollar-circle-line"></i>
                                </div>
                                <div class="flex-1 ms-2">
                                    <h5 class="mb-0"><%=formattedPrice%></h5>
                                    <p class="text-muted mb-0">Total</p>
                                </div>
                            </div>
                        </div>
                        </a>
                    </div><!--end col-->

                    <div class="col-xl-2 col-lg-4 col-md-4 mt-4"style="width: max-content;">
                        <a href="${pageContext.request.contextPath}/listFlights" style="text-decoration: none;">
                        <div class="card">
                            <div class="d-flex align-items-center">
                                <div class="icon text-center rounded-md">
                                    <i class="ri-flight-takeoff-line"></i>
                                </div>
                                <div class="flex-1 ms-2">
                                    <h5 class="mb-0"><%=flight%></h5>
                                    <p class="text-muted mb-0">Flight</p>
                                </div>
                            </div>
                        </div>
                        </a>
                    </div><!--end col-->
                </div>

                <!-- Thêm phần biểu đồ doanh thu -->
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

                </div>

            </div>
        </div>
    </main>


</div>

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

