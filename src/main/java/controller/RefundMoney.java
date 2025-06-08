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

@WebServlet(name = "RefundMoney", value = "/moneyRefund")
public class RefundMoney extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RefundDAO refundDAO = new RefundDAO();
        TicketsDAO ticketsDAO = new TicketsDAO();
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        if (action.equals("list")) {
            List<Refund> refundList = refundDAO.getAllRefunds();
            List<Tickets> ticketsList = ticketsDAO.getAllTickets();

            request.setAttribute("ticketsList", ticketsList);
            request.setAttribute("refundList", refundList);
            request.getRequestDispatcher("/views/admin/jsp/listRefund.jsp").forward(request, response);
        }
        if (action.equals("details")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Refund refundDetail = refundDAO.getRefundById(id);

            request.setAttribute("refundDetail", refundDetail);
            request.getRequestDispatcher("/views/admin/jsp/viewDetailRefund.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}