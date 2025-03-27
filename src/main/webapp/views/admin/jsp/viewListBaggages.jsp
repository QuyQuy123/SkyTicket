
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Skyticket - Baggages mangement</title>
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
    List<Baggages> baggages = (List<Baggages>) request.getAttribute("baggages");
    List<Airlines> airlines = (List<Airlines>) request.getAttribute("airlines");
    int currentPage = (Integer) request.getAttribute("currentPage");
    int totalPages = (Integer) request.getAttribute("totalPages");
    if (baggages == null) baggages = new ArrayList<>();

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
                    <h5 class="mb-0">Baggages List</h5>

                    <div class="search-bar p-0 d-none d-md-block ms-2">
                        <div id="search" class="menu-search mb-0">
                            <form action="<%= request.getContextPath() %>/baggagesSearch" method="get"
                                  class="d-flex">
                                <!-- Ô tìm kiếm -->
                                <input type="text" name="BaggageID" class="form-control border rounded-pill me-2"
                                       placeholder="Search BaggageID..." >
                                <select name="AirlineName" class="form-select border rounded-pill me-2">
                                    <option value="">Select Airline Name</option>
                                    <%
                                        for (Airlines airline : airlines) {
                                    %>
                                    <option value="<%= airline.getAirlineName() %>">
                                        <%= airline.getAirlineName() %>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select>
                                <select name="orderWeight" id="order1" class="form-select border rounded-pill me-2">
                                    <option value="">Order of Weight</option>
                                    <option value="asc" ${param.order == 'asc' ? 'selected' : ''}>Weight Ascending</option>
                                    <option value="desc" ${param.order == 'desc' ? 'selected' : ''}>Weight Descending</option>
                                </select>
                                <select name="orderPrice" id="order2" class="form-select border rounded-pill me-2">
                                    <option value="">Order of Price</option>
                                    <option value="asc" ${param.order == 'asc' ? 'selected' : ''}>Price Ascending</option>
                                    <option value="desc" ${param.order == 'desc' ? 'selected' : ''}>Price Descending</option>
                                </select>

                                <!-- Nút tìm kiếm -->
                                <button type="submit" class="btn btn-outline-primary rounded-pill me-2">Search</button>
                            </form>

                        </div>
                    </div>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/views/admin/jsp/Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Baggages</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-12 mt-4">
                        <div class="table-responsive shadow rounded">
                            <table class="table table-center bg-white mb-0">
                                <thead>
                                <tr>
                                    <th class="border-bottom p-3">BaggageId</th>
                                    <th class="border-bottom p-3">Airline Name</th>
                                    <th class="border-bottom p-3">Weight</th>
                                    <th class="border-bottom p-3">Price</th>
                                    <th class="border-bottom p-3">Status</th>
                                    <th class="border-bottom p-3">Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    for (Baggages b : baggages) {
                                        String airlineName = "Unknown"; // Mặc định nếu không tìm thấy
                                        for (Airlines a : airlines) {
                                            if (b.getAirlineId() == a.getAirlineId()) {
                                                airlineName = a.getAirlineName();
                                                break; // Thoát vòng lặp khi tìm thấy hãng phù hợp
                                            }
                                        }
                                %>
                                <tr>
                                    <td class="p-3"><%= b.getBaggageId() %></td>
                                    <td class="p-3"><%= airlineName %></td>
                                    <td class="p-3"><%= b.getWeight() %></td>
                                    <td class="p-3"><%= b.getPrice() %></td>
                                    <td class="p-3"><span class="badge <%= b.getStatus()== 1 ? "bg-soft-success" : "bg-soft-warning" %>"><%=b.getStatus()== 1 ? "Active" : "Deactive" %></span></td>
                                    <td class=" p-2">
                                        <a href="${pageContext.request.contextPath}/updateBaggage?id=<%= b.getBaggageId() %>" class="btn btn-icon btn-pills btn-soft-success"><i class="uil uil-pen"></i></a>
                                        <a href="javascript:void(0);" class="btn btn-icon btn-pills btn-soft-danger" onclick="confirmDelete(<%= b.getBaggageId() %>)">
                                            <i class="uil uil-trash"></i>
                                        </a>
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
        <!-- Phân trang -->
        <div class="d-flex justify-content-center mt-3 margin-bottom">
            <div class="pagination">
                <!-- Nút First -->
                <% if (currentPage > 1) { %>
                <a href="<%= request.getContextPath() %>/baggagesSearch?page=1&BaggageID=<%= request.getAttribute("baggageId") != null ? request.getAttribute("baggageId") : "" %>&AirlineName=<%= request.getAttribute("airlinesName") != null ? request.getAttribute("airlinesName") : "" %>&orderWeight=<%= request.getAttribute("orderWeight") != null ? request.getAttribute("orderWeight") : "" %>&orderPrice=<%= request.getAttribute("orderPrice") != null ? request.getAttribute("orderPrice") : "" %>"
                   class="btn btn-outline-primary">First</a>
                <% } %>

                <!-- Nút Previous -->
                <% if (currentPage > 1) { %>
                <a href="<%= request.getContextPath() %>/baggagesSearch?page=<%= currentPage - 1 %>&BaggageID=<%= request.getAttribute("baggageId") != null ? request.getAttribute("baggageId") : "" %>&AirlineName=<%= request.getAttribute("airlinesName") != null ? request.getAttribute("airlinesName") : "" %>&orderWeight=<%= request.getAttribute("orderWeight") != null ? request.getAttribute("orderWeight") : "" %>&orderPrice=<%= request.getAttribute("orderPrice") != null ? request.getAttribute("orderPrice") : "" %>"
                   class="btn btn-outline-primary">Previous</a>
                <% } %>

                <!-- Hiển thị trang hiện tại -->
                <span class="btn btn-primary"><%= currentPage %> / <%= totalPages %></span>

                <!-- Nút Next -->
                <% if (currentPage < totalPages) { %>
                <a href="<%= request.getContextPath() %>/baggagesSearch?page=<%= currentPage + 1 %>&BaggageID=<%= request.getAttribute("baggageId") != null ? request.getAttribute("baggageId") : "" %>&AirlineName=<%= request.getAttribute("airlinesName") != null ? request.getAttribute("airlinesName") : "" %>&orderWeight=<%= request.getAttribute("orderWeight") != null ? request.getAttribute("orderWeight") : "" %>&orderPrice=<%= request.getAttribute("orderPrice") != null ? request.getAttribute("orderPrice") : "" %>"
                   class="btn btn-outline-primary">Next</a>
                <% } %>

                <!-- Nút Last -->
                <% if (currentPage < totalPages) { %>
                <a href="<%= request.getContextPath() %>/baggagesSearch?page=<%= totalPages %>&BaggageID=<%= request.getAttribute("baggageId") != null ? request.getAttribute("baggageId") : "" %>&AirlineName=<%= request.getAttribute("airlinesName") != null ? request.getAttribute("airlinesName") : "" %>&orderWeight=<%= request.getAttribute("orderWeight") != null ? request.getAttribute("orderWeight") : "" %>&orderPrice=<%= request.getAttribute("orderPrice") != null ? request.getAttribute("orderPrice") : "" %>"
                   class="btn btn-outline-primary">Last</a>
                <% } %>
            </div>
        </div>
        <!-- Footer Start -->
        <%@include file="bottom.jsp"%>
        <!-- End -->
    </main>
    <!--End page-content" -->
</div>
<!-- page-wrapper -->



<!-- javascript -->
<script>
    function confirmDelete(baggageId, currentPage) {
        if (confirm("Are you sure to delete this baggage?")) {
            window.location.href = "<%= request.getContextPath() %>/deleteBaggage?id=" +
                baggageId + "&page=" + currentPage;
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