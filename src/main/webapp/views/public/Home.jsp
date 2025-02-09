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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="fixed-header">
    <jsp:include page="/views/layout/Header.jsp"/>
</div>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/PublicHome.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/News.css"/>
    <script src="<%= request.getContextPath() %>/js/Home.js" defer></script>


</head>
<body>
<div class="background">
    <form action="FlightSearchServlet" method="GET">
        <div class="container py-5">
            <div class="card shadow p-4">
                <div class="row g-3 align-items-center">
                    <!-- Departure -->
                    <div class="col-md-2 position-relative">
                        <i class="fa-solid fa-plane-departure input-icon"></i>
                        <input type="text" class="form-control" placeholder="Hà Nội" id="departure" name="departure"
                               required>
                    </div>


                    <!-- Destination -->
                    <div class="col-md-2 position-relative">
                        <i class="fa-solid fa-plane-arrival input-icon"></i>
                        <input type="text" class="form-control" placeholder="Đà Nẵng" id="destination"
                               name="destination" required>
                    </div>


                    <!-- Departure Date -->
                    <div class="col-md-2 position-relative">
                        <input style="width: 170px" type="date" class="form-control" id="departureDate"
                               name="departureDate" required>
                    </div>


                    <!-- Return Date -->
                    <div class="col-md-2 position-relative">
                        <input style="width: 170px" type="date" class="form-control" id="returnDate" name="returnDate"
                               disabled>
                    </div>


                    <!-- Passengers -->
                    <div class="col-md-2 position-relative">
                        <i class="fa-solid fa-users input-icon"></i>
                        <button type="button"
                                class="btn btn-outline-secondary w-100 d-flex align-items-center justify-content-between"
                                id="passengerBtn">
                            <span style="margin-left: 35px;">1 người</span>
                            <i class="fa-solid fa-chevron-down"></i>
                        </button>
                        <div class="passenger-dropdown" id="passengerDropdown">
                            <div class="passenger-item">
                                <span>Người lớn (Trên 18)</span>
                                <div>
                                    <button type="button" class="btn btn-sm btn-light"
                                            onclick="adjustPassenger('adult', -1)">-
                                    </button>
                                    <span id="adultCount">1</span>
                                    <button type="button" class="btn btn-sm btn-light"
                                            onclick="adjustPassenger('adult', 1)">+
                                    </button>
                                </div>
                                <input type="hidden" id="adultPassenger" name="adultPassenger" value="1">
                            </div>
                            <div class="passenger-item">
                                <span>Trẻ em (2-12)</span>
                                <div>
                                    <button type="button" class="btn btn-sm btn-light"
                                            onclick="adjustPassenger('child', -1)">-
                                    </button>
                                    <span id="childCount">0</span>
                                    <button type="button" class="btn btn-sm btn-light"
                                            onclick="adjustPassenger('child', 1)">+
                                    </button>
                                </div>
                                <input type="hidden" id="childPassenger" name="childPassenger" value="1">
                            </div>
                            <div class="passenger-item">
                                <span>Em bé (0-2)</span>
                                <div>
                                    <button type="button" class="btn btn-sm btn-light"
                                            onclick="adjustPassenger('infant', -1)">-
                                    </button>
                                    <span id="infantCount">0</span>
                                    <button type="button" class="btn btn-sm btn-light"
                                            onclick="adjustPassenger('infant', 1)">+
                                    </button>
                                </div>
                                <input type="hidden" id="infantPassenger" name="infantPassenger" value="1">
                            </div>
                            <button type="button" class="btn btn-orange w-100 mt-2" onclick="closePassengerDropdown()">
                                Chọn
                            </button>
                        </div>
                        <!-- Hidden input để gửi số lượng hành khách -->
                        <input type="hidden" id="totalPassengers" name="totalPassengers" value="1">
                    </div>


                    <!-- Search Button -->
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-orange w-100" name="submit">Tìm chuyến bay</button>
                    </div>
                </div>


                <!-- Second Row: Trip Type -->
                <div class="row mt-3">
                    <div class="col-md-2 offset-md-4 text-center">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="tripType" id="oneWay" value="oneWay"
                                   checked>
                            <label class="form-check-label" for="oneWay">Một chiều</label>
                        </div>
                    </div>
                    <div class="col-md-2 text-center">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="tripType" id="roundTrip"
                                   value="roundTrip">
                            <label class="form-check-label" for="roundTrip">Khứ hồi</label>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>


</div>

<div class="main-container" id="body-2">

    <div style="display: ${empty param.id ? '' : 'none'};margin: 60px 0">
        <h1 style="margin-bottom: 30px; text-align: center; font-size: 30px">NEWS</h1>
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



<jsp:include page="/views/layout/Footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.js"></script>


</body>
</html>



