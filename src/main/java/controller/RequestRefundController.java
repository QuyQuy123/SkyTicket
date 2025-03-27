package controller;

import dal.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import model.Refund;
import model.Tickets;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(name = "RequestRefundController", urlPatterns = {"/requestRefund"})

public class RequestRefundController extends HttpServlet {

    AccountDAO ad = new AccountDAO();
    RefundDAO rd = new RefundDAO();
    TicketsDAO td = new TicketsDAO();
    BookingDAO bd = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer idd = (Integer) session.getAttribute("id");
        if (idd != null) {
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("account", acc);
            response.sendRedirect("ticketHistoryURL");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bank = request.getParameter("bank");
        String bankAccount = request.getParameter("confirmBankAccount");
        String ticketIdStr = request.getParameter("ticketId");
        String bookStr = request.getParameter("orderId");
        Timestamp requestDate = new Timestamp(System.currentTimeMillis());
        Timestamp refundDate = null;
        try {
            int ticketId = Integer.parseInt(ticketIdStr);
            int statusId = 1;
            int refundId = rd.addRefund(new Refund(ticketId,bankAccount,bank, requestDate,refundDate, td.getPriceById(ticketId), statusId));

            int bookId = Integer.parseInt(bookStr);
            List<Tickets> list = td.getAllTicketsByBookingId(bookId);
            if(list.size() > 1){
                for (Tickets ticket : list) {
                    td.waitRefundPendingByTicketId(ticket.getTicketId());
                }
            }else{
                bd.changeStatusToRefundPending(bookId);
                td.waitRefundPending(bookId);
            }



        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        response.sendRedirect("requestRefund");



    }


}
