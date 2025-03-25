package controller;


import dal.CountriesDAO;
import dal.LocationsDAO;
import dal.PaymentsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Countries;
import model.Locations;
import model.Payments;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchPayments")
public class PaymentsSearch extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 6;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String paymentMethod = req.getParameter("search");
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

        PaymentsDAO paymentsDAO = new PaymentsDAO();

        // Lấy danh sách kết quả tìm kiếm theo trang
        List<Payments> searchResults = paymentsDAO.searchPaymentByPage(paymentMethod, statusStr, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        int totalRecords = paymentsDAO.getTotalSearchRecords(paymentMethod, statusStr);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Nếu page lớn hơn totalPages nhưng không có dữ liệu, đưa về trang cuối cùng có dữ liệu
        if (page > totalPages) page = totalPages;

        // Nếu danh sách tìm kiếm rỗng mà page > 1, quay lại trang trước
        if (searchResults.isEmpty() && page > 1) {
            page--;
            searchResults = paymentsDAO.searchPaymentByPage(paymentMethod, statusStr, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }

        // Đưa dữ liệu vào request attribute
        req.setAttribute("payment", searchResults);
        req.setAttribute("searchName", paymentMethod);
        req.setAttribute("searchStatus", statusStr);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/views/admin/jsp/viewListPayments.jsp").forward(req, resp);
    }
}
