<%--
  Created by IntelliJ IDEA.
  User: 84968
  Date: 2/9/2025
  Time: 9:54 PM
  To change this template use File | Settings | File Templates.
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.News" %>
<%@page import="dal.NewsDAO" %>
<%@page import="java.util.List" %>
<jsp:include page="/views/layout/Header.jsp"/>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="shortcut icon" type="image/png" href="<%= request.getContextPath() %>/img/logo.png"/>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/News.css"/>
  <title>News</title>
</head>
<body>

<div class="container box" >
  <div style="display: ${empty param.id ? '' : 'none'};margin: auto">
    <h1 style="margin-bottom: 20px; text-align: center;padding-top: 106px">NEWS</h1>
    <div class="news-container">
      <%

        List<News> listNew = (List<News>) request.getAttribute("listNew");
        if (listNew != null) {
          for (int i = listNew.size() - 1; i >= 0; i--) {
            News n = listNew.get(i);
      %>
      <div class="news-item" onclick="viewNews('<%= n.getNewId() %>');">
        <img src="<%= n.getImg() %>" alt="<%= n.getTitle() %>" >

        <h2 style="height: 25%;"><%= n.getTitle() %></h2>
        <div class="news-content" style="display: none;">
          <p><%= n.getContent() %></p>
        </div>

      </div>
      <%
          }
        }
      %>
    </div>
  </div>

  <div id="selected" style="display: ${empty param.id ? 'none' : ''}" class="row">
    <div class="col-md-2"></div>
    <div class="col-md-6" style="margin: 130px 0">
      <%
        NewsDAO nd = new NewsDAO();
        String newsIdStr = request.getParameter("id");
        if (newsIdStr != null) {
          try {
            int newsId = Integer.parseInt(newsIdStr);
            News selectedNews = nd.getNewsById(newsId);
            if (selectedNews != null) {
      %>
      <div class="selected-news">
        <h1><%= selectedNews.getTitle() %></h1>
        <img src="<%= selectedNews.getImg() %>" alt="<%= selectedNews.getTitle() %>">
        <p><%= selectedNews.getContent() %></p>

      </div>

      <%
            }
          } catch (NumberFormatException e) {
            e.printStackTrace();
          }
        }
      %>
    </div>
  </div>
</div>



<jsp:include page="/views/layout/Footer.jsp"/>
<script>
  function viewNews(newsId) {
    window.location.href = 'NewsURL?id=' + newsId;
  }
</script>
</body>
</html>

