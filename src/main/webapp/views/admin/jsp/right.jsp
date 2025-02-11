<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/10/2025
  Time: 1:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
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
            <li><a href="Dashboard.jsp"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
            <li><a href="appointment.html"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Updating</a>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Accounts management</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="chat.html">List of accounts</a></li>
                        <li><a href="email.html">Add account</a></li>

                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Airlines Management</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="viewListAirlines.jsp">List of airlines</a></li>
                        <li><a href="addAirline.jsp">Add airline</a></li>

                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Airports
                    Management</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="controller/AirportsController.java">List of airports</a></li>
                        <li><a href="add-patient.html">Add airport</a></li>

                    </ul>
                </div>
            </li>


            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-shopping-cart me-2 d-inline-block"></i>Updating</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="shop.html">Shop</a></li>
                        <li><a href="product-detail.html">Shop Detail</a></li>
                        <li><a href="shopcart.html">Shopcart</a></li>
                        <li><a href="checkout.html">Checkout</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Updating</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="blogs.html">Blogs</a></li>
                        <li><a href="blog-detail.html">Blog Detail</a></li>
                    </ul>
                </div>
            </li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Updating</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="faqs.html">FAQs</a></li>
                        <li><a href="review.html">Reviews</a></li>
                        <li><a href="invoice-list.html">Invoice List</a></li>
                        <li><a href="invoice.html">Invoice</a></li>
                        <li><a href="terms.html">Terms & Policy</a></li>
                        <li><a href="privacy.html">Privacy Policy</a></li>
                        <li><a href="error.html">404 !</a></li>
                        <li><a href="blank-page.html">Blank Page</a></li>
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
