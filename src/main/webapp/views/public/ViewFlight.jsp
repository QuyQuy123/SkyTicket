<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="dal.*" %>
<%@ page import="java.text.NumberFormat" %><%--
  Created by IntelliJ IDEA.
  User: 84968
  Date: 2/21/2025
  Time: 2:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Set" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Tìm kiếm chuyến bay</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/ViewFlight.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
   <style>
       .flight-container {
           min-height: 90vh;
           position: relative;
           padding-bottom: 60px;
       }

       .flight-content {
           flex: 1;
           padding: 20px;
       }

       .pagination-container {
           display: flex;
           justify-content: center;
           align-items: center;
           gap: 10px;
           margin: 20px 0;
           padding: 20px;
           font-family: Arial, sans-serif;
           position: absolute;
           bottom: -100px;
           width: 100%;
           text-align: center;
       }

       .pagination-button {
           padding: 8px 16px;
           background-color: #007bff;
           color: white;
           border: none;
           border-radius: 4px;
           cursor: pointer;
           font-size: 14px;
           transition: background-color 0.3s;
       }

       .pagination-button:disabled {
           background-color: #cccccc;
           cursor: not-allowed;
       }

       .pagination-button:hover:not(:disabled) {
           background-color: #0056b3;
       }

       .pagination-current {
           font-size: 16px;
           color: #333;
           font-weight: bold;
       }

       .pagination-button, .pagination-current {
           z-index: 10;
       }
   </style>
</head>
<body>
<jsp:include page="/views/layout/Header.jsp"/>

<%
    SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
%>
  <%
    LocationsDAO ld = new LocationsDAO();
    CountriesDAO cd = new CountriesDAO();
    AirportsDAO apd = new AirportsDAO();
    AirlinesDAO ald = new AirlinesDAO();
    FlightsDAO fld = new FlightsDAO();
    SeatsDAO sd = new SeatsDAO();

  %>
<div style="margin: 100px 0" class="row">
  <div class="col-md-1">

  </div>
  <div class="col-md-10">
    <div class="flight-detail" style="display: block">
        <%
            Airports depAirport = null, desAirport = null;
            Locations depLocation = null, desLocation = null;
            Countries depCountry = null, desCountry = null;
            int adultNumber = 0, childNumber = 0, infantNumber = 0, totalPassengers = 0;

            String depParam = request.getParameter("departure");
            String desParam = request.getParameter("destination");
            String adultParam = request.getParameter("adult");
            String childParam = request.getParameter("child");
            String infantParam = request.getParameter("infant");

            if (depParam != null && !depParam.isEmpty() && desParam != null && !desParam.isEmpty()) {
                depAirport = (Airports) apd.getAirportById(Integer.parseInt(depParam));
                depLocation = (Locations) ld.getLocationByLId(depAirport.getLocationId());
                depCountry = (Countries) cd.getCountryById(depLocation.getCountryId());

                desAirport = (Airports) apd.getAirportById(Integer.parseInt(desParam));
                desLocation = (Locations) ld.getLocationByLId(desAirport.getLocationId());
                desCountry = (Countries) cd.getCountryById(desLocation.getCountryId());
                // Kiểm tra giá trị trước khi parse
                adultNumber = (adultParam != null && !adultParam.isEmpty()) ? Integer.parseInt(adultParam) : 0;
                childNumber = (childParam != null && !childParam.isEmpty()) ? Integer.parseInt(childParam) : 0;
                infantNumber = (infantParam != null && !infantParam.isEmpty()) ? Integer.parseInt(infantParam) : 0;

                totalPassengers = adultNumber + childNumber + infantNumber;
            }
        if(request.getParameter("flightDetailId")==null){

      %>
      <div style="width: 100%; color:#3C6E57; text-align: center; "><h3>Chọn chuyến bay khởi hành</h3></div>
      <%} else {
        Airports tmpA = depAirport; depAirport = desAirport; desAirport = tmpA;
        Locations tmpL = depLocation; depLocation = desLocation; desLocation = tmpL;
        Countries tmpC = depCountry; depCountry = desCountry; desCountry = tmpC;
//          System.out.println(request.getParameter("flightDetailId"));
      %>
      <div style="width: 100%; color:#3C6E57; text-align: center "><h3>Chọn chuyến bay khứ hồi</h3></div>
      <% }
          assert depCountry != null;%>
      <div class="flight-info" style="width: 100%">
        <div class="airport-info">
          <div class="flight-icon">✈️</div>
          <div class="airport-name"><%=depAirport.getAirportName()%></div>
          <div class="location"><%=depLocation.getLocationName()%>, <%=depCountry.getCountryName()%></div>
        </div>
        <div class="flight-details">
          <div class="flight-icon">🛫</div>
          <div class="flight-type">Hành khách</div>
          <div class="flight-time">
            <%= adultNumber %> Người lớn<% if (adultNumber > 1) { %>s<% } %>
            <% if (childNumber > 0) { %>, <%= childNumber %> Trẻ em<% } %>
            <% if (infantNumber > 0) { %>, <%= infantNumber %> Em bé<% } %>
          </div>
        </div>
        <div class="airport-info">
          <div class="flight-icon">🛬</div>
          <div class="airport-name"><%=desAirport.getAirportName()%></div>
          <div class="location"><%=desLocation.getLocationName()%>, <%=desCountry.getCountryName()%></div>
        </div>
      </div>
    </div>

      <div class="row">
          <div class="col-md-3">
              <div class="flight-detail" style="display: block; height: fit-content; background-color: #f9f9f9">
                  <div class="sorting-options">
                      <h5>Sắp xếp theo:</h5>
                      <div>
                          <input type="radio" id="sortTimeAsc" name="sortFlights" value="timeAsc" onchange="sortFlights(this.value)" checked>
                          <label for="sortTimeAsc">Sớm nhất trước</label>
                      </div>
                      <div>
                          <input type="radio" id="sortTimeDesc" name="sortFlights" value="timeDesc" onchange="sortFlights(this.value)">
                          <label for="sortTimeDesc">Muộn nhất trước</label>
                      </div>
                      <div>
                          <input type="radio" id="sortPriceAsc" name="sortFlights" value="priceAsc" onchange="sortFlights(this.value)">
                          <label for="sortPriceAsc">Giá: Thấp đến cao</label>
                      </div>
                      <div>
                          <input type="radio" id="sortPriceDesc" name="sortFlights" value="priceDesc" onchange="sortFlights(this.value)">
                          <label for="sortPriceDesc">Giá: Cao đến thấp</label>
                      </div>
                  </div>

              </div>
          </div>




          <div class="col-md-9 flights-container">

              <%
                  List<Flights> flightTickets = (List<Flights>) request.getAttribute("flightTickets");
                  if (flightTickets != null && !flightTickets.isEmpty()) {
                      for (Flights f : flightTickets) {
                          int airlineId = fld.getAirlineIdByFlightId(f.getFlightId());


                          String airlineImage = ald.getImageById(airlineId);
                          String airlineName = ald.getNameById(airlineId);
                          Flights flight = fld.getFlightById(f.getFlightId());
                          List<Seats> seats = sd.getAllSeatByAirlineId(airlineId);

              %>
              <div class="flight-detail" style="display: block">
                  <div class="flight-info" style="display: flex">
                      <div class="airline-logo-container">

                          <img src="<%= request.getContextPath() + "/img/" + airlineImage %>"
                               alt="Logo">

                      </div>
                      <div style="width: 88%; display: flex; align-items: center; padding: 30px 15px">
                          <div style="width: 20%; text-align: left">
                              <p class="airline-name"><%= ald.getNameById(airlineId) %></p>
                              <a style="cursor: pointer" onclick="openModal(<%=f.getFlightId()%>)">Thông tin chi tiết</a>
                          </div>

                          <div style="display: flex; width: 42%; padding-top: 1%">
                              <div>
                                  <p class="time depTime"><%= timeFormat.format(f.getDepartureTime()) %></p>
                                  <p class="location"><%=depLocation.getLocationName()%></p>
                              </div>
                              <svg width="150" height="30" xmlns="http://www.w3.org/2000/svg">
                                  <line x1="12" y1="15" x2="65" y2="15" stroke="#B1B9CB" stroke-width="2" stroke-dasharray="5,5"></line>
                                  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" x="70" y="5" viewBox="0 0 576 512">
                                      <path fill="#B1B9CB" d="M482.3 192c34.2 0 93.7 29 93.7 64c0 36-59.5 64-93.7 64l-116.6 0L265.2 495.9c-5.7 10-16.3 16.1-27.8 16.1l-56.2 0c-10.6 0-18.3-10.2-15.4-20.4l49-171.6L112 320 68.8 377.6c-3 4-7.8 6.4-12.8 6.4l-42 0c-7.8 0-14-6.3-14-14c0-1.3 .2-2.6 .5-3.9L32 256 .5 145.9c-.4-1.3-.5-2.6-.5-3.9c0-7.8 6.3-14 14-14l42 0c5 0 9.8 2.4 12.8 6.4L112 192l102.9 0-49-171.6C162.9 10.2 170.6 0 181.2 0l56.2 0c11.5 0 22.1 6.2 27.8 16.1L365.7 192l116.6 0z"></path>
                                  </svg>
                                  <line x1="90" y1="15" x2="150" y2="15" stroke="#B1B9CB" stroke-width="2" stroke-dasharray="5,5"></line>
                              </svg>


                              <div>
                                  <p class="time"><%= timeFormat.format(f.getArrivalTime()) %></p>
                                  <p class="location"><%=desLocation.getLocationName()%></p>
                              </div>
                          </div>
                          <div style="display: flex; align-items: center; width: 38%; justify-content: end">
                              <div class="price">
                                  <span class="old-price"><%= NumberFormat.getInstance().format(f.getClassVipPrice()) %> ₫</span>
                                  <span><span style="font-size: 17px">chỉ từ</span> <%= NumberFormat.getInstance().format(f.getClassEconomyPrice())%> ₫</span>
                              </div>
                              <div style="display: flex; margin-left: 20px" onclick="showTicketCategory(<%=f.getFlightId()%>)">

                                  <svg class="arrow" id="arrow<%=f.getFlightId()%>" xmlns="http://www.w3.org/2000/svg" height="25" width="25" viewBox="0 0 512 512" style="transition: transform 0.3s ease;">
                                      <path d="M233.4 406.6c12.5 12.5 32.8 12.5 45.3 0l192-192c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L256 338.7 86.6 169.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l192 192z"></path>
                                  </svg>
                              </div>
                          </div>
                      </div>
                  </div>


                  <div id="ticket-category-container<%=f.getFlightId()%>" style="max-height: 0; overflow: hidden; transition: max-height 0.5s ease, opacity 0.5s ease; opacity: 0;">
                      <div style="text-align: center; font-size: 20px">Chọn hạng vé</div>
                      <div class="ticket-category-list" style="display: flex; flex-wrap: wrap; justify-content: center; gap: 90px;">
                          <%
                              Set<String> displayedClasses = new HashSet<>();

                              int businessSeatsActive = 0;
                              int economySeatsActive = 0;

                              for (int i = 0; i < seats.size(); i++) {
                                  String seatClass = seats.get(i).getSeatClass();
                                  if (seats.get(i).getStatus() == 1) {
                                      if ("Business".equals(seatClass)) {
                                          businessSeatsActive++;
                                      } else if ("Economy".equals(seatClass)) {
                                          economySeatsActive++;
                                      }
                                  }
                              }
                              String[] targetClasses = {"Business", "Economy"};
                              for (String targetClass : targetClasses) {
                                  for (int i = 0; i < seats.size(); i++) {
                                      String seatClass = seats.get(i).getSeatClass();
                                      if (!targetClass.equals(seatClass)) {
                                          continue;
                                      }

                                      if (displayedClasses.contains(seatClass)) {
                                          continue;
                                      }
                                      displayedClasses.add(seatClass);
                                      double price = 0;
                                      if ("Business".equals(seatClass)) {
                                          price = (long) f.getClassVipPrice();
                                      } else if ("Economy".equals(seatClass)) {
                                          price = f.getClassEconomyPrice();
                                      }
                                      boolean isCategoryActive = ("Business".equals(seatClass) && businessSeatsActive > 0) || ("Economy".equals(seatClass) && economySeatsActive > 0);
                          %>

                          <div class="ticket-category-box" style="width:30%;margin-bottom: 50px">
                              <div class="ticket-category-head" style="background-color:cadetblue;">
                                  <%= seatClass %>
                                  <div style="font-size: 25px"><%= NumberFormat.getInstance().format(price) %> ₫</div>
                              </div>
                              <div class="ticket-category-body" style="border: 2px solid <% %>; padding: 12px 12px; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px; min-height: 85%">
                                  <div>
                                      <img style="width: 100%; display: block; border-radius: 10px; transition: transform 0.3s ease;"
                                           src="<%= request.getContextPath() + "/img/" + airlineImage %>" alt="alt"/>

                                  </div>
                                  <div class="ticket-category-info" style="font-size: 13px; margin-top: 12px; margin-left: 42px;">
                                      <%= seats.get(i).getSeatClass() %>
                                  </div>
                                  <% if ("oneWay".equals(request.getParameter("flightType"))) { %>
                                  <form class="ticket-category-form" action="bookingFlightTicketsURL" style="display: flex; justify-content: center;">
                                      <input type="hidden" name="seatCategory" value="<%= seats.get(i).getSeatId() %>"/>

                                      <input type="hidden" name="flightDetailId" value="<%= f.getFlightId() %>"/>
                                      <input type="hidden" name="adult" value="${param.adult}"/>
                                      <input type="hidden" name="child" value="${param.child}"/>
                                      <input type="hidden" name="infant" value="${param.infant}"/>
                                      <%
                                          if (totalPassengers <= 10) {
                                      %>
                                      <button style="background-color: cadetblue;" type="submit">Mua Vé</button>
                                      <%
                                      } else {
                                      %>
                                      <button style="background-color: #aaa" disabled>Đã bán hết</button>
                                      <%
                                          }
                                      %>
                                  </form>
                                  <% } else if ("roundTrip".equals(request.getParameter("flightType")) && request.getParameter("flightDetailId") == null) { %>
                                  <form class="ticket-category-form" action="SearchFlightsURL" style="display: flex; justify-content: center;">

                                      <input type="hidden" name="seatCategory" value="<%= seats.get(i).getSeatId() %>"/>
                                      <input type="hidden" name="flightDetailId" value="<%= f.getFlightId() %>"/>

                                      <input type="hidden" name="departure" value="${param.departure}"/>
                                      <input type="hidden" name="destination" value="${param.destination}"/>
                                      <input type="hidden" name="departureDate" value="${param.departureDate}"/>
                                      <input type="hidden" name="returnDate" value="${param.returnDate}"/>
                                      <input type="hidden" name="adult" value="${param.adult}"/>
                                      <input type="hidden" name="child" value="${param.child}"/>
                                      <input type="hidden" name="infant" value="${param.infant}"/>
                                      <input type="hidden" name="flightType" value="roundTrip"/>
                                      <%
                                          if (totalPassengers <= 10) {
                                      %>
                                      <button style="background-color:cadetblue;width: 83%" type="submit">Chọn vé khởi hành</button>
                                      <%
                                      } else {
                                      %>
                                      <button style="background-color: #aaa" disabled>Đã bán hết</button>
                                      <%
                                          }
                                      %>
                                  </form>
                                  <% } else if ("roundTrip".equals(request.getParameter("flightType")) && request.getParameter("flightDetailId") != null) { %>
                                  <form class="ticket-category-form" action="bookingFlightTicketsURL" style="display: flex; justify-content: center;">
                                      <input type="hidden" name="seatCategory" value="${param.seatCategory}"/>
                                      <input type="hidden" name="flightDetailId" value="${param.flightDetailId}"/>
                                      <input type="hidden" name="seatCategory2" value="<%= seats.get(i).getSeatId() %>"/>
                                      <input type="hidden" name="flightDetailId2" value="<%= f.getFlightId() %>"/>
                                      <input type="hidden" name="adult" value="${param.adult}"/>
                                      <input type="hidden" name="child" value="${param.child}"/>
                                      <input type="hidden" name="infant" value="${param.infant}"/>
                                      <%
                                          if (totalPassengers <= 10) {
                                      %>
                                      <button style="background-color: cadetblue;width: 75%" type="submit">Chọn vé khứ hồi</button>
                                      <%
                                      } else {
                                      %>
                                      <button style="background-color: #aaa" disabled>Đã bán hết</button>
                                      <%
                                          }
                                      %>
                                  </form>
                                  <% } %>
                              </div>
                          </div>
                          <%
                                          break;
                                      }
                                  }

                          %>
                      </div>
                  </div>



                  <%
                      SimpleDateFormat dateTimeFormat = new SimpleDateFormat("HH:mm dd/MM/yyyy");
                  %>


                  <div class="container">
                      <!-- Modal Detail Information -->
                      <div class="modal fade" id="detail<%=f.getFlightId()%>" role="dialog">
                          <div class="modal-dialog">
                              <!-- Modal content-->
                              <div class="modal-content">
                                  <div class="modal-header" style="padding:5px 5px;">
                                      <button type="button" class="close" style="font-size: 30px; margin-right: 8px;
                                                        margin-top: 2px;" data-dismiss="modal">&times;</button>
                                      <h3 style="margin-left: 12px; font-weight: 700; color: #3C6E57">
                                          <%=depLocation.getLocationName()%> - <%=desLocation.getLocationName()%>
                                      </h3>
                                  </div>
                                  <div class="modal-body row" style="padding:18px 50px;">
                                      <div class="col-md-4" style="width: 41%">
                                          <p>Khởi hành: <span class="departure-time"><%= timeFormat.format(f.getDepartureTime()) %></span></p>
                                          <%
                                              long totalTime = f.getArrivalTime().getTime()-f.getDepartureTime().getTime();
                                              long hours = totalTime / (1000 * 60 * 60);
                                              long minutes = (totalTime / (1000 * 60)) % 60;
                                          %>
                                          <p>Tổng thời gian: <span class="total-time"><%= hours %> giờ <%= minutes %> phút</span></p>
                                          <div>
                                              <div class="airline-logo-container" style="width: 65%; margin: 15px 0">
                                                  <img src="<%= request.getContextPath() + "/img/" + airlineImage %>"
                                                       alt="Logo">
                                              </div>
                                              <p class="airline-name"><strong>Hãng bay: </strong><%= ald.getNameById(airlineId) %></p>

                                          </div>
                                      </div>
                                      <div class="col-md-1"></div>
                                      <div class="col-md-7" style="display: flex">
                                          <div>
                                              <svg height="200" width="10" xmlns="http://www.w3.org/2000/svg">
                                                  <line x1="0" y1="0" x2="0" y2="200" style="stroke:black;stroke-width:5px; stroke-dasharray:10,5"></line>
                                                  Sorry, your browser does not support inline SVG.
                                              </svg>
                                          </div>
                                          <div style="position: relative; width: 100%">
                                              <div>
                                                  <p>
                                                                <span class="departure-time"><%= dateTimeFormat.format(f.getDepartureTime()) %>
                                                                    <span class="location"><%= depLocation.getLocationName() %>, <%=depCountry.getCountryName()%></span>
                                                                </span>
                                                  </p>
                                                  <p><span class="airport"><%= depAirport.getAirportName() %></span></p>
                                              </div>
                                              <p style="position: absolute; top: 41%; color: #aaa"><%= hours %> h <%= minutes %> m</p>

                                              <div style="position: absolute; bottom: 0">
                                                  <p>
                                                                <span class="destination-time"><%= dateTimeFormat.format(f.getArrivalTime()) %>
                                                                    <span class="location"><%= desLocation.getLocationName() %>, <%=desCountry.getCountryName()%></span>
                                                                </span>
                                                  </p>
                                                  <p><span class="airport"><%= desAirport.getAirportName() %></span></p>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="modal-footer">
                                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                                  </div>

                              </div>
                          </div>
                      </div>
                  </div>
              </div>
              <%
                  }
                  }
              %>

              <div class="pagination-container">
                  <%
                      Integer currentPageObj = (Integer) request.getAttribute("currentPage");
                      int currentPage = (currentPageObj != null) ? currentPageObj : 1;

                      Integer totalPagesObj = (Integer) request.getAttribute("totalPages");
                      int totalPages = (totalPagesObj != null) ? totalPagesObj : 1;

                      // flightTickets = (List<Flights>) request.getAttribute("flightTickets");
                      boolean hasFlights = flightTickets != null && !flightTickets.isEmpty();

                      String flightDetailId = request.getParameter("flightDetailId"); // Lấy flightDetailId từ request
                  %>

                  <% if (hasFlights && currentPage > 1) { %>
                  <form method="get" action="SearchFlightsURL">
                      <input type="hidden" name="page" value="<%= currentPage - 1 %>">
                      <input type="hidden" name="departure" value="<%= request.getParameter("departure") %>">
                      <input type="hidden" name="destination" value="<%= request.getParameter("destination") %>">
                      <input type="hidden" name="departureDate" value="<%= request.getParameter("departureDate") %>">
                      <input type="hidden" name="returnDate" value="<%= request.getParameter("returnDate") %>">
                      <input type="hidden" name="adult" value="${param.adult}">
                      <input type="hidden" name="child" value="${param.child}">
                      <input type="hidden" name="infant" value="${param.infant}">
                      <input type="hidden" name="seatCategory" value="${param.seatCategory}"/>
                      <input type="hidden" name="flightType" value="<%= (flightDetailId != null && request.getParameter("flightType") == null) ? "roundTrip" : request.getParameter("flightType") %>">
                      <% if (flightDetailId != null) { %>
                      <input type="hidden" name="flightDetailId" value="<%= flightDetailId %>">
                      <% } %>
                      <button type="submit" class="pagination-button">Trang trước</button>
                  </form>
                  <% } %>

                  <% if (hasFlights) { %>
                  <span class="pagination-current">Trang <%= currentPage %> / <%= totalPages %></span>
                  <% } else { %>
                  <span class="pagination-current">Không có chuyến bay nào được tìm thấy</span>
                  <% } %>

                  <% if (hasFlights && currentPage < totalPages) { %>
                  <form method="get" action="SearchFlightsURL">
                      <input type="hidden" name="page" value="<%= currentPage + 1 %>">
                      <input type="hidden" name="departure" value="<%= request.getParameter("departure") %>">
                      <input type="hidden" name="destination" value="<%= request.getParameter("destination") %>">
                      <input type="hidden" name="departureDate" value="<%= request.getParameter("departureDate") %>">
                      <input type="hidden" name="returnDate" value="<%= request.getParameter("returnDate") %>">
                      <input type="hidden" name="adult" value="${param.adult}">
                      <input type="hidden" name="child" value="${param.child}">
                      <input type="hidden" name="infant" value="${param.infant}">
                      <input type="hidden" name="seatCategory" value="${param.seatCategory}"/>
                      <input type="hidden" name="flightType" value="<%= (flightDetailId != null && request.getParameter("flightType") == null) ? "roundTrip" : request.getParameter("flightType") %>">
                      <% if (flightDetailId != null) { %>
                      <input type="hidden" name="flightDetailId" value="<%= flightDetailId %>">
                      <% } %>
                      <button type="submit" class="pagination-button">Trang sau</button>
                  </form>
                  <% } %>
              </div>



          </div>






      </div>





    </div>


  </div>
</div>


</body>
<jsp:include page="/views/layout/Footer.jsp"/>

<script>
    function openModal(id) {
        $("#detail" + id).modal('show');
    }

    function showTicketCategory(id) {
        var container = document.getElementById("ticket-category-container" + id);
        var arrow = document.getElementById("arrow" + id);

        if (container.style.maxHeight === "0px" || container.style.maxHeight === "") {
            container.style.maxHeight = "800px";
            container.style.opacity = "1";
            arrow.style.transform = "rotate(180deg)";
        } else {
            container.style.maxHeight = "0px";
            container.style.opacity = "0";
            arrow.style.transform = "rotate(0deg)";
        }
    }

    function sortFlights(sortBy) {
        const flightsContainer = document.querySelector('.flights-container');
        if (!flightsContainer) {
            console.error("Không tìm thấy flights-container!");
            return;
        }

        // Lưu pagination-container
        const pagination = flightsContainer.querySelector('.pagination-container');
        let paginationClone = pagination ? pagination.cloneNode(true) : null;

        // Chỉ lấy các phần tử có class 'flight-detail'
        let flights = Array.from(flightsContainer.querySelectorAll('.flight-detail'));

        flights.sort((a, b) => {
            const priceAEl = a.querySelector('.price span:last-child');
            const priceBEl = b.querySelector('.price span:last-child');
            const timeAEl = a.querySelector('.depTime');
            const timeBEl = b.querySelector('.depTime');

            const priceA = priceAEl ? parseInt(priceAEl.innerText.replace(/[^0-9]/g, '')) || 0 : 0;
            const priceB = priceBEl ? parseInt(priceBEl.innerText.replace(/[^0-9]/g, '')) || 0 : 0;
            const timeA = timeAEl ? parseTime(timeAEl.innerText) : new Date(0);
            const timeB = timeBEl ? parseTime(timeBEl.innerText) : new Date(0);

            if (!priceAEl || !priceBEl || !timeAEl || !timeBEl) {
                console.log("Phần tử lỗi:", a, b);
            }

            switch (sortBy) {
                case 'priceAsc':
                    return priceA - priceB;
                case 'priceDesc':
                    return priceB - priceA;
                case 'timeAsc':
                    return timeA - timeB;
                case 'timeDesc':
                    return timeB - timeA;
                default:
                    return 0;
            }
        });

        // Xóa nội dung hiện tại và thêm lại các chuyến bay
        flightsContainer.innerHTML = '';
        flights.forEach(flight => flightsContainer.appendChild(flight));

        // Thêm lại pagination-container nếu có
        if (paginationClone) {
            flightsContainer.appendChild(paginationClone);
        }
    }

    function parseTime(timeString) {
        const [h, m] = timeString.split(':').map(Number);
        return new Date(2004, 16, 11, h, m);
    }

    function sortAirlines(selectedAirline) {
        const flightsContainer = document.querySelector('.flights-container');
        let flights = Array.from(flightsContainer.children);

        flights.forEach(flight => {
            const airlineName = flight.querySelector('.airline-name').innerText;

            if (selectedAirline === 'default' || airlineName === selectedAirline) {
                flight.style.display = 'block';
            } else {
                flight.style.display = 'none';
            }
        });
    }

</script>

</html>
