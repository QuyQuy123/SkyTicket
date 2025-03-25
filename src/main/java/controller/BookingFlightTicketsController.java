package controller;

import dal.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import model.Bookings;
import model.Passengers;

import java.io.IOException;
import java.sql.Date;




@WebServlet(name = "BookingFlightTicketsController", urlPatterns = {"/bookingFlightTicketsURL"})

public class BookingFlightTicketsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AccountDAO ad = new AccountDAO();
        HttpSession session = req.getSession();
        Integer idd = (Integer) session.getAttribute("id");
        if (idd != null) {
            Accounts acc = ad.getAccountsById(idd);
            req.setAttribute("account", acc);
        }

        req.getRequestDispatcher("views/public/BookingFlightTickets.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookingDAO bd = new BookingDAO();
        TicketsDAO td = new TicketsDAO();
        PassengersDAO pd = new PassengersDAO();
        BaggageDAO bgd = new BaggageDAO();
        AccountDAO ad = new AccountDAO();
        HttpSession session = request.getSession();
        EmailServlet email = new EmailServlet();
        Integer id = (Integer) session.getAttribute("id");
        float totalPrice =0;
        try {
            String pContactName = request.getParameter("pContactName").trim();
            String pContactPhoneNumber = request.getParameter("pContactPhoneNumber").trim();
            String pContactEmail = request.getParameter("pContactEmail").trim();
            int adultTicket = Integer.parseInt(request.getParameter("adultTicket"));
            int childTicket = Integer.parseInt(request.getParameter("childTicket"));
            int infantTicket = Integer.parseInt(request.getParameter("infantTicket"));
            int totalPassengers = adultTicket + childTicket + infantTicket;
            session.setAttribute("adultTicket", adultTicket);
            session.setAttribute("childTicket", childTicket);
            session.setAttribute("infantTicket", infantTicket);

            int flightDetailId = Integer.parseInt(request.getParameter("flightDetailId"));
            session.setAttribute("flightDetailId", flightDetailId);
            float commonPrice = Float.parseFloat(request.getParameter("commonPrice"));
            totalPrice += (float) (commonPrice *(adultTicket  + childTicket *0.9 + infantTicket *0.8));
            String flightDetailId2Str = request.getParameter("flightDetailId2");
            int flightDetailId2 = 0;
            float commonPrice2 = 0;

            if (flightDetailId2Str != null) {
                flightDetailId2 = Integer.parseInt(flightDetailId2Str);
                session.setAttribute("flightDetailId2", flightDetailId2);
                commonPrice2 = Float.parseFloat(request.getParameter("commonPrice2"));

                totalPrice += (float) (commonPrice2 *(adultTicket  + childTicket *0.9 + infantTicket *0.8));

            }

            bd.createBooking(pContactName,pContactPhoneNumber,pContactEmail,totalPrice,id);
            Bookings newBookId = bd.getLatestBooking();

            for (int i = 1; i <= totalPassengers; i++) {
                String pSex = request.getParameter("pSex" + i);
                String pName = request.getParameter("pName" + i).trim();
                Date pDob = Date.valueOf(request.getParameter("pDob" + i));
                String pPhoneNumber = request.getParameter("pPhoneNumber" + i);
                int seatId1 = 1;
                pd.createPassenger(pName, pPhoneNumber, pDob, pSex, id, newBookId.getBookingID());
                Passengers newPassenger = pd.getLatestPassengerByBookingId(newBookId.getBookingID());

                if (newPassenger != null) {
                    if (flightDetailId2Str != null) {
                        int seatId2 = 2;

                        if (i >= adultTicket + 1 && i <= adultTicket + childTicket) {
                            td.createTicket(null, flightDetailId, seatId1, newPassenger.getPassengerID(), newBookId.getBookingID(), null, (float) (commonPrice*0.9));
                            td.createTicket(null, flightDetailId2, seatId2, newPassenger.getPassengerID(), newBookId.getBookingID(), null, (float) (commonPrice*0.9));
                        } else if (i >= adultTicket + childTicket + 1) {
                            td.createTicket(null, flightDetailId, seatId1, newPassenger.getPassengerID(), newBookId.getBookingID(), null, (float) (commonPrice*0.8));
                            td.createTicket(null, flightDetailId2, seatId2, newPassenger.getPassengerID(), newBookId.getBookingID(), null, (float) (commonPrice*0.8));
                        } else {
                            Integer pBaggages = request.getParameter("pBaggages" + i).equals("0") ? null : Integer.parseInt(request.getParameter("pBaggages" + i));
                            Integer pBaggages2 = request.getParameter("pBaggages" + (totalPassengers + i)).equals("0") ? null : Integer.parseInt(request.getParameter("pBaggages" + (totalPassengers + i)));
                            int pBPrice = ((pBaggages != null) ? bgd.getPriceBaggagesById(pBaggages) : 0);
                            int pBPrice2 = ((pBaggages2 != null) ? bgd.getPriceBaggagesById(pBaggages2) : 0);
                            totalPrice += pBPrice + pBPrice2;
                            td.createTicket(null, flightDetailId, seatId1, newPassenger.getPassengerID(), newBookId.getBookingID(), (pBaggages != null ? pBaggages : 0), commonPrice+pBPrice);
                            td.createTicket(null, flightDetailId2, seatId2, newPassenger.getPassengerID(), newBookId.getBookingID(), (pBaggages != null ? pBaggages : 0), commonPrice2+pBPrice2);
                        }
                    } else {
                        if (i >= adultTicket + 1 && i <= adultTicket + childTicket) {
                            td.createTicket(null, flightDetailId, seatId1, newPassenger.getPassengerID(), newBookId.getBookingID(), null, (float) (commonPrice*0.9));
                        } else if (i >= adultTicket + childTicket + 1) {
                            td.createTicket(null, flightDetailId, seatId1, newPassenger.getPassengerID(), newBookId.getBookingID(), null, (float) (commonPrice*0.8));
                        } else {
                            Integer pBaggages = request.getParameter("pBaggages" + i).equals("0") ? null : Integer.parseInt(request.getParameter("pBaggages" + i));
                            int pBPrice = ((pBaggages != null) ? bgd.getPriceBaggagesById(pBaggages) : 0);
                            totalPrice += pBPrice;
                            td.createTicket(null, flightDetailId, seatId1, newPassenger.getPassengerID(), newBookId.getBookingID(), (pBaggages != null ? pBaggages : 0), commonPrice+pBPrice);
                        }
                    }
                    bd.updateTotalPrice(newBookId.getBookingID(),totalPrice);
                }
            }
            if (id != null) {
                Accounts acc = ad.getAccountsById(id);
                request.setAttribute("account", acc);
            }
             Bookings b = bd.getLatestBooking();
            email.sendBookingEmail(b.getContactEmail(),b);

            request.setAttribute("bookingId", b.getBookingID());
            request.setAttribute("price", b.getTotalPrice());
            request.getRequestDispatcher("views/public/SuccessfulBooking.jsp").forward(request, response);

        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("views/public/error.jsp").forward(request, response);
        }


    }
}
