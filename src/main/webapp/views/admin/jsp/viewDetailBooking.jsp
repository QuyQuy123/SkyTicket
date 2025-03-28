<%--
  Created by IntelliJ IDEA.
  User: nguye
  Date: 16/03/2025
  Time: 3:09 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ page import="model.*" %>
    <%@ page import="dal.PaymentsDAO" %>
    <%@ page import="dal.BookingsDAO" %>
    <%@ page import="dal.BookingDAO" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <title>SkyTicket - Bookings management</title>
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

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
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




    <main class="page-content bg-light">
        <%@ include file="top.jsp" %>

        <%
            Bookings bookings = (Bookings) request.getAttribute("booking");
            PaymentsDAO pd = new PaymentsDAO();
            Payments p = pd.getPaymentByBookingId(bookings.getBookingID());
            BookingDAO bd = new BookingDAO();


            // Xử lý yêu cầu từ AJAX
            String action = request.getParameter("action");
            if ("confirmPayment".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                boolean success = bd.changeStatusToSuccess(bookingId);
                if (success) {
                    bookings = bd.getBookingById(bookingId); // Cập nhật lại booking
                    request.setAttribute("msg", "Payment confirmed successfully!");
                } else {
                    request.setAttribute("msg", "Failed to confirm payment.");
                }
            }else if ("confirmRefund".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            boolean success = bd.changeStatusToRefundSuccess(bookingId);
            if (success) {
                bookings = bd.getBookingById(bookingId); // Cập nhật lại booking
                request.setAttribute("msg", "Refund confirmed successfully!");
            } else {
                request.setAttribute("msg", "Failed to confirm Refund.");
            }
        }
        %>

        <div class="container-fluid">
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between">
                    <h5 class="mb-0">Booking ID: <%= bookings.getBookingID()%> </h5>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/listBookingsURL">Bookings</a></li>
                            <li class="breadcrumb-item active" aria-current="page">View Booking</li>
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
                            <hr>
<%--                            Code phần vé--%>


                            <hr>

                            <form class="mt-4" action="${pageContext.request.contextPath}/updateLocation" method="post" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Code: </label>
                                            <input name="code" id="name" type="text" disabled class="form-control"
                                                   value="<%=bookings.getCode() != null ? bookings.getCode(): ""%>">
                                        </div>
                                    </div><!--end col-->
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Contact Name: </label>
                                            <input name="contactName" id="phone" type="text" disabled class="form-control"
                                                   value="<%=bookings.getContactName() != null ? bookings.getContactName(): ""%>">
                                        </div>
                                    </div><!--end col-->
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Contact Phone: </label>
                                            <input name="contactPhone" id="email" type="text" disabled class="form-control"
                                                   value="<%=bookings.getContactPhone() != null ? bookings.getContactPhone(): ""%>">
                                        </div>
                                    </div><!--end col-->
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Contact Email: </label>
                                            <input name="contactEmail" id="contact" type="text" disabled class="form-control"
                                                   value="<%=bookings.getContactEmail() != null ? bookings.getContactEmail(): ""%>">
                                        </div>
                                    </div><!--end col-->
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Total Price: </label>
                                            <input name="totalPrice" id="idnumber" type="text" disabled class="form-control"
                                                   value="<%=bookings.getTotalPrice() != 0 ? bookings.getTotalPrice(): ""%>">
                                        </div>
                                    </div><!--end col-->
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Booking Date: </label>
                                            <input name="bookingDate" id="date" type="text" disabled class="form-control"
                                                   value="<%=bookings.getBookingDate() != null ? bookings.getBookingDate(): ""%>">
                                        </div>
                                    </div><!--end col-->
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Status: </label>
                                            <input name="status" id="bookingStatus" type="text" disabled class="form-control" value="<%=
                                               bookings.getStatus() == 1 ? "Is Pending" :
                                               bookings.getStatus() == 2 ? "Payment Success" :
                                               bookings.getStatus() == 3 ? "Is Cancelled" :
                                               bookings.getStatus() == 4 ? "Refund Pending" :
                                               bookings.getStatus() == 5 ? "Refund Complete" : "" %>">
                                        </div>
                                    </div>

                                    <% if (bookings.getAccountID() != 0) { %>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Account ID: </label>
                                            <input name="accountId" id="id" type="text" disabled class="form-control"
                                                   value="<%=bookings.getAccountID() != 0 ? bookings.getAccountID(): ""%>">
                                        </div>
                                    </div><!--end col-->
                                    <% } %>

                                    <div class="mt-3">
                                        <a href="${pageContext.request.contextPath}/listBookingsURL" class="btn btn-primary">Back</a>
                                        <% if (p != null && bookings.getStatus() == 1) { %>
                                        <button type="button" class="btn btn-success" onclick="confirmPayment(<%= bookings.getBookingID() %>)">Confirm Payment</button>
                                        <% } %>
                                        <% if (p != null && bookings.getStatus() == 4) { %>
                                        <button type="button" class="btn btn-success" onclick="confirmRefund(<%= bookings.getBookingID() %>)">Confirm Refund</button>
                                        <% } %>
                                    </div>
                                </div><!--end row-->
                            </form>
                        </div>
                    </div><!--end col-->

                    <div class="col-lg-4 mt-4">
                        <div class="card rounded border-0 shadow">
                            <div class="p-4 border-bottom d-flex align-items-center">
                                <i class="bi bi-pin-angle-fill text-danger me-2"></i>
                                <h5 class="mb-0">Note</h5>
                            </div>
                            <ul class="list-unstyled mb-0 p-4" data-simplebar style="height: 664px;">
                                <div>
                                    Booking name must be ...
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
            </div><!--end container-->

            <%@include file="bottom.jsp" %>
    </main>

    <!-- JavaScript để xử lý Confirm Payment -->
    <script>
        function confirmPayment(bookingId) {
            if (confirm("Are you sure you want to confirm confirm success booking ?")) {
                fetch(window.location.href, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: "action=confirmPayment&bookingId=" + bookingId
                })
                    .then(response => {
                        if (response.ok) { // Tương đương status === 200
                            location.reload();
                        }
                    })
                    .catch(error => console.error("Lỗi:", error));
            }
        }
        function confirmRefund(bookingId) {
            if (confirm("Are you sure you want to confirm to refunded this booking ?")) {
                fetch(window.location.href, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: "action=confirmRefund&bookingId=" + bookingId
                })
                    .then(response => {
                        if (response.ok) { // Tương đương status === 200
                            location.reload();
                        }
                    })
                    .catch(error => console.error("Lỗi:", error));
            }
        }


    </script>


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
</title>
</head>
<body>

</body>
</html>
