package controller;


import dal.BookingDAO;
import dal.BookingsDAO;

import dal.TicketsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bookings;


import java.io.IOException;

@WebServlet("/viewBooking")
public class BookingsDetail extends HttpServlet {
    private BookingDAO bookingsDAO;
    private EmailServlet email ;

    @Override
    public void init() throws ServletException {
        bookingsDAO = new BookingDAO();
        email = new EmailServlet();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Bookings bookings = bookingsDAO.getBookingById(id);

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
        if ("confirmPayment".equals(action)) {
            int bookingId = Integer.parseInt(req.getParameter("bookingId"));
            boolean success = bookingsDAO.changeStatusToSuccess(bookingId);
            Bookings book = bookingsDAO .getBookingById(bookingId);
            email.sendPaymentSuccessfulbyEmail(book.getContactEmail(), book);
            if (success) {
                req.setAttribute("msg", "Payment confirmed successfully!");
            } else {
                req.setAttribute("msg", "Failed to confirm payment.");
            }
            Bookings bookings = bookingsDAO.getBookingById(bookingId);
            req.setAttribute("booking", bookings);
        }
        if ("confirmRefund".equals(action)) {
            int bookingId = Integer.parseInt(req.getParameter("bookingId"));
            boolean success = bookingsDAO.changeStatusToRefundSuccess(bookingId);
//            Bookings book = bookingsDAO .getBookingById(bookingId);
//            email.sendPaymentSuccessfulbyEmail(book.getContactEmail(), book);
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
