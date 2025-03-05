<%@ page import="model.Flights" %>
<%@ page import="java.util.List" %>
<%@ page import="dal.FlightsDAO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <h5 class="mb-0">Add New Seat</h5>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/listSeats">Seats</a></li>
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
                            <c:if test="${not empty error}">
                                <div style="color: red; font-weight: bold;">
                                        ${error}
                                </div>
                            </c:if>

                            <form class="mt-4" action="<%= request.getContextPath() %>/addSeats" method="post" >

                                <div class="row">
                                    <div class="col-lg-8 mt-4">
                                        <div class="card border-0 p-4 rounded shadow">
                                            <div class="row align-items-center">
                                            </div><!--end row-->
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label" for="SeatId">SeatID</label>
                                                        <input name="SeatId" id="SeatId" type="text" class="form-control"
                                                               placeholder="SeatID" disabled>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label" for="FlightId">Flight ID</label>
                                                        <select id="FlightId" name="FlightId" class="form-control department-name">
                                                            <%
                                                                List<Flights> flights = (List<Flights>) request.getAttribute("flights");
                                                                if (flights != null) {
                                                                    for (Flights flight : flights) {
                                                            %>
                                                            <option value="<%= flight.getFlightId() %>"><%= flight.getFlightId() %></option>
                                                            <%
                                                                    }
                                                                }
                                                            %>
                                                        </select>
                                                    </div>
                                                </div><!--end col-->

                                                <!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label" for="Status">Status</label>
                                                        <select name="Status" class="form-control department-name select2input" id="hehe">
                                                            <option value="1" >Active</option>
                                                            <option value="0">Deactive</option>
                                                        </select>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label" for="SeatNumber">Seat Number </label> <label style="color: red">(only digits)</label>
                                                        <input name="SeatNumber" id="SeatNumber" type="number" class="form-control"
                                                               placeholder="Seat Number" >
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label" for="SeatClass">Seat Class</label>
                                                        <select name="SeatClass" class="form-control department-name select2input" id="SeatClass">
                                                            <option >Economy</option>
                                                            <option >Business</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label" for="isBooked">Is Booked</label>
                                                        <select name="isBooked" class="form-control department-name select2input" id="isBooked">
                                                            <option value="1" >Yes</option>
                                                            <option value="0" >No</option>
                                                        </select>
                                                    </div>
                                                </div>

                                            </div><!--end row-->

                                            <div class="d-flex gap-2">
                                                <button type="submit" name="submit" id="submit" class="btn btn-primary">Add Seat</button>
                                                <button type="reset" class="btn btn-outline-secondary">Reset</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
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
