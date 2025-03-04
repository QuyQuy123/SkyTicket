package controller;

import dal.AccountDAO;
import dal.AirlinesDAO;
import dal.FlightsDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import model.Flights;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SearchFlightsController", urlPatterns = {"/SearchFlightsURL"})
public class SearchFlightsController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("views/public/ViewFlight.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        AccountDAO ad = new AccountDAO();
        FlightsDAO fldao = new FlightsDAO();
        AirlinesDAO aidao = new AirlinesDAO();
        LocationsDAO locdao = new LocationsDAO();
        HttpSession session = request.getSession();
        Integer idd = (Integer) session.getAttribute("id");
        int i = (idd != null) ? idd : -1;
        Accounts acc = ad.getAccountsById(i);
        request.setAttribute("account", acc);

        try {
            int adultTickets = Integer.parseInt(request.getParameter("adult"));
            int childTickets = Integer.parseInt(request.getParameter("child"));
            int infantTickets = Integer.parseInt(request.getParameter("infant"));
            request.setAttribute("totalPassengers", (adultTickets + childTickets + infantTickets));
        } catch (Exception e) {
            System.out.println(e);
        }

        String depAStr = request.getParameter("departure");
        String desAStr = request.getParameter("destination");
        String depDateStr = request.getParameter("departureDate");
        String reDateStr = request.getParameter("returnDate");
        String flightDetailIdStr = request.getParameter("flightDetailId");

        List<Flights> flightList = new ArrayList<>(); // Khởi tạo mặc định không null

        try {
            if (flightDetailIdStr == null) {
                int depAStrs = Integer.parseInt(depAStr);
                int desAStrs = Integer.parseInt(desAStr);
                Date parsedDate = Date.valueOf(depDateStr);
                flightList = fldao.getFlightsByAirportAndDate(depAStrs, desAStrs, parsedDate);
            } else {
                request.setAttribute("reDate", reDateStr);
                int depA = Integer.parseInt(depAStr);
                int desA = Integer.parseInt(desAStr);
                Date reDate = Date.valueOf(reDateStr);
                flightList = fldao.getFlightsByAirportAndDate(desA, depA, reDate);
            }
        } catch (Exception e) {
            System.out.println("Error fetching flights: " + e.getMessage());
        }

        // Phân trang
        int flightsPerPage = 3;
        int currentPage = 1;

        try {
            if (request.getParameter("page") != null) {
                currentPage = Integer.parseInt(request.getParameter("page"));
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid page number: " + e.getMessage());
        }

        // Xử lý phân trang với danh sách rỗng
        int startIndex = (currentPage - 1) * flightsPerPage;
        int endIndex = flightList.isEmpty() ? 0 : Math.min(startIndex + flightsPerPage, flightList.size());
        int totalPages = flightList.isEmpty() ? 1 : (int) Math.ceil((double) flightList.size() / flightsPerPage);

        List<Flights> paginatedFlights = flightList.isEmpty() ?
                new ArrayList<>() :
                flightList.subList(startIndex, endIndex);

        // Gán các thuộc tính cho request
        request.setAttribute("flightTickets", paginatedFlights);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("views/public/ViewFlight.jsp").forward(request, resp);
    }
}
