package controller;

import dal.AccountDAO;
import dal.DiscountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Accounts;
import model.Discounts;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "DiscountSearchServlet", value = "/discountSearch")
public class DiscountSearch extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Khởi tạo DAO
        DiscountDAO discountDAO = new DiscountDAO();
        AccountDAO accountDAO = new AccountDAO();

        // Lấy tham số tìm kiếm từ request
        String search = request.getParameter("search");
        if (search == null) {
            search = ""; // Nếu không có tham số search, đặt mặc định là chuỗi rỗng
        }

        // Xử lý trang hiện tại
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            try {
                currentPage = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                currentPage = 1; // Nếu lỗi, về trang đầu tiên
            }
        }

        // Tính tổng số bản ghi dựa trên kết quả lọc
        int totalRecords = discountDAO.getTotalRecordsFiltered(search);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Đảm bảo currentPage nằm trong phạm vi hợp lệ
        if (currentPage < 1) {
            currentPage = 1;
        } else if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }

        // Lấy danh sách discount và account
        List<Discounts> discountsList = discountDAO.searchDiscounts(search, currentPage, RECORDS_PER_PAGE);
        List<Accounts> accountsList = accountDAO.getAllAccounts();

        // Đặt các thuộc tính để gửi về JSP
        request.setAttribute("discountsList", discountsList);
        request.setAttribute("accountsList", accountsList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search); // Lưu tham số tìm kiếm để sử dụng trong phân trang

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("/views/admin/jsp/viewListDiscounts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Xử lý POST giống như GET
    }
}