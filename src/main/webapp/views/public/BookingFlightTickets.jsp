

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dal.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.NumberFormat" %>

<%@ page import="java.util.List" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.util.Locale" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--


 Created by IntelliJ IDEA.
 User: 84968
 Date: 2/28/2025
 Time: 1:59 PM
 To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Booking Flight Tickets</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/43.1.0/ckeditor5.css">
    <script src="<%= request.getContextPath() %>/js/Validation.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


    <style>


        body {
            background-color: #f7f7f7;
            color: #333;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .main-container {
            border: 1px solid #ddd;
            margin-bottom: 20px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            align-items: center;
        }
        .main-container2 {
            border: 1px solid #ddd;
            margin-bottom: 20px;
            border-radius: 10px;
            background-color: #fff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .main-container img {
            width: 150px;
            height: auto;
            border-radius: 5px;
        }
        .details {
            margin-left: 20px;
        }
        .details h3 {
            margin: 10px 0;
            font-size: 18px;
            color: #3C6E57;
        }
        .details p {
            margin: 10px 0;
            font-size: 16px;
        }
        .details span {
            font-weight: bold;
        }


        .passenger-info {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }


        .passenger-info-input {
            padding: 15px;
            margin-bottom: 30px;
            border-radius: 8px;
            border: 5px solid #9DC567;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }


        .passenger-info-input-box{
            display: flex;
            margin-bottom: 15px
        }


        .passenger-info-input-box input{
            width: 100%;
        }


        .passenger-info-input-title{
            margin: 0;
            width: 150px;
            align-items: center;
            display: flex;
        }


        .main-container2 .inform label {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }


        .main-container2 .inform input[type="text"],
        .main-container2 .inform input[type="date"],
        .main-container2 .inform input[type="email"],
        .main-container2 .inform input[type="number"],
        .main-container2 .inform select {
            padding: 5px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #fff;
            transition: border-color 0.3s ease;
        }


        .main-container2 .inform input[type="text"]:focus,
        .main-container2 .inform input[type="date"]:focus,
        .main-container2 .inform input[type="number"]:focus,
        .main-container2 .inform input[type="email"]:focus,
        .main-container2 .inform select:focus {
            border-color: #9DC567;
            outline: none;
        }


        .ticket-pricing {
            font-family: Arial, sans-serif;
            max-width: 400px;
            margin: 20px auto;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
        }


        .ticket-item, .ticket-total {
            display: flex;
            justify-content: space-between;
            padding: 5px 0;
        }


        .ticket-item span, .ticket-total span {
            font-size: 16px;
        }


        .ticket-total {
            color: #3C6E57;
            font-weight: bold;
            border-top: 1px solid #ddd;
            margin-top: 10px;
            padding-top: 10px;
        }


        .ticket-item span:last-child, .ticket-total span:last-child {
            color: #333;
        }
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }


        /* Hộp modal */




        /* Nút đóng */


    </style>




    <style>
        .modalSeat {


            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5); /* Làm mờ nền */
            display: none;
            z-index: 999;
            justify-content: center;
            align-items: center;


        }
        .modalSeat2 {


            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5); /* Làm mờ nền */
            display: none;
            z-index: 1000;
            justify-content: center;
            align-items: center;


        }


        .modal-content {
            background: white;
            width: 80%; /* Hoặc chỉnh theo mong muốn */
            max-width: 800px; /* Giới hạn tối đa */
            max-height: 80vh; /* Giới hạn chiều cao */
            overflow-y: auto; /* Cuộn khi nội dung quá dài */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
        }


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
            width: 50px !important;
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
        .seat.selector {
            background-color: #5a5959;
        }


        .seat.regular:hover {
            background-color: mediumseagreen;
        }


        .seat.btn-soft-secondary:hover {
            background-color: darkred;
        }
        .close-btn {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 24px;
            cursor: pointer;
            border: none;
            background: none;
        }


        .close-btn:hover {
            color: red;
        }




    </style>


    <script>
        function submitPassengerForm(totalPassenger) {
            console.log("Hàm submitPassengerForm được gọi với totalPassenger =", totalPassenger);


            const form = document.getElementById("passengerForm");
            if (form) {
                console.log("Tìm thấy form:", form);
            } else {
                console.log("Không tìm thấy form!");
            }


            console.log("Form hợp lệ, đang submit...");
            form.submit();
        }
    </script>
</head>
<body>
<jsp:include page="/views/layout/Header.jsp"/>


<%
    AirlinesDAO ald = new AirlinesDAO();
    FlightsDAO fd = new FlightsDAO();
    SeatsDAO sd = new SeatsDAO();
    AirportsDAO apd = new AirportsDAO();
    LocationsDAO ld = new LocationsDAO();
    CountriesDAO cd = new CountriesDAO();
    BaggageDAO bd = new BaggageDAO();
    SeatsDAO seatsDAO = new SeatsDAO();




    int adultTicket = Integer.parseInt(request.getParameter("adult"));
    int childTicket = Integer.parseInt(request.getParameter("child")==null?"0":request.getParameter("child"));
    int infantTicket = Integer.parseInt(request.getParameter("infant"));
    int totalPassengers = adultTicket + childTicket +infantTicket;


    Seats s = sd.getSeatById(Integer.parseInt(request.getParameter("seatCategory")));//seatId
    String seatClass = s.getSeatClass();


    int flightlId = Integer.parseInt(request.getParameter("flightDetailId"));
    Flights f = fd.getFlightById(flightlId);
    int airlineId = f.getAirlineId();
    Airlines airline = ald.getAirlineById(airlineId);




    List<Seats> seats = seatsDAO.getAllSeatByAirlineId(airline.getAirlineId());


    request.setAttribute("airline", airline);


    request.setAttribute("seats", seats);
    request.setAttribute("seatClass", seatClass);


    int departureAirportId = f.getDepartureAirportId();
    Airports dpa = apd.getAirportById(departureAirportId);
    Locations dpl = ld.getLocationByLId(dpa.getLocationId());
    Countries dpc = cd.getCountryById(dpl.getCountryId());
    int destinationAirportId = f.getArrivalAirportId();
    Airports dsa = apd.getAirportById(destinationAirportId);
    Locations dsl = ld.getLocationByLId(dsa.getLocationId());
    Countries dsc = cd.getCountryById(dsl.getCountryId());


//    DiscountDAO dd = new DiscountDAO();
%>
<script>
    var airline = "<%= request.getAttribute("airline") %>";
    var seats = <%= new Gson().toJson(request.getAttribute("seats")) %>; // Nếu `seats` là danh sách
    console.log("Airline:", airline);
    console.log("Seats:", seats);
</script>
<main>
    <div class="container" style="margin-top: 100px;">
        <div class="main-container">
            <img src="<%= request.getContextPath() + "/img/" + airline.getImage() %>" alt="Logo">
            <div class="details">
                <h3>Additional Details: </h3>
                <p>- Passengers: <span><%=adultTicket%> adult,
                           <%=childTicket%> children,
                           <%=infantTicket%> infant</span></p>
                <p>- Airline: <span><%=airline.getAirlineName()%></span></p>
            </div>
            <div class="details">
                <h3>Depart Flight Information: </h3>
                <%
                    SimpleDateFormat dateTimeFmt = new SimpleDateFormat("HH:mm dd/MM/yyyy");
                %>
                <p>- Departure: <span><%=dateTimeFmt.format(f.getDepartureTime())%></span></p>
                <p><span><%=dpa.getAirportName()%>, <%=dpl.getLocationName()%>,<%=dpc.getCountryName()%> </span></p>
                <p>- Destination: <span><%=dateTimeFmt.format(f.getArrivalTime())%></span></p>
                <p><span><%=dsa.getAirportName()%>, <%=dsl.getLocationName()%>, <%=dsc.getCountryName()%></span></p>

            </div>

            <%
                int flightDetailId2 = -1;
                Seats s2 = null;
                Flights f2 = null;
                if(request.getParameter("flightDetailId2")!=null){
                    totalPassengers*=2;
                    flightDetailId2= Integer.parseInt(request.getParameter("flightDetailId2"));
                    s2 = sd.getSeatById(Integer.parseInt(request.getParameter("seatCategory2")));
                    f2 = fd.getFlightById(flightDetailId2);
                    int departureAirportId2 = f2.getDepartureAirportId();
                    Airports dpa2 = apd.getAirportById(departureAirportId2);
                    Locations dpl2 = ld.getLocationByLId(dpa2.getLocationId());
                    int destinationAirportId2 = f2.getArrivalAirportId();
                    Airports dsa2 = apd.getAirportById(destinationAirportId2);
                    Locations dsl2 = ld.getLocationByLId(dsa2.getLocationId());
                    String seatClass2 = s2.getSeatClass();
                    int airlineId2 = f2.getAirlineId();
                    Airlines airline2 = ald.getAirlineById(airlineId2);

                    List<Seats> seats2 = seatsDAO.getAllSeatByAirlineId(airline2.getAirlineId());


                    request.setAttribute("airline2", airline2);


                    request.setAttribute("seats2", seats2);
                    request.setAttribute("seatClass2", seatClass2);
            %>

            <div class="details">
                <h3>Return Flight Information: </h3>
                <p>- Departure: <span><%=dateTimeFmt.format(f2.getDepartureTime())%></span></p>
                <p><span><%=dpa2.getAirportName()%>, <%=dpl2.getLocationName()%>,<%=dpc.getCountryName()%></span></p>
                <p>- Destination: <span><%=dateTimeFmt.format(f2.getArrivalTime())%></span></p>
                <p><span><%=dsa2.getAirportName()%>, <%=dsl2.getLocationName()%>,<%=dsc.getCountryName()%></span></p>

            </div>
            <%
                }
            %>
        </div>
        <%
            int  m = (request.getParameter("flightDetailId2")!=null)?2:1;//m =1 thì là 1 chiều, =2 là khứ hồi
            NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            Accounts currentAcc = null;
            if(request.getAttribute("account") != null){
                currentAcc = (Accounts) request.getAttribute("account");
            }
        %>

        <div style="display: flex; justify-content: space-between">
            <div style="width: 68%; display: block">




                <form style="width: 100%" id="passengerForm" action="bookingFlightTicketsURL" method="post">
                    <input type="hidden" name="flightDetailId" value="<%=flightlId%>"/>
                    <input type="hidden" name="seatCategoryId" value="<%=s.getSeatId()%>"/>
                    <input type="hidden" name="adultTicket" value="<%=adultTicket%>"/>
                    <input type="hidden" name="childTicket" value="<%=childTicket%>"/>
                    <input type="hidden" name="infantTicket" value="<%=infantTicket%>"/>
                    <%
                        double price = 0;
                        if ("Business".equals(sd.getSeatById(s.getSeatId()).getSeatClass())) {
                            price = (long) f.getClassVipPrice();
                        } else if ("Economy".equals(sd.getSeatById(s.getSeatId()).getSeatClass())) {
                            price = f.getClassEconomyPrice();
                        }


                    %>
                    <input type="hidden" name="commonPrice" value="<%= price%>"/>
                    <%if(m==2){
                    %>
                    <input type="hidden" name="flightDetailId2" value="<%=flightDetailId2%>"/>
                    <input type="hidden" name="seatCategoryId2" value="<%=s2.getSeatId()%>"/>
                    <%
                        double price2 = 0;
                        if ("Business".equals(sd.getSeatById(s2.getSeatId()).getSeatClass())) {
                            price2 = (long) f2.getClassVipPrice();
                        } else if ("Economy".equals(sd.getSeatById(s2.getSeatId()).getSeatClass())) {
                            price2 = f2.getClassEconomyPrice();
                        }


                    %>
                    <input type="hidden" name="commonPrice2" value="<%= price2 %>"/>
                    <%
                        }%>
                    <div class="main-container2 passenger-info" >
                        <div style="width: 100%; text-align: center;
                                font-size: 20px;
                                color: #333;
                                margin-bottom: 20px;
                                color: #3C6E57;
                                letter-spacing: 1px;"><p>PASSENGER CONTACT</p></div>
                        <div style="width: 100%" class="inform">
                            <div class="passenger-info-input" style="position: relative">
                                <div style="padding: 15px">
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title">Full Name:</div>
                                        <input type="text" pattern="^[\p{L}\s]+$" name="pContactName" id="name0" value="<%=(currentAcc!=null)?currentAcc.getFullName():""%>" required/>
                                    </div>
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title">Phone number:</div>
                                        <input type="text" oninput="validatePhone(this)" name="pContactPhoneNumber" value="<%=(currentAcc!=null)?currentAcc.getPhone():""%>" required/>
                                    </div>
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title">Email:</div>
                                        <input type="email" name="pContactEmail" value="<%=(currentAcc!=null)?currentAcc.getEmail():""%>" required/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main-container2 passenger-info" >
                        <div style="width: 100%; text-align: center;
                                font-size: 20px;
                                color: #333;
                                margin-bottom: 20px;
                                color: #3C6E57;
                                letter-spacing: 1px;"><p>PASSENGER INFORMATION</p></div>
                        <div style="width: 100%" class="inform">
                            <% for(int i = 1; i<=adultTicket; i++){
                            %>
                            <div  class="passenger-info-input" style="position: relative">
                                <div style="position: absolute;
                                        top: -14px;
                                        font-size: 16px;
                                        background-color: white;
                                        color: #3C6E57;
                                        padding: 0 10px;">PASSENGER ADULT <%=i%> </div>
                                <div style="padding: 15px">
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 168px">Full Name:</div>
                                        <select name="pSex<%=i%>" style="margin-right: 5px">
                                            <option value="1">Mr</option>
                                            <option value="0">Mrs</option>
                                        </select>
                                        <input type="text" pattern="^[\p{L}\s]+$" id="name<%=i%>" name="pName<%=i%>" required/>
                                    </div>
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title">Date of birth:</div>
                                        <%
                                            java.util.Calendar calendarAdult = java.util.Calendar.getInstance();
                                            calendarAdult.add(java.util.Calendar.YEAR, -12);
                                            String maxDateAdult = new java.text.SimpleDateFormat("yyyy-MM-dd").format(calendarAdult.getTime());
                                        %>
                                        <input type="date" name="pDob<%=i%>" required max="<%=maxDateAdult%>" onkeydown="return false;">
                                    </div>
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title">Phone number:</div>
                                        <input type="text" oninput="validatePhone(this)" name="pPhoneNumber<%=i%>" required/>
                                    </div>
                                    <div class="passenger-info-input-box"  >
                                        <div class="passenger-info-input-title" style="width: 121px">Baggage:</div>
                                        <select name="pBaggages<%=i%>" id="baggage<%=i%>" onchange= "updateTotalBaggage()">
                                            <option value="0">Buy 0kg extra checked baggage - <%=currencyFormatter.format(0)%>></option>
                                            <% for(Baggages b : bd.getAllBaggagesByAirline(airlineId)){
                                                if(b.getStatus() == 1){
                                            %>
                                            <option value="<%=b.getBaggageId()%>" data-price="<%=b.getPrice()%>">Buy <%=b.getWeight()%>kg extra checked baggage - <%=currencyFormatter.format(b.getPrice())%></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>


                                    <div id="Adult<%=i%>" class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 200px">Select seat for departuring:</div>
                                        <div style="display: flex; align-items: center; margin-right: 20px; font-weight: 600; font-size: 16px; color: #3C6E57">
                                            <span style=""><%=s.getSeatClass()%> - <span id="seatCodeForDisplaying<%=i%>">Not Selected</span></span>
                                        </div>
                                        <button type="button" class="btn btn-info" style="text-decoration: none"  onclick="openSeatModal('Adult<%=i%>')">Choose</button>
                                        <input type="hidden" name="code<%=i%>" id="seatCode<%=i%>"/>
                                    </div>


                                    <% if(m==2){
                                    %>
                                    <div class="passenger-info-input-box"  >
                                        <div class="passenger-info-input-title" style="width: 121px">Baggage:</div>
                                        <label for="baggage<%=i+totalPassengers/2%>"></label>
                                        <select name="pBaggages<%=i+totalPassengers/2%>" id="baggage<%=i+totalPassengers/2%>" onchange="updateTotalBaggage()">
                                            <option value="0">Buy 0kg extra checked baggage - <%=currencyFormatter.format(0)%>></option>
                                            <% for(Baggages b : bd.getAllBaggagesByAirline(airlineId)){
                                                if(b.getStatus() == 1){
                                            %>
                                            <option value="<%=b.getBaggageId()%>" data-price="<%=b.getPrice()%>">Buy <%=b.getWeight()%>kg extra checked baggage - <%=currencyFormatter.format(b.getPrice())%></option>
                                            <%
                                                    }
                                                }
                                            %>

                                        </select>
                                    </div>


                                    <div id="Adultm<%=i%>" class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 200px">Select seat for departuring:</div>
                                        <div style="display: flex; align-items: center; margin-right: 20px; font-weight: 600; font-size: 16px; color: #3C6E57">
                                            <span style=""><%=s2.getSeatClass()%> - <span id="seatCodeForDisplayingm<%=i%>">Not Selected</span></span>
                                        </div>
                                        <button type="button" class="btn btn-info" style="text-decoration: none" onclick="openSeatModal2('Adultm<%=i%>')">Choose</button>
                                        <input type="hidden" name="codem<%=i%>" id="seatCodem<%=i%>"/>
                                    </div>


                                    <%
                                        }%>
                                </div>
                            </div>
                            <%
                                }
                            %>
                            <% for(int i = adultTicket+1; i<=adultTicket+childTicket; i++){
                            %>


                            <div class="passenger-info-input" style="position: relative">
                                <div style="position: absolute;
                                        top: -14px;
                                        font-size: 16px;
                                        background-color: white;
                                        color: #3C6E57;
                                        padding: 0 10px;">PASSENGER CHILDREN <%=i-adultTicket%> </div>
                                <div style="padding: 15px">
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 168px">Full Name:</div>
                                        <select name="pSex<%=i%>" style="margin-right: 5px">
                                            <option value="1">Boy</option>
                                            <option value="0">Girl</option>
                                        </select>
                                        <input type="text" pattern="^[\p{L}\s]+$" id="name<%=i%>" name="pName<%=i%>" required/>
                                    </div>
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title">Date of birth:</div>
                                        <%
                                            java.util.Calendar calendarChild = java.util.Calendar.getInstance();
                                            calendarChild.add(java.util.Calendar.YEAR, -2);
                                            String maxDateChild = new java.text.SimpleDateFormat("yyyy-MM-dd").format(calendarChild.getTime());
                                        %>
                                        <input type="date" name="pDob<%=i%>" required max="<%=maxDateChild%>" onkeydown="return false;">
                                    </div>
                                    <div id="<%=i%>" class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 200px">Select seat for departuring:</div>
                                        <div style="display: flex; align-items: center; margin-right: 20px; font-weight: 600; font-size: 16px; color: #3C6E57">
                                            <span style=""><%=s.getSeatClass()%> - <span id="seatCodeForDisplaying<%=i%>">Not Selected</span></span>
                                        </div>
                                        <button type="button" class="btn btn-info" style="text-decoration: none" onclick="openSeatModal('Child<%=i%>')">Choose</button>
                                        <input type="hidden" name="code<%=i%>" id="seatCode<%=i%>"/>
                                    </div>


                                    <% if(m==2){
                                    %>
                                    <div id="m<%=i%>" class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 200px">Select seat for departuring:</div>
                                        <div style="display: flex; align-items: center; margin-right: 20px; font-weight: 600; font-size: 16px; color: #3C6E57">
                                            <span style=""><%=s2.getSeatClass()%> - <span id="seatCodeForDisplayingm<%=i%>">Not Selected</span></span>
                                        </div>
                                        <button type="button" class="btn btn-info" style="text-decoration: none" onclick="openSeatModal2('Childm<%=i%>')">Choose</button>
                                        <input type="hidden" name="codem<%=i%>" id="seatCodem<%=i%>"/>
                                    </div>


                                    <%
                                        }%>
                                </div>
                            </div>
                            <%
                                }
                            %>
                            <% for(int i = adultTicket+childTicket+1; i<=adultTicket+childTicket+infantTicket; i++){
                            %>
                            <div class="passenger-info-input" style="position: relative">
                                <div style="position: absolute;
                                        top: -14px;
                                        font-size: 16px;
                                        background-color: white;
                                        color: #3C6E57;
                                        padding: 0 10px;">PASSENGER INFANT <%=i-(adultTicket+childTicket)%> </div>
                                <div style="padding: 15px">
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 168px">Full Name:</div>
                                        <select name="pSex<%=i%>" style="margin-right: 5px">
                                            <option value="1">Boy</option>
                                            <option value="0">Girl</option>
                                        </select>
                                        <input type="text" pattern="^[\p{L}\s]+$" id="name<%=i%>" name="pName<%=i%>" required/>
                                    </div>
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title">Date of birth:</div>
                                        <%
                                            java.util.Calendar calendarInfant = java.util.Calendar.getInstance();
                                            calendarInfant.add(java.util.Calendar.YEAR, 0);
                                            String maxDateInfant = new java.text.SimpleDateFormat("yyyy-MM-dd").format(calendarInfant.getTime());
                                        %>
                                        <input type="date" name="pDob<%=i%>" required max="<%=maxDateInfant%>" onkeydown="return false;">
                                    </div>
                                </div>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>


                </form>


            </div>
            <%--hóa đơn--%>
            <div class="main-container2 passenger-info" style="width: 30%; height: fit-content">
                <div style="width: 100%; text-align: center; font-size: 20px; color: #3C6E57; margin-bottom: 20px; letter-spacing: 1px;">
                    <p>INVOICE</p>
                </div>
                <div class="ticket-pricing">
                    <%
                        // Giả định bạn có hai đối tượng Flight riêng biệt
                        // Lấy giá vé từ từng chuyến bay
                        double outboundVipPrice = f.getClassVipPrice();       // Giá Business lượt đi
                        double outboundEconomyPrice = f.getClassEconomyPrice(); // Giá Economy lượt đi
                        double inboundVipPrice = (m == 2) ? f2.getClassVipPrice() : 0;       // Giá Business lượt về (0 nếu không có)
                        double inboundEconomyPrice = (m == 2) ? f2.getClassEconomyPrice() : 0; // Giá Economy lượt về (0 nếu không có)


                        // Lấy hạng vé từng chặng
                        String outboundClass = s.getSeatClass(); // Hạng vé lượt đi
                        String inboundClass = (m == 2) ? s2.getSeatClass() : "";   // Hạng vé lượt về (rỗng nếu không có)


                        // Tính giá cho người lớn từng chặng
                        double outboundAdultPrice = (outboundClass.equals("Business") ? outboundVipPrice : outboundEconomyPrice) * adultTicket;
                        double inboundAdultPrice = (m == 2) ? (inboundClass.equals("Business") ? inboundVipPrice : inboundEconomyPrice) * adultTicket : 0;


                        // Tính giá cho trẻ em từng chặng (50% giá người lớn)
                        double outboundChildPrice = (outboundClass.equals("Business") ? (outboundVipPrice * 0.9) : (outboundEconomyPrice * 0.9)) * childTicket;
                        double inboundChildPrice = (m == 2) ? (inboundClass.equals("Business") ? (inboundVipPrice * 0.9) : (inboundEconomyPrice * 0.9)) * childTicket : 0;


                        // Tính giá cho trẻ sơ sinh từng chặng (10% giá người lớn)
                        double outboundInfantPrice = (outboundClass.equals("Business") ? (outboundVipPrice * 0.8) : (outboundEconomyPrice * 0.8)) * infantTicket;
                        double inboundInfantPrice = (m == 2) ? (inboundClass.equals("Business") ? (inboundVipPrice * 0.8) : (inboundEconomyPrice * 0.8)) * infantTicket : 0;


                        // Tổng giá vé cho từng loại hành khách
                        double adultTotalPrice = outboundAdultPrice + inboundAdultPrice;
                        double childTotalPrice = outboundChildPrice + inboundChildPrice;
                        double infantTotalPrice = outboundInfantPrice + inboundInfantPrice;


                        // Tổng giá vé
                        double totalTicketPrice = adultTotalPrice + childTotalPrice + infantTotalPrice;




                    %>
                    <div class="ticket-item">
                        <span>Adult Ticket x <%= adultTicket * m %></span>
                        <span>= <%= currencyFormatter.format(adultTotalPrice) %> </span>
                    </div>
                    <div class="ticket-item">
                        <span>Children Ticket x <%= childTicket * m %></span>
                        <span>= <%= currencyFormatter.format(childTotalPrice) %> </span>
                    </div>
                    <div class="ticket-item">
                        <span>Infant Ticket x <%= infantTicket * m %></span>
                        <span>= <%= currencyFormatter.format(infantTotalPrice) %></span>
                    </div>
                    <div class="ticket-item">
                        <span>Baggage</span>
                        <span id="totalBaggage">= 0 ₫</span>
                    </div>
                    <div class="ticket-total">
                        <span>Total Price:</span>
                        <span id="totalPrice" data-total-ticket-price="<%= totalTicketPrice %>"><%= currencyFormatter.format(totalTicketPrice) %> ₫</span>
                    </div>
                </div>
                <div style="width: 100%">
                    <button style="width: 100%; background-color: #9DC567; padding: 10px 30px; border: none; border-radius: 8px; color: white"
                            onclick="submitPassengerForm(<%=adultTicket + childTicket + infantTicket%>)"
                    >SUBMIT</button>
                </div>
            </div>
        </div>
    </div>


</main>
<jsp:include page="/views/layout/Footer.jsp"/>

<section>


    <div id="ModalSeat" class="modalSeat"  >
        <div class="modal-content">
            <button class="close-btn" onclick="closeModal()">&times;</button>
            <div class="container-fluid" >
                <div class="layout-specing">
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


                                            <button id="${seat.seatId}"   class="seat vip" data-seat="1" data-number="${seat.seatNumber}" data-id="${seat.seatId}" style=" border: none; padding: 0; font-size: inherit; color: inherit; cursor: pointer;"
                                            >
                                                    ${seat.seatNumber}
                                            </button>

                                        </c:when>
                                        <c:otherwise>


                                            <button class="seat vip btn-soft-secondary" style=" border: none; padding: 0; font-size: inherit; color: inherit; cursor: pointer;"
                                            >
                                                ❌
                                            </button>


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


                                        <button id="${seat.seatId}"  class="seat regular" data-seat="1" data-number="${seat.seatNumber}" data-id="${seat.seatId}" style=" border: none; padding: 0; font-size: inherit; color: inherit; cursor: pointer;"
                                        >
                                                ${seat.seatNumber}
                                        </button>

                                    </c:when>
                                    <c:otherwise>

                                        <button class="seat regular btn-soft-secondary" style=" border: none; padding: 0; font-size: inherit; color: inherit; cursor: pointer;"
                                        >
                                            ❌
                                        </button>


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
            </div>
        </div>
    </div>
</section>
<section>
    <div id="ModalSeat2" class="modalSeat2"  >
        <div class="modal-content">
            <button class="close-btn" onclick="closeModal2()">&times;</button>
            <div class="container-fluid" >
                <div class="layout-specing">
                    <div class="plane-container">
                        <div class="plane-title"><img
                                alt="control room"
                                src="${pageContext.request.contextPath}/views/admin/assets/images/airlines/control_room_airline.png">
                        </div>

                        <div class="plane">
                            <hr style="width: 80%; margin: 20px auto; border: 2px solid black;">


                            <c:if test="${not empty airline2}">
                            <!-- Ghế VIP -->
                            <p>VIP Seats</p>
                            <c:set var="count" value="0"/>
                            <c:forEach var="seat" items="${seats2}">
                                <c:if test="${seat.seatClass eq 'Vip'}">
                                    <!-- Nếu là ghế đầu tiên của hàng mới, tạo div row -->
                                    <c:if test="${count % airline2.numberOfSeatsOnVipRow == 0}">
                                        <div class="row">
                                    </c:if>
                                    <!-- Hiển thị ghế -->
                                    <c:choose>
                                        <c:when test="${seat.status == 1}">


                                            <button  id="${seat.seatId}" class="seat vip" data-seat="2" data-number="${seat.seatNumber}" data-id="${seat.seatId}" style="background-color: gold; border: none; padding: 0; font-size: inherit; color: inherit; cursor: pointer;"
                                            >
                                                    ${seat.seatNumber}
                                            </button>


                                        </c:when>
                                        <c:otherwise>


                                            <button class="seat vip btn-soft-secondary" style=" border: none; padding: 0; font-size: inherit; color: inherit; cursor: pointer;"
                                            >
                                                ❌
                                            </button>


                                        </c:otherwise>
                                    </c:choose>




                                    <c:set var="count" value="${count + 1}"/>


                                    <!-- Nếu đủ 6 ghế, đóng div row -->
                                    <c:if test="${count % airline2.numberOfSeatsOnVipRow == 0}">
                                        </div>
                                    </c:if>
                                </c:if>
                            </c:forEach>


                            <c:if test="${count % airline2.numberOfSeatsOnVipRow != 0}">
                        </div>
                        </c:if>


                        <hr style="width: 80%; margin: 20px auto; border: 2px solid black;">


                        <!-- Ghế Economy -->
                        <p>Economy Seats</p>
                        <c:set var="count" value="0"/>
                        <c:forEach var="seat" items="${seats2}">
                            <c:if test="${seat.seatClass eq 'Economy'}">
                                <c:if test="${count % airline2.numberOfSeatsOnEconomyRow == 0}">
                                    <div class="row">
                                </c:if>

                                <c:choose>
                                    <c:when test="${seat.status == 1}">


                                        <button id="${seat.seatId}" class="seat regular" data-seat="2" data-number="${seat.seatNumber}" data-id="${seat.seatId}" style=" border: none; padding: 0; font-size: inherit; color: inherit; cursor: pointer;"
                                        >
                                                ${seat.seatNumber}
                                        </button>


                                    </c:when>
                                    <c:otherwise>


                                        <button  class="seat regular btn-soft-secondary" style=" border: none; padding: 0; font-size: inherit; color: inherit; cursor: pointer;"
                                        >
                                            ❌
                                        </button>


                                    </c:otherwise>
                                </c:choose>


                                <c:set var="count" value="${count + 1}"/>


                                <c:if test="${count % airline2.numberOfSeatsOnEconomyRow == 0}">
                                    </div>
                                </c:if>
                            </c:if>
                        </c:forEach>


                        <c:if test="${count % airline2.numberOfSeatsOnEconomyRow != 0}">
                    </div>
                    </c:if>
                    </c:if>

                    <hr style="width: 80%; margin: 20px auto; border: 2px solid black;">


                    <div class="plane-title"><img
                            alt="airline tail"
                            src="${pageContext.request.contextPath}/views/admin/assets/images/airlines/tail.png">
                    </div>
                </div>
            </div>
        </div>
    </div>


</section>


<script>
    function closeModal() {
        document.getElementById("ModalSeat").style.display = "none";
    }
    function closeModal2() {
        document.getElementById("ModalSeat2").style.display = "none";
    }
</script>

<script>
    function updateTotalBaggage() {
        var totalBaggage = 0;
        var baggageId = 0;

        // Tính giá hành lý cho chuyến đi của người lớn (1 đến adultTicket)
        for (var i = 1; i <= <%= adultTicket %>; i++) {
            var baggageElement = document.getElementById("baggage" + i);
            if (baggageElement) {  // Kiểm tra xem phần tử có tồn tại không
                baggageId = parseInt(baggageElement.value);
                if (baggageId !== 0) {
                    var selectedOption = baggageElement.options[baggageElement.selectedIndex];
                    totalBaggage += parseInt(selectedOption.getAttribute('data-price'));
                }
            }
        }
        // Tính giá hành lý cho chuyến về của người lớn (nếu m == 2)
        var n = <%= m %>; // Gán giá trị của m từ JSP vào biến JavaScript
        if (n === 2) {
            for (var i = 1; i <= <%= adultTicket %>; i++) {
                var returnBaggageId = i + <%= (adultTicket + childTicket + infantTicket) %>;
                var baggageElement = document.getElementById("baggage" + returnBaggageId);
                if (baggageElement) {
                    baggageId = parseInt(baggageElement.value);
                    if (baggageId !== 0) {
                        var selectedOption = baggageElement.options[baggageElement.selectedIndex];
                        totalBaggage += parseInt(selectedOption.getAttribute('data-price'));
                    }
                }
            }
        }

        // Cập nhật giá hành lý hiển thị
        document.getElementById("totalBaggage").innerText = "= " + new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(totalBaggage);

        // Gọi hàm cập nhật tổng giá
        updateTotalPrice(totalBaggage);
    }
    function updateTotalPrice(totalBaggage) {
        // Lấy giá vé cơ bản từ thuộc tính data-total-ticket-price
        var totalTicketPrice = parseFloat(document.getElementById("totalPrice").getAttribute('data-total-ticket-price'));
        // Tính tổng giá: giá vé cơ bản + giá hành lý
        var total = totalTicketPrice + totalBaggage;

        // Cập nhật hiển thị tổng giá
        document.getElementById("totalPrice").innerText = new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(total);
    }
    window.openSeatModal = openSeatModal;



    function openSeatModal(elementId) {
        // Lấy modal theo ID
        closeAllModals();
        var modal = document.getElementById("ModalSeat");
        // Hiển thị modal
        modal.style.display = "flex";
        if (modal.hasAttribute("data-target-id")) {
            modal.removeAttribute("data-target-id");
        }
        // Lưu ID của người dùng đang chọn ghế
        modal.setAttribute("data-target-id", elementId);
    }
    let currentChoosingSeat = [];
    let selectedSeats = [];
    let selectedSeats2 = [];
    function getIndexFromName(name) {
        // Tìm số cuối trong chuỗi name (ví dụ: "Adult1" -> 1)
        var match = name.match(/\d+$/);
        return match ? parseInt(match[0]) : null; // Chuyển về số nguyên, nếu không có số thì trả về null
    }
    document.addEventListener("click", function (event) {
        if (event.target.tagName === "BUTTON" && event.target.hasAttribute("data-id") && event.target.getAttribute("data-seat")==1) {
            var modal = document.getElementById("ModalSeat");
            var seatButton = event.target;
            var seatCode = event.target.getAttribute("data-id");
            var targetId = modal.getAttribute("data-target-id");
            var seatNumber = event.target.getAttribute("data-number");
            if (!targetId) return; // Nếu không có targetId, thoát khỏi hàm


            // Kiểm tra xem ghế này đã có ai chọn chưa
            var existingSeat = selectedSeats.find(seat => seat.seatId === seatCode);


            if (existingSeat && existingSeat.name !== targetId) {
                alert("Ghế này đã có người khác chọn!");
                return;
            }


            // Tìm xem người dùng này đã chọn ghế nào chưa
            var userSeatIndex = selectedSeats.findIndex(seat => seat.name === targetId);


            if (userSeatIndex !== -1) {
                // Nếu bấm vào lại ghế cũ, bỏ chọn ghế đó
                if (selectedSeats[userSeatIndex].seatId === seatCode) {
                    selectedSeats.splice(userSeatIndex, 1);
                    seatButton.classList.remove("selector"); // Xóa class màu
                    document.getElementById(`seatCodeForDisplaying`+getIndexFromName(targetId)).innerText = "Not Selected";
                    document.getElementById(`seatCode`+getIndexFromName(targetId)).value = "";
                } else {
                    // Nếu chọn ghế khác, đổi ghế
                    const seatId = selectedSeats[userSeatIndex].seatId;


                    document.getElementById(seatId)?.classList.remove("selector");
                    console.log(document.getElementById(seatId))
                    // **Cập nhật seatId mới trong danh sách**
                    selectedSeats[userSeatIndex].seatId = seatCode;


                    seatButton.classList.add("selector"); // Thêm màu ghế mới


                    // Cập nhật giao diện hiển thị ghế
                    document.getElementById(`seatCodeForDisplaying` + getIndexFromName(targetId)).innerText = seatNumber;
                    document.getElementById(`seatCode` + getIndexFromName(targetId)).value = seatCode;
                }
            } else {
                // Nếu chưa có ghế nào, thêm mới vào danh sách
                selectedSeats.push({ name: targetId, seatId: seatCode });
                seatButton.classList.add("selector"); // Thêm màu ghế mới


                // Cập nhật giao diện hiển thị ghế
                document.getElementById(`seatCodeForDisplaying`+ getIndexFromName(targetId)).innerText = seatNumber;
                document.getElementById(`seatCode`+getIndexFromName(targetId)).value = seatCode;
            }


            console.log("Selected Seats:", selectedSeats); // Kiểm tra danh sách ghế đã chọn


            // Đóng modal sau khi chọn ghế
            closeModal();
        }
    });
    document.addEventListener("click", function (event) {
        if (event.target.tagName === "BUTTON" && event.target.hasAttribute("data-id") && event.target.getAttribute("data-seat")==2) {
            var modal = document.getElementById("ModalSeat2");
            var seatButton = event.target;
            var seatCode = event.target.getAttribute("data-id");
            var targetId = modal.getAttribute("data-target-id");
            var seatNumber = event.target.getAttribute("data-number");
            if (!targetId) return; // Nếu không có targetId, thoát khỏi hàm


            // Kiểm tra xem ghế này đã có ai chọn chưa
            var existingSeat = selectedSeats.find(seat => seat.seatId === seatCode);


            if (existingSeat && existingSeat.name !== targetId) {
                alert("Ghế này đã có người khác chọn!");
                return;
            }


            // Tìm xem người dùng này đã chọn ghế nào chưa
            var userSeatIndex = selectedSeats.findIndex(seat => seat.name === targetId);


            if (userSeatIndex !== -1) {
                // Nếu bấm vào lại ghế cũ, bỏ chọn ghế đó
                if (selectedSeats[userSeatIndex].seatId === seatCode) {
                    selectedSeats.splice(userSeatIndex, 1);
                    seatButton.classList.remove("selector"); // Xóa class màu
                    document.getElementById(`seatCodeForDisplayingm`+getIndexFromName(targetId)).innerText = "Not Selected";
                    document.getElementById(`seatCodem`+getIndexFromName(targetId)).value = "";
                } else {
                    // Nếu chọn ghế khác, đổi ghế
                    const seatId = selectedSeats[userSeatIndex].seatId;
                    document.getElementById(seatId)?.classList.remove("selector");
                    console.log(document.getElementById(seatId))
                    // **Cập nhật seatId mới trong danh sách**
                    selectedSeats[userSeatIndex].seatId = seatCode;


                    seatButton.classList.add("selector"); // Thêm màu ghế mới


                    // Cập nhật giao diện hiển thị ghế
                    document.getElementById(`seatCodeForDisplayingm` + getIndexFromName(targetId)).innerText = seatNumber;
                    document.getElementById(`seatCodem` + getIndexFromName(targetId)).value = seatCode;
                }
            } else {
                // Nếu chưa có ghế nào, thêm mới vào danh sách
                selectedSeats.push({ name: targetId, seatId: seatCode });
                seatButton.classList.add("selector"); // Thêm màu ghế mới


                // Cập nhật giao diện hiển thị ghế
                document.getElementById(`seatCodeForDisplayingm`+ getIndexFromName(targetId)).innerText = seatNumber;
                document.getElementById(`seatCodem`+getIndexFromName(targetId)).value = seatCode;
            }


            console.log("Selected Seats 2:", selectedSeats); // Kiểm tra danh sách ghế đã chọn


            // Đóng modal sau khi chọn ghế
            closeModal2();
        }
    });


    function openSeatModal2(elementId) {
        // Lấy modal theo ID
        closeAllModals();
        var modal = document.getElementById("ModalSeat2");


        // Hiển thị modal
        modal.style.display = "flex";
        if (modal.hasAttribute("data-target-id")) {
            modal.removeAttribute("data-target-id");
        }
        // Lưu ID của người dùng đang chọn ghế
        modal.setAttribute("data-target-id", elementId);
    }
    function closeAllModals() {


        document.querySelectorAll(".modalSeat, .modalSeat2").forEach(modal => {
            modal.style.display = "none";
        });
    }
</script>
<script>
    function validateNameInput(totalPassenger) {
        for (var psg = 0; psg <= totalPassenger; psg++) {
            const name = document.getElementById("name" + psg).value.trim();
            if (name === "") {
                alert("Please enter a valid name for passenger " + psg + ". Do not enter spaces only.");
                return false;
            }
        }
        return true;
    }


    function handleSeatClick(seat, seatColor, i) {
        console.log("Seat color: " + seatColor);
        if (seatColor === '#FFF') {
            selectSeat(seat, i);
        } else {
            alert('This seat cannot be selected.');
        }
    }
    let currentChoosingSeat = [];
    let selectedSeats = [];
    let selectedSeats2 = [];


    function selectSeat(seat, i) {
        const seatContainer = seat.querySelector(`.seat-container`);
        const selectedSeatCodeElement = document.getElementById('selectedSeatCode' + i);
        const confirmedSeat = document.getElementById("seatCode" + i);
        const confirmedSeatForDisplaying = document.getElementById("seatCodeForDisplaying" + i);


        const seatCode = seat.querySelector('.seatName').value;
        if (i <= <%=adultTicket+childTicket+infantTicket%>) {
            if (selectedSeats.includes(seatCode) && currentChoosingSeat[i] !== seat) {
                alert('This seat is already selected by another passenger.');
                return;
            }
        } else {
            if (selectedSeats2.includes(seatCode) && currentChoosingSeat[i] !== seat) {
                alert('This seat is already selected by another passenger.');
                return;
            }
        }


        console.log(currentChoosingSeat[i]);
        console.log(selectedSeats);
        //khi đang có ghế được chọn, chuyển ghế đó thành empty
        if (currentChoosingSeat[i] !== undefined && currentChoosingSeat[i] !== null) {
            const preSeat = currentChoosingSeat[i].querySelector('.seat-container');
            const preRects = preSeat.querySelectorAll('svg rect');
            preRects.forEach(rect => {
                rect.setAttribute("fill", "#FFF");
                rect.setAttribute("stroke", "#B8B8B8");
            });
            const prePaths = preSeat.querySelectorAll('path');
            prePaths.forEach(path => {
                path.setAttribute("d", "");
            });
            //xoá ghế chọn trước đó khỏi selectedSeat
            if (i <= <%=adultTicket+childTicket+infantTicket%>) {
                const index = selectedSeats.indexOf(currentChoosingSeat[i].querySelector('.seatName').value);
                if (index > -1) {
                    selectedSeats.splice(index, 1);
                }
            } else {
                const index = selectedSeats2.indexOf(currentChoosingSeat[i].querySelector('.seatName').value);
                if (index > -1) {
                    selectedSeats2.splice(index, 1);
                }
            }


        }


        if (currentChoosingSeat[i] !== seat) {// nhấn sang ghế khác
            const seatRects = seatContainer.querySelectorAll('svg rect');
            seatRects.forEach(rect => {
                rect.setAttribute("fill", "rgb(139, 229, 176)");
                rect.setAttribute("stroke", "green");
            });
            const seatPaths = seatContainer.querySelectorAll('path');
            seatPaths.forEach(path => {
                path.setAttribute("d", "M20 6.333A6.67 6.67 0 0 0 13.334 13 6.67 6.67 0 0 0 20 19.667 6.67 6.67 0 0 0 26.667 13 6.669 6.669 0 0 0 20 6.333zm-1.333 10L15.333 13l.94-.94 2.394 2.387 5.06-5.06.94.946-6 6z");
                path.setAttribute("fill", "green");
            });


            currentChoosingSeat[i] = seat;


            if (i <= <%=adultTicket+childTicket+infantTicket%>) {
                selectedSeats.push(seatCode);//thêm ghế vừa chọn vào danh sách ghế được chọn của chuyến đi
            } else {
                selectedSeats2.push(seatCode);//thêm ghế vừa chọn vào danh sách ghế được chọn của chuyến về
            }
            let tmp = currentChoosingSeat[i].querySelector('.seatName').value;
            //phần hiển thị ở modal
            selectedSeatCodeElement.textContent = tmp;
            //phần input và hiển thị ở form
            confirmedSeat.value = tmp;
            confirmedSeatForDisplaying.textContent = tmp;
        } else { // nhấn thêm lần nữa vào ghế đang chọn để huỷ chọn
            const seatRects = seatContainer.querySelectorAll('svg rect');
            seatRects.forEach(rect => {
                rect.setAttribute("fill", "#FFF");
                rect.setAttribute("stroke", "#B8B8B8");
            });
            const seatPaths = seatContainer.querySelectorAll('path');
            seatPaths.forEach(path => {
                path.setAttribute("d", " ");
            });


            if (i <= <%=adultTicket+childTicket+infantTicket%>) {
                const index = selectedSeats.indexOf(currentChoosingSeat[i].querySelector('.seatName').value);
                if (index > -1) {
                    selectedSeats.splice(index, 1);
                }
            } else {
                const index = selectedSeats2.indexOf(currentChoosingSeat[i].querySelector('.seatName').value);
                if (index > -1) {
                    selectedSeats2.splice(index, 1);
                }
            }
            currentChoosingSeat[i] = null;
            selectedSeatCodeElement.textContent = 'None';
            confirmedSeatForDisplaying.textContent = 'Not Selected';
            confirmedSeat.value = null;
        }
    }
    function validateSelectTicket() {
        const seatInputs = document.querySelectorAll("input[type='hidden'][name^='code']");
        for (let input of seatInputs) {
            if (!input.value) {
                alert("Please select a seat for all tickets before submitting.");
                return false;
            }
        }
        return true;
    }


</script>




</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>


</html>

