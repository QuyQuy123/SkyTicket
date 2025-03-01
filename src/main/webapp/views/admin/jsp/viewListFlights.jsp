<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="utf-8"/>
    <title>SkyTicket - Airlines management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Premium Bootstrap 4 Landing Page Template"/>
    <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health"/>
    <meta name="author" content="Shreethemes"/>
    <meta name="email" content="support@shreethemes.in"/>
    <meta name="website" content="${pageContext.request.contextPath}/views/admin/jsp/Dashboard.jsp"/>
    <meta name="Version" content="v1.2.0"/>
    <!-- favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/views/admin/assets/images/favicon.ico.png">
    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/bootstrap.min.css" rel="stylesheet"
          type="text/css"/>
    <!-- simplebar -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/simplebar.css" rel="stylesheet"
          type="text/css"/>
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/materialdesignicons.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/remixicon.css" rel="stylesheet"
          type="text/css"/>
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
    <!-- Css -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/style.min.css" rel="stylesheet"
          type="text/css" id="theme-opt"/>

</head>

<body>
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
    <%@include file="right.jsp" %>

    <!-- Start Page Content -->
    <main class="page-content bg-light">
        <%@include file="top.jsp" %>


        <div class="container-fluid">
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between">
                    <h5 class="mb-0">Flights List</h5>

                    <div class="search-bar p-0 d-none d-md-block ms-2">
                        <div id="search" class="menu-search mb-0">
                            <form action="${pageContext.request.contextPath}/searchAccount" method="get"
                                  class="d-flex">
                                <!-- Ô tìm kiếm -->
                                <input type="text" name="search" class="form-control border rounded-pill me-2"
                                       placeholder="Name/Email/Phone" value="${param.search}">

                                <select name="roleId" class="form-select border rounded-pill me-2" style="width: 150px">
                                    <option value="">Role</option>
                                    <c:forEach var="role" items="${rolesList}">
                                        // param chính là cái giá trị roleId được gửi từ jsp đi
                                        <option value="${role.roleId}" ${param.roleId == role.roleId ? 'selected' : ''}>${role.roleName}</option>
                                    </c:forEach>
                                </select>

                                <!-- Bộ lọc trạng thái -->
                                <select name="status" class="form-select border rounded-pill me-2" style="width: 150px">
                                    <option value="">Status</option>
                                    <option value="1" ${param.status == '1' ? 'selected' : ''}>Active</option>
                                    <option value="0" ${param.status == '0' ? 'selected' : ''}>Deactive</option>
                                </select>


                                <!-- Nút tìm kiếm -->
                                <button type="submit" class="btn btn-outline-primary rounded-pill me-2" style="width: 100px">Search</button>
                            </form>

                        </div>
                    </div>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/views/admin/jsp/Dashboard.jsp">SkyTicket</a></li>
                            <li class="breadcrumb-item active" aria-current="page">List Flights</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-12 mt-4">
                        <div class="table-responsive shadow rounded">
                            <table class="table table-bordered bg-white mb-0 text-center align-middle">
                                <thead>
                                <tr>
                                    <th class="border-bottom 1">ID</th>
                                    <th class="border-bottom p-1">Departure Airport </th>
                                    <th class="border-bottom p-1">Arrival Airport </th>
                                    <th class="border-bottom p-1">Departure Time </th>
                                    <th class="border-bottom p-1">Arrival Time </th>
                                    <th class="border-bottom p-1">Price Vip</th>
                                    <th class="border-bottom p-1">Price Eco </th>
                                    <th class="border-bottom p-1">Airline</th>
                                    <th class="border-bottom p-1">Status </th>
                                    <th class="border-bottom p-1">Action </th>

                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${not empty listFlights}">
                                        <c:forEach var="f" items="${listFlights}">
                                            <tr>
                                                <td class="p-1">${f.flightId}</td>
                                                <td class="p-1">
                                                    <c:forEach var="deA" items="${airportList}">
                                                        <c:if test="${deA.airportId == f.departureAirportId}">
                                                            ${deA.airportName}
                                                        </c:if>
                                                    </c:forEach>
                                                </td>

                                                <td class="p-1">
                                                    <c:forEach var="arA" items="${airportList}">
                                                        <c:if test="${arA.airportId == f.arrivalAirportId}">
                                                            ${arA.airportName}
                                                        </c:if>
                                                    </c:forEach>
                                                </td>

                                                <td class="p-1">${f.departureTime}</td>
                                                <td class="p-1">${f.arrivalTime}</td>
                                                <td class="p-1">${f.classVipPrice}</td>
                                                <td class="p-1">${f.classEconomyPrice}</td>


                                                <td class="p-1">
                                                    <c:forEach var="airline" items="${airlineList}">
                                                        <c:if test="${airline.airlineId == f.airlineId}">
                                                            ${airline.airlineName}
                                                        </c:if>
                                                    </c:forEach>
                                                </td>

                                                <td class="p-1">
                                                    <c:choose>
                                                        <c:when test="${f.status == 1}">
                                                            <span class="text-success fw-bold">Active</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-danger fw-bold">Deactive</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class=" p-1">
                                                    <a href="${pageContext.request.contextPath}/manageFlights?action=update&id=${f.flightId}" class="btn btn-icon btn-sm btn-soft-success"><i
                                                            class="uil uil-pen"></i></a>

                                                    <c:choose>
                                                        <c:when test="${acl.status == 0}">
                                                            <!-- Nút khôi phục -->
                                                            <a href="javascript:void(0);"
                                                               onclick="confirmRestore(${f.flightId})"
                                                               class="btn btn-icon btn-sm btn-soft-success">
                                                                <i class="uil uil-redo"></i>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <!-- Nút xóa (vô hiệu hóa) -->
                                                            <a href="javascript:void(0);"
                                                               onclick="confirmDelete(${f.flightId})"
                                                               class="btn btn-icon btn-sm btn-soft-danger">
                                                                <i class="uil uil-trash"></i>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="8" class="text-center p-3" style="color: red; font-weight: bold">Account is empty!</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end container-->

        <!--phân trang-->
        <c:choose>
            <c:when test="${searchpage == 'page'}">
                <div class="d-flex justify-content-center mt-3">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/listFlights?page=1&search=${search}&status=${status}&roleId=${roleId}"
                               class="btn btn-outline-primary">First</a>
                            <a href="${pageContext.request.contextPath}/searchAccount?page=${currentPage - 1}&search=${search}&status=${status}&roleId=${roleId}"
                               class="btn btn-outline-primary">Previous</a>
                        </c:if>

                        <span class="btn btn-primary">${currentPage} / ${totalPages}</span>

                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/searchAccount?page=${currentPage + 1}&search=${search}&status=${status}&roleId=${roleId}"
                               class="btn btn-outline-primary">Next</a>
                            <a href="${pageContext.request.contextPath}/searchAccount?page=${totalPages}&search=${search}&status=${status}&roleId=${roleId}"
                               class="btn btn-outline-primary">Last</a>
                        </c:if>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="d-flex justify-content-center mt-3">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="${pageContext.request.contextPath}/manageAccount?action=view&page=1&search=${search}"
                               class="btn btn-outline-primary">First</a>
                            <a href="${pageContext.request.contextPath}/manageAccount?action=view&page=${currentPage - 1}"
                               class="btn btn-outline-primary">Previous</a>
                        </c:if>

                        <span class="btn btn-primary">${currentPage} / ${totalPages}</span>

                        <c:if test="${currentPage < totalPages}">
                            <a href="${pageContext.request.contextPath}/manageAccount?action=view&page=${currentPage + 1}"
                               class="btn btn-outline-primary">Next</a>
                            <a href="${pageContext.request.contextPath}/manageAccount?action=view&page=${totalPages}"
                               class="btn btn-outline-primary">Last</a>
                        </c:if>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>


        <!-- Footer Start -->
        <%@include file="bottom.jsp" %>
        <!-- End -->
    </main>
    <!--End page-content" -->
</div>
<!-- page-wrapper -->




<!-- nút delete/restore -->
<script>
    function confirmDelete(id) {
        if (confirm("Are you sure you want to deactivate this flight?")) {

            let urlParams = new URLSearchParams(window.location.search);
            let currentPage = urlParams.get("page") || 1; // Nếu không có thì mặc định là trang 1

            fetch('${pageContext.request.contextPath}/manageAccount?action=delete&id=' + id, {
                method: 'GET',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'}
            }).then(response => {
                if (response.ok) {
                    alert("Account is deactivated!");
                    <c:choose>
                    <c:when test="${searchpage == 'page'}">
                    window.location.href = "${pageContext.request.contextPath}/searchAccount?page=" + currentPage + "&search=${search}&status=${status}&roleId=${roleId}";
                    </c:when>
                    <c:otherwise>
                    window.location.href = "${pageContext.request.contextPath}/manageAccount?action=view&page=" + currentPage;
                    </c:otherwise>
                    </c:choose>
                } else {
                    alert("Error! Try again!!!");
                }
            }).catch(error => console.error("Error: ", error));
        }
    }

    function confirmRestore(id) {
        if (confirm("Are you sure you want to restore this flight?")) {
            let urlParams = new URLSearchParams(window.location.search);
            let currentPage = urlParams.get("page") || 1;

            fetch('${pageContext.request.contextPath}/manageAccount?action=restore&id=' + id, {
                method: 'GET',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            }).then(response => {
                if (response.ok) {
                    alert("Account restore successfully!!");
                    <c:choose>
                    <c:when test="${searchpage == 'page'}">
                    window.location.href = "${pageContext.request.contextPath}/searchAccount?page=" + currentPage + "&search=${search}&status=${status}&roleId=${roleId}";
                    </c:when>
                    <c:otherwise>
                    window.location.href = "${pageContext.request.contextPath}/manageAccount?action=view&page=" + currentPage;
                    </c:otherwise>
                    </c:choose>

                } else {
                    alert("Error! Try again!!!");
                }
            }).catch(error => console.error("Error: ", error));
        }
    }
</script>

<!-- javascript -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/bootstrap.bundle.min.js"></script>

<!-- simplebar -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/simplebar.min.js"></script>

<!-- Icons -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/feather.min.js"></script>

<!-- Main Js -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/app.js"></script>

</body>

</html>