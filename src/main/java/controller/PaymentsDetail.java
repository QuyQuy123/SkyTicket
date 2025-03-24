package controller;


import dal.BookingsDAO;
import dal.PassengersDAO;
import dal.PaymentsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Bookings;
import model.Passengers;
import model.Payments;

import java.io.IOException;

@WebServlet("/viewPayment")
public class PaymentsDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        PaymentsDAO pdao = new PaymentsDAO();
        BookingsDAO bookingsDAO = new BookingsDAO();

        Payments payments = new Payments();
        payments = pdao.getPaymentById(id);
        Bookings bookings = new Bookings();
        bookings = bookingsDAO.getBookingsById(pdao.getBookingidById(id));

        if (payments == null) {
            req.setAttribute("error", "Payment not found");
            req.getRequestDispatcher("views/admin/jsp/viewListPayments.jsp").forward(req, resp);
        }else{
            req.setAttribute("payment", payments);
            req.setAttribute("booking", bookings);
            req.getRequestDispatcher("views/admin/jsp/viewDetailPayment.jsp").forward(req, resp);
        }
    }
}
