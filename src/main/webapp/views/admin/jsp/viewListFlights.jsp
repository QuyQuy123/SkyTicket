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
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/bootstrap.min.css" rel="stylesheet"
          type="text/css"/>
    <!-- simplebar -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/simplebar.css" rel="stylesheet"
          type="text/css"/>
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/materialdesignicons.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/remixicon.css" rel="stylesheet"
          type="text/css"/>
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/style.min.css" rel="stylesheet"
          type="text/css" id="theme-opt"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .btn-custom {
            background-color: #198754 !important; /* Màu xanh lá */
            border-color: #146c43 !important;
            color: white;
            transition: all 0.3s ease-in-out; /* Hiệu ứng mượt */
        }

        .btn-custom:hover {
            background-color: #146c43 !important; /* Tối màu khi hover */
            transform: scale(1.1); /* Hiệu ứng phóng to */
        }

        .hover-trigger {
            position: relative;
            cursor: pointer;
        }

        .hover-trigger::after {
            content: "Search here";
            position: absolute;
            left: 150%;
            top: 0%;
            transform: translateX(-50%);
            background-color: #198754;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 12px;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s ease-in-out, visibility 0.3s ease-in-out;
        }

        .hover-trigger:hover::after {
            opacity: 1;
            visibility: visible;
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
        <%@include file="top.jsp" %>


        <div class="container-fluid">
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between">
                    <h5 class="mb-0">Flights List</h5>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a
                                    href="${pageContext.request.contextPath}/views/admin/jsp/Dashboard.jsp">SkyTicket</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">List Flights</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-12 mt-4">
                        <div class="table-responsive shadow rounded">
                            <form action="${pageContext.request.contextPath}/listFlights" method="post"
                                  class="d-flex">
                                <table id="searchTable"
                                       class="table table-bordered bg-white mb-0 text-center align-middle">
                                    <thead>

                                    <tr style="background-color: #b6d4fe">
                                        <th scope="col" class="border-bottom hover-trigger"
                                            style="font-weight: normal;">=>
                                        </th>
                                        <th scope="col" class="border-bottom p-1">
                                            <input type="text" class="form-control" name="deA" value="${param.deA}"
                                                   placeholder="...">
                                        </th>
                                        <th scope="col" class="border-bottom p-1">
                                            <input type="text" class="form-control" name="arA" value="${param.arA}"
                                                   placeholder="...">
                                        </th>
                                        <th scope="col" class="border-bottom p-1">
                                            <input type="date" class="form-control" name="dateFrom"
                                                   value="${param.dateFrom}">
                                        </th>
                                        <th scope="col" class="border-bottom p-1">
                                            <input type="date" class="form-control" name="dateTo"
                                                   value="${param.dateTo}">
                                        </th>
                                        <th scope="col" class="border-bottom p-1">
                                            <input type="number" class="form-control" placeholder="From: "
                                                   name="priceVipFrom" value="${param.priceVipFrom}">
                                            <input type="number" class="form-control" placeholder="To: "
                                                   name="priceVipTo" value="${param.priceVipTo}">
                                        </th>
                                        <th scope="col" class="border-bottom p-1">
                                            <input type="number" class="form-control" placeholder="From: "
                                                   name="priceEcoFrom" value="${param.priceEcoFrom}">
                                            <input type="number" class="form-control" placeholder="To: "
                                                   name="priceEcoTo" value="${param.priceEcoTo}">
                                        </th>
                                        <th scope="col" class="border-bottom p-1">
                                            <input type="text" class="form-control" name="airlineName"
                                                   value="${param.airlineName}" placeholder="...">
                                        </th>
                                        <th scope="col" class="border-bottom p-1">
                                            <select name="status" class="form-select border me-2">
                                                <option value=""></option>
                                                <option value="1" ${param.status == '1' ? 'selected' : ''}>Active
                                                </option>
                                                <option value="0" ${param.status == '0' ? 'selected' : ''}>Deactive
                                                </option>
                                            </select>
                                        </th>
                                        <th scope="col" class="border-bottom p-1">
                                            <button class="btn btn-custom">
                                                <i class="fa fa-search"></i>
                                            </button>
                                        </th>
                                    </tr>


                                    <tr>
                                        <th scope="col" class="border-bottom p-1">ID</th>
                                        <th scope="col" class="border-bottom p-1">Departure Airport</th>
                                        <th scope="col" class="border-bottom p-1">Arrival Airport</th>
                                        <th scope="col" class="border-bottom p-1">Departure Time</th>
                                        <th scope="col" class="border-bottom p-1">Arrival Time</th>
                                        <th scope="col" class="border-bottom p-1">Price Vip</th>
                                        <th scope="col" class="border-bottom p-1">Price Eco</th>
                                        <th scope="col" class="border-bottom p-1">Airline</th>
                                        <th scope="col" class="border-bottom p-1">Status</th>
                                        <th scope="col" class="border-bottom p-1">Action</th>
                                    </tr>


                                    </thead>
                                    <tbody>
                                    <c:choose>
                                        <c:when test="${not empty listFlights}">
                                            <c:forEach var="f" items="${listFlights}">
                                                <tr>
                                                    <td class="p-1">${f.flightId}</td>
                                                    <td class="p-1">
                                                        <c:forEach var="deA" items="${airportList}">
                                                            <c:if test="${deA.airportId == f.departureAirportId}">
                                                                ${deA.airportName}
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>

                                                    <td class="p-1">
                                                        <c:forEach var="arA" items="${airportList}">
                                                            <c:if test="${arA.airportId == f.arrivalAirportId}">
                                                                ${arA.airportName}
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>

                                                    <td class="p-1">${f.departureTime}</td>
                                                    <td class="p-1">${f.arrivalTime}</td>
                                                    <td class="p-1">${f.classVipPrice}</td>
                                                    <td class="p-1">${f.classEconomyPrice}</td>


                                                    <td class="p-1">
                                                        <c:forEach var="airline" items="${airlineList}">
                                                            <c:if test="${airline.airlineId == f.airlineId}">
                                                                ${airline.airlineName}
                                                            </c:if>
                                                        </c:forEach>
                                                    </td>

                                                    <td class="p-1">
                                                        <c:choose>
                                                            <c:when test="${f.status == 1}">
                                                                <span class="text-success fw-bold">Active</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-danger fw-bold">Deactive</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class=" p-1">
                                                        <a href="${pageContext.request.contextPath}/manageFlights?action=update&id=${f.flightId}"
                                                           class="btn btn-icon btn-sm btn-soft-success"><i
                                                                class="uil uil-pen"></i></a>

                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8" class="text-center p-3"
                                                    style="color: red; font-weight: bold">Not found!
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end container-->



        <!--phân trang-->

        <div class="d-flex justify-content-center mt-3">
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/listFlights?page=1&search=${search}"
                       class="btn btn-outline-primary">First</a>
                    <a href="${pageContext.request.contextPath}/listFlights?page=${currentPage - 1}"
                       class="btn btn-outline-primary">Previous</a>
                </c:if>

                <span class="btn btn-primary">${currentPage} / ${totalPages}</span>

                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/listFlights?page=${currentPage + 1}"
                       class="btn btn-outline-primary">Next</a>
                    <a href="${pageContext.request.contextPath}/listFlights?page=${totalPages}"
                       class="btn btn-outline-primary">Last</a>
                </c:if>
            </div>
        </div>


        <!-- Footer Start -->
        <%@include file="bottom.jsp" %>
        <!-- End -->
    </main>
    <!--End page-content" -->
</div>
<!-- page-wrapper -->


<!-- javascript -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/bootstrap.bundle.min.js"></script>

<!-- simplebar -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/simplebar.min.js"></script>

<!-- Icons -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/feather.min.js"></script>

<!-- Main Js -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/app.js"></script>

</body>

</html>