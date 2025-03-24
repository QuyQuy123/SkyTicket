package controller;

import dal.PaymentsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Payments;

import java.io.IOException;
import java.util.List;

@WebServlet("/sortPayments")
public class PaymentsSort extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 6;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sortBy = request.getParameter("sortBy");
        String order = request.getParameter("order");

        // Xác định trang hiện tại
        int page = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        PaymentsDAO paymentsDAO = new PaymentsDAO();

        // Lấy toàn bộ danh sách thanh toán
        List<Payments> listPayments = paymentsDAO.getAllPayments();

        // Thực hiện sắp xếp trong Servlet
        if ("date".equals(sortBy)) {
            listPayments.sort((p1, p2) -> "asc".equals(order)
                    ? p1.getPaymentDate().compareTo(p2.getPaymentDate())
                    : p2.getPaymentDate().compareTo(p1.getPaymentDate()));
        } else if ("price".equals(sortBy)) {
            listPayments.sort((p1, p2) -> "asc".equals(order)
                    ? Double.compare(p1.getTotalPrice(), p2.getTotalPrice())
                    : Double.compare(p2.getTotalPrice(), p1.getTotalPrice()));
        }

        // Tính tổng số trang
        int totalRecords = listPayments.size();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Đảm bảo page hợp lệ
        if (page > totalPages) page = totalPages;

        // Áp dụng phân trang bằng subList
        int fromIndex = (page - 1) * RECORDS_PER_PAGE;
        int toIndex = Math.min(fromIndex + RECORDS_PER_PAGE, totalRecords);
        List<Payments> paginatedPayments = listPayments.subList(fromIndex, toIndex);

        // Nếu danh sách rỗng mà page > 1, quay lại trang trước
        if (paginatedPayments.isEmpty() && page > 1) {
            page--;
            fromIndex = (page - 1) * RECORDS_PER_PAGE;
            toIndex = Math.min(fromIndex + RECORDS_PER_PAGE, totalRecords);
            paginatedPayments = listPayments.subList(fromIndex, toIndex);
        }

        // Đưa dữ liệu vào request attribute
        request.setAttribute("payment", paginatedPayments);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("order", order);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/jsp/viewListPayments.jsp").forward(request, response);
    }
}
