<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="dal.*" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.NumberFormat" %><%--
  Created by IntelliJ IDEA.
  User: 84968
  Date: 2/21/2025
  Time: 2:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>JSP</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/ViewFlight.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

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

  %>
<div style="margin: 100px 0" class="row">
  <div class="col-md-1">

  </div>
  <div class="col-md-10">
    <div class="flight-detail" style="display: block">
      <%
        Airports depAirport = (Airports) apd.getAirportById(Integer.parseInt(request.getParameter("departure")));
        Locations depLocation = (Locations) ld.getLocationById(depAirport.getLocationId());
        Countries depCountry = (Countries) cd.getCountryById(depLocation.getLocationId());

        Airports desAirport = (Airports) apd.getAirportById(Integer.parseInt(request.getParameter("destination")));
        Locations desLocation = (Locations) ld.getLocationById(desAirport.getLocationId());
        Countries desCountry = (Countries) cd.getCountryById(desLocation.getLocationId());

        int adultNumber = Integer.parseInt(request.getParameter("adult"));
        int childNumber = Integer.parseInt(request.getParameter("child"));
        int infantNumber = Integer.parseInt(request.getParameter("infant"));
        int totalPassengers = adultNumber+ childNumber+infantNumber;

        if(request.getParameter("flightDetailId")==null){
      %>
      <div style="width: 100%; color:#3C6E57; text-align: center; "><h3>SELECT FLIGHT</h3></div>
      <%} else {
        Airports tmpA = depAirport; depAirport = desAirport; desAirport = tmpA;
        Locations tmpL = depLocation; depLocation = desLocation; desLocation = tmpL;
        Countries tmpC = depCountry; depCountry = desCountry; desCountry = tmpC;
      %>
      <div style="width: 100%; color:#3C6E57; text-align: center "><h3>SELECT  FLIGHT</h3></div>
      <% }%>
      <div class="flight-info" style="width: 100%">
        <div class="airport-info">
          <div class="flight-icon">✈️</div>
          <div class="airport-name"><%=depAirport.getAirportName()%></div>
          <div class="location"><%=depLocation.getLocationName()%>, <%=depCountry.getCountryName()%></div>
        </div>
        <div class="flight-details">
          <div class="flight-icon">🛫</div>
          <div class="flight-type">Passenger</div>
          <div class="flight-time">
            <%= adultNumber %> Adult<% if (adultNumber > 1) { %>s<% } %>
            <% if (childNumber > 0) { %>, <%= childNumber %> Child<% } %>
            <% if (infantNumber > 0) { %>, <%= infantNumber %> Infant<% } %>
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
                      <h5>Sort by:</h5>
                      <div>
                          <input type="radio" id="sortTimeAsc" name="sortFlights" value="timeAsc" onchange="sortFlights(this.value)" checked>
                          <label for="sortTimeAsc">Earliest First</label>
                      </div>
                      <div>
                          <input type="radio" id="sortTimeDesc" name="sortFlights" value="timeDesc" onchange="sortFlights(this.value)">
                          <label for="sortTimeDesc">Latest First</label>
                      </div>
                      <div>
                          <input type="radio" id="sortPriceAsc" name="sortFlights" value="priceAsc" onchange="sortFlights(this.value)">
                          <label for="sortPriceAsc">Price: Low to High</label>
                      </div>
                      <div>
                          <input type="radio" id="sortPriceDesc" name="sortFlights" value="priceDesc" onchange="sortFlights(this.value)">
                          <label for="sortPriceDesc">Price: High to Low</label>
                      </div>
                  </div>

              </div>
          </div>




          <div class="col-md-9 flights-container">

              <%
                  List<Flights> flightTickets = (List<Flights>) request.getAttribute("flightTickets");
                  for ( Flights f : flightTickets) {
                      int airlineId = fld.getAirlineIdByFlightId(f.getFlightId());
                      System.out.println(f.getFlightId());
                      String airlineImage = ald.getImageById(airlineId);
                      String airlineName = ald.getNameById(airlineId);
                      Flights flight = fld.getFlightById(f.getFlightId());

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
                              <a style="cursor: pointer" onclick="openModal(<%=f.getFlightId()%>)">Detail Information</a>
                          </div>

                          <div style="display: flex; width: 42%; padding-top: 1%">
                              <div>
                                  <p class="time depTime"><%= timeFormat.format(f.getDepartureTime()) %></p>
                                  <p class="location"><%=depLocation.getLocationName()%></p>
                              </div>
                              <svg width="150" height="30" xmlns="http://www.w3.org/2000/svg">
                                  <line x1="12" y1="15" x2="65" y2="15" stroke="#B1B9CB" stroke-width="2" stroke-dasharray="5,5" />
                                  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" x="70" y="5" viewBox="0 0 576 512">
                                      <path fill="#B1B9CB" d="M482.3 192c34.2 0 93.7 29 93.7 64c0 36-59.5 64-93.7 64l-116.6 0L265.2 495.9c-5.7 10-16.3 16.1-27.8 16.1l-56.2 0c-10.6 0-18.3-10.2-15.4-20.4l49-171.6L112 320 68.8 377.6c-3 4-7.8 6.4-12.8 6.4l-42 0c-7.8 0-14-6.3-14-14c0-1.3 .2-2.6 .5-3.9L32 256 .5 145.9c-.4-1.3-.5-2.6-.5-3.9c0-7.8 6.3-14 14-14l42 0c5 0 9.8 2.4 12.8 6.4L112 192l102.9 0-49-171.6C162.9 10.2 170.6 0 181.2 0l56.2 0c11.5 0 22.1 6.2 27.8 16.1L365.7 192l116.6 0z"/>
                                  </svg>
                                  <line x1="90" y1="15" x2="150" y2="15" stroke="#B1B9CB" stroke-width="2" stroke-dasharray="5,5" />
                              </svg>


                              <div>
                                  <p class="time"><%= timeFormat.format(f.getArrivalTime()) %></p>
                                  <p class="location"><%=desLocation.getLocationName()%></p>
                              </div>
                          </div>
                          <div style="display: flex; align-items: center; width: 38%; justify-content: end">
                              <div class="price">
                                  <span class="old-price"><%= NumberFormat.getInstance().format(f.getClassEconomyPrice()) %> ₫</span>
                                  <span><span style="font-size: 17px">only from</span> <%= NumberFormat.getInstance().format(f.getClassVipPrice())%> ₫</span>
                              </div>
                              <div style="display: flex; margin-left: 20px" onclick="showTicketCategory(<%=f.getFlightId()%>">
                                  <svg class="arrow" id="arrow<%=f.getFlightId()%>" xmlns="http://www.w3.org/2000/svg" height="25" width="25" viewBox="0 0 512 512" style="transition: transform 0.3s ease;">
                                      <path d="M233.4 406.6c12.5 12.5 32.8 12.5 45.3 0l192-192c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L256 338.7 86.6 169.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l192 192z"/>
                                  </svg>
                              </div>
                          </div>
                      </div>
                  </div>

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
                                      <div class="col-md-4">
                                          <p>Departs: <span class="departure-time">2h</span></p>
                                          <p>Total time: <span class="total-time">3 minutes</span></p>
                                          <div>
                                              <div class="airline-logo-container" style="width: 65%; margin: 15px 0">
                                                  <img src="<%= request.getContextPath() + "/img/" + airlineImage %>"
                                                       alt="Logo">
                                              </div>
                                              <p class="airline-name"><strong>Airline: </strong><%= ald.getNameById(airlineId) %></p>
                                              <p class="aircraft"><strong>Plane: </strong>Siuuu</p>
                                          </div>
                                      </div>
                                      <div class="col-md-1"></div>
                                      <div class="col-md-7" style="display: flex">
                                          <div>
                                              <svg height="200" width="10" xmlns="http://www.w3.org/2000/svg">
                                                  <line x1="0" y1="0" x2="0" y2="200" style="stroke:black;stroke-width:5px; stroke-dasharray:10,5" />
                                                  Sorry, your browser does not support inline SVG.
                                              </svg>
                                          </div>
                                          <div style="position: relative; width: 100%">
                                              <div>
                                                  <p>
                                                                <span class="departure-time">2h -
                                                                    <span class="location"><%= depLocation.getLocationName() %>, <%=depCountry.getCountryName()%></span>
                                                                </span>
                                                  </p>
                                                  <p><span class="airport"><%= depAirport.getAirportName() %></span></p>
                                              </div>
                                              <p style="position: absolute; top: 41%; color: #aaa">2h  minutes</p>

                                              <div style="position: absolute; bottom: 0">
                                                  <p>
                                                                <span class="destination-time">3h -
                                                                    <span class="location"><%= desLocation.getLocationName() %>, <%=desCountry.getCountryName()%></span>
                                                                </span>
                                                  </p>
                                                  <p><span class="airport"><%= desAirport.getAirportName() %></span></p>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="modal-footer">
                                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                  </div>

                              </div>
                          </div>
                      </div>
                  </div>


              </div>
              <%
                  }

              %>
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
        let flights = Array.from(flightsContainer.children);

        flights.sort((a, b) => {
            const priceA = parseInt(a.querySelector('.price span:last-child').innerText.replace(/[^0-9]/g, ''));
            const priceB = parseInt(b.querySelector('.price span:last-child').innerText.replace(/[^0-9]/g, ''));
            const timeA = parseTime(a.querySelector('.depTime').innerText);
            const timeB = parseTime(b.querySelector('.depTime').innerText);

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
        flightsContainer.innerHTML = '';
        flights.forEach(flight => flightsContainer.appendChild(flight));
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
