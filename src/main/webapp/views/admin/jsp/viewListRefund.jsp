
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Skyticket - Refund mangement</title>
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

    <style>
        .badge {
            font-weight: 500;
            text-align: center;
            border-radius: 20px;
            padding: 6px 12px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-transform: uppercase;
            display: inline-block;
        }
        .badge.status-refund-pending {
            background-color: #f1c40f;
        }
        .badge.status-refund-success {
            background-color: #27ae60;
        }
        .badge.status-failed {
            background-color: #e74c3c;
        }

    </style>
</head>

<body>
<%
    List<Refund> refundList = (List<Refund>) request.getAttribute("refundList");
    List<Tickets> ticketsList = (List<Tickets>) request.getAttribute("ticketsList");
    int currentPage = (Integer) request.getAttribute("currentPage");
    int totalPages = (Integer) request.getAttribute("totalPages");

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
                    <h5 class="mb-0">Refund List</h5>

                    <div class="search-bar p-0 d-none d-md-block ms-2">
                        <div id="search" class="menu-search mb-0">
                            <form action="<%= request.getContextPath() %>/refundSearch" method="get"
                                  class="d-flex">
                                <!-- Ô tìm kiếm -->
                                <input type="text" name="RefundID" class="form-control border rounded-pill me-2 w-150 px-3 text-truncate"
                                       style="min-width: 300px; width: 50%;"
                                       placeholder="Search with Refund Id or Ticket Code" >
                                <select name="orderPricet" id="order" class="form-select border rounded-pill me-2">
                                    <option value="">Order of price</option>
                                    <option value="asc" ${param.order == 'asc' ? 'selected' : ''}>Price Ascending</option>
                                    <option value="desc" ${param.order == 'desc' ? 'selected' : ''}>Price Descending</option>
                                </select>
                                <!-- Bộ lọc trạng thái -->

                                <select name="status" class="form-select border rounded-pill me-2">
                                    <option value="">All Status</option>
                                    <option value="1">Pending</option>
                                    <option value="2">Success</option>
                                    <option value="3">Failed</option>
                                </select>


                                <!-- Nút tìm kiếm -->
                                <button type="submit" class="btn btn-outline-primary rounded-pill me-2">Search</button>
                            </form>

                        </div>
                    </div>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/views/admin/jsp/Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Refund</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-12 mt-4">
                        <div class="table-responsive shadow rounded">
                            <table class="table table-center bg-white mb-0">
                                <thead>
                                <tr>
                                    <th class="border-bottom p-3">Refund ID</th>
                                    <th class="border-bottom p-3">Ticket Code</th>
                                    <th class="border-bottom p-3">Request Date</th>
                                    <th class="border-bottom p-3">Refund Date</th>
                                    <th class="border-bottom p-3">Refund Price</th>
                                    <th class="border-bottom p-3">Status</th>
                                    <th class="border-bottom p-3">Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    for (Refund                                     r : refundList) {
                                        String ticketCode = "Unknown";
                                        for(Tickets t : ticketsList){
                                            if(r.getTicketId() == t.getTicketId()){
                                                ticketCode = t.getCode();
                                            }
                                        }

                                %>
                                <tr>
                                    <td class="p-3" ><%= r.getRefundId() %></td>
                                    <td class="p-3"><%= ticketCode %></td>
                                    <td class="p-3"><%= r.getRequestDate()%></td>
                                    <td class="p-3"><%= r.getRefundDate() %></td>
                                    <td class="p-3"><%= r.getRefundPrice() %></td>

                                    <td class="p-3">
                                        <span class="badge <%=
                                            r.getStatus() == 1 ? "status-refund-pending" :
                                            r.getStatus() == 2 ? "status-refund-success" :
                                            "status-failed" %> <%=
                                            r.getStatus() == 1 ? "bg-soft-warning text-warning" :
                                            r.getStatus() == 2 ? "bg-soft-success text-success" :
                                            "bg-soft-danger text-danger" %>">
                                            <%= r.getStatus() == 1 ? "Refund Pending" : r.getStatus() == 2 ? "Refund Success" :
                                                            "Failed" %>
                                        </span>
                                    </td>


                                    <td class=" p-2">
                                        <a href="${pageContext.request.contextPath}/listRefund?action=details&id=<%=r.getRefundId()%>" class="btn btn-icon btn-sm btn-soft-primary"><i
                                                class="uil uil-eye"></i></a>
                                        <a href="#" class="btn btn-icon btn-pills btn-soft-success"><i class="uil uil-pen"></i></a>
                                        <a href="#" class="btn btn-icon btn-pills btn-soft-danger">
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
                <a href="<%= request.getContextPath() %>/refundSearch?RefundID=<%= request.getAttribute("refundIdOrTicketCode") != null ? request.getAttribute("refundIdOrTicketCode") : "" %>&orderPricet=<%= request.getAttribute("orderPricet") != null ? request.getAttribute("orderPricet") : "" %>&status=<%= request.getAttribute("status") != null ? request.getAttribute("status") : "" %>&page=1"
                   class="btn btn-outline-primary">First</a>
                <% } %>

                <!-- Nút Previous -->
                <% if (currentPage > 1) { %>
                <a href="<%= request.getContextPath() %>/refundSearch?RefundID=<%= request.getAttribute("refundIdOrTicketCode") != null ? request.getAttribute("refundIdOrTicketCode") : "" %>&orderPricet=<%= request.getAttribute("orderPricet") != null ? request.getAttribute("orderPricet") : "" %>&status=<%= request.getAttribute("status") != null ? request.getAttribute("status") : "" %>&page=<%= currentPage - 1 %>"
                   class="btn btn-outline-primary">Previous</a>
                <% } %>

                <!-- Hiển thị trang hiện tại -->
                <span class="btn btn-primary"><%= currentPage %> / <%= totalPages %></span>

                <!-- Nút Next -->
                <% if (currentPage < totalPages) { %>
                <a href="<%= request.getContextPath() %>/refundSearch?RefundID=<%= request.getAttribute("refundIdOrTicketCode") != null ? request.getAttribute("refundIdOrTicketCode") : "" %>&orderPricet=<%= request.getAttribute("orderPricet") != null ? request.getAttribute("orderPricet") : "" %>&status=<%= request.getAttribute("status") != null ? request.getAttribute("status") : "" %>&page=<%= currentPage + 1 %>"
                   class="btn btn-outline-primary">Next</a>
                <% } %>

                <!-- Nút Last -->
                <% if (currentPage < totalPages) { %>
                <a href="<%= request.getContextPath() %>/refundSearch?RefundID=<%= request.getAttribute("refundIdOrTicketCode") != null ? request.getAttribute("refundIdOrTicketCode") : "" %>&orderPricet=<%= request.getAttribute("orderPricet") != null ? request.getAttribute("orderPricet") : "" %>&status=<%= request.getAttribute("status") != null ? request.getAttribute("status") : "" %>&page=<%= totalPages %>"
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