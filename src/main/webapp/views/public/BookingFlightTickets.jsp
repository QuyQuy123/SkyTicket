<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="dal.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.List" %>

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


    </style>
</head>
<body>
<jsp:include page="/views/layout/Header.jsp"/>

<%
    SimpleDateFormat timeFmt = new SimpleDateFormat("HH:mm");
    SimpleDateFormat dateFmt = new SimpleDateFormat("dd/MM/yyyy");
    AirlinesDAO ald = new AirlinesDAO();
    FlightsDAO fd = new FlightsDAO();
    SeatsDAO sd = new SeatsDAO();
    AirportsDAO apd = new AirportsDAO();
    LocationsDAO ld = new LocationsDAO();
    CountriesDAO cd = new CountriesDAO();
    BaggageDAO bd = new BaggageDAO();


    int adultTicket = Integer.parseInt(request.getParameter("adult"));
    int childTicket = Integer.parseInt(request.getParameter("child")==null?"0":request.getParameter("child"));
    int infantTicket = Integer.parseInt(request.getParameter("infant"));
    int totalPassengers = adultTicket + childTicket +infantTicket;

    Seats s = sd.getSeatById(Integer.parseInt(request.getParameter("seatCategory")));//seatId

    int flightlId = Integer.parseInt(request.getParameter("flightDetailId"));
    Flights f = fd.getFlightById(flightlId);
    int airlineId = f.getAirlineId();
    Airlines a = ald.getAirlineById(airlineId);
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

<main>
    <div class="container" style="margin-top: 100px;">
        <div class="main-container">
            <img src="<%= request.getContextPath() + "/img/" + a.getImage() %>" alt="Logo">
            <div class="details">
                <h3>Additional Details: </h3>
                <p>- Passengers: <span><%=adultTicket%> adult,
                            <%=childTicket%> children,
                            <%=infantTicket%> infant</span></p>
                <p>- Airline: <span><%=a.getAirlineName()%></span></p>

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
                int airlineId2 = -1;
                Flights fl2 = null;
                if(request.getParameter("flightDetailId2")!=null){
                    totalPassengers*=2;
                    flightDetailId2= Integer.parseInt(request.getParameter("flightDetailId2"));
                    s2 = sd.getSeatById(Integer.parseInt(request.getParameter("seatCategory2")));
                    fl2 = (Flights)fd.getFlightById(flightDetailId2);
                    Flights f2 = fd.getFlightById(fl2.getFlightId());
                    airlineId2 = f2.getAirlineId();
                    Airlines a2 = ald.getAirlineById(airlineId2);
                    int departureAirportId2 = f2.getDepartureAirportId();
                    Airports dpa2 = apd.getAirportById(departureAirportId2);
                    Locations dpl2 = ld.getLocationByLId(dpa2.getLocationId());

                    Countries dpc2 = cd.getCountryById(dpl2.getCountryId());

                    int destinationAirportId2 = f2.getArrivalAirportId();
                    Airports dsa2 = apd.getAirportById(destinationAirportId2);
                    Locations dsl2 = ld.getLocationByLId(dsa2.getLocationId());
                    Countries dsc2 = cd.getCountryById(dsl2.getCountryId());
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
                    <input type="hidden" name="commonPrice2" value="<%= fl2.getClassEconomyPrice() %>"/>
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
                            <div class="passenger-info-input" style="position: relative">
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
                                        <select name="pBaggages<%=i%>" id="baggage<%=i%>" onchange="updateTotalBaggage()">
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
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 200px">Select seat for departuring:</div>
                                        <div style="display: flex; align-items: center; margin-right: 20px; font-weight: 600; font-size: 16px; color: #3C6E57">
                                            <span style=""><%=s.getSeatClass()%> - <span id="seatCodeForDisplaying<%=i%>">Not Selected</span></span>
                                        </div>
                                        <a class="btn btn-info" style="text-decoration: none" onclick="openSeatModal(<%=i%>)">Choose</a>
                                        <input type="hidden" name="code<%=i%>" id="seatCode<%=i%>"/>
                                    </div>
                                    <% if(m==2){
                                    %>
                                    <div class="passenger-info-input-box"  >
                                        <div class="passenger-info-input-title" style="width: 121px">Baggage:</div>
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
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 200px">Select seat for returning:</div>
                                        <div style="display: flex; align-items: center; margin-right: 20px; font-weight: 600; font-size: 16px; color: #3C6E57">
                                            <span style=""><%=s2.getSeatClass()%> - <span id="seatCodeForDisplaying<%=i+totalPassengers/2%>">Not Selected</span></span>
                                        </div>
                                        <button class="btn btn-info" style="text-decoration: none" onclick="openSeatModal(<%=i+totalPassengers/2%>)">Choose</button>
                                        <input type="hidden" name="code<%=i+totalPassengers/2%>" id="seatCode<%=i+totalPassengers/2%>"/>
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
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 200px" >Select seat for departuring:</div>
                                        <div style="display: flex; align-items: center; margin-right: 20px; font-weight: 600; font-size: 16px; color: #3C6E57">
                                            <span style=""><%=s.getSeatClass()%> - <span id="seatCodeForDisplaying<%=i%>">Not Selected</span></span>
                                        </div>
                                        <a class="btn btn-info" style="text-decoration: none" onclick="openSeatModal(<%=i%>)">Choose</a>

                                        <input type="hidden" name="code<%=i%>" id="seatCode<%=i%>"/>
                                    </div>
                                    <% if(m==2){
                                    %>
                                    <div class="passenger-info-input-box">
                                        <div class="passenger-info-input-title" style="width: 200px">Select seat for returning:</div>
                                        <div style="display: flex; align-items: center; margin-right: 20px; font-weight: 600; font-size: 16px; color: #3C6E57">
                                            <span style=""><%=s2.getSeatClass()%> - <span id="seatCodeForDisplaying<%=i+totalPassengers/2%>">Not Selected</span></span>
                                        </div>
                                        <a class="btn btn-info" style="text-decoration: none" onclick="openSeatModal(<%=i+totalPassengers/2%>)">Choose</a>
                                        <input type="hidden" name="code<%=i+totalPassengers/2%>" id="seatCode<%=i+totalPassengers/2%>"/>
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
                        double inboundVipPrice = (m == 2) ? fl2.getClassVipPrice() : 0;       // Giá Business lượt về (0 nếu không có)
                        double inboundEconomyPrice = (m == 2) ? fl2.getClassEconomyPrice() : 0; // Giá Economy lượt về (0 nếu không có)

                        // Lấy hạng vé từng chặng
                        String outboundClass = s.getSeatClass(); // Hạng vé lượt đi
                        String inboundClass = (m == 2) ? s2.getSeatClass() : "";   // Hạng vé lượt về (rỗng nếu không có)

                        // Tính giá cho người lớn từng chặng
                        double outboundAdultPrice = (outboundClass.equals("Business") ? outboundVipPrice : outboundEconomyPrice) * adultTicket;
                        double inboundAdultPrice = (m == 2) ? (inboundClass.equals("Business") ? inboundVipPrice : inboundEconomyPrice) * adultTicket : 0;

                        // Tính giá cho trẻ em từng chặng (50% giá người lớn)
                        double outboundChildPrice = (outboundClass.equals("Business") ? (outboundVipPrice * 0.5) : (outboundEconomyPrice * 0.5)) * childTicket;
                        double inboundChildPrice = (m == 2) ? (inboundClass.equals("Business") ? (inboundVipPrice * 0.5) : (inboundEconomyPrice * 0.5)) * childTicket : 0;

                        // Tính giá cho trẻ sơ sinh từng chặng (10% giá người lớn)
                        double outboundInfantPrice = (outboundClass.equals("Business") ? (outboundVipPrice * 0.1) : (outboundEconomyPrice * 0.1)) * infantTicket;
                        double inboundInfantPrice = (m == 2) ? (inboundClass.equals("Business") ? (inboundVipPrice * 0.1) : (inboundEconomyPrice * 0.1)) * infantTicket : 0;

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

<%--  Modal chọn ghế--%>
                <%for (int j = 1; j <= totalPassengers; j++) { %>
        <div class="modal fade " id="seatModal<%=j%>" tabindex="-1" aria-labelledby="seatModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="min-width: 45%">
                <div class="modal-content">
                    <div class="modal-header" style="padding:5px 5px;">
                        <button type="button" class="close" style="font-size: 30px; margin-right: 12px;"
                                data-dismiss="modal">×
                        </button>
                        <h4 style="margin-left: 12px">Choose seat</h4>
                    </div>
                    <div style="display: flex;padding: 30px; justify-content: space-around">
                        <div>
                            <table>
                                <%
                                    TicketsDAO td = new TicketsDAO();
                                    int rowNumber = 0; // Bắt đầu từ hàng 0
                                    String[] seatLetters = {"0", "1", "2", "3", "4", "5", "6"}; // 7 cột ???

                                    int seatIndex = 0;

                                    int numberOfSeat = s.getSeatNumber();
                                    String seatCat = s.getSeatClass();
                                    List<String> bookedSeats = td.getAllTicketCodesById(flightlId, s.getSeatId());
                                    if (j > adultTicket + childTicket + infantTicket) {
                                        numberOfSeat = 10;
                                        seatCat = s.getSeatClass();
                                        bookedSeats = td.getAllTicketCodesById(flightlId, s.getSeatId());
                                    }

                                    // Số hàng dọc (mỗi bên 10 ghế)
                                    int numberOfRowsPerSide = 10;
                                %>
                                <thead>
                                <tr>
                                    <% for (int i = 0; i < 6; i++) { %>
                                    <th style="padding-left: 15px;"><%= seatLetters[i] %>
                                    </th>
                                    <% if (i == 2) { %> <!-- Thêm khoảng trống sau cột 2 -->
                                    <th style="padding-left: 15px; width: 40px"></th>
                                    <% }
                                    } %>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    for (int row = 0; row < numberOfRowsPerSide; row++) { // Lặp qua 10 hàng
                                %>
                                <tr>
                                    <%
                                        // Bên trái: 3 cột (0, 1, 2)
                                        for (int col = 0; col < 3; col++) {
                                            String seatCode = seatLetters[col] + row; // Tạo mã ghế (00, 01, 02, ..., 10, 11, 12, ...)
                                            String seatColor = bookedSeats.contains(seatCode) ? "#D8D8D8" : "#FFF";
                                            String strokeColor = "#B8B8B8";
//                                            Tickets thisTicket = td.getTicketByCode(seatCode, flightlId, s.getSeatId());
//                                            if(j>adultTicket+childTicket+infantTicket){
//                                                thisTicket = td.getTicketByCode(seatCode, flightlId, s.getSeatId());
//                                            }
                                    %>

                                    <td class="seat<%=j%>" data-seat-code="<%= seatCode %>">
                                        <div onclick="handleSeatClick(this, '<%= seatColor %>', <%= j %>)"
                                             data-disabled="false" style="padding-right: 10px" data-color="#B8B8B8">
                                            <div class="seat-container">
                                                <svg width="40" height="32" viewBox="0 0 40 32" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                    <rect x="8.75" y="2.75" width="22.5" height="26.5" rx="2.25"
                                                          fill="<%= seatColor %>" stroke="<%= strokeColor %>"
                                                          stroke-width="1.5" stroke-linejoin="round"></rect>
                                                    <rect x="10.25" y="11.75" width="14.5" height="5.5" rx="2.25"
                                                          transform="rotate(90 10.25 11.75)" fill="<%= seatColor %>"
                                                          stroke="<%= strokeColor %>" stroke-width="1.5"
                                                          stroke-linejoin="round"></rect>
                                                    <rect x="35.25" y="11.75" width="14.5" height="5.5" rx="2.25"
                                                          transform="rotate(90 35.25 11.75)" fill="<%= seatColor %>"
                                                          stroke="<%= strokeColor %>" stroke-width="1.5"
                                                          stroke-linejoin="round"></rect>
                                                    <rect x="8.75" y="22.75" width="22.5" height="6.5" rx="2.25"
                                                          fill="<%= seatColor %>" stroke="<%= strokeColor %>"
                                                          stroke-width="1.5" stroke-linejoin="round"></rect>
                                                    <path class="icon-selected"
                                                          d="M20 6.333A6.67 6.67 0 0 0 13.334 13 6.67 6.67 0 0 0 20 19.667 6.67 6.67 0 0 0 26.667 13 6.669 6.669 0 0 0 20 6.333zm-1.333 10L15.333 13l.94-.94 2.394 2.387 5.06-5.06.94.946-6 6z"
                                                          fill="transparent"></path>
                                                </svg>
                                                <input type="hidden" class="seatName" value="<%= seatCode %>"/>
                                            </div>
                                        </div>
                                    </td>
                                    <% }
                                        // Khoảng trống ở giữa (cột 3)
                                    %>
                                    <td></td> <!-- Để trống cột giữa làm hành lang, không cho phép chọn -->
                                    <%
                                        // Bên phải: 3 cột (4, 5, 6)
                                        for (int col = 3; col < 6; col++) {
                                            String seatCode = seatLetters[col] + row; // Tạo mã ghế (40, 50, 60, ..., 41, 51, 61, ...)
                                            String seatColor = bookedSeats.contains(seatCode) ? "#D8D8D8" : "#FFF";
                                            String strokeColor = "#B8B8B8";
//                                            Tickets thisTicket = td.getTicketByCode(seatCode, flightlId, s.getSeatId());
//                                            if(j>adultTicket+childTicket+infantTicket){
//                                                thisTicket = td.getTicketByCode(seatCode, flightlId, s.getSeatId());
//                                            }
                                    %>

                                    <td class="seat<%=j%>" data-seat-code="<%= seatCode %>">
                                        <div onclick="handleSeatClick(this, '<%= seatColor %>', <%= j %>)"
                                             data-disabled="false" style="padding-right: 10px" data-color="#B8B8B8">
                                            <div class="seat-container">
                                                <svg width="40" height="32" viewBox="0 0 40 32" fill="none"
                                                     xmlns="http://www.w3.org/2000/svg">
                                                    <rect x="8.75" y="2.75" width="22.5" height="26.5" rx="2.25"
                                                          fill="<%= seatColor %>" stroke="<%= strokeColor %>"
                                                          stroke-width="1.5" stroke-linejoin="round"></rect>
                                                    <rect x="10.25" y="11.75" width="14.5" height="5.5" rx="2.25"
                                                          transform="rotate(90 10.25 11.75)" fill="<%= seatColor %>"
                                                          stroke="<%= strokeColor %>" stroke-width="1.5"
                                                          stroke-linejoin="round"></rect>
                                                    <rect x="35.25" y="11.75" width="14.5" height="5.5" rx="2.25"
                                                          transform="rotate(90 35.25 11.75)" fill="<%= seatColor %>"
                                                          stroke="<%= strokeColor %>" stroke-width="1.5"
                                                          stroke-linejoin="round"></rect>
                                                    <rect x="8.75" y="22.75" width="22.5" height="6.5" rx="2.25"
                                                          fill="<%= seatColor %>" stroke="<%= strokeColor %>"
                                                          stroke-width="1.5" stroke-linejoin="round"></rect>
                                                    <path class="icon-selected"
                                                          d="M20 6.333A6.67 6.67 0 0 0 13.334 13 6.67 6.67 0 0 0 20 19.667 6.67 6.67 0 0 0 26.667 13 6.669 6.669 0 0 0 20 6.333zm-1.333 10L15.333 13l.94-.94 2.394 2.387 5.06-5.06.94.946-6 6z"
                                                          fill="transparent"></path>
                                                </svg>
                                                <input type="hidden" class="seatName" value="<%= seatCode %>"/>
                                            </div>
                                        </div>
                                    </td>
                                    <% }
                                    %>
                                </tr>
                                <% }
                                %>
                                </tbody>
                            </table>
                        </div>
                        <div>
                            <div style="padding-top: 20px">
                                <div style="margin-bottom: 10px">
                                    <svg width="40" height="32" viewBox="0 0 40 32" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <rect x="8.75" y="2.75" width="22.5" height="26.5" rx="2.25" fill="#FFF"
                                              stroke="#B8B8B8" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="10.25" y="11.75" width="14.5" height="5.5" rx="2.25"
                                              transform="rotate(90 10.25 11.75)" fill="#FFF" stroke="#B8B8B8"
                                              stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="35.25" y="11.75" width="14.5" height="5.5" rx="2.25"
                                              transform="rotate(90 35.25 11.75)" fill="#FFF" stroke="#B8B8B8"
                                              stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="8.75" y="22.75" width="22.5" height="6.5" rx="2.25" fill="#FFF"
                                              stroke="#B8B8B8" stroke-width="1.5" stroke-linejoin="round"></rect>
                                    </svg>
                                    Empty Seat
                                </div>
                                <div style="margin-bottom: 10px">
                                    <svg width="40" height="32" viewBox="0 0 40 32" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <rect x="8.75" y="2.75" width="22.5" height="26.5" rx="2.25"
                                              fill="rgb(139, 229, 176)" stroke="green" stroke-width="1.5"
                                              stroke-linejoin="round"></rect>
                                        <rect x="10.25" y="11.75" width="14.5" height="5.5" rx="2.25"
                                              transform="rotate(90 10.25 11.75)" fill="rgb(139, 229, 176)"
                                              stroke="green" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="35.25" y="11.75" width="14.5" height="5.5" rx="2.25"
                                              transform="rotate(90 35.25 11.75)" fill="rgb(139, 229, 176)"
                                              stroke="green" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="8.75" y="22.75" width="22.5" height="6.5" rx="2.25"
                                              fill="rgb(139, 229, 176)" stroke="green" stroke-width="1.5"
                                              stroke-linejoin="round"></rect>
                                    </svg>
                                    Selected Seat
                                </div>
                                <div style="margin-bottom: 10px">
                                    <svg width="40" height="32" viewBox="0 0 40 32" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <rect x="8.75" y="2.75" width="22.5" height="26.5" rx="2.25" fill="#D8D8D8"
                                              stroke="#B8B8B8" stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="10.25" y="11.75" width="14.5" height="5.5" rx="2.25"
                                              transform="rotate(90 10.25 11.75)" fill="#D8D8D8" stroke="#B8B8B8"
                                              stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="35.25" y="11.75" width="14.5" height="5.5" rx="2.25"
                                              transform="rotate(90 35.25 11.75)" fill="#D8D8D8" stroke="##B8B8B8"
                                              stroke-width="1.5" stroke-linejoin="round"></rect>
                                        <rect x="8.75" y="22.75" width="22.5" height="6.5" rx="2.25" fill="#D8D8D8"
                                              stroke="#B8B8B8" stroke-width="1.5" stroke-linejoin="round"></rect>
                                    </svg>
                                    Booked Seat
                                </div>
                                <div style="margin-right: auto; font-size: 15px; font-weight: bold; color: green;">
                                    Choosing Seat:</br> <%=seatCat%> - <span id="selectedSeatCode<%=j%>">None</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Confirm</button>
                    </div>
                </div>
            </div>
            <% } %>
        </div>


    </div>

</main>



    <div style="margin-bottom: 0px">
        <jsp:include page="/views/layout/Footer.jsp"/>
    </div>


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
    function openSeatModal(i) {
        console.log("Opening modal for passenger " + i);
        $("#seatModal" + i).modal('show');
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

    function submitPassengerForm(totalPassenger) {
        const form = document.getElementById("passengerForm");
        if (form.checkValidity() && validateSelectTicket() && validateNameInput(totalPassenger)) {
            form.submit();
        } else {
            form.reportValidity();
        }

    }
    function updateTotalBaggage() {
        var totalBaggage = 0;
        var baggageId = 0;

        // Tính giá hành lý cho hành khách người lớn (1 đến adultTicket)
        for (var i = 1; i <= <%= adultTicket %>; i++) {
            var baggageElement = document.getElementById("baggage" + i);
            baggageId = parseInt(baggageElement ? baggageElement.value : 0);
            if (baggageId !== 0) {
                var selectedOption = baggageElement.options[baggageElement.selectedIndex];
                totalBaggage += parseInt(selectedOption.getAttribute('data-price'));
            }
        }

        // Tính giá hành lý cho hành khách còn lại (từ adultTicket + childTicket + infantTicket + 1 đến totalPassengers)
        for (var i = <%= adultTicket + childTicket + infantTicket + 1 %>; i <= <%= totalPassengers %>; i++) {
            var baggageElement = document.getElementById("baggage" + i);
            baggageId = parseInt(baggageElement ? baggageElement.value : 0);
            if (baggageId !== 0) {
                var selectedOption = baggageElement.options[baggageElement.selectedIndex];
                totalBaggage += parseInt(selectedOption.getAttribute('data-price'));
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

</script>


</body>


</html>

