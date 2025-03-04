<%--
 Created by IntelliJ IDEA.
 User: 84968
 Date: 1/20/2025
 Time: 2:52 PM
 To change this template use File | Settings | File Templates.
--%>
<%@page import="model.News" %>
<%@page import="dal.NewsDAO" %>
<%@page import="java.util.List" %>
<%@page import="model.Locations"%>
<%@ page import="model.Locations" %>
<%@ page import="dal.LocationsDAO" %>
<%@page import="dal.AirportsDAO"%>
<%@ page import="model.Airports" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="fixed-header" style=";top: 0;left: 0;right: 0;bottom: 0;">
    <jsp:include page="/views/layout/Header.jsp"/>
</div>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/PublicHome.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/News.css"/>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Bootstrap Datepicker CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    <!-- Bootstrap Datepicker JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

    <script src="<%= request.getContextPath() %>/js/Home.js" defer></script>
    <style>
        .flight-form {
            position: relative;
            z-index: 10;
            padding-top: 280px;


        }




        #input-form {
            position: relative;
            z-index: 10;
            top: 45%
        }


        .form-container {
            /*border: 2px solid #ccc;*/
            padding: 2%;
            /*background: rgba(255, 255, 255, 0.3); !* Nền trắng với 80% độ trong suốt *!*/
            /*box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);*/
            height: 240px;
            width: 80%;
            border-radius: 20px;
            border-bottom: none;
        }


        .location-list {
            display: none;
            position: absolute;
            background-color: white;
            border: 1px solid #ccc;
            z-index: 1000;
            width: 250px;
            height: 153px;
            overflow-y: auto;
            top: 80px;
            left: 14px;
            border-radius: 8px;

        }

        .location-item {
            cursor: pointer;
            padding: 10px 15px;
            transition: background-color 0.3s ease;

        }

        .location-item:hover {
            background-color: #f0f0f0;
        }

        .location-item span {
            transition: color 0.3s ease, filter 0.3s ease;
        }

        .passenger-label {
            color: #3C6E57;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .passenger-selector {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 20px;
            display: flex;
            justify-content: space-between;
            width: 100%;
            max-width: 600px;
        }
        .passenger-type {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 33%;
        }
        .passenger-input {
            color: activecaption;
            height: 50%;
            width: 40%;
            font-size: 18px;
        }
        .passenger-controls{
            display: flex;
        }
        .options-container {
            margin-top: 30px;
            width: 400px;
            height: auto;
            border-radius: 5px;
        }
        .passenger-count {
            color: #3C6E57;
            font-size: 20px;
            font-weight: bold;
            width: 55px;
            border: 2px solid;
            border-radius: 5px;
            text-align: center;
            margin: 0 10px;
        }

        .search-button {
            height: 100%;
            margin-top: 18px;
            width: 165px;
            font-size: 18px;
            color: #3C6E57;
            background-color: white;
            border: 2px solid #3C6E57;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .search-button:hover {
            color: white;
            background-color: #5bc0de;
        }

        .age-range{
            margin-top: 8px;
            color: #3C6E57;
            font-size: 12px;
            font-weight: 600;
        }

    </style>

</head>
<body>

<%
    LocationsDAO locate = new LocationsDAO();
    AirportsDAO airport = new AirportsDAO();
%>
 <div>

<div class="background">
    <div class="flight-form ">
    <form id="input-form" action="SearchFlightsURL" method="GET" class="row g-1" onsubmit="return validateLocations(event)">
        <div class="form-container" style="margin: 0 auto">
            <div class="row form-input">
                <div style="display: flex;">
                    <div style="display: flex; align-items: center; font-size: 16px; margin-right: 20px">
                        <input type="radio" id="oneWay" name="flightType" value="oneWay" style="transform: scale(1.5);" checked onclick="toggleReturnDate()">
                        <label for="oneWay" style="color: black;margin: 0; margin-left: 10px">One-way</label>
                    </div>
                    <div style="display: flex; align-items: center; font-size: 16px">
                        <input type="radio" id="roundTrip" name="flightType" value="roundTrip" style="transform: scale(1.5);" onclick="toggleReturnDate()">
                        <label for="roundTrip" style="color: black;margin: 0; margin-left: 10px">Round-trip</label>
                    </div>
                </div>
                <p id="errorMessage" style="font-size: 16px; color: red;"></p>
<%--                <%if(request.getAttribute("account") != null && ((Accounts)request.getAttribute("account")).getRoleId() != 2){--%>
<%--                %>--%>
<%--                <p style="font-size: 16px;color: red;">Please use customer account to use the service.</p>--%>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>

                <div class="row" style="height: 55px; margin-top: 20px">
                    <!-- From Field -->
                    <div class="col-md-2" style="padding-right: 0px">
                        <p style="color: black; margin: 0; font-size: 12px">FROM</p>
                        <input type="text" value="Hà Nội" readonly style="height: 100%;font-size: 18px" class="form-control" id="fromDisplay" onclick="showLocationList('from')" oninput="filterLocations('from')" placeholder="FROM" required >
                        <input type="hidden" value="1" id="from" name="departure">
                        <div id="from-locations" class="location-list" style="margin-top: 88px;margin-left: 85px;width: 300px;height: 300px">

                            <input type="text" id="searchLocation1" onkeyup="filterLocations(event)"
                                   placeholder="Tìm kiếm địa điểm..."
                                   style="width: 100%; padding: 8px; margin-bottom: 10px; font-size: 14px;">

                            <%
                                for(Locations lo : locate.getAllLocation()) {
                                    for(Airports ai : airport.getAllAirports()){
                                        if(ai.getLocationId() == lo.getLocationId()){
                            %>
                            <div class="location-item" onclick="selectLocation('<%= ai.getAirportId() %>', '<%= lo.getLocationName() %>', 'from')">
                                <span class="location-name" style="font-weight: bold; font-size: 16px; color: black;">
                                    <%= lo.getLocationName() %>
                                </span></br>
                                <span class="airport-name" style="font-size: 14px; color: grey; filter: blur(1%);">
                                    <%= ai.getAirportName() %>
                                </span>
                            </div>
                            <% } } } %>
                        </div>

                    </div>



                    <!-- To Field -->
                    <div class="col-md-2" style="padding-right: 0px">
                        <p style="color: black; margin: 0; font-size: 12px">TO</p>
                        <input type="text" value="TP. Hồ Chí Minh" readonly style="height: 100%;font-size: 18px" class="form-control" id="toDisplay" onclick="showLocationList('to')" oninput="filterLocations('to')" placeholder="TO" required>
                        <input type="hidden" value="2" id="to" name="destination">
                        <div id="to-locations" class="location-list" style="margin-top: 88px;margin-left: 260px;width: 300px;height: 300px">

                            <input type="text" id="searchLocation2" onkeyup="filterLocations(event)"
                                   placeholder="Tìm kiếm địa điểm..."
                                   style="width: 100%; padding: 8px; margin-bottom: 10px; font-size: 14px;">
                            <%
                                for(Locations lo : locate.getAllLocation()) {
                                    for(Airports ai : airport.getAllAirports()){
                                        if(ai.getLocationId() == lo.getLocationId()){
                            %>
                            <div class="location-item" onclick="selectLocation('<%= ai.getAirportId() %>', '<%= lo.getLocationName() %>', 'to')">
                                <span class="location-name" style="font-weight: bold; font-size: 16px; color: black;">
                                                    <%= lo.getLocationName() %>
                                </span></br>
                                <span class="airport-name" style="font-size: 14px; color: grey; filter: blur(1%);">
                                                    <%= ai.getAirportName() %>
                                </span>
                            </div>
                            <% } } } %>
                        </div>
                    </div>

                    <!-- Departure Date Field -->
                    <div class="col-md-2" style="padding-right: 0px">
                        <p style="color: black; margin: 0; font-size: 12px">DEPART</p>
                        <input type="date" id="departureDate" class="form-control" name="departureDate" style="height: 100%;font-size: 18px;" placeholder="dd-mm-yyyy" onkeydown="return false;" required >
                    </div>
                    <div class="col-md-2" id="returnDateField" style="display:none;padding-right: 0px" >
                        <p style="color: black; margin: 0; font-size: 12px">RETURN</p>
                        <input type="date" id="returnDate" class="form-control" name="returnDate" style="height: 100%;font-size: 18px;" autocomplete="off"   placeholder="dd-mm-yyyy" onkeydown="return false;">
                    </div>

                    <!-- Passengers Field -->
                    <div class="col-md-4" id="passengerField" style="position: relative; padding-right: 0;">
                        <p style="color: black; margin: 0; font-size: 12px">PASSENGER</p>
                        <input type="number" class="form-control" id="passengers" value="1" min="1" max="10" required readonly
                               onclick="togglePassengerOptions()"
                               style="height: 100%; width: 100%; font-size: 18px;">

                        <div id="passenger-options" class="passenger-options"
                             style="display: none; position: absolute; top: 50px; left: 15px; z-index: 1000;">
                            <div class="options-container" style="margin-top: 46px;margin-left: -32px">
                                <div class="passenger-selector" style="    width: 350px;margin-left: -37px;">
                                    <div class="passenger-type">
                                        <div class="passenger-label">Adult</div>
                                        <div class="passenger-controls">
                                            <input type="number" id="adult-count" class="passenger-count" name="adult" value="1" min="1" max="10" class="passenger-input">
                                        </div>
                                    </div>
                                    <div class="passenger-type">
                                        <div class="passenger-label">Children</div>
                                        <div class="passenger-controls">
                                            <input type="number"id="child-count" class="passenger-count" name="child" value="0" min="0" max="9" class="passenger-input">
                                        </div>
                                        <div class="age-range">2-11 Year Olds</div>
                                    </div>
                                    <div class="passenger-type">
                                        <div class="passenger-label">Infant</div>
                                        <div class="passenger-controls">
                                            <input type="number" id="infant-count" class="passenger-count" name="infant" value="0" min="0" max="5" class="passenger-input">
                                        </div>
                                        <div class="age-range">0-2 Year Olds</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="col-md-2">
                        <button type="submit" class="search-button" onclick="validateDates()" style="margin-top: 21px">
<%--                                <%= (request.getAttribute("account") == null || ((Accounts)request.getAttribute("account")).getRoleId() == 3) ? "" : "disabled" %>>--%>
                            Search Flights
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    </div>

</div>

<div class="main-container">
    <div id="introduction">
        <h1 style="font-size: 30px">Welcome to SkyTicket!</h1>
        <p style="font-size: 16px">Embark on a new adventure – Book your ticket now and explore the world!</p>
    </div>

    <div id="promotion">
        <div class="promotion-item row">
            <div class="col-md-6">
                <img style="transform: rotateY(180deg);" src="<%= request.getContextPath() %>/img/tong_dai.jpg" alt="">
            </div>
            <div class="col-md-6">
                <h3>Attractive offers</h3>
                <p>
                    SkyTicket is committed to providing reasonable fares, many transportation options and attractive promotions.
                    The 24/7 customer care team is always ready to support to bring the best experience to you.
                </p>
            </div>
        </div>
        <div class="promotion-item row">
            <div class="col-md-6">
                <img src="<%= request.getContextPath() %>/img/news_bamboo_2.jpg" alt="">
            </div>
            <div class="col-md-6">
                <h3>Peaceful discovery</h3>
                <p>
                    SkyTicket is committed to ensuring absolute safety for customers. The team of drivers are professionally trained, vehicles are always periodically maintained and equipped with standard safety equipment, so that each of your trips goes smoothly and safely.
                </p>
            </div>
        </div>

    </div>

</div>

<div class="main-container" id="body-2">

    <div style="display: ${empty param.id ? '' : 'none'};margin: 60px 0">
        <h1 style="margin-bottom: 30px; text-align: center; font-size: 30px;color: #007acc">NEWS</h1>
        <div class="news-container">
            <%

                List<News> listNew = (List<News>) request.getAttribute("listNew");

                if (listNew != null) {
                    for (int i = listNew.size() - 1; i >= listNew.size()-4; i--) {
                        News n = listNew.get(i);
            %>
            <div class="news-item" onclick="viewNews('<%= n.getNewId() %>');">
                <img src="<%= n.getImg() %>" alt="<%= n.getTitle() %>" >

                <h2 style="height: 25%;"><%= n.getTitle() %></h2>
                <div class="news-content" style="display: none;">
                    <p><%= n.getContent() %></p>
                </div>

<%--                <div   style="margin-top: 7%;margin-left: 3%;">--%>
<%--                    <img src="#" style="width: 12%; height: 100%;">--%>
<%--                    <p style="margin-top: -8%;--%>
<%--                               margin-left: 14%;--%>
<%--                               font-size: 16px;">BamBoo Eway</p>--%>
<%--                </div>--%>

            </div>
            <%
                    }
                }
            %>
        </div>
        <div style="width: 100%; text-align: center; margin-top: 20px; ">
            <a href="NewsURL" style="font-size: 20px; color: #3C6E57">More >></a>

        </div>
    </div>

</div>
 </div>
<jsp:include page="/views/layout/Footer.jsp"/>



</body>
</html>



