<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/10/2025
  Time: 1:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Title</title>
    <style>
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
        }


        .logo img {
            width: 50px;
        }


        .logo span {
            font-size: 20px;
            font-weight: bold;
            color: black;
        }


        .logo .highlight {
            color: orange;
        }
    </style>
</head>
<body>
<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
        <div class="sidebar-brand">
            <a href="<%= request.getContextPath() %>" style="text-decoration: none;">
                <div class="logo" style="cursor: pointer;">
                    <img src="<%= request.getContextPath() %>/img/logo.jpg" alt="Online Booking">
                    <span>Sky <span class="highlight">Ticket</span></span>
                </div>
            </a>
        </div>

        <ul class="sidebar-menu pt-3">
            <li><a href="<%= request.getContextPath() %>/views/admin/jsp/Dashboard.jsp"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
            <li><a href="#"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Updating</a>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Accounts</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/manageAccount?action=view">List of accounts</a></li>
                        <li><a href="<%= request.getContextPath() %>/manageAccount?action=add">Add account</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Airlines</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/listAirlines">List of airlines</a></li>
                        <li><a href="<%= request.getContextPath() %>/views/admin/jsp/addAirline.jsp">Add airline</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Airports
                   </a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/AirportListURL">List of airports</a></li>

                        <li><a href="<%= request.getContextPath() %>/views/admin/jsp/addAirport.jsp">Add airport</a></li>

                    </ul>
                </div>
            </li>

            <%--            Locations Managerment--%>
            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Locations
                </a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/listLocationsURL">List of locations</a></li>

                        <li><a href="<%= request.getContextPath() %>/views/admin/jsp/addLocation.jsp">Add locations</a></li>

                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-shopping-cart me-2 d-inline-block"></i>Flights</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/listFlights">Lists of flights</a></li>
                        <li><a href="<%= request.getContextPath() %>/manageFlights?action=add">Add Flight</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>News</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/viewNews">List of news</a></li>
                        <li><a href="<%= request.getContextPath() %>/manageNews?action=add">Add news</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Countries</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/listCountriesURL">List of countries</a></li>
                        <li><a href="<%= request.getContextPath() %>/views/admin/jsp/addCountry.jsp">Add country</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Seats</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/listSeats">Lists of Seats</a></li>
                        <li><a href="<%= request.getContextPath() %>/addSeats">Add Seat</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Baggages</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/BaggagesList">List of Baggages</a></li>
                        <li><a href="review.html">Add Baggage</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Passengers</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/listPassengersURL">List of passengers</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Payments</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/listPaymentsURL">List of payments</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Bookings</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="<%= request.getContextPath() %>/listBookingsURL">List of bookings</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i
                        class="uil uil-sign-in-alt me-2 d-inline-block"></i>Updating</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="login.html">Login</a></li>
                        <li><a href="signup.html">Signup</a></li>
                        <li><a href="forgot-password.html">Forgot Password</a></li>
                        <li><a href="lock-screen.html">Lock Screen</a></li>
                        <li><a href="thankyou.html">Thank you...!</a></li>
                    </ul>
                </div>
            </li>

            <li><a href="components.html"><i class="uil uil-cube me-2 d-inline-block"></i>Updating</a></li>

            <li><a href="../landing/index-two.html" target="_blank"><i
                    class="uil uil-window me-2 d-inline-block"></i>Landing page</a></li>
        </ul>
        <!-- sidebar-menu  -->
    </div>
    <!-- sidebar-content  -->
    <ul class="sidebar-footer list-unstyled mb-0">
        <li class="list-inline-item mb-0 ms-1">
            <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                <i class="uil uil-comment icons"></i>
            </a>
        </li>
    </ul>
</nav>
<!-- sidebar-wrapper  -->
</body>
</html>
