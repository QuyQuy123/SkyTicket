package controller;

import dal.AccountDAO;
import dal.BookingsDAO;
import dal.PaymentsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bookings;
import model.Payments;

import java.io.IOException;

@WebServlet("/viewBooking")
public class BookingsDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        BookingsDAO bookingsDAO = new BookingsDAO();

        Bookings bookings = new Bookings();
        bookings = bookingsDAO.getBookingById(id);

        if (bookings == null) {
            req.setAttribute("error", "Booking not found");
            req.getRequestDispatcher("views/admin/jsp/viewListBookings.jsp").forward(req, resp);
        }else{
            req.setAttribute("booking", bookings);
            req.getRequestDispatcher("views/admin/jsp/viewDetailBooking.jsp").forward(req, resp);
        }
    }
}
