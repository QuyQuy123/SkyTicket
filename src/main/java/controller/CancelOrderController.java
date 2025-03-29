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
import model.Bookings;
import model.Payments;

import java.io.IOException;
@WebServlet(name = "CancelOrderController", urlPatterns = {"/cancelOrder"})
public class CancelOrderController extends HttpServlet {

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
        }
        else{
            request.setAttribute("notice", "You have cancelled ticket successful");
            request.getRequestDispatcher("views/customer/TicketHistory.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingIdStr = request.getParameter("orderId");
        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            td.cancelAllTicketsByBookingId(bookingId);
            bd.canceBookingById(bookingId);
           
        } catch (Exception e) {

        }
        response.sendRedirect("cancelOrder");



    }
}
