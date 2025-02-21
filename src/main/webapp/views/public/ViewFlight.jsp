<%@ page import="model.Locations" %>
<%@ page import="dal.LocationsDAO" %>
<%@ page import="model.Countries" %>
<%@ page import="dal.CountriesDAO" %>
<%@ page import="model.Airports" %>
<%@ page import="dal.AirportsDAO" %><%--
  Created by IntelliJ IDEA.
  User: 84968
  Date: 2/21/2025
  Time: 2:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
    LocationsDAO ld = new LocationsDAO();
    CountriesDAO cd = new CountriesDAO();
    AirportsDAO ad = new AirportsDAO();

  %>
<div style="margin: 100px 0" class="row">
  <div class="col-md-1">

  </div>
  <div class="col-md-10">
    <div class="flight-detail" style="display: block">
      <%
        Airports depAirport = (Airports) ad.getAirportById(Integer.parseInt(request.getParameter("departure")));
        Locations depLocation = (Locations) ld.getLocationById(depAirport.getLocationId());
        Countries depCountry = (Countries) cd.getCountryById(depLocation.getCountryId());

        Airports desAirport = (Airports) ad.getAirportById(Integer.parseInt(request.getParameter("destination")));
        Locations desLocation = (Locations) ld.getLocationById(desAirport.getLocationId());
        Countries desCountry = (Countries) cd.getCountryById(desLocation.getCountryId());

        int adultNumber = Integer.parseInt(request.getParameter("adult"));
        int childNumber = Integer.parseInt(request.getParameter("child"));
        int infantNumber = Integer.parseInt(request.getParameter("infant"));
        int totalPassengers = adultNumber+ childNumber+infantNumber;

        if(request.getParameter("flightDetailId")==null){
      %>
      <div style="width: 100%; color:#3C6E57; text-align: center; "><h3>SELECT OUTBOUND FLIGHT</h3></div>
      <%} else {
        Airports tmpA = depAirport; depAirport = desAirport; desAirport = tmpA;
        Locations tmpL = depLocation; depLocation = desLocation; desLocation = tmpL;
        Countries tmpC = depCountry; depCountry = desCountry; desCountry = tmpC;
      %>
      <div style="width: 100%; color:#3C6E57; text-align: center "><h3>SELECT REBOUND FLIGHT</h3></div>
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



  </div>






</div>


</body>
<jsp:include page="/views/layout/Footer.jsp"/>
</html>
