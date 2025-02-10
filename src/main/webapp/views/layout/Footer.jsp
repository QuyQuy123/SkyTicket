<%--
 Created by IntelliJ IDEA.
 User: 84968
 Date: 2/6/2025
 Time: 11:34 AM
 To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Footer.css">
    <title>Footer</title>
</head>
<body>

<footer class="footer">
    <h3>Đặt vé máy bay, thật đơn giản.</h3>
    <p>Tải ngay ứng dụng để trải nghiệm đặt vé nhanh chóng và dễ dàng nhất chỉ trong 1 phút!</p>
<hr style="margin-bottom: 5px ;margin-top: 15px ;opacity: 0.6">
    <div class="content" id="contactSection">
        <div class="column">
            <h4>SKY TICKET</h4>
            <a href="#">Tin tức</a>
            <a href="#">Giới thiệu</a>
            <a href="footer">Liên hệ</a>
        </div>

        <div class="column">
            <h4>LINK HỮU ÍCH</h4>
            <a href="#">Hình thức thanh toán</a>
            <a href="#">Câu hỏi thường gặp</a>
            <a href="#">Hướng dẫn đặt vé</a>
        </div>

        <div class="column">
            <h4>LIÊN HỆ </h4>
            <div class="social">
                <a href="https://www.facebook.com/4quycoi/">📸 Facebook</a>
            </div>
            <div class="social">
                <a href="mailto:flyticket.work@gmail.com">📧 Gmail</a>
            </div>
            <div class="social">
                <a href="tel:0968311852">📞 0968311852</a>
            </div>
        </div>

        <div class="map-container">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.506216904075!2d105.52271427591022!3d21.012421688338286!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2sFPT%20University!5e0!3m2!1sen!2s!4v1715499627309!5m2!1sen!2s" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
    </div>

</footer>

</body>
</html>



