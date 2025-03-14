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
import java.util.List;



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

            int flightDetailId = Integer.parseInt(request.getParameter("flightDetailId"));
            int seatCategoryId = Integer.parseInt(request.getParameter("seatCategoryId"));

            totalPrice = Float.parseFloat(request.getParameter("commonPrice"));
            String flightDetailId2Str = request.getParameter("flightDetailId2");
            int flightDetailId2 = 0;
            int seatCategoryId2 = 0;
            float commonPrice2 = 0;

            if (flightDetailId2Str != null) {
                flightDetailId2 = Integer.parseInt(flightDetailId2Str);
                seatCategoryId2 = Integer.parseInt(request.getParameter("seatCategoryId2"));
                float commonPriceFloat2 = Float.parseFloat(request.getParameter("commonPrice2"));
                commonPrice2 = Math.round(commonPriceFloat2);
                totalPrice = commonPrice2;
            }

            String booking = bd.createBooking(pContactName,pContactPhoneNumber,pContactEmail,totalPrice,id);
            Bookings newBookId = bd.getLatestBooking();
            System.out.println(newBookId);

            Bookings b =bd.getBookingByCode(booking);

            for (int i = 1; i <= totalPassengers; i++) {
                String pSex = request.getParameter("pSex" + i);
                String pName = request.getParameter("pName" + i).trim();
                Date pDob = Date.valueOf(request.getParameter("pDob" + i));
                String pPhoneNumber = request.getParameter("pPhoneNumber" + i).trim();
                String code = request.getParameter("code" + i);

//                if (code != null) {
//                    if (td.getTicketByCode(code, flightDetailId, seatCategoryId) != null) {
//                        bd.deleteOrderByCode(b.getCode());
//                        request.getRequestDispatcher("views/public/failedBooking.jsp").forward(request, response);
//                        return;
//                    }
//                }
                boolean passeger = pd.createPassenger(pName,pPhoneNumber,pDob,pSex,id != null ? id : 0,newBookId.getBookingID());
                List<Passengers> lp = pd.getPassengersByBookingId(newBookId.getBookingID());
                for (Passengers p1 : lp) {
                    if (flightDetailId2Str != null) {
                        String code2 = request.getParameter("code" + (totalPassengers + i));
                        if (code2 != null) {
                            if (td.getTicketByCode(code2, flightDetailId2, seatCategoryId2) != null) {
                                bd.deleteOrderByCode(b.getCode());
                                request.getRequestDispatcher("views/public/error.jsp").forward(request, response);
                                return;
                            }
                        }
                        if (i >= adultTicket + 1 && i <= adultTicket + childTicket) {

                            td.createTicket(code, flightDetailId, seatCategoryId, p1.getPassengerID(), newBookId.getBookingID(),1, 20000);

                            td.createTicket(code2, flightDetailId2, seatCategoryId2, p1.getPassengerID(), newBookId.getBookingID(),1, 20000);
                        } else if (i >= adultTicket + childTicket + 1) {
                            td.createTicket(code, flightDetailId, seatCategoryId, p1.getPassengerID(), newBookId.getBookingID(), 1, 20000);
                            td.createTicket(null, flightDetailId2, seatCategoryId2, p1.getPassengerID(), newBookId.getBookingID(), 1, 20000);
                        } else {

                            Integer pBaggages = request.getParameter("pBaggages" + i).equals("0") ? null : Integer.parseInt(request.getParameter("pBaggages" + i));
                            Integer pBaggages2 = request.getParameter("pBaggages" + (totalPassengers + i)).equals("0") ? null : Integer.parseInt(request.getParameter("pBaggages" + (totalPassengers + i)));
                            int pBPrice = ((pBaggages != null) ? bgd.getPriceBaggagesById(pBaggages) : 0);
                            int pBPrice2 = ((pBaggages2 != null) ? bgd.getPriceBaggagesById(pBaggages2) : 0);
                            totalPrice += pBPrice + pBPrice2;
                            td.createTicket(code, flightDetailId, seatCategoryId, p1.getPassengerID(), newBookId.getBookingID(), 1, 20000);
                            td.createTicket(code2, flightDetailId2, seatCategoryId2, p1.getPassengerID(), newBookId.getBookingID(), 1, 20000);
                        }
                    } else {
                        if (i >= adultTicket + 1 && i <= adultTicket + childTicket) {
                            td.createTicket(code, flightDetailId, seatCategoryId, p1.getPassengerID(), newBookId.getBookingID(), 1, 20000);
                        } else if (i >= adultTicket + childTicket + 1) {
                            td.createTicket(code, flightDetailId, seatCategoryId, p1.getPassengerID(), newBookId.getBookingID(),1, 20000);
                        } else {

                            Integer pBaggages = request.getParameter("pBaggages" + i).equals("0") ? null : Integer.parseInt(request.getParameter("pBaggages" + i));
                            System.out.println("pBaggages" + pBaggages);
                            int pBPrice = ((pBaggages != null) ? bgd.getPriceBaggagesById(pBaggages) : 0);
                            totalPrice += pBPrice;
                            td.createTicket(code, flightDetailId, seatCategoryId, p1.getPassengerID(), newBookId.getBookingID(),1, 2000);
                        }
                    }
                   // bd.updateTotalPrice(b.getBookingID(), totalPrice);
                }
            }

            if (id != null) {
                Accounts acc = ad.getAccountsById(id);
                request.setAttribute("account", acc);
            }
             b = bd.getLatestBooking();
            email.sendBookingEmail(b.getContactEmail(),b);

            request.setAttribute("bookingId", b.getBookingID());
            request.setAttribute("price", b.getTotalPrice());
            request.getRequestDispatcher("views/public/successfulBooking.jsp").forward(request, response);

        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("views/public/error.jsp").forward(request, response);
        }


    }
}
