package controller;

import dal.RefundDAO;
import dal.TicketsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Refund;
import model.Tickets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "RefundSearch", value = "/refundSearch")
public class RefundSearch extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 10;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RefundDAO refundDAO = new RefundDAO();
        TicketsDAO ticketDAO = new TicketsDAO();

        // Lấy các tham số từ request
        String refundIdOrTicketCode = request.getParameter("RefundID");
        String orderPricet = request.getParameter("orderPricet");
        String status = request.getParameter("status");

        // Xử lý trang hiện tại
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            try {
                currentPage = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        // Phân biệt RefundId và TicketCode
        String refundId = null;
        String ticketCode = null;
        if (refundIdOrTicketCode != null && !refundIdOrTicketCode.trim().isEmpty()) {
            // Kiểm tra xem refundIdOrTicketCode có phải là số nguyên không
            if (refundIdOrTicketCode.matches("\\d+")) { // Chỉ chứa chữ số
                refundId = refundIdOrTicketCode;
            } else { // Chứa ký tự không phải số
                ticketCode = refundIdOrTicketCode;
            }
        }

        // Tính tổng số bản ghi dựa trên kết quả lọc
        int totalRecords;
        try {
            totalRecords = refundDAO.getTotalRecordsFiltered(refundId, ticketCode, status);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving total records: " + e.getMessage());
            totalRecords = 0;
        }
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Điều chỉnh currentPage
        if (currentPage < 1) {
            currentPage = 1;
        } else if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }

        // Lấy danh sách hoàn tiền và vé
        List<Refund> refundList;
        List<Tickets> ticketsList;
        try {
            refundList = refundDAO.searchRefunds(refundId, ticketCode, status, orderPricet, currentPage, RECORDS_PER_PAGE);
            ticketsList = ticketDAO.getAllTickets();
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving data: " + e.getMessage());
            refundList = new ArrayList<>();
            ticketsList = new ArrayList<>();
        }

        // Đặt các thuộc tính để gửi về JSP
        request.setAttribute("refundList", refundList);
        request.setAttribute("ticketsList", ticketsList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        // Lưu các tham số lọc để JSP sử dụng trong liên kết phân trang
        request.setAttribute("refundIdOrTicketCode", refundIdOrTicketCode);
        request.setAttribute("orderPricet", orderPricet);
        request.setAttribute("status", status);

        // Chuyển hướng về trang JSP
        request.getRequestDispatcher("/views/admin/jsp/viewListRefund.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}