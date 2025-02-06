<%--
 Created by IntelliJ IDEA.
 User: 84968
 Date: 1/20/2025
 Time: 2:52 PM
 To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="fixed-header" style="position: fixed;top: 0;left: 0;right: 0;bottom: 0;">
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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Header.css">
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
<jsp:include page="/views/layout/Footer.jsp"/>
<jsp:include page="/views/layout/Footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.js"></script>


</body>
</html>



