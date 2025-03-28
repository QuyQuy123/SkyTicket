package controller;


import dal.BookingsDAO;
import dal.LocationsDAO;
import dal.PaymentsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Bookings;
import model.Locations;
import model.Payments;

import java.io.IOException;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)

@WebServlet("/updatePayment")
public class PaymentsUpdate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        PaymentsDAO paymentsDAO = new PaymentsDAO();
        BookingsDAO bookingsDAO = new BookingsDAO();

        Payments payments = new Payments();
        payments = paymentsDAO.getPaymentById(id);
        Bookings bookings = bookingsDAO.getBookingsById(paymentsDAO.getIdByBookingid(id));

        if (payments == null) {
            req.setAttribute("error", "Payment not found");
            req.getRequestDispatcher("/views/admin/jsp/updatePayment.jsp").forward(req, resp);
        }else{
            req.setAttribute("payments", payments);
            req.setAttribute("bookings", bookings);
            req.getRequestDispatcher("/views/admin/jsp/updatePayment.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        PaymentsDAO paymentsDAO = new PaymentsDAO();
        BookingsDAO bookingsDAO = new BookingsDAO();

        int id = Integer.parseInt(req.getParameter("locationId"));
        String locationName = req.getParameter("name");
        int status = Integer.parseInt(req.getParameter("status"));
        Payments payments = paymentsDAO.getPaymentById(id);
        Bookings bookings = bookingsDAO.getBookingsById(paymentsDAO.getIdByBookingid(id));

        if (paymentsDAO.getStatus(id) == status) {
            req.setAttribute("error", "Payment already exists!");
            req.setAttribute("payments", payments);
            req.setAttribute("bookings", bookings);
            req.getRequestDispatcher("/views/admin/jsp/updatePayment.jsp").forward(req, resp);
            return;
        } else {
            if (payments == null) {
                req.setAttribute("message", "Payment not found.");
                req.getRequestDispatcher("/views/admin/jsp/viewListPayments.jsp").forward(req, resp);
                return;
            }

            payments.setPaymentStatus(status);

            boolean success = paymentsDAO.updatePaymentStatus(status,id);
            if (success) {
                req.setAttribute("msg", "Payment updated successfully!");
                req.setAttribute("payments", payments);
                req.setAttribute("bookings", bookings);
                req.getRequestDispatcher("/views/admin/jsp/updatePayment.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Update failed!");
                req.setAttribute("payments", payments);
                req.setAttribute("bookings", bookings);
                req.getRequestDispatcher("/views/admin/jsp/updatePayment.jsp").forward(req, resp);
            }
        }

    }
}
