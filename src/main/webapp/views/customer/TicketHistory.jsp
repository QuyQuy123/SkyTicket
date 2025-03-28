<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="dal.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Ticket History</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <style>
        /* Reset mặc định và cài đặt chung */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fa;
            line-height: 1.6;
        }
        /* Container chính */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .order-container {
            margin-top: 30px; /* Thay vì dùng transform: translateY */
            margin-bottom: 50px;
        }

        /* Buying History */
        .buying-history {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        .order-card {
            border: none;
            padding: 20px;
            border-radius: 12px;
            background-color: #ffffff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 15px;
            border-bottom: 2px solid #eef2f7;
        }

        .order-id strong {
            font-size: 26px;
            color: #1a73e8;
        }

        .contact-info {
            font-size: 14px;
            color: #6c757d;
            margin-top: 8px;
        }

        .contact-info i {
            margin-right: 5px;
            color: #1a73e8;
        }

        /* Ticket Details */
        .ticket-details {
            display: flex;
            align-items: center;
            padding: 20px;
            background-color: #fafafa;
            border-radius: 10px;
            margin-bottom: 15px;
            transition: background-color 0.2s ease;
        }

        .ticket-details:hover {
            background-color: #f1f5f9;
        }

        .airline-image img {
            width: 90px;
            height: auto;
            border-radius: 8px;
            object-fit: cover;
        }

        .flight-info {
            flex-grow: 1;
            padding-left: 20px;
        }

        .flight-info div {
            font-size: 15px;
            color: #333;
            margin-bottom: 8px;
        }

        .flight-info i {
            color: #1a73e8;
            margin-right: 8px;
        }

        .ticket-actions {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 10px;
            padding-left: 20px;
        }

        .ticket-actions .btn {
            padding: 8px 20px;
            font-size: 14px;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .ticket-actions .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        /* Status Labels */
        .status-label {
            padding: 6px 16px;
            font-size: 14px;
            font-weight: 600;
            color: #fff;
            border-radius: 20px;
            min-width: 120px;
            text-align: center;
        }

        .status-label.completed { background-color: #343a40; }
        .status-label.pending { background-color: #ffc107; color: #333; }
        .status-label.successful { background-color: #28a745; }
        .status-label.processing { background-color: #fd7e14; }
        .status-label.cancelled,
        .status-label.rejected,
        .status-label.rejection { background-color: #dc3545; }
        .status-label.request { background-color: #ffc107; color: #333; }

        /* Order Total */
        .list-price {
            padding: 15px 0;
            border-bottom: 1px solid #eef2f7;
            font-size: 15px;
            color: #555;
            text-align: right;
        }
        .order-actions {
            margin-top: 15px;
            text-align: right;
        }
        .order-actions .btn {
            padding: 10px 25px;
            font-size: 15px;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .order-actions .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        #payment_methods h2 {
            font-size: 22px;
            font-weight: 600;
            color: #1a73e8;
            text-align: left; /* Căn trái để đồng bộ với giao diện */
            margin-bottom: 25px;
        }

        .payment-options {
            display: flex;
            gap: 20px;
        }

        .payment-option {
            flex: 1;
        }

        .payment-option .btn {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px;
            width: 100%;
            background-color: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .payment-option .btn:hover {
            background-color: #e9ecef;
            border-color: #1a73e8;
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .imgPayment {
            width: 45px;
            height: 45px;
            object-fit: contain;
            border-radius: 5px;
        }

        .name-pay {
            font-size: 15px;
            color: #333;
        }
        .name-pay br + span {
            color: #6c757d;
            font-size: 13px;
        }

        /* Pagination */
        .pagination {
            justify-content: center;
            margin-top: 30px;
        }

        .pagination .page-link {
            border-radius: 6px;
            margin: 0 5px;
            color: #1a73e8;
            border: 1px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .pagination .page-link:hover {
            background-color: #1a73e8;
            color: #fff;
            border-color: #1a73e8;
        }

        .pagination .active .page-link {
            background-color: #1a73e8;
            border-color: #1a73e8;
            color: #fff;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .order-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            .ticket-details {
                flex-direction: column;
                align-items: flex-start;
                padding: 15px;
            }

            .ticket-actions {
                align-items: flex-start;
                padding-left: 0;
                margin-top: 15px;
            }

            .payment-options {
                flex-direction: column;
                gap: 15px;
            }


        }


        .status-filter {
            width: 200px;
            border-radius: 10px;
            border: 1px solid #ccc;
            padding: 8px;
            font-weight: 500;
            color: #333;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .status-filter option[value=""] {
            color: #6c757d;
        }

        .status-filter option[value="2"] {
            color: #27ae60; /* Màu xanh lá cho "Booking Successful" */
        }

        .status-filter option[value="3"] {
            color: #e74c3c; /* Màu đỏ đậm cho "Is Cancelled" */
        }

        .status-filter option[value="5"] {
            color: #3498db; /* Màu xanh dương cho "Refund Completed" */
        }

        /* Tùy chỉnh giao diện khi focus */
        .status-filter:focus {
            outline: none; /* Bỏ viền mặc định khi focus */
            border-color: #27ae60; /* Viền xanh lá khi focus */
            box-shadow: 0 0 5px rgba(39, 174, 96, 0.3); /* Hiệu ứng sáng khi focus */
        }
    </style>

</head>

<body>
<jsp:include page="/views/layout/Header.jsp"/>

<div class="container mt-5 order-container">
    <%
        List<Bookings> listBooking = (List<Bookings>) request.getAttribute("listBooking");
        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        TicketsDAO td = new TicketsDAO();
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm dd-MM-yyyy");
        AirlinesDAO ad = new AirlinesDAO();
        PassengersDAO pd = new PassengersDAO();
        SeatsDAO sd = new SeatsDAO();
        FlightsDAO fd = new FlightsDAO();
        AirportsDAO apd = new AirportsDAO();
        BaggageDAO bd = new BaggageDAO();
        BookingDAO bkd = new BookingDAO();
        PaymentsDAO pmd = new PaymentsDAO();
    %>


    <div class="row mt-3 mb-3">
        <div class="col-md-12">
            <form action="ticketHistoryURL" method="get" class="form-inline justify-content-center">
                <input type="text" value="${param.code}" class="form-control" name="code" placeholder="Enter code here to search ..." aria-label="Search" style="width: 30%; font-size: 1.2em">
                <div class="input-group-append">
                    <button class="btn btn-outline-secondary" type="submit" style="padding: 12px;margin-left: 30px;">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>


    <!-- Status Tabs Section -->
    <div class="row" style="margin-top: 20px">
        <div class="col-md-12">
            <div class="form-group">
                <label for="statusFilter" style="font-weight: bold;">Filter by Status:</label>
                <select id="statusFilter" class="form-control status-filter" onchange="filterByStatus(this)">
                    <option value="" <%= request.getParameter("status") == null ? "selected" : "" %>>All</option>
                    <option value="1" <%= "1".equals(request.getParameter("status")) ? "selected" : "" %>>Is Pending</option>
                    <option value="2" <%= "2".equals(request.getParameter("status")) ? "selected" : "" %>>Booking Successful</option>
                    <option value="3" <%= "3".equals(request.getParameter("status")) ? "selected" : "" %>>Is Cancelled</option>
                    <option value="4" <%= "4".equals(request.getParameter("status")) ? "selected" : "" %>>Refund Pending</option>
                    <option value="5" <%= "5".equals(request.getParameter("status")) ? "selected" : "" %>>Refund Completed</option>
                    <option value="6" <%= "6".equals(request.getParameter("status")) ? "selected" : "" %>>Rejected Refund</option>
                </select>
            </div>
        </div>
    </div>


    <!-- Buying History -->
    <div class="buying-history">
        <% int id = 0; %>
        <% for (Bookings b : listBooking) { %>
        <% List<Tickets> listTicketInBooking = td.getAllTicketsByBookingId(b.getBookingID()); %>
        <% if (!listTicketInBooking.isEmpty()) { %>
        <div class="order-card">
            <div class="order-header">
                <div class="order-id">
                    <strong style="font-size: 28px;"><%=b.getCode()%></strong>
                    <span style="margin-left: 4px; font-size: 12px; color: #aaa;"><%=sdf.format(b.getBookingDate())%></span><br>
                    <div class="contact-info" style="color: #9a9999; margin-top: 5px;">
                        Contact: <i class="fas fa-user"></i> <%=b.getContactName()%> |
                        <i class="fas fa-phone"></i> <%=b.getContactPhone()%> |
                        <i class="fas fa-envelope"></i> <%=b.getContactEmail()%>
                    </div>
                </div>
                <div class="order-details">
                    <% switch (b.getStatus()) {
                        case 1: %>
                    <span class="status-label pending">Is Pending</span>
                    <% break;
                        case 2: %>
                    <span class="status-label successful">Successful Payment</span>
                    <% break;
                        case 3: %>
                    <span class="status-label cancelled">Is Cancelled</span>
                    <% break;
                        case 4: %>
                    <span class="status-label request">Refund Pending</span>
                    <% break;
                        case 5: %>
                    <span class="status-label successful">Refund Complete</span>
                    <% break;
                        case 6: %>
                    <span class="status-label cancelled">Reject Refund</span>
                    <% break;
                    } %>
                </div>
            </div>

            <%
                LocalTime desTime = null;
                LocalDate desDate = null;
                LocalTime depTime = null;
                LocalDate depDate = null;
                LocalDateTime currentDateTime = LocalDateTime.now();
                int count = 1;
                boolean allTicketsCancelled = true;
                Payments payment = pmd.getPaymentByBookingId(b.getBookingID());
                boolean isPaid = payment != null && payment.getPaymentDate() != null;

            %>
            <% LocalDateTime depDateTime = null;
                for (Tickets t : listTicketInBooking) { %>
            <% id = t.getTicketId(); %>
            <% if (t.getStatus() != 3) allTicketsCancelled = false; %>
            <div class="ticket-details">
                <div class="flight-info" style="display: flex; flex-direction: column; gap: 5px;">
                    <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 20px">
                        <div class="airline-image">
                            <img src="<%=request.getContextPath()%>/img/logo.jpg" alt="Airline Logo" class="img-fluid">
                        </div>
                        <div>
                            <div>Ticket <%=count%></div>
                            <div>
                                <%=pd.getPassengerById(pd.getPassengerIdByTicketId(t.getTicketId())).getGender().equals("Male") ? "Mr." : "Mrs."%>
                                <%=pd.getPassengerById(pd.getPassengerIdByTicketId(t.getTicketId())).getPassengerName()%></div>
                            <div><%=sd.getSeatById(t.getSeatId()).getSeatClass()%> - <%=t.getCode()%></div>
                        </div>
                    </div>

                    <%
                        Flights flight = fd.getFlightById(t.getFlightId());
                        if (flight != null) {
                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                            Timestamp departureString = flight.getDepartureTime();
                            Timestamp arrivalString = flight.getArrivalTime();
                            LocalDateTime departureDateTime = departureString.toLocalDateTime();
                            LocalDateTime destinationDateTime = arrivalString.toLocalDateTime();
                            depDate = departureDateTime.toLocalDate();
                            depTime = departureDateTime.toLocalTime();
                            desDate = destinationDateTime.toLocalDate();
                            desTime = destinationDateTime.toLocalTime();
                    %>
                    <div><i class="fas fa-plane"></i>
                        <%=apd.getAirportById(flight.getDepartureAirportId()).getAirportName()%> <strong>To</strong>
                    <%=apd.getAirportById(flight.getArrivalAirportId()).getAirportName()%></div>
                    <div>
                        <i class="far fa-calendar-alt"></i> <%=depDate%>
                        <span class="time-separator" style="margin-left: 10px;">
                            <i class="far fa-clock"></i> <%=depTime%> - <%=desTime%>
                    <%
                        long totalTime = flight.getArrivalTime().getTime() - flight.getDepartureTime().getTime();
                        long hours = totalTime / (1000 * 60 * 60);
                        long minutes = (totalTime / (1000 * 60)) % 60;
                    %>
                            <p>Total time: <span class="total-time"><%=hours%> h <%=minutes%> m</span></p>
                        </span>
                    </div>
                    <div><i class="fas fa-plane-departure"></i>
                    <%=ad.getAirlineById(flight.getAirlineId()).getAirlineName()%></div>
                    <% } %>

                    <%
                        Baggages bg = bd.getBaggageById(t.getBaggageId());
                        if (bg != null) {
                    %>
                    <div><i class="fas fa-suitcase"></i> Extra baggage: <%=bg.getWeight()%>kg</div>
                    <% } %>
                </div>
                <div class="ticket-actions">
                    <div><strong style="font-size: 16px"><%=currencyFormatter.format(t.getPrice())%></strong></div>
                    <%
                        depDateTime = LocalDateTime.of(depDate != null ? depDate : LocalDate.now(), depTime != null ? depTime : LocalTime.now());
                    %>
                </div>
            </div>
            <% count++; %>
            <% } %>

            <div class="list-price" style="text-align: right; padding: 15px 0">
                <div>Totals Booking Tickets: <%=currencyFormatter.format(bkd.getTotalPriceAllTickets(b.getBookingID()))%></div>
            </div>

            <div class="order-total-section" style="font-size: 1.2em;">
                <!-- Logic hiển thị nút Request Refund cho toàn bộ booking -->
                <%
                    if (isPaid && ((listTicketInBooking.size() == 1 && listTicketInBooking.get(0).getStatus() == 3) || (listTicketInBooking.size() > 1 && allTicketsCancelled)) && b.getStatus() != 4 && b.getStatus() != 5) {
                %>
                <div class="order-actions" style="margin-top: 10px; text-align: right">
                    <button class="btn btn-warning" style="text-decoration: none;" onclick="openModalRequestRefund(
                        <%=listTicketInBooking.get(0).getTicketId()%>, <%=b.getBookingID()%>)">Request Refund</button>
                </div>
                <% } %>

                <!-- Logic hiển thị nút Cancel Order và Pay Now -->
                <div class="order-actions" style="margin-top: 10px; text-align: right">
                    <% if (!isPaid && b.getStatus() != 3 && b.getStatus() != 4 && b.getStatus() != 5) { %>
                    <button type="submit" class="btn btn-success" id="togglePaymentBtn<%=b.getBookingID()%>
                " onclick="paymentMedthodDisplay(<%=b.getBookingID()%>)">PAY NOW</button>
                    <% } %>
                    <%
                        if (currentDateTime.isBefore(depDateTime) && b.getStatus() != 3 && b.getStatus() != 4 && b.getStatus() != 5
                                && b.getStatus() != 6 && !allTicketsCancelled) {
                    %>
                    <button class="btn btn-danger" style="text-decoration: none;" onclick="openModalOrder(
                        <%=b.getBookingID()%>)">Cancel Order</button>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Payment Methods -->
        <div id="payment_methods<%=b.getBookingID()%>" style="display: none;">
            <h2>Payments Method</h2>
            <div class="payment-options">
                <div class="payment-option">
                    <form action="VnpayServlet" id="frmCreateOrder" method="post">
                        <input type="hidden" name="bookingID" value="<%=b.getBookingID()%>"/>
                        <input type="hidden" name="bankCode" value="">
                        <input type="hidden" class="form-control" data-val="true" data-val-number="The field Amount must be a number." data-val-required="The Amount field is required." id="amount" max="1000000000" min="1" name="amount" type="number" value="
            <%=b.getTotalPrice()%>"/>
                        <input type="hidden" name="language" checked value="vn">
                        <button type="submit" class="btn btn-default">
                            <img class="imgPayment" src="<%=request.getContextPath()%>/img/VnPay.jpg" alt="VNPAY">
                            <div class="name-pay">VNPAY<br>VNPAY payment gateway</div>
                        </button>
                    </form>
                </div>
                <div class="payment-option">
                    <form action="QRCodeURL" method="post">
                        <input type="hidden" name="bookingID" value="<%=b.getBookingID()%>"/>
                        <button type="submit" class="btn btn-default">
                            <img class="imgPayment" src="<%=request.getContextPath()%>/img/qr.png" alt="QR CODE">
                            <div class="name-pay">QR Code<br>Pay by QR Code transfer</div>
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <% } else { %>
        <div class="alert alert-warning">
            No tickets found for this booking (Code: <%= b.getCode() %>).
        </div>
        <% } %>
        <% } %>
    </div>

    <!-- Pagination -->
    <% String statusIdParam = request.getParameter("status");
        String code = request.getParameter("code");
        if (statusIdParam == null && code == null) { %>
    <div style="width: 100%; margin: 0 auto">
        <nav aria-label="..." style="width: 100%; text-align: center;">
            <ul class="pagination">
                <c:if test="${index != 1}">
                    <li class="page-item">
                        <a class="page-link" href="ticketHistoryURL?index=${index - 1}">Previous</a>
                    </li>
                </c:if>
                <c:forEach begin="1" end="${numOfPage}" var="i">
                    <c:if test="${index == i}">
                        <li class="page-item active">
                            <a class="page-link" href="ticketHistoryURL?index=${i}">${i}</a>
                        </li>
                    </c:if>
                    <c:if test="${index != i}">
                        <li class="page-item">
                            <a class="page-link" href="ticketHistoryURL?index=${i}">${i}</a>
                        </li>
                    </c:if>
                </c:forEach>
                <c:if test="${index != numOfPage}">
                    <li class="page-item">
                        <a class="page-link" href="ticketHistoryURL?index=${index + 1}">Next</a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
    <% } %>

</div>

<!-- Modal Cancel Ticket -->
<div id="cancelTicketModal" class="modal" role="dialog" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5);">
    <div class="modal-dialog" style="margin: 15% auto; width: 30%; position: relative;">
        <div class="modal-content" style="background-color: #fff; padding: 20px; border: 1px solid #888; margin-top: -110px;">
            <form action="cancelTicket" method="post">
                <input type="hidden" id="modalTicketId" name="ticketId" value="">
                <input type="hidden" id="modalOrderId" name="orderId" value="">
                <h2>Cancel Ticket</h2>
                <p>Are you sure you want to cancel this ticket?</p>
                <div style="display: flex; justify-content: space-between;">
                    <button type="submit" id="confirmCancel" class="btn btn-danger" style="flex: 1; margin-right: 10px;">Yes</button>
                    <button type="button" id="closeModal" class="btn btn-secondary" style="flex: 1;" onclick="closeModal()">No</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal Cancel Order -->
<div id="cancelOrderModal" class="modal" role="dialog" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5);">
    <div class="modal-dialog" style="margin: 15% auto; width: 30%; position: relative;">
        <div class="modal-content" style="background-color: #fff; padding: 20px; border: 1px solid #888; margin-top: -110px;">
            <form action="cancelOrder" method="post">
                <input type="hidden" id="modalOrderId1" name="orderId" value="">
                <h2>Cancel Order</h2>
                <p>Are you sure you want to cancel this order?</p>
                <div style="display: flex; justify-content: space-between;">
                    <button type="submit" id="confirmCancelOrder" class="btn btn-danger" style="flex: 1; margin-right: 10px;">Yes</button>
                    <button type="button" id="closeOrderModal" class="btn btn-secondary" style="flex: 1;" onclick="closeOrderModal()">No</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal Request Refund -->
<div id="requestRefundModal" class="modal" role="dialog" style="display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5);">
    <div class="modal-dialog" style="margin: 15% auto; width: 30%; position: relative;">
        <div class="modal-content" style="background-color: #fff; padding: 20px; border: 1px solid #888; margin-top: -110px;">
            <form action="requestRefund" method="post" onsubmit="return validateBankAccount()">
                <input type="hidden" id="modalTicketId2" name="ticketId" value="">
                <input type="hidden" id="modalOrderId2" name="orderId" value="">
                <h2 id="requestRefundLabel">Request Refund</h2>
                <p id="requestRefundDescription">Please provide your bank details to request a refund.</p>
                <div class="form-group">
                    <label for="bank">Bank Name</label>
                    <select id="bank" name="bank" required class="form-control">
                        <option value="">Select a bank</option>
                        <option value="BIDV">BIDV</option>
                        <option value="TP Bank">TP Bank</option>
                        <option value="MB Bank">MB Bank</option>
                        <option value="MB Bank">Mai Bank</option>
                        <option value="MB Bank">Toi e bank</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="bankAccount">Bank Account</label>
                    <input type="text" id="bankAccount" name="bankAccount" required class="form-control">
                </div>
                <div class="form-group">
                    <label for="confirmBankAccount">Confirm Bank Account</label>
                    <input type="text" id="confirmBankAccount" name="confirmBankAccount" required class="form-control">
                </div>
                <div style="display: flex; justify-content: space-between;">
                    <button type="submit" id="confirmRequestRefund" class="btn btn-danger" style="flex: 1; margin-right: 10px;">Yes</button>
                    <button type="button" id="closeRequestRefundModal" class="btn btn-secondary" style="flex: 1;" onclick="closeOrderModal()">No</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script>
    function validateBankAccount() {
        const bankSelect = document.getElementById('bank').value;
        const bankAccount = document.getElementById('bankAccount').value;
        let regex;

        switch (bankSelect) {
            case 'BIDV':
                regex = /^455\d{11}$/;
                break;
            case 'TP Bank':
                regex = /^0000\d{7}$/;
                break;
            case 'MB Bank':
                regex = /^\d{10}$/;
                break;
            default:
                alert('Please select a valid bank.');
                return false;
        }

        if (!regex.test(bankAccount)) {
            alert('Invalid bank account number for the selected bank.');
            return false;
        }

        const confirmBankAccount = document.getElementById('confirmBankAccount').value;
        if (bankAccount !== confirmBankAccount) {
            alert('Bank account and confirm bank account do not match.');
            return false;
        }

        return true;
    }

    function openModalRequestRefund(ticketId, orderId) {
        document.getElementById("modalTicketId2").value = ticketId;
        document.getElementById("modalOrderId2").value = orderId;
        document.getElementById("requestRefundModal").style.display = "block";
    }

    function closeModalRequestRefund() {
        document.getElementById("requestRefundModal").style.display = "none";
    }

    document.getElementById("closeRequestRefundModal").onclick = closeModalRequestRefund;

    function openModalTicket(ticketId, orderId) {
        document.getElementById("modalTicketId").value = ticketId;
        document.getElementById("modalOrderId").value = orderId;
        document.getElementById("cancelTicketModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("cancelTicketModal").style.display = "none";
    }

    document.getElementById("closeModal").onclick = closeModal;

    function openModalOrder(orderId) {
        document.getElementById('modalOrderId1').value = orderId;
        document.getElementById('cancelOrderModal').style.display = 'block';
    }

    function closeOrderModal() {
        document.getElementById('cancelOrderModal').style.display = 'none';
        document.getElementById('requestRefundModal').style.display = 'none'; // Đóng cả modal refund
    }

    document.getElementById("closeOrderModal").onclick = closeOrderModal;

    window.onclick = function (event) {
        const modals = [
            document.getElementById("requestRefundModal"),
            document.getElementById("cancelTicketModal"),
            document.getElementById("cancelOrderModal")
        ];
        modals.forEach(function (modal) {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        });
    };

    $("#frmCreateOrder").submit(function () {
        var postData = $("#frmCreateOrder").serialize();
        var submitUrl = $("#frmCreateOrder").attr("action");
        $.ajax({
            type: "POST",
            url: submitUrl,
            data: postData,
            dataType: 'JSON',
            success: function (x) {
                if (x.code === '00') {
                    if (window.vnpay) {
                        vnpay.open({width: 768, height: 600, url: x.data});
                    } else {
                        location.href = x.data;
                    }
                    return false;
                } else {
                    alert(x.Message);
                }
            }
        });
        return false;
    });

    function paymentMedthodDisplay(id) {
        var paymentMethods = document.getElementById("payment_methods" + id);
        if (paymentMethods.style.display === 'none' || paymentMethods.style.display === '') {
            paymentMethods.style.display = 'block';
        } else {
            paymentMethods.style.display = 'none';
        }
    }

    function filterByStatus(selectElement) {
        var status = selectElement.value;
        var url = "ticketHistoryURL";
        if (status) {
            url += "?status=" + status;
        }
        window.location.href = url;
    }
</script>

<script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<jsp:include page="/views/layout/Footer.jsp"/>

</body>
</html>