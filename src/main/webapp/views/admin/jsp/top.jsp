<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2/10/2025
  Time: 1:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="top-header">
    <div class="header-bar d-flex justify-content-between border-bottom">
        <div class="d-flex align-items-center">
            <a href="#" class="logo-icon">
                <img src="../assets/images/logo-icon.png" height="30" class="small" alt="">
                <span class="big">
                                    <img src="../assets/images/logo-dark.png" height="24" class="logo-light-mode"
                                         alt="">
                                    <img src="../assets/images/logo-light.png" height="24" class="logo-dark-mode"
                                         alt="">
                                </span>
            </a>
            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                <i class="uil uil-bars"></i>
            </a>
            <div class="search-bar p-0 d-none d-md-block ms-2">
                <div id="search" class="menu-search mb-0">
                    <form role="search" method="get" id="searchform" class="searchform">
                        <div>
                            <input type="text" class="form-control border rounded-pill" name="s" id="s"
                                   placeholder="Search Keywords...">
                            <input type="submit" id="searchsubmit" value="Search">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <ul class="list-unstyled mb-0">


        </ul>
    </div>
</div>
</body>
</html>
