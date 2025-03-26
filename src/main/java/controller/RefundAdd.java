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
import java.security.Timestamp;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


@WebServlet(name = "RefundAdd", value = "/addRefund")
public class RefundAdd extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RefundDAO refundDAO = new RefundDAO();
        TicketsDAO ticketsDAO = new TicketsDAO();
        List<Tickets> tickets = ticketsDAO.getAllTickets();
        List<Refund> refunds = refundDAO.getAllRefunds();

        request.setAttribute("tickets", tickets);
        request.setAttribute("refunds", refunds);
        request.getRequestDispatcher("/views/admin/jsp/addRefund.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}