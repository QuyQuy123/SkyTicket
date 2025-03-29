<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dal.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thanh toán - Sky Ticket</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
    <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            color: #2d3436;
        }

        .container {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            margin-top: 70px;
        }

        /* Box thông báo đặt vé thành công */
        .success-box {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 750px;
            padding: 40px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .success-box:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
        }

        .success-box svg {
            width: 120px;
            height: 120px;
            fill: #32b877;
            margin-bottom: 25px;
            animation: pulse 1.5s infinite ease-in-out;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

        .success-box h3 {
            color: #1a252f;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 15px;
        }

        .success-box p {
            color: #636e72;
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 25px;
        }

        .button {
            font-size: 16px;
            font-weight: 600;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 25px;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
            outline: none;
        }

        .pay-now {
            background-color: #32b877;
            color: #ffffff;
        }

        .pay-now:hover {
            background-color: #27a465;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(50, 184, 119, 0.4);
        }

        .pay-later {
            background-color: #ffffff;
            color: #e74c3c;
            border: 2px solid #e74c3c;
        }

        .pay-later:hover {
            background-color: #e74c3c;
            color: #ffffff;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
        }

        /* Container chi tiết thanh toán */
        .details-container {
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 750px;
            padding: 30px;
            display: none;
            flex-wrap: wrap;
            gap: 30px;
            transition: opacity 0.3s ease;
        }

        .details-container.active {
            display: flex;
            opacity: 1;
        }

        .main-details, .payment-methods {
            flex: 1;
            min-width: 250px;
        }

        .details-section {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            text-align: left;
            margin-bottom: 20px;
            transition: transform 0.3s ease;
        }

        .details-section:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .details-section h3 {
            font-size: 20px;
            margin-bottom: 10px;
            color: #1a252f;
        }

        .details-section p {
            margin: 5px 0;
            font-size: 15px;
        }

        .details-section span {
            color: #636e72;
            font-weight: 500;
        }

        .payment-methods h2 {
            text-align: center;
            color: #1a252f;
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 25px;
        }

        .payment-options {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .payment-option {
            flex: 1;
            min-width: 250px;
            max-width: 300px;
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .payment-option:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .payment-option button {
            background: none;
            border: none;
            padding: 0;
            width: 100%;
            cursor: pointer;
        }

        .img-payment {
            width: 80px;
            height: auto;
            margin-bottom: 15px;
            transition: transform 0.3s ease;
        }

        .payment-option:hover .img-payment {
            transform: scale(1.1);
        }

        .payment-name {
            font-size: 15px;
            font-weight: 600;
            color: #2d3436;
            line-height: 1.4;
        }

        .payment-name span {
            font-size: 13px;
            color: #636e72;
            display: block;
        }

        @media (max-width: 768px) {
            .success-box, .details-container {
                width: 95%;
                padding: 20px;
            }

            .main-details, .payment-methods {
                min-width: 100%;
            }

            .button-container {
                flex-direction: column;
                gap: 10px;
            }

            .button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/views/layout/Header.jsp"/>

<%
    SimpleDateFormat timeFmt = new SimpleDateFormat("HH:mm");
    SimpleDateFormat dateFmt = new SimpleDateFormat("dd/MM/yyyy");
    AirlinesDAO ald = new AirlinesDAO();
    FlightsDAO fd = new FlightsDAO();
    AirportsDAO apd = new AirportsDAO();
    LocationsDAO ld = new LocationsDAO();
    BookingDAO bkd = new BookingDAO();

    int flightDetailId = (int) session.getAttribute("flightDetailId");
    Integer flightDetailId2str = (Integer) session.getAttribute("flightDetailId2");

    int bookingId = (int) request.getAttribute("bookingId");

    Flights flight = fd.getFlightById(flightDetailId);
    Airports departureAirport = apd.getAirportById(flight.getDepartureAirportId());
    Airports arrivalAirport = apd.getAirportById(flight.getArrivalAirportId());
    int aid = fd.getAirlineIdByFlightId(flightDetailId);
    Airlines airline = ald.getAirlineById(aid);

    int depLocationId = ld.getLocationIdByAirportId(departureAirport.getAirportId());
    int arrLocationId = ld.getLocationIdByAirportId(arrivalAirport.getAirportId());
    Locations depLocation = ld.getLocationById(depLocationId);
    Locations arrLocation = ld.getLocationById(arrLocationId);

    Airlines airline2 = null;
    Flights flight2 = null;
    Locations depLocation2 = null;
    Locations arrLocation2 = null;
    Airports departureAirport2 = null;
    Airports arrivalAirport2 = null;


    if(flightDetailId2str != null){
        int flightDetailId2 = flightDetailId2str;
         flight2 = fd.getFlightById(flightDetailId2);
         departureAirport2 = apd.getAirportById(flight2.getDepartureAirportId());
         arrivalAirport2 = apd.getAirportById(flight2.getArrivalAirportId());
        int aid2 = fd.getAirlineIdByFlightId(flightDetailId2);
         airline2 = ald.getAirlineById(aid2);
        int depLocationId2 = ld.getLocationIdByAirportId(departureAirport2.getAirportId());
        int arrLocationId2 = ld.getLocationIdByAirportId(arrivalAirport2.getAirportId());
         depLocation2 = ld.getLocationById(depLocationId2);
         arrLocation2 = ld.getLocationById(arrLocationId2);
    }


    double totalPrice = bkd.getTotalPriceAllTickets(bookingId);

    int adultTicket = 0;
    int childTicket = 0;
    int infantTicket = 0;

    Object adultObj = session.getAttribute("adultTicket");
    Object childObj = session.getAttribute("childTicket");
    Object infantObj = session.getAttribute("infantTicket");

    if (adultObj != null) {
        adultTicket = (int) adultObj;
    }
    if (childObj != null) {
        childTicket = (int) childObj;
    }
    if (infantObj != null) {
        infantTicket = (int) infantObj;
    }


%>

<div class="container">
    <!-- Phần thông báo đặt vé thành công -->
    <div class="success-box" id="successBox">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
            <path fill="#32b877" d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"></path>
        </svg>
        <h3>Đặt vé thành công</h3>
        <p>Đơn hàng đã được duyệt, vui lòng thanh toán ít nhất 10 ngày trước giờ bay</p>
        <div class="button-container">
            <button class="button pay-now" onclick="showPaymentDetails()">Thanh toán ngay</button>
            <button class="button pay-later" onclick="goHome()">Thanh toán sau</button>
        </div>
    </div>

    <!-- Phần chi tiết thanh toán -->
    <div class="details-container" id="detailsContainer">
        <div class="main-details">
            <div class="details-section">
                <h3>Thông tin bổ sung:</h3>
                <%

                %>
                <p>-<strong> Hành khách: </strong><span>người lớn <%=adultTicket%>, trẻ em <%=childTicket%>, em bé <%=infantTicket%></span></p>

            </div>
            <div class="details-section">
                <h3>Thông tin chuyến bay đi:</h3>
                <%
                    SimpleDateFormat dateTimeFmt = new SimpleDateFormat("HH:mm dd/MM/yyyy");
                %>
                <p>-<strong> Hãng bay: </strong><span><%= airline.getAirlineName() %></span></p>
                <p>-<strong> Khởi hành:</strong> <span><%=dateTimeFmt.format(flight.getDepartureTime())%></span></p>
                    <span><%= departureAirport.getAirportName() %>, <%= depLocation.getLocationName() %></span></p>
                <p>-<strong> Điểm đến:</strong> <span><%=dateTimeFmt.format(flight.getArrivalTime())%></span></p>
                    <span><%= arrivalAirport.getAirportName() %>, <%= arrLocation.getLocationName() %></span></p>
            </div>
            <% if (flightDetailId2str != null) { %>
            <div class="details-section">
                <h3>Thông tìn chuyến bay khứ hồi:</h3>
                <%
                     dateTimeFmt = new SimpleDateFormat("HH:mm dd/MM/yyyy");
                %>
                <p>-<strong> Hãng bay: </strong><span><%=airline2.getAirlineName() %></span></p>
                <p>-<strong> Khởi hành:</strong> <span><%=dateTimeFmt.format(flight2.getDepartureTime())%></span></p>
                <span><%= departureAirport2.getAirportName() %>, <%= depLocation2.getLocationName() %></span></p>
                <p>-<strong> Điểm đến:</strong> <span><%=dateTimeFmt.format(flight2.getArrivalTime())%></span></p>
                <span><%= arrivalAirport2.getAirportName() %>, <%= arrLocation2.getLocationName() %></span></p>
            </div>
            <% } %>
            <div class="details-section">
                <h3 style="color: red">
                    Total Price: <fmt:formatNumber value="<%=totalPrice%>" type="number" groupingUsed="true" /> đ
                </h3>
            </div>
        </div>
        <div class="payment-methods">
            <h2>Phương thức thanh toán</h2>
            <div class="payment-options">
                <div class="payment-option">
                    <form action="VnpayServletURL" id="frmCreateOrder" method="post">
                        <input type="hidden" name="bookingID" value="<%=bookingId%>"/>
                        <input type="hidden" name="bankCode" value="">
                        <input type="hidden" id="amount" name="amount" value="<%=totalPrice%>" />
                        <input type="hidden" name="language" value="vn">
                        <button type="submit">
                            <img class="img-payment" src="<%= request.getContextPath() %>/img/VnPay.jpg" alt="VNPAY">
                            <div class="payment-name">
                                VNPAY<br><span>Cổng thanh toán VNPAY</span>
                            </div>
                        </button>
                    </form>
                </div>
                <div class="payment-option">
                    <form action="QRCodeURL" method="post">
                        <input type="hidden" name="bookingID" value="<%=bookingId%>"/>
                        <button type="submit">
                            <img class="img-payment" src="<%= request.getContextPath() %>/img/qr.png" alt="QR CODE">
                            <div class="payment-name">
                                QR Code<br><span>Thanh toán bằng mã QR</span>
                            </div>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layout/Footer.jsp"/>

<script>
    function goHome() {
        window.location.href = 'home';
    }

    function showPaymentDetails() {
        // Ẩn phần thông báo thành công
        document.getElementById('successBox').style.display = 'none';
        // Hiển thị phần chi tiết thanh toán
        document.getElementById('detailsContainer').style.display = 'flex';
    }

    $("#frmCreateOrder").submit(function () {
        var postData = $("#frmCreateOrder").serialize();
        var submitUrl = $("#frmCreateOrder").attr("action");
        $.ajax({
            type: "POST",
            url: submitUrl,
            data: postData,
            dataType: 'JSON',
            success: function (x) {
                if (x.code === '00') {
                    if (window.vnpay) {
                        vnpay.open({width: 768, height: 600, url: x.data});
                    } else {
                        location.href = x.data;
                    }
                    return false;
                } else {
                    alert(x.Message);
                }
            }
        });
        return false;
    });
</script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>