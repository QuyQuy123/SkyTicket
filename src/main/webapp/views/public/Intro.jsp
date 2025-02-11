<%--
  Created by IntelliJ IDEA.
  User: 84968
  Date: 2/11/2025
  Time: 9:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/views/layout/Header.jsp"/>
<html>
<head>
    <title>Title</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6; /* Giãn cách dòng */
        }
        h2, h3 {
            text-align: center;
            margin-top: 60px;
            margin-bottom: 20px;
        }
        strong {
            font-weight: bold;
        }
        .content-intro {
            margin: 40px auto;
            padding: 5px;
            max-width: 900px; /* Giới hạn chiều rộng để không quá dài */
        }
        p {
            margin-bottom: 15px; /* Tạo khoảng cách giữa các đoạn */
        }
        ul {
            margin-top: 10px;
            margin-left: 20px;
            padding-left: 20px;
        }
        ul li {
            margin-bottom: 10px;
        }
        ol {
            margin-bottom: 50px;
            margin-left: 20px;
            padding-left: 20px;
        }
        ol li {
            margin-bottom: 15px;
        }
    </style>

</head>
<body>
<div class="content-intro">


<h2 style="    margin-top: 90px;margin-bottom: 40px;">Lời giới thiệu</h2>

<p><strong>SkyTicket</strong> là website cung cấp dịch vụ đặt chỗ và bán vé máy bay trực tuyến của nhiều hãng hàng không trong nước và quốc tế. Với giao diện thân thiện, dễ thao tác, OnlineBooking không chỉ giúp khách hàng nhanh chóng lựa chọn được hành trình đi lại tối ưu nhất mà còn chọn được giá vé tốt trong tháng, so sánh được giá vé giữa các hãng hàng không, đặt và mua được vé trực tuyến.</p>

<p><strong>SkyTicket</strong> đang nỗ lực để trở thành địa chỉ bán vé máy bay tin cậy nhất và có nhiều dịch vụ giá trị gia tăng nhất cho khách hàng. Hãy ủng hộ chúng tôi và giúp chúng tôi trở thành nhà cung cấp dịch vụ tốt nhất cho các bạn.</p>

<h3>Mọi ý kiến đóng góp vui lòng gửi về Văn phòng Công ty TNHH Online Booking</h3>
<ul style="margin-top:5px">
    <li><strong>Địa chỉ:</strong> Tầng 8 tòa nhà Creative City Hà Nội, số 1 Lương Yên</li>
    <li><strong>Điện thoại:</strong> (84-4) 88888888</li>
    <li><strong>Fax:</strong> 04.88888888</li>
    <li><strong>Hotline:</strong> 1900 6868</li>
    <li><strong>Email:</strong> booking@SkyTicket.vn</li>
</ul>

<h2 style ="margin-top: 90px;margin-bottom: 40px;">HÃY TRẢI NGHIỆM VÀ CẢM NHẬN SỰ KHÁC BIỆT CHỈ CÓ Ở Online Booking!</h2>

<ol style="margin-bottom: 40px">
    <li><strong>Giá vé không thể tốt hơn:</strong>
        <p>Giá vé nội địa và quốc tế rẻ hơn do OnlineBooking là đại lý chính thức của các hãng hàng không giá rẻ như Tiger Air, VietJet Air…</p>
    </li>
    <li><strong>Hệ thống so sánh giá vé thông minh:</strong>
        <p>SkyTicket giúp quý khách dễ dàng so sánh giá vé giữa các Hãng cho cùng một hành trình, Giá vé được cập nhật liên tục và thông tin “Giá vé tốt trong tháng” chỉ có tại OnlineBooking.vn.</p>
    </li>
    <li><strong>Tốc độ xử lý nhanh, hình thức thông tin đa dạng:</strong>
        <p>Hệ thống xử lý đơn hàng tối ưu với đội ngũ IT giàu kinh nghiệm.</p>
    </li>
    <li><strong>Đội ngũ tư vấn viên chuyên nghiệp:</strong>
        <p>Giải đáp, hỗ trợ thông tin chỉ ít phút sau khi đặt vé trực tuyến hoặc qua điện thoại.</p>
    </li>
    <li><strong>Thanh toán nhanh chóng, tiện lợi:</strong>
        <p>Phương thức thanh toán linh hoạt và theo lựa chọn của khách hàng.</p>
    </li>
</ol>

</div>

<jsp:include page="/views/layout/Footer.jsp"/>
</body>

</html>
