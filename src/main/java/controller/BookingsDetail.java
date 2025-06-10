package controller;


import dal.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bookings;
import model.Tickets;


import java.io.IOException;
import java.util.List;

@WebServlet("/viewBooking")
public class BookingsDetail extends HttpServlet {
    private BookingDAO bookingsDAO;
    private EmailServlet email ;
    private PaymentsDAO p;
    private TicketsDAO td;
    private SeatsDAO s;

    @Override
    public void init() throws ServletException {
        bookingsDAO = new BookingDAO();
        email = new EmailServlet();
        p = new PaymentsDAO();
        s= new SeatsDAO();
        td = new TicketsDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Bookings bookings = bookingsDAO.getBookingById(id);
        TicketsDAO ticketsDAO = new TicketsDAO();
        List<Tickets> ticketsList = ticketsDAO.getAllTicketsByBookingId(id);
        req.setAttribute("ticketsList", ticketsList);

        if (bookings == null) {
            req.setAttribute("error", "Booking not found");
            req.getRequestDispatcher("views/admin/jsp/viewListBookings.jsp").forward(req, resp);
        } else {
            req.setAttribute("booking", bookings);
            req.getRequestDispatcher("views/admin/jsp/viewDetailBooking.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        int payid = p.getIdByBookingid(bookingId);
        Bookings book = bookingsDAO .getBookingById(bookingId);
        if(bookingId == 2){
            td.confirmSuccessAllTicketsByBookingId(bookingId);
        }
        if ("confirmPayment".equals(action)) {
            boolean success = bookingsDAO.changeStatusToSuccess(bookingId);
            p.updatePaymentStatus(2,payid);
            // email.sendPaymentSuccessfulbyEmail(book.getContactEmail(), book);
            if (success) {
                req.setAttribute("msg", "Payment confirmed successfully!");
            } else {
                req.setAttribute("msg", "Failed to confirm payment.");
            }
            req.setAttribute("booking", book);
        }
        if ("confirmRefund".equals(action)) {
            boolean success = bookingsDAO.changeStatusToRefundSuccess(bookingId);
            bookingsDAO.updateTotalPrice(bookingId, bookingsDAO.getTotalPriceAllTickets(bookingId) - bookingsDAO.getTotalPriceCancelledTicket(bookingId));
            if (success) {
                req.setAttribute("msg", "Refund confirmed successfully!");
            } else {
                req.setAttribute("msg", "Failed to confirm Refund.");
            }
            Bookings bookings = bookingsDAO.getBookingById(bookingId);
            req.setAttribute("booking", bookings);
        }
        if ("confirmReject".equals(action)) {
            boolean success = bookingsDAO.changeStatusToRefundReject(bookingId);
            if (success) {
                req.setAttribute("msg", "Refund confirmed successfully!");
            } else {
                req.setAttribute("msg", "Failed to confirm Refund.");
            }
            Bookings bookings = bookingsDAO.getBookingById(bookingId);
            req.setAttribute("booking", bookings);
        }



        req.getRequestDispatcher("views/admin/jsp/viewDetailBooking.jsp").forward(req, resp);
    }
}
