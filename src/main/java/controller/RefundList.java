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
        List<Refund> refundList = refundDAO.getAllRefunds();
        List<Tickets>
        request.setAttribute("refundList", refundList);
        request.getRequestDispatcher("/views/admin/jsp/viewListRefund.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}