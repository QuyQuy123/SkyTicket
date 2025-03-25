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
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/bootstrap.min.css" rel="stylesheet"
          type="text/css"/>
    <!-- simplebar -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/simplebar.css" rel="stylesheet"
          type="text/css"/>
    <!-- Select2 -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/select2.min.css" rel="stylesheet"/>
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/materialdesignicons.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/remixicon.css" rel="stylesheet"
          type="text/css"/>
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <!-- Css -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/style.min.css" rel="stylesheet"
          type="text/css" id="theme-opt"/>

    <style>
        /* Căn chỉnh phần container */
        .plane-container {
            text-align: center;
            padding: 20px;
        }

        /* Viền ngoài cho hình máy bay */
        .plane-container {
            margin-top: 20px;
            border: 4px dashed #40c18b; /* Viền đậm màu xám đen */
            border-radius: 15px; /* Bo góc nhẹ */
            padding: 20px; /* Khoảng cách bên trong */
            background-color: #f8f9fa; /* Màu nền nhẹ */
            box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.3); /* Hiệu ứng bóng */
        }


        /* Tiêu đề */
        h5 {
            font-weight: bold;
            color: #333;
            text-align: center;
        }

        /* Hàng ghế */
        .row {
            display: flex;
            justify-content: center;
            margin: 10px 0;
        }

        /* Ghế */
        .seat {
            width: 50px;
            height: 50px;
            margin: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            font-weight: bold;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
        }

        /* Màu ghế */
        .seat.vip {
            background-color: gold;
            color: black;
        }

        .seat.regular {
            background-color: lightgreen;
            color: black;
        }

        .seat.btn-soft-secondary {
            background-color: lightcoral;
            color: white;
        }

        /* Hover hiệu ứng */
        .seat button:hover {
            transform: scale(1.1);
            transition: 0.2s;
        }

        /* Ghế */
        .seat {
            width: 50px;
            height: 50px;
            margin: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            font-weight: bold;
            box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease-in-out;
        }

        /* Màu ghế */
        .seat.vip {
            background-color: gold;
            color: black;
        }

        .seat.regular {
            background-color: lightgreen;
            color: black;
        }

        .seat.btn-soft-secondary {
            background-color: lightcoral;
            color: white;
        }

        /* Hover hiệu ứng rõ ràng hơn */
        .seat:hover {
            transform: scale(1.15); /* Phóng to ghế */
            box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.3); /* Tạo bóng đổ */
        }

        /* Đổi màu nền khi hover */
        .seat.vip:hover {
            background-color: orange;
        }

        .seat.regular:hover {
            background-color: mediumseagreen;
        }

        .seat.btn-soft-secondary:hover {
            background-color: darkred;
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
                    <h5 class="mb-0">Seats Map - Flight ID: ${airline.airlineId}</h5>


                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/listAirlines">Airlines</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">Seats Map</li>
                        </ul>
                    </nav>
                </div>


                <!-- Code phần seat ở đây-->

                <div class="plane-container">
                    <div class="plane-title"><img
                            alt="control room"
                            src="${pageContext.request.contextPath}/views/admin/assets/images/airlines/control_room_airline.png">
                    </div>

                    <div class="plane">
                        <hr style="width: 80%; margin: 20px auto; border: 2px solid black;">

                        <!-- Form ẩn để gửi dữ liệu bằng POST -->
                        <form id="seatForm" action="${pageContext.request.contextPath}/listseats" method="POST">
                            <input type="hidden" name="seatId" id="seatId">
                            <input type="hidden" name="id" value="${airline.airlineId}">
                        </form>

                        <c:if test="${not empty airline}">
                        <!-- Ghế VIP -->
                        <p>VIP Seats</p>
                        <c:set var="count" value="0"/>
                        <c:forEach var="seat" items="${seats}">
                            <c:if test="${seat.seatClass eq 'Vip'}">
                                <!-- Nếu là ghế đầu tiên của hàng mới, tạo div row -->
                                <c:if test="${count % airline.numberOfSeatsOnVipRow == 0}">
                                    <div class="row">
                                </c:if>

                                <!-- Hiển thị ghế -->
                                <c:choose>
                                    <c:when test="${seat.status == 1}">
                                        <div class="seat vip">
                                            <button style="background: none; border: none; padding: 0; font-size: inherit; color: inherit; cursor: pointer;"
                                                    onclick="confirmChangeStatus('${seat.seatId}','${seat.seatNumber}', '${seat.seatClass}')">
                                                    ${seat.seatNumber}
                                            </button>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="seat vip btn-soft-secondary">
                                            <button style="background: none; border: none; padding: 0; font-size: inherit; color: inherit; cursor: pointer;"
                                                    onclick="confirmChangeStatus('${seat.seatId}','${seat.seatNumber}', '${seat.seatClass}')">
                                                ❌
                                            </button>
                                        </div>
                                    </c:otherwise>
                                </c:choose>


                                <c:set var="count" value="${count + 1}"/>

                                <!-- Nếu đủ 6 ghế, đóng div row -->
                                <c:if test="${count % airline.numberOfSeatsOnVipRow == 0}">
                                    </div>
                                </c:if>
                            </c:if>
                        </c:forEach>

                        <c:if test="${count % airline.numberOfSeatsOnVipRow != 0}">
                    </div>
                    </c:if>

                    <hr style="width: 80%; margin: 20px auto; border: 2px solid black;">

                    <!-- Ghế Economy -->
                    <p>Economy Seats</p>
                    <c:set var="count" value="0"/>
                    <c:forEach var="seat" items="${seats}">
                        <c:if test="${seat.seatClass eq 'Economy'}">
                            <c:if test="${count % airline.numberOfSeatsOnEconomyRow == 0}">
                                <div class="row">
                            </c:if>

                            <c:choose>
                                <c:when test="${seat.status == 1}">
                                    <div class="seat regular">
                                        <button style="background: none; border: none; padding: 0; font-size: inherit; color: inherit; cursor: pointer;"
                                                onclick="confirmChangeStatus('${seat.seatId}','${seat.seatNumber}', '${seat.seatClass}')">
                                                ${seat.seatNumber}
                                        </button>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="seat regular btn-soft-secondary">
                                        <button style="background: none; border: none; padding: 0; font-size: inherit; color: inherit; cursor: pointer;"
                                                onclick="confirmChangeStatus('${seat.seatId}','${seat.seatNumber}', '${seat.seatClass}')">
                                            ❌
                                        </button>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <c:set var="count" value="${count + 1}"/>

                            <c:if test="${count % airline.numberOfSeatsOnEconomyRow == 0}">
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>

                    <c:if test="${count % airline.numberOfSeatsOnEconomyRow != 0}">
                </div>
                </c:if>
                </c:if>


                <hr style="width: 80%; margin: 20px auto; border: 2px solid black;">

                <div class="plane-title"><img
                        alt="airline tail"
                        src="${pageContext.request.contextPath}/views/admin/assets/images/airlines/tail.png">
                </div>
            </div>


            <!-- hết phần seat-->
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
    function confirmChangeStatus(seatId, seatNumber, seatClass) {
        debugger;
        let confirmMsg = "Bạn có muốn chuyển trạng thái ghế " + seatClass + " " + seatNumber + " không?";
        console.log(seatId);
        if (confirm(confirmMsg)) {
            document.getElementById("seatId").value = seatId; // Đưa seatId vào form
            document.getElementById("seatForm").submit(); // Gửi form bằng POST
        }
    }
</script>
</body>
</html>
