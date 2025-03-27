package controller;

import dal.RefundDAO;
import dal.TicketsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Refund;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "RefundSort", value = "/sortRefund")
public class RefundSort extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 10;
    RefundDAO refundDAO = new RefundDAO();
    TicketsDAO ticketsDAO = new TicketsDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            // Lấy toàn bộ danh sách refund từ DAO
            List<Refund> refundList = refundDAO.getAllRefunds2();

            // Thực hiện sắp xếp trong Servlet
            if ("requestDate".equals(sortBy)) {
                refundList.sort((r1, r2) -> "asc".equals(order)
                        ? r1.getRequestDate().compareTo(r2.getRequestDate())
                        : r2.getRequestDate().compareTo(r1.getRequestDate()));
            } else if ("refundPrice".equals(sortBy)) {
                refundList.sort((r1, r2) -> "asc".equals(order)
                        ? Double.compare(r1.getRefundPrice(), r2.getRefundPrice())
                        : Double.compare(r2.getRefundPrice(), r1.getRefundPrice()));
            }

            // Tính tổng số trang
            int totalRecords = refundList.size();
            int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

            // Đảm bảo page hợp lệ
            if (totalRecords == 0) {
                totalPages = 1; // Nếu không có bản ghi, vẫn có 1 trang rỗng
            }
            if (page > totalPages) page = totalPages;

            // Áp dụng phân trang bằng subList
            int fromIndex = (page - 1) * RECORDS_PER_PAGE;
            int toIndex = Math.min(fromIndex + RECORDS_PER_PAGE, totalRecords);
            List<Refund> paginatedRefunds = refundList.subList(fromIndex, toIndex);

            // Nếu danh sách rỗng mà page > 1, quay lại trang trước
            if (paginatedRefunds.isEmpty() && page > 1) {
                page--;
                fromIndex = (page - 1) * RECORDS_PER_PAGE;
                toIndex = Math.min(fromIndex + RECORDS_PER_PAGE, totalRecords);
                paginatedRefunds = refundList.subList(fromIndex, toIndex);
            }

            // Đưa dữ liệu vào request attribute
            request.setAttribute("ticketsList", ticketsDAO.getAllTickets());
            request.setAttribute("refundList", paginatedRefunds);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("order", order);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            // Chuyển hướng về JSP
            request.getRequestDispatcher("/views/admin/jsp/viewListRefund.jsp").forward(request, response);

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}