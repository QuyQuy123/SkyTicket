<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Bookings" %>
<%@ page import="dal.*" %>
<%@ page import="model.Airlines" %><%--
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

    <%
        TicketsDAO td = new TicketsDAO();
        AccountDAO ad = new AccountDAO();
        BookingsDAO bd = new BookingsDAO();
        PaymentsDAO pd = new PaymentsDAO();
        AirlinesDAO ald = new AirlinesDAO();
        double price = td.getTotalPrice();
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        String formattedPrice = currencyFormat.format(price);
        FlightsDAO fd = new FlightsDAO();
        int flight = fd.getFlightCountByStatus();
        List<Accounts> acc = ad.getAllAccounts();
        List<Bookings> book = bd.getAllBookings();
        List<Airlines> air = ald.getAllAirlines();
        int numAcc = acc.size();
        int numBook = book.size();
        int numPay = pd.getTotalRecords();
        int numAir = air.size();
    %>


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
                                    <h5 class="mb-0"><%=numAcc%></h5>
                                    <p class="text-muted mb-0">Accounts</p>
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
                                    <h5 class="mb-0"><%=formattedPrice%></h5>
                                    <p class="text-muted mb-0">Tổng doanh thu</p>
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
                                    <h5 class="mb-0"><%=numAir%></h5>
                                    <p class="text-muted mb-0">Máy bay</p>
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
                                    <h5 class="mb-0"><%=flight%></h5>
                                    <p class="text-muted mb-0">Chuyến bay</p>
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
                                    <h5 class="mb-0"><%=numBook%></h5>
                                    <p class="text-muted mb-0">Đặt vé</p>
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
                                    <h5 class="mb-0"><%=numPay%></h5>
                                    <p class="text-muted mb-0">Thanh toán</p>
                                </div>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->


                <div class="row">
                    <div class="col-xl-12 col-lg-7 mt-4">
                        <div class="card shadow border-0 p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h6 class="align-items-center mb-0">Doanh thu theo tháng</h6>


                                <div class="mb-0 position-relative">
                                    <select class="form-select form-control" id="yearchart">
                                        <%
                                            int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                                            for (int year = currentYear; year >= 2023; year--) {
                                        %>
                                        <option value="<%= year %>"><%= year %></option>
                                        <%
                                            }
                                        %>
                                    </select>

                                </div>
                            </div>
                            <div id="dashboard" class="apex-chart"></div>
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

