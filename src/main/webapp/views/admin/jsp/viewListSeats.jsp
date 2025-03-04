
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="model.Airports" %>
<%@ page import="model.Locations" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Seats" %>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Skyticket - Airport mangement</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
    <meta name="author" content="Shreethemes" />
    <meta name="email" content="support@shreethemes.in" />
    <meta name="website" content="<%= request.getContextPath() %>/views/admin/jsp/Dashboard.jsp" />
    <meta name="Version" content="v1.2.0" />
    <!-- favicon -->
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/views/admin/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="<%= request.getContextPath() %>/views/admin/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- simplebar -->
    <link href="<%= request.getContextPath() %>/views/admin/assets/css/simplebar.css" type="text/css" />
    <!-- Icons -->
    <link href="<%= request.getContextPath() %>/views/admin/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="<%= request.getContextPath() %>/views/admin/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
    <!-- Css -->
    <link href="<%= request.getContextPath() %>/views/admin/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
</head>

<body>
<%
    List<Seats> listSeats = (List<Seats>) request.getAttribute("seats");
    int currentPage = (Integer) request.getAttribute("currentPage");
    int totalPages = (Integer) request.getAttribute("totalPages");
    if (listSeats == null) listSeats = new ArrayList<>();

%>

<!-- Loader -->
<div id="preloader">
    <div id="status">
        <div class="spinner">
            <div class="double-bounce1"></div>
            <div class="double-bounce2"></div>
        </div>
    </div>
</div>
<!-- Loader -->

<div class="page-wrapper doctris-theme toggled">
    <%@include file="right.jsp"%>
    <!-- sidebar-wrapper  -->

    <!-- Start Page Content -->
    <main class="page-content bg-light">
        <%@include file="top.jsp"%>
        <% String message = (String) session.getAttribute("message");
            if (message != null) { %>
        <div class="alert alert-success" role="alert">
            <%= message %>
        </div>
        <script>
            setTimeout(function () {
                document.querySelector(".alert").style.display = "none";
            }, 3000);
        </script>
        <% session.removeAttribute("message"); %>
        <% } %>

        <div class="container-fluid">
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between">
                    <h5 class="mb-0">Seats List</h5>

                    <div class="search-bar p-0 d-none d-md-block ms-2">
                        <div id="search" class="menu-search mb-0">
                            <form action="<%= request.getContextPath() %>/seatsSearch" method="get"
                                  class="d-flex">
                                <!-- Ô tìm kiếm -->
                                <input type="text" name="search" class="form-control border rounded-pill me-2"
                                       placeholder="Search Seats..." >
                                <input type="text" name="flightId" class="form-control border rounded-pill me-2"
                                       placeholder="Flight ID...">


                                <!-- Bộ lọc trạng thái -->
                                <select name="status" class="form-select border rounded-pill me-2">
                                    <option value="">Status</option>
                                    <option value="1">Active</option>
                                    <option value="0">Deactive</option>
                                </select>

                                <select name="isBooked" class="form-select border rounded-pill me-2">
                                    <option value="">IsBooked</option>
                                    <option value="1">Yes</option>
                                    <option value="0">No</option>
                                </select>

                                <!-- Nút tìm kiếm -->
                                <button type="submit" class="btn btn-outline-primary rounded-pill me-2">Search</button>
                            </form>

                        </div>
                    </div>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/views/admin/jsp/Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Seats</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-12 mt-4">
                        <div class="table-responsive shadow rounded">
                            <table class="table table-center bg-white mb-0">
                                <thead>
                                <tr>
                                    <th class="border-bottom p-3">SeatID</th>
                                    <th class="border-bottom p-3">FlightId</th>
                                    <th class="border-bottom p-3">Status</th>
                                    <th class="border-bottom p-3">Seat Number</th>
                                    <th class="border-bottom p-3">SeatClass</th>
                                    <th class="border-bottom p-3">IsBooked</th>
                                    <th class="border-bottom p-3">Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    for (Seats seat : listSeats){
                                %>
                                <tr>
                                    <td class="p-3"><%= seat.getSeatId() %></td>
                                    <td class="p-3"><%= seat.getFlightId()%></td>
                                    <td class="p-3"><span class="badge <%= seat.getStatus() == 1 ? "bg-soft-success" : "bg-soft-warning" %>"><%= seat.getStatus() == 1 ? "Active" : "Inactive" %></span></td>
                                    <td class="p-3"><%= seat.getSeatNumber() %></td>
                                    <td class="p-3"><%= seat.getSeatClass() %></td>
                                    <td class="p-3"><span class="badge <%= seat.getIsBooked() == 1 ? "bg-soft-success" : "bg-soft-warning" %>"><%= seat.getIsBooked() == 1 ? "Yes" : "No" %></span></td>
                                    <td class="text-end p-2">
                                        <a href="<%= request.getContextPath() %>/updateSeatURL?SeatId=<%=seat.getSeatId()%>" class="btn btn-icon btn-pills btn-soft-success"><i class="uil uil-pen"></i></a>
                                        <a href="javascript:void(0);" class="btn btn-icon btn-pills btn-soft-danger" onclick="confirmDelete(<%= seat.getSeatId() %>)">
                                            <i class="uil uil-trash"></i>
                                    </td>
                                </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div><!--end container-->

        <!--phân trang-->
        <c:choose>
            <c:when test="${searchpage == 'page'}">
                <div class="d-flex justify-content-center mt-3 margin-bottom">
                    <div class="pagination">
                        <!-- Nút First -->
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/seatsSearch?page=1&search=${search}&status=${status}"
                               class="btn btn-outline-primary">First</a>
                        </c:if>

                        <!-- Nút Previous -->
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/seatsSearch?page=${currentPage - 1}&search=${search}&status=${status}"
                               class="btn btn-outline-primary">Previous</a>
                        </c:if>

                        <!-- Hiển thị trang hiện tại -->
                        <span class="btn btn-primary">${currentPage} / ${totalPages}</span>

                        <!-- Nút Next -->
                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/seatsSearch?page=${currentPage + 1}&search=${search}&status=${status}"
                               class="btn btn-outline-primary">Next</a>
                        </c:if>

                        <!-- Nút Last -->
                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/seatsSearch?page=${totalPages}&search=${search}&status=${status}"
                               class="btn btn-outline-primary">Last</a>
                        </c:if>

                    </div>
                </div>
            </c:when>

        </c:choose>
        <!-- Footer Start -->
        <%@include file="bottom.jsp"%>
        <!-- End -->
    </main>
    <!--End page-content" -->
</div>
<!-- page-wrapper -->



<!-- javascript -->
<script>
    function confirmDelete(seatId) {
        if (confirm("Are you sure to delete this seat?")) {
            window.location.href = "<%= request.getContextPath() %>/SeatDelete?seatId=" + seatId;
        }
    }
</script>
<script src="<%= request.getContextPath() %>/views/admin/assets/js/bootstrap.bundle.min.js"></script>
<!-- simplebar -->
<script src="<%= request.getContextPath() %>/views/admin/assets/js/simplebar.min.js"></script>
<!-- Icons -->
<script src="<%= request.getContextPath() %>/views/admin/assets/js/feather.min.js"></script>
<!-- Main Js -->
<script src="<%= request.getContextPath() %>/views/admin/assets/js/app.js"></script>

</body>

</html>