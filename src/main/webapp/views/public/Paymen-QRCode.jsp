<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.Accounts" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QR Code Payment</title>
    <style>
        :root {
            --primary-color: #3c6e57;
            --secondary-color: #28a745;
            --background-color: #f4f4f4;
            --card-background: #ffffff;
            --text-color: #333333;
            --border-radius: 12px;
        }

        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
        }

        body {
            background-color: var(--background-color);
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Đảm bảo body chiếm toàn bộ chiều cao viewport */
        }

        .content {
            flex: 1 0 auto; /* Nội dung chính sẽ mở rộng để chiếm không gian còn lại */
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 0 1rem;
        }

        .container {
            background-color: var(--card-background);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: var(--border-radius);
            padding: 2rem;
            max-width: 800px;
            width: 100%;
        }

        h1 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .content-inner {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
        }

        .qr-code {
            flex: 1;
            min-width: 300px;
        }

        .qr-code img {
            width: 100%;
            max-width: 325px;
            height: auto;
            display: block;
            margin: 0 auto;
        }

        .details {
            flex: 1;
            min-width: 300px;
        }

        .details p {
            margin-bottom: 1rem;
            font-size: 1.1rem;
        }

        .details b {
            color: var(--primary-color);
        }

        .details i {
            color: #666;
            font-size: 0.9rem;
        }

        .submit-btn {
            display: block;
            width: 100%;
            padding: 1rem;
            background-color: var(--secondary-color);
            color: white;
            border: none;
            border-radius: var(--border-radius);
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 1.5rem;
        }

        .submit-btn:hover {
            background-color: #218838;
        }

        .discount-form {
            margin-top: 2rem;
        }

        .discount-form h4 {
            margin-bottom: 0.5rem;
        }

        .discount-input {
            width: 100%;
            padding: 0.5rem;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .apply-btn {
            display: inline-block;
            padding: 0.5rem 1rem;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 0.5rem;
        }

        .apply-btn:hover {
            background-color: #357ae8;
        }

        .message {
            margin-top: 1rem;
            text-align: center;
            font-weight: bold;
        }

        .success {
            color: var(--secondary-color);
        }

        .error {
            color: #dc3545;
        }

        footer {
            flex-shrink: 0;
            width: 100%;
        }
    </style>
</head>
<body>
<jsp:include page="/views/layout/Header.jsp"/>
<%
    Accounts currentAcc = null;
    String phone = (String)request.getAttribute("phone");
    String email = (String)request.getAttribute("email");
    Double totalCost =(Double)request.getAttribute("totalCost");

    if(request.getAttribute("account") != null){
        currentAcc = (Accounts) request.getAttribute("account");
    }
%>
<div class="content" style="margin-top: 135px;margin-bottom: 100px">
    <div class="container">
        <h1>QR Code Payment</h1>
        <div class="content-inner">
            <div class="qr-code">
                <img class="img-payment" src="<%= request.getContextPath() %>/img/qr.png" alt="QR CODE">
            </div>
            <div class="details">
                <p>Payment customer information:<br> <b>Email: <%=email%></b><br>
                    <b>Phone: <%=phone%></b>
                </p>
                <p>Payment amount: <b><fmt:formatNumber value="<%= totalCost%>" type="number" groupingUsed="true" /> VND</b></p>
                <p class="warning-text"><i style="color: red">*Please enter the exact phone number in the transfer details for the system to process the payment automatically</i></p>
                <p><i>Payment time within 24 hours. If after 24 hours you do not receive transfer information, the order will be canceled.</i></p>
                <form action="QRCodeURL" method="get">
                    <input type="hidden" value="<%= totalCost%>" name="totalCost"/>
                    <input type="submit" value="Confirm Payment" class="submit-btn">
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/views/layout/Footer.jsp"/>
</body>
</html>