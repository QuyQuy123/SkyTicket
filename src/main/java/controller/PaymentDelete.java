package controller;


import dal.PaymentsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/deletePayment")
public class PaymentDelete extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        try {
            // Lấy action và id từ request
            String action = req.getParameter("action");
            String idParam = req.getParameter("id");

            // Kiểm tra tham số hợp lệ
            if (idParam == null || action == null) {
                session.setAttribute("message", "Invalid request parameters.");
                resp.sendRedirect(req.getContextPath() + "/listPaymentsURL");
                return;
            }

            int id = Integer.parseInt(idParam);
            PaymentsDAO pdao = new PaymentsDAO();
            boolean result = false;

            // Xử lý theo action
            if ("restore".equals(action)) {
                result = pdao.updatePaymentStatus(id, 2);
                session.setAttribute("message", result ? "Payment change status successfully!" : "Failed to change status payment.");
            } else {
                session.setAttribute("message", "Invalid action.");
            }

            // Chuyển hướng về danh sách locations
            resp.sendRedirect(req.getContextPath() + "/listPaymentsURL");
        } catch (NumberFormatException e) {
            session.setAttribute("message", "Invalid payment ID.");
            resp.sendRedirect(req.getContextPath() + "/listPaymentsURL");
        } catch (Exception e) {
            session.setAttribute("message", "An error occurred while processing.");
            resp.sendRedirect(req.getContextPath() + "/listPaymentsURL");
        }
    }
}
