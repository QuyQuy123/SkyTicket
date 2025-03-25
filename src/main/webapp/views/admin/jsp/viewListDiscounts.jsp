
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Skyticket - Seats mangement</title>
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
    List<Discounts> discountsList = (List<Discounts>) request.getAttribute("discountsList");
    List<Accounts> accountsList = (List<Accounts>) request.getAttribute("accountsList");
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
                    <h5 class="mb-0">Discount List</h5>

                    <div class="search-bar p-0 d-none d-md-block ms-2">
                        <div id="search" class="menu-search mb-0">
                            <form action="<%= request.getContextPath() %>/discountSearch" method="get"
                                  class="d-flex">
                                <!-- Ô tìm kiếm -->
                                <input type="text" name="search" class="form-control border rounded-pill me-2"
                                       placeholder="Search Discount Id or Account Name..." >


                                <!-- Nút tìm kiếm -->
                                <button type="submit" class="btn btn-outline-primary rounded-pill me-2">Search</button>
                            </form>

                        </div>
                    </div>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/views/admin/jsp/Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Discount</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-12 mt-4">
                        <div class="table-responsive shadow rounded">
                            <table class="table table-center bg-white mb-0">
                                <thead>
                                <tr>
                                    <th class="border-bottom p-3">Discount Id </th>
                                    <th class="border-bottom p-3">Account Name </th>
                                    <th class="border-bottom p-3">Percent</th>
                                    <th class="border-bottom p-3">Points</th>
                                    <th class="border-bottom p-3">Delete</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    for (Discounts d : discountsList) {
                                        String accountName = "Unknown";
                                        for(Accounts a : accountsList){
                                            if(d.getAccountId() == a.getAccountId()){
                                                accountName = a.getFullName();
                                                break;
                                            }
                                        }
                                %>
                                <tr>
                                    <td class="p-3"><%= d.getDiscountId()%></td>
                                    <td class="p-3"><%= accountName %></td>
                                    <td class="p-3">
                                        <div class="d-flex align-items-center">
                                            <form method="post" action="<%= request.getContextPath() %>/updateDiscount" class="me-2">
                                                <input type="hidden" name="discountId" value="<%= d.getDiscountId() %>">
                                                <input type="hidden" name="field" value="percent">
                                                <input type="hidden" name="action" value="decrease">
                                                <button type="submit" class="btn btn-sm btn-outline-secondary"
                                                        <%= d.getPercent() <= 0 ? "disabled" : "" %>>-</button>
                                            </form>
                                            <form method="post" action="<%= request.getContextPath() %>/updateDiscount" class="me-2">
                                                <input type="hidden" name="discountId" value="<%= d.getDiscountId() %>">
                                                <input type="hidden" name="field" value="percent">
                                                <input type="hidden" name="action" value="set">
                                                <input type="number" name="value" step="0.1" min="0" max="100"
                                                       value="<%= String.format("%.1f", d.getPercent()) %>"
                                                       class="form-control form-control-sm" style="width: 70px;"
                                                       onchange="this.form.submit()">
                                            </form>
                                            <form method="post" action="<%= request.getContextPath() %>/updateDiscount" class="ms-2">
                                                <input type="hidden" name="discountId" value="<%= d.getDiscountId() %>">
                                                <input type="hidden" name="field" value="percent">
                                                <input type="hidden" name="action" value="increase">
                                                <button type="submit" class="btn btn-sm btn-outline-secondary"
                                                        <%= d.getPercent() >= 100 ? "disabled" : "" %>>+</button>
                                            </form>
                                        </div>
                                    </td>
                                    <td class="p-3">
                                        <div class="d-flex align-items-center">
                                            <form method="post" action="<%= request.getContextPath() %>/updateDiscount" class="me-2">
                                                <input type="hidden" name="discountId" value="<%= d.getDiscountId() %>">
                                                <input type="hidden" name="field" value="points">
                                                <input type="hidden" name="action" value="decrease">
                                                <button type="submit" class="btn btn-sm btn-outline-secondary"
                                                        <%= d.getPoints() <= 0 ? "disabled" : "" %>>-</button>
                                            </form>
                                            <form method="post" action="<%= request.getContextPath() %>/updateDiscount" class="me-2">
                                                <input type="hidden" name="discountId" value="<%= d.getDiscountId() %>">
                                                <input type="hidden" name="field" value="points">
                                                <input type="hidden" name="action" value="set">
                                                <input type="number" name="value" step="1" min="0"
                                                       value="<%= d.getPoints() %>"
                                                       class="form-control form-control-sm" style="width: 70px;"
                                                       onchange="this.form.submit()">
                                            </form>
                                            <form method="post" action="<%= request.getContextPath() %>/updateDiscount" class="ms-2">
                                                <input type="hidden" name="discountId" value="<%= d.getDiscountId() %>">
                                                <input type="hidden" name="field" value="points">
                                                <input type="hidden" name="action" value="increase">
                                                <button type="submit" class="btn btn-sm btn-outline-secondary">+</button>
                                            </form>
                                        </div>
                                    </td>
                                    <td class="p-2">
                                        <a href="javascript:void(0)" class="btn btn-icon btn-pills btn-soft-danger"
                                           onclick="confirmDeleteDiscount(<%= d.getDiscountId() %>)">
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

        <!-- Phân trang -->
        <div class="d-flex justify-content-center mt-3 margin-bottom">
            <div class="pagination">
                <!-- Nút First -->

                <a href="<%= request.getContextPath() %>/discountSearch?page=1&search=<%= request.getAttribute("search") %>"
                   class="btn btn-outline-primary">First</a>

                <!-- Nút Previous -->

                <a href="<%= request.getContextPath() %>/discountSearch?page=<%= currentPage - 1 %>&search=${search}"
                   class="btn btn-outline-primary">Previous</a>

                <!-- Hiển thị trang hiện tại -->
                <span class="btn btn-primary"><%= currentPage %> / <%= totalPages %></span>

                <!-- Nút Next -->
                <a href="<%= request.getContextPath() %>/discountSearch?page=<%= currentPage + 1 %>&search=${search}"
                   class="btn btn-outline-primary">Next</a>

                <!-- Nút Last -->
                <a href="<%= request.getContextPath() %>/discountSearch?page=<%= totalPages %>&search=${search}"
                   class="btn btn-outline-primary">Last</a>

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
    function confirmDeleteDiscount(discountId) {
        if (confirm("Are you sure you want to delete this discount?")) {
            window.location.href = "<%= request.getContextPath() %>/deleteDiscount?discountId=" + discountId;
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