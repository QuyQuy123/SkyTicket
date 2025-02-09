<%@ page import="java.util.List" %>
<%@ page import="model.Airports" %><%--
  Created by IntelliJ IDEA.
  User: 84968
  Date: 2/7/2025
  Time: 12:53 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        List<Airports> listAirport = (List<Airports>) request.getAttribute("airports");
    %>
    <form action="AirportURL" method="get">
        <p> <input type="text" name="airport" id="" placeholder="Nhập tên thành phố hoặc mã sân bay" >
            <input type="hidden" name="service" value="listAll">
            <input type="submit" value="Search" name="submit">
            <input type="reset" value="Clear">
        </p>
    </form>

    <table border="1">

    <tr>
            <th>Locations</th>
        </tr>
        <%for (Airports airports : listAirport){ %>
            <tr>
                <td> <%=airports.getLocation()%></td>
            </tr>
        <%}%>
    </table>


</body>
</html>
