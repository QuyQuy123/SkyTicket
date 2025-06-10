package controller;

import dal.AccountDAO;
import dal.BookingDAO;
import dal.FlightsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import model.Bookings;
import model.Flights;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;



@WebServlet(name = "TicketHistoryController", urlPatterns = {"/ticketHistoryURL"})
public class TicketHistoryController extends HttpServlet {
    AccountDAO ad = new AccountDAO();
    BookingDAO bd = new BookingDAO();
    FlightsDAO fd = new FlightsDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer idd = (Integer) session.getAttribute("id");
        if (idd == null) {
            response.sendRedirect("LoginURL");
            return;
        } else {
            Accounts acc = ad.getAccountsById(idd);
            request.setAttribute("account", acc);
        }

        String statusIdParam = request.getParameter("status");
        List<Bookings> listBooking;

        if (statusIdParam != null && !statusIdParam.isEmpty()) {
            int status = Integer.parseInt(statusIdParam);
            listBooking = bd.getOrdersByStatusAndAccountId(status,idd);

        }else {
            String code = request.getParameter("code");

            if (code != null && !code.isEmpty()) {
                listBooking = bd.getListOrderByCodeAndAccountId(code.trim(), idd);
            } else {
                String idx = request.getParameter("index");
                int index = 1;
                if (idx != null) {
                    index = Integer.parseInt(idx);
                }
                int numberOfItem = bd.getNumberAllOrdersByAccountId(idd);
                int numOfPage = (int) Math.ceil((double) numberOfItem/2 );
                request.setAttribute("index", index);
                request.setAttribute("numOfPage", numOfPage);
                listBooking = bd.getAllOrdersByAccountId(idd,index);
            }
        }
        request.setAttribute("listBooking", listBooking);
        List<Flights> listFlight = fd.getAllFlights();
        request.setAttribute("listFlight", listFlight);
        request.getRequestDispatcher("views/customer/TicketHistory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}

