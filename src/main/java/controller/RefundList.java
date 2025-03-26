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
import java.util.List;

@WebServlet(name = "RefundList", value = "/listRefund")
public class RefundList extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 10;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RefundDAO refundDAO = new RefundDAO();
        TicketsDAO ticketsDAO = new TicketsDAO();
        String action = request.getParameter("action");
        if(action == null) {
            action = "list";
        }
        if(action.equals("list")) {
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

            int totalRecords = refundDAO.getTotalRecords();
            int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

            if (page > totalPages) page = totalPages;

            List<Refund> refundList = refundDAO.getRefundByPage((page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
            List<Tickets> ticketsList = ticketsDAO.getAllTickets();

            if (refundList.isEmpty() && page > 1) {
                page--;
                refundList = refundDAO.getRefundByPage((page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
            }

            request.setAttribute("ticketsList", ticketsList);
            request.setAttribute("refundList", refundList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("/views/admin/jsp/viewListRefund.jsp").forward(request, response);
        }
        if(action.equals("details")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Refund refundetail = refundDAO.getRefundById(id);

            request.setAttribute("refundDetail", refundetail);
            request.getRequestDispatcher("/views/admin/jsp/viewDetailRefund.jsp").forward(request, response);

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}