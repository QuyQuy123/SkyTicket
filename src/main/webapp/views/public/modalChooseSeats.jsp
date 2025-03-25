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
            border: 4px dashed #40c18b;
            border-radius: 15px;
            padding: 20px;
            background-color: #f8f9fa;
            box-shadow: 5px 5px 15px rgba(0, 0, 0, 0.3);
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


        .seat button {
            background: none;
            border: none;
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }


    </style>
</head>

<body>

<div id="myModal" class="modal">
    <div class="modal-content">
        <button class="close" onclick="closeModal()">&times;</button>
        <div class="container-fluid">
            <div class="layout-specing">
                <div class="plane-container">
                    <c:if test="${not empty ali}">
                    <p>Head</p>
                    <hr style="width: 80%; margin: 20px auto; border: 2px  black;">

                    <form id="seatForm" action="${pageContext.request.contextPath}/listseats" method="POST">
                        <input type="hidden" name="seatId" id="seatId">
                        <input type="hidden" name="id" value="${ali.airlineId}">
                    </form>

                    <c:if test="${not empty seats}">
                    <!-- Ghế VIP -->
                    <p>VIP Seats</p>
                    <c:if test="${seatClass eq 'Vip'}">
                        <p class="text-center">Select seats:</p>
                    <c:set var="count" value="0"/>
                    <div class="seat-container">
                        <c:forEach var="seat" items="${seats}">
                            <c:if test="${seat.seatClass eq 'Vip'}">
                                <c:if test="${count % ali.numberOfSeatsOnVipRow == 0}">
                                    <div class="row">
                                </c:if>

                                <div class="seat vip ${seat.status == 1 ? '' : 'btn-soft-secondary'}">
                                    <button onclick="confirmChangeStatus('${seat.seatId}', '${seat.seatNumber}', '${seat.seatClass}')">
                                            ${seat.status == 1 ? seat.seatNumber : '❌'}
                                    </button>
                                </div>

                                <c:set var="count" value="${count + 1}"/>
                                <c:if test="${count % ali.numberOfSeatsOnVipRow == 0}">
                                    </div>
                                </c:if>
                            </c:if>
                        </c:forEach>
                        <c:if test="${count % ali.numberOfSeatsOnVipRow != 0}">
                    </div>
                    </c:if>
                </div>
                </c:if>

                <hr style="width: 80%; margin: 20px auto; border: 2px  black;">

                <!-- Ghế Economy -->
                <p>Economy Seats</p>
                <c:if test="${seatClass eq 'Economy'}">
                <p class="text-center">Select seats:</p>
                <c:set var="count" value="0"/>
                <div class="seat-container">
                    <c:forEach var="seat" items="${seats}">
                        <c:if test="${seat.seatClass eq 'Economy'}">
                            <c:if test="${count % ali.numberOfSeatsOnEconomyRow == 0}">
                                <div class="row">
                            </c:if>

                            <div class="seat regular ${seat.status == 1 ? '' : 'btn-soft-secondary'}">
                                <button>
                                        ${seat.status == 1 ? seat.seatNumber : '❌'}
                                </button>
                            </div>

                            <c:set var="count" value="${count + 1}"/>
                            <c:if test="${count % ali.numberOfSeatsOnEconomyRow == 0}">
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>
                    <c:if test="${count % ali.numberOfSeatsOnEconomyRow != 0}">
                </div>
                </c:if>
            </div>
            </c:if>
            </c:if>
            <c:if test="${empty seats}">
                <p class="text-center">No seat available!</p>
            </c:if>
            <hr style="width: 80%; margin: 20px auto; border: 2px black;">
            <p>Tail</p>
            </c:if>
            <c:if test="${empty ali}">
                <p class="text-center">No flight available!</p>
            </c:if>
        </div>
    </div>
</div>
</div>
</div>


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
