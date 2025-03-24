package controller;

import dal.AccountDAO;
import dal.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import model.Bookings;

import java.io.IOException;

@WebServlet(name = "QRCodeController", urlPatterns = "/QRCodeURL")
public class QRCodeControler extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer idd = (Integer) session.getAttribute("id");
        AccountDAO ad = new AccountDAO();
        BookingDAO bd = new BookingDAO();
        int i = (idd != null) ? idd : -1;
        Accounts acc = ad.getAccountsById(i);
        request.setAttribute("account", acc);
        String bookingID = request.getParameter("bookingID");


        if (bookingID != null) {
            int bookID = Integer.parseInt(bookingID);
            Bookings b = bd.getBookingById(bookID);
            String email = b.getContactEmail();
            String phone = b.getContactPhone();
            double totalPrice = b.getTotalPrice();
            session.setAttribute("bookID", bookID);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("totalCost", totalPrice);
            request.getRequestDispatcher("views/public/Paymen-QRCode.jsp").forward(request, response);
        }


    }

}
