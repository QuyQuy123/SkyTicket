package controller;

import dal.AccountDAO;
import dal.DiscountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import model.Discounts;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "DiscountAdd", value = "/addDiscounts")
public class DiscountAdd extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AccountDAO accountDAO = new AccountDAO();
        List<Accounts> accounts = accountDAO.getAllAccounts();
        request.setAttribute("accounts", accounts);
        request.getRequestDispatcher("/views/admin/jsp/addDiscount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String redirectUrl = request.getContextPath() + "/addDiscounts"; // Quay lại trang add nếu lỗi
        DiscountDAO discountDAO = new DiscountDAO();
        try {
            // Lấy dữ liệu từ form
            String accountIdStr = request.getParameter("accountName"); // accountId từ select
            String percentStr = request.getParameter("Percent");
            String pointsStr = request.getParameter("Points");

            // Validate input
            if (accountIdStr == null || accountIdStr.isEmpty()) {
                request.setAttribute("msg", "Account name is required!");
                response.sendRedirect(redirectUrl);
                return;
            }

            if (percentStr == null || percentStr.trim().isEmpty()) {
                request.setAttribute("msg", "Percent is required!");
                response.sendRedirect(redirectUrl);
                return;
            }

            if (pointsStr == null || pointsStr.trim().isEmpty()) {
                request.setAttribute("msg", "Points is required!");
                response.sendRedirect(redirectUrl);
                return;
            }

            // Validate Percent (chỉ số, không chữ/ký tự đặc biệt, 0-100)
            double percent;
            try {
                percent = Double.parseDouble(percentStr);
                if (percent < 0 || percent > 100) {
                    request.setAttribute("msg", "Percent must be between 0 and 100!");
                    response.sendRedirect(redirectUrl);
                    return;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("msg", "Percent must be a valid number (no letters or special characters)!");
                response.sendRedirect(redirectUrl);
                return;
            }

            // Validate Points (chỉ số nguyên, không âm, không chữ/ký tự đặc biệt)
            int points;
            try {
                points = Integer.parseInt(pointsStr);
                if (points < 0) {
                    request.setAttribute("msg", "Points must be a non-negative integer!");
                    response.sendRedirect(redirectUrl);
                    return;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("msg", "Points must be a valid integer (no letters or special characters)!");
                response.sendRedirect(redirectUrl);
                return;
            }

            // Parse accountId
            int accountId = Integer.parseInt(accountIdStr);

            // Tạo đối tượng Discounts
            Discounts discount = new Discounts();
            discount.setAccountId(accountId);
            discount.setPercent(percent);
            discount.setPoints(points);

            // Thêm discount vào database
            boolean isAdded = discountDAO.insertDiscount(accountId, percent, points); // Sửa insertDiscount để nhận các tham số

            if (isAdded) {
                request.setAttribute("msg", "Discount added successfully!");
                request.getRequestDispatcher("/views/admin/jsp/addDiscount.jsp").forward(request, response);
            } else {
                request.setAttribute("msg", "Failed to add discount!");
                request.getRequestDispatcher("/views/admin/jsp/addDiscount.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("msg", "Invalid input format!");
            response.sendRedirect(redirectUrl);
        } catch (SQLException e) {
            request.setAttribute("msg", "Database error: " + e.getMessage());
            response.sendRedirect(redirectUrl);
            e.printStackTrace();
        } catch (Exception e) {
            request.setAttribute("msg", "Unexpected error: " + e.getMessage());
            response.sendRedirect(redirectUrl);
            e.printStackTrace();
        }
    }
}