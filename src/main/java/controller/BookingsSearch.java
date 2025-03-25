package controller;


import dal.AccountDAO;
import dal.BookingsDAO;
import dal.PassengersDAO;
import dal.PaymentsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Accounts;
import model.Bookings;
import model.Passengers;
import model.Payments;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchBookings")
public class BookingsSearch extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 6;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String search = req.getParameter("search");
        String statusStr = req.getParameter("status");


        // Xác định số trang hiện tại
        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        BookingsDAO bookingsDAO = new BookingsDAO();

        // Lấy danh sách kết quả tìm kiếm theo trang
        List<Bookings> searchResults = bookingsDAO.searchBookingByPage(search, statusStr, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        int totalRecords = bookingsDAO.getTotalSearchRecords(search, statusStr);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Nếu page lớn hơn totalPages nhưng không có dữ liệu, đưa về trang cuối cùng có dữ liệu
        if (page > totalPages) page = totalPages;

        // Nếu danh sách tìm kiếm rỗng mà page > 1, quay lại trang trước
        if (searchResults.isEmpty() && page > 1) {
            page--;
            searchResults = bookingsDAO.searchBookingByPage(search, statusStr, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }

        // Đưa dữ liệu vào request attribute
        req.setAttribute("booking", searchResults);
        req.setAttribute("searchName", search);
        req.setAttribute("searchStatus", statusStr);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/views/admin/jsp/viewListBookings.jsp").forward(req, resp);
    }
}
