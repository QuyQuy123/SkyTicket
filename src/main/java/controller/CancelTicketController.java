package controller;

import dal.AccountDAO;
import dal.BookingDAO;
import dal.PaymentsDAO;
import dal.TicketsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;


import java.io.IOException;
@WebServlet(name = "CancelTicketController", urlPatterns = {"/cancelTicket"})
public class CancelTicketController extends HttpServlet {
    BookingDAO bd = new BookingDAO();
    TicketsDAO td = new TicketsDAO();
    PaymentsDAO pd = new PaymentsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AccountDAO ad = new AccountDAO();
        HttpSession session = request.getSession();
        Integer idd = (Integer) session.getAttribute("id");
        if (idd != null) {
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("account", acc);
            response.sendRedirect("ticketHistoryURL");
        }else{
            request.setAttribute("notice", "You have cancelled ticket successful");
            request.getRequestDispatcher("views/customer/TicketHistory.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ticketIdStr = request.getParameter("ticketId");
        String bookingStr = request.getParameter("orderId");
        try {
            int ticketId = Integer.parseInt(ticketIdStr);
            int bookingId = Integer.parseInt(bookingStr);

            request.setAttribute("orderId", bookingId);
            td.cancelTicketById(ticketId);

            if(td.countNumberTicketNotCancel(bookingId) == 0){
                bd.canceBookingById(bookingId);
            }
            bd.updateTotalPrice(bookingId, bd.getTotalPriceAllTickets(bookingId) - bd.getTotalPriceCancelledTicket(ticketId));


        }catch (NumberFormatException e) {
        }
        response.sendRedirect("cancelTicket");

    }
}
