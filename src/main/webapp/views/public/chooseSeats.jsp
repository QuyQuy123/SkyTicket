<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 3/27/2025
  Time: 4:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String passengerId = (String) request.getAttribute("passengerId");
%>
<div id="<%= passengerId %>" class="passenger-info-input-box">
    <div class="passenger-info-input-title" style="width: 200px">Select seat for departuring:</div>
    <div style="display: flex; align-items: center; margin-right: 20px; font-weight: 600; font-size: 16px; color: #3C6E57">
        <span style=""><%=s.getSeatClass()%> - <span id="seatCodeForDisplaying<%=i%>">Not Selected</span></span>
    </div>
    <button class="btn btn-info" style="text-decoration: none" onclick="openSeatModal(<%=i%>)">Choose</button>
    <input type="hidden" name="code<%=i%>" id="seatCode<%=i%>"/>
</div>
<script>
    var passengerId = "<%= passengerId %>";
    console.log(passengerId);
</script>

</body>
</html>
