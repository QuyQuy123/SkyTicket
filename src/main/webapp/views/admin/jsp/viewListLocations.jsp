
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="model.Airports" %>
<%@ page import="dal.AirportsDAO" %>
<%@ page import = "java.util.Vector" %>
<%@ page import="model.Locations" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Countries" %>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Skyticket - Locations mangement</title>
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
    List<Locations> listLocations = (List<Locations>) request.getAttribute("locations");
    List<Countries> listCountries = (List<Countries>) request.getAttribute("countries");

    if (listLocations == null) listLocations = new ArrayList<>();
    if (listCountries == null) listCountries = new ArrayList<>();
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
                    <h5 class="mb-0">Locations List</h5>

                    <div class="search-bar p-0 d-none d-md-block ms-2">
                        <div id="search" class="menu-search mb-0">
                            <form action="<%= request.getContextPath() %>/searchLocations" method="get"
                                  class="d-flex">
                                <!-- Ô tìm kiếm -->
                                <input type="text" name="search" class="form-control border rounded-pill me-2"
                                       placeholder="Search Locations..." >

                                <!-- Bộ lọc trạng thái -->
                                <select name="status" class="form-select border rounded-pill me-2">
                                    <option value="1">Active</option>
                                    <option value="0">Deactive</option>
                                </select>

                                <!-- Nút tìm kiếm -->
                                <button type="submit" class="btn btn-outline-primary rounded-pill me-2">Search</button>
                            </form>

                        </div>
                    </div>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="Dashboard.jsp">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Locations</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-12 mt-4">
                        <div class="table-responsive shadow rounded">
                            <table class="table table-center bg-white mb-0">
                                <thead>
                                <tr>
                                    <th class="border-bottom p-3">ID</th>
                                    <th class="border-bottom p-3">Name</th>
                                    <th class="border-bottom p-3">Country Name</th>
                                    <th class="border-bottom p-3">Status</th>
                                    <th class="border-bottom p-3">Actions</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    for (Locations locations: listLocations){
                                        String locationName = "unknown";
                                        for(Countries countries : listCountries){
                                            if(countries.getCountryId() == locations.getCountryId()){
                                                locationName = countries.getCountryName();
                                            }
                                        }
                                %>
                                <tr>
                                    <td class="p-3"><%= locations.getLocationId() %></td>
                                    <td class="p-3"><%= locations.getLocationName() %></td>
                                    <td class="p-3"><%= locationName %></td>
                                    <td class="p-3"><span class="badge <%= locations.getStatus() == 1 ? "bg-soft-success" : "bg-soft-warning" %>"><%= locations.getStatus() == 1 ? "Active" : "Inactive" %></span></td>
                                    <td class="text-end p-3">
                                        <a href="${pageContext.request.contextPath}/viewLocation?id=<%= locations.getLocationId() %>" class="btn btn-icon btn-sm btn-soft-primary"><i
                                                class="uil uil-eye"></i></a>
                                        <a href="${pageContext.request.contextPath}/updateLocation?id=<%= locations.getLocationId() %>" class="btn btn-icon btn-sm btn-soft-success"><i
                                                class="uil uil-pen"></i></a>
                                            <% if (locations.getStatus() == 0) {
                                                %>
                                            <a href="javascript:void(0);" class="btn btn-icon btn-pills btn-soft-danger" onclick="confirmRestore(<%= locations.getLocationId() %>)">
                                                <i class="uil uil-redo"></i>
                                            <%
                                            } else { %>
                                                <a href="javascript:void(0);" class="btn btn-icon btn-pills btn-soft-danger" onclick="confirmDelete(<%= locations.getLocationId() %>)">
                                                    <i class="uil uil-trash"></i>
                                                    <% } %>

                                    </td>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div><!--end container-->

        <!-- Hiển thị phân trang -->
        <div class="d-flex justify-content-center mt-3">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/listLocationsURL?page=${currentPage - 1}">Previous</a>
                        </li>
                    </c:if>

                    <li class="page-item disabled">
                        <span class="page-link">${currentPage} / ${totalPages}</span>
                    </li>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="${pageContext.request.contextPath}/listLocationsURL?page=${currentPage + 1}">Next</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
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
    function confirmDelete(locationId) {
        if (confirm("Are you sure to deactivate this location?")) {
            window.location.href = "<%= request.getContextPath() %>/deleteLocation?action=deactivate&id=" + locationId;
        }
    }

    function confirmRestore(locationId) {
        if (confirm("Do you want to restore this location?")) {
            window.location.href = "<%= request.getContextPath() %>/deleteLocation?action=restore&id=" + locationId;
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