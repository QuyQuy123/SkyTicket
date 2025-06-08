
<!DOCTYPE html>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.*" %>
<%@ page import="model.Accounts" %>
<%@ page import="dal.AccountDAO" %>
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
<!-- Modal cập nhật thông tin hoàn tiền -->
<div class="modal fade" id="refundModal" tabindex="-1" aria-labelledby="refundModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="<%= request.getContextPath() %>/UpdateRefundServlet" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="refundModalLabel">Update Bank Information</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="refundId" id="modalRefundId" />
                    <div class="mb-3">
                        <label for="accountHolder" class="form-label">Account Holder</label>
                        <input type="text" class="form-control" id="accountHolder" name="accountHolder" required>
                    </div>
                    <div class="mb-3">
                        <label for="bankName" class="form-label">Bank Name</label>
                        <input type="text" class="form-control" id="bankName" name="bankName" required>
                    </div>
                    <div class="mb-3">
                        <label for="bankAccount" class="form-label">Bank Account</label>
                        <input type="text" class="form-control" id="bankAccount" name="bankAccount" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Update</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </form>
    </div>
</div>

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
                                    <th class="border-bottom p-3">AccountHolder</th>
                                    <th class="border-bottom p-3">BankName</th>
                                    <th class="border-bottom p-3">BankAccount</th>
                                    <th class="border-bottom p-3">Code</th>
                                    <th class="border-bottom p-3">Money refund
                                    </th>

                                    <th class="border-bottom p-3">Create at
                                    </th>
                                    <th class="border-bottom p-3">Reason</th>


                                    <th class="border-bottom p-3">Status</th>
                                    <th class="border-bottom p-3">Create by</th>
                                    <th class="border-bottom p-3">Accepted by</th>
                                    <th class="border-bottom p-3">Action</th>

                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    for (Refund r : refundList) {
                                        String ticketCode = "Unknown";
                                        for(Tickets t : ticketsList){
                                            if(r.getTicketId() == t.getTicketId()){
                                                ticketCode = t.getCode();
                                            }
                                        }

                                %>
                                <tr>
                                    <td class="p-3"><%= r.getAccountHolder() %></td>
                                    <td class="p-3"><%= r.getBankName() %></td>
                                    <td class="p-3"><%= r.getBankAccount() %></td>
                                    <td class="p-3"><%= r.getTicketCode() %></td>
                                    <td class="p-3"><%= r.getRefundPrice() %></td>
                                    <td class="p-3"><%= r.getRequestDate()%></td>
                                    <td class="p-3">
                                        <%= r.getStatus() == 1 ? "Waiting " : r.getStatus() == 2 ? "Success" : "Failed" %>
                                    </td>
                                    <td class="p-3">
    <span class="badge <%=
        r.getStatus() == 1 ? "status-refund-pending bg-soft-warning text-warning" :
        r.getStatus() == 2 ? "status-refund-success bg-soft-success text-success" :
        "status-failed bg-soft-danger text-danger" %>">
        <%= r.getStatus() == 1 ? "Waiting" :
                r.getStatus() == 2 ? "True" :
                        "Failes" %>
    </span>
                                    </td>
                                    <td class="p-3"><%= r.getCreatedBy() %></td>

                                    <td class="p-3"><%= account.getFullName() %></td>

                                    <td class="p-2">
                                        <a href="#"
                                           class="btn btn-icon btn-pills btn-soft-success"
                                           data-bs-toggle="modal"
                                           data-bs-target="#refundModal"
                                           onclick="populateModal('<%= r.getRefundId() %>', '<%= r.getAccountHolder() %>', '<%= r.getBankName() %>', '<%= r.getBankAccount() %>')">
                                            <i class="uil uil-pen"></i>
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
<script>
    function populateModal(refundId, accountHolder, bankName, bankAccount) {
        document.getElementById("modalRefundId").value = refundId;
        document.getElementById("accountHolder").value = accountHolder;
        document.getElementById("bankName").value = bankName;
        document.getElementById("bankAccount").value = bankAccount;
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