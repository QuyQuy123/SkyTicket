<%@ page import="model.Locations" %>
<%@ page import="java.util.List" %>
<%@ page import="dal.LocationsDAO" %>
<%@ page import="model.Countries" %>
<%@ page import="dal.CountriesDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8"/>
  <title>Locations Managerment</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Premium Bootstrap 4 Landing Page Template"/>
  <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health"/>
  <meta name="author" content="Shreethemes"/>
  <meta name="email" content="support@shreethemes.in"/>
  <meta name="website" content="../../../index.html"/>
  <meta name="Version" content="v1.2.0"/>
  <!-- favicon -->
  <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
  <!-- Bootstrap -->
  <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
  <!-- simplebar -->
  <link href="../assets/css/simplebar.css" rel="stylesheet" type="text/css"/>
  <!-- Select2 -->
  <link href="../assets/css/select2.min.css" rel="stylesheet"/>
  <!-- Date picker -->
  <link rel="stylesheet" href="../assets/css/flatpickr.min.css">
  <!-- Icons -->
  <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css"/>
  <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css"/>
  <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
  <!-- Css -->
  <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt"/>

</head>

<body>
<%
  List<Countries> countries = new CountriesDAO().getAllCountries();
  HttpSession session1 = request.getSession();

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
  <%@include file="right.jsp" %>
  <!-- sidebar-wrapper  -->

  <!-- Start Page Content -->
  <main class="page-content bg-light">
    <%@include file="top.jsp" %>

    <div class="container-fluid">
      <div class="layout-specing">
        <div class="d-md-flex justify-content-between">
          <h5 class="mb-0">Add new Location</h5>

          <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
            <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
              <li class="breadcrumb-item"><a href="Dashboard.jsp">Home</a></li>
              <li class="breadcrumb-item"><a
                      href="<%= request.getContextPath() %>/listLocationsURL">Locations</a></li>
              <li class="breadcrumb-item active" aria-current="page">Add Location</li>
            </ul>
          </nav>
        </div>
        <%
          String successMsg = (String) session.getAttribute("successMsg");
          if (successMsg != null) {
        %>
        <div class="alert alert-success" role="alert">
          <%= successMsg %>
        </div>
        <% session.removeAttribute("successMsg"); %>
        <%
          }
        %>

        <%
          String errorMsg = (String) session.getAttribute("errorMsg");
          if (errorMsg != null) {
        %>
        <div class="alert alert-success" role="alert">
          <%= errorMsg %>
        </div>
        <% session.removeAttribute("errorMsg"); %>
        <%
          }
        %>


        <div>
          <form action="<%= request.getContextPath() %>/LocationAdd" method="post">
            <div class="row">
              <div class="col-lg-8 mt-4">
                <div class="card border-0 p-4 rounded shadow">
                  <div class="row align-items-center">
                  </div><!--end row-->
                  <div class="row">
                    <div class="col-md-6">
                      <div class="mb-3">
                        <label class="form-label" for="name">Location ID</label>
                        <input name="name" id="name" type="text" class="form-control"
                               placeholder="LocationID" disabled>
                      </div>
                    </div><!--end col-->

                    <div class="col-md-6">
                      <div class="mb-3">
                        <label class="form-label" for="airportName">Location Name</label>
                        <input name="name" id="airportName" type="text" class="form-control"
                               placeholder="Location Name " required>
                      </div>
                    </div><!--end col-->

                    <div class="col-md-6">
                      <div class="mb-3">
                        <label class="form-label" for="locationId">Country</label>
                        <select class="form-control department-name select2input"
                                id="locationId" name="countryID">
                          <%
                            for (Countries country : countries) {
                          %>
                          <option value="<%= country.getCountryId() %>"><%= country.getCountryName() %>
                          </option>
                          <%}%>
                        </select>
                      </div>
                    </div><!--end col-->

                    <div class="col-md-6">
                      <div class="mb-3">
                        <label class="form-label" for="status">Status</label>
                        <select name="status" class="form-control department-name select2input" id="hehe">
                          <option value="active">Active</option>
                          <option value="deactive">Deactive</option>
                        </select>
                      </div>
                    </div><!--end col-->
                  </div><!--end row-->

                  <div class="d-flex gap-2">
                    <button type="submit" name="submit" id="submit" class="btn btn-primary">Add location</button>
                    <button type="reset" class="btn btn-outline-secondary">Reset</button>
                  </div>
                </div>
              </div>
            </div>
          </form>
        </div><!--end row-->
      </div>
    </div><!--end container-->

    <!-- Footer Start -->
    <%@include file="bottom.jsp" %>
    <!-- End -->
  </main>
  <!--End page-content" -->
</div>
<!-- page-wrapper -->


<!-- javascript -->
<script>
  setTimeout(function() {
    let alertBox = document.querySelector(".alert");
    if (alertBox) {
      alertBox.style.display = "none";
    }
  }, 3000);
</script>

<script src="../assets/js/jquery.min.js"></script>
<script src="../assets/js/bootstrap.bundle.min.js"></script>
<!-- simplebar -->
<script src="../assets/js/simplebar.min.js"></script>
<!-- Select2 -->
<script src="../assets/js/select2.min.js"></script>
<script src="../assets/js/select2.init.js"></script>
<!-- Datepicker -->
<script src="../assets/js/flatpickr.min.js"></script>
<script src="../assets/js/flatpickr.init.js"></script>
<!-- Icons -->
<script src="../assets/js/feather.min.js"></script>
<!-- Main Js -->
<script src="../assets/js/app.js"></script>

</body>

</html>
