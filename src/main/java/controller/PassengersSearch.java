package controller;

import dal.AccountDAO;
import dal.PassengersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Accounts;
import model.Passengers;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchPassengers")
public class PassengersSearch extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 6;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("search");
        String statusStr = req.getParameter("status");
        if (keyword == null) keyword = "";

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

        PassengersDAO passengersDAO = new PassengersDAO();
        AccountDAO accountDAO = new AccountDAO();

        // Lấy danh sách kết quả tìm kiếm theo trang
        List<Passengers> searchResults = passengersDAO.searchPassengerByPage(keyword, statusStr, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        int totalRecords = passengersDAO.getTotalSearchRecords(keyword, statusStr);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Nếu page lớn hơn totalPages nhưng không có dữ liệu, đưa về trang cuối cùng có dữ liệu
        if (page > totalPages) page = totalPages;

        // Nếu danh sách tìm kiếm rỗng mà page > 1, quay lại trang trước
        if (searchResults.isEmpty() && page > 1) {
            page--;
            searchResults = passengersDAO.searchPassengerByPage(keyword, statusStr, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }

        List<Accounts> listAccounts = accountDAO.getAllAccounts();
        req.setAttribute("accounts", listAccounts);
        req.setAttribute("passengers", searchResults);
        req.setAttribute("searchKeyword", keyword);
        req.setAttribute("searchStatus", statusStr);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/views/admin/jsp/viewListPassengers.jsp").forward(req, resp);
    }
}
