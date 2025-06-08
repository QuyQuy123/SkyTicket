package controller;

import dal.RefundDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/UpdateRefundServlet")
public class UpdateRefundServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Thiết lập UTF-8 để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            // Lấy dữ liệu từ form
            int refundId = Integer.parseInt(request.getParameter("refundId"));
            String accountHolder = request.getParameter("accountHolder");
            String bankName = request.getParameter("bankName");
            String bankAccount = request.getParameter("bankAccount");

            // Gọi DAO để cập nhật dữ liệu
            RefundDAO dao = new RefundDAO();
            dao.updateRefundInfo(refundId, accountHolder, bankName, bankAccount);

            // Gửi thông báo thành công
            request.getSession().setAttribute("message", "Cập nhật hoàn tiền thành công!");

        } catch (Exception e) {
            e.printStackTrace(); // hoặc log bằng logger thực tế
            request.getSession().setAttribute("message", "Lỗi khi cập nhật hoàn tiền: " + e.getMessage());
        }

        // Quay lại danh sách hoàn tiền
        response.sendRedirect("moneyRefund");
    }
}
