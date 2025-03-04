<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/10/2025
  Time: 1:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8"/>
    <title>SkyTicket - Flights management</title>
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
    <!-- Select2 -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/select2.min.css" rel="stylesheet"/>
    <!-- Icons -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/materialdesignicons.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/remixicon.css" rel="stylesheet"
          type="text/css"/>
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <!-- Css -->
    <link href="${pageContext.request.contextPath}/views/admin/assets/css/style.min.css" rel="stylesheet"
          type="text/css" id="theme-opt"/>

    <!-- CKEditor -->
    <script src="https://cdn.ckeditor.com/4.21.0/standard/ckeditor.js"></script>

    <style>

        .btn-gradient {
            background: linear-gradient(45deg, #ff416c, #ff4b2b);
            color: white;
            border: none;
            transition: 0.3s;
        }

        .btn-gradient:hover {
            background: linear-gradient(45deg, #ff4b2b, #ff416c);
            transform: scale(1.05);
        }
    </style>
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
        <%@ include file="top.jsp" %>

        <div class="container-fluid">
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between">
                    <h5 class="mb-0">
                        <c:choose>
                            <c:when test="${isUpdate}">Update News ID: ${news.newId}</c:when>
                            <c:otherwise>Add News</c:otherwise>
                        </c:choose>
                    </h5>


                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a
                                    href="${pageContext.request.contextPath}/views/admin/jsp/Dashboard.jsp">SkyTicket</a>
                            </li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/#">List News</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                ${ isUpdate ? 'Update News' : 'Add News'}
                            </li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-lg-12 mt-4">
                        <div class="card border-0 p-4 rounded shadow">

                            <c:if test="${not empty msg}">
                                <div style="color: green; font-weight: bold;">
                                        ${msg}
                                </div>
                            </c:if>

                            <form class="mt-4" action="${pageContext.request.contextPath}/manageNews" method="post" enctype="multipart/form-data">

                                <div class="row align-items-center">
                                    <div class="col-lg-5 col-md-4">
                                        <label class="form-label" for="imgNews">Image: </label>
                                        <input type="file" name="imgNews" id="imgNews" class="form-control">

                                        <!-- Nếu có ảnh cũ, hiển thị ảnh đó -->
                                        <c:if test="${not empty news and not empty news.img}">
                                            <div class="mt-2">
                                                <img src="${news.img}" alt="origin news" class="img-thumbnail" width="250">
                                            </div>
                                        </c:if>

                                        <hr>
                                    </div>
                                </div><!--end row-->

                                <br>

                                <div class="row">

                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label class="form-label" for="title">Title: </label>
                                            <input name="title" id="title" type="text"
                                                   class="form-control"
                                                   placeholder="Title name"
                                                   value="${not empty news ? news.title : ''}">
                                        </div>
                                    </div><!--end col-->


                                    <div class="container mt-4">
                                        <label class="form-label" for="editor">Content: </label>
                                        <textarea id="editor" name="content" value="${not empty news ? news.content : ''}"></textarea>
                                        <br>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="airline">Airline</label>
                                            <select name="airline" id="airline"
                                                    class="form-control gender-name select2input">
                                                <option value="" disabled ${empty news ? 'selected' : ''}>-- Select Airline
                                                    --
                                                </option>
                                                <c:forEach var="airline" items="${airlinesList}">
                                                    <option value="${airline.airlineId}" ${airline.airlineId == news.airlineId ? 'selected' : ''}>
                                                            ${airline.airlineName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>


                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label" for="sts">Status</label>
                                            <select class="form-control gender-name select2input" name="status"
                                                    id="sts">
                                                <option value="" disabled ${empty news ? 'selected' : ''}> --Select
                                                    Status--
                                                </option>
                                                <option value="1" ${news.status == 1 ? 'selected' : ''}>Active</option>
                                                <option value="0" ${news.status == 0 ? 'selected' : ''}>Deactive</option>
                                            </select>
                                        </div>
                                    </div>


                                </div>

                                <c:choose>
                                    <c:when test="${isAdd}">
                                        <input type="hidden" name="action" value="add">
                                        <button type="submit" class="btn btn-primary">Add News</button>
                                    </c:when>
                                    <c:when test="${isUpdate}">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="${news.newId}">
                                        <button type="submit" class="btn btn-primary">Update News</button>
                                    </c:when>
                                </c:choose>
                                <button type="reset" class="btn btn-primary">Reset</button>

                            </form>
                        </div>
                    </div>

                </div><!--end row-->
            </div>
        </div>

        <%@include file="bottom.jsp" %>
    </main>
    <!--End page-content" -->
</div>
<!-- page-wrapper -->


<!-- javascript -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/views/admin/assets/js/bootstrap.bundle.min.js"></script>
<!-- simplebar -->
<script src="${pageContext.request.contextPath}/views/admin//assets/js/simplebar.min.js"></script>
<!-- Select2 -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/select2.min.js"></script>
<script src="${pageContext.request.contextPath}/views/admin/assets/js/select2.init.js"></script>
<!-- Icons -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/feather.min.js"></script>
<!-- Main Js -->
<script src="${pageContext.request.contextPath}/views/admin/assets/js/app.js"></script>

<script>
    // Khởi tạo CKEditor
    CKEDITOR.replace('editor');

    // Đảm bảo dữ liệu CKEditor được gửi khi submit
    document.querySelector("form").addEventListener("submit", function () {
        document.querySelector("#editor").value = CKEDITOR.instances.editor.getData();
    });
</script>


</body>
</html>
