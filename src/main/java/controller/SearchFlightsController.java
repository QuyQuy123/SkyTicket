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
import java.util.List;

@WebServlet(name = "SearchFlightsController", urlPatterns = {"/SearchFlightsURL"})
public class SearchFlightsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("views/public/ViewFlight.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
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

        String depAStr = request.getParameter("departure"); // airport ID
        String desAStr = request.getParameter("destination");
        String depDateStr = request.getParameter("departureDate");

        int depAStrs = Integer.parseInt(depAStr);
        int desAStrs = Integer.parseInt(desAStr);
        Date parsedDate = Date.valueOf(depDateStr);

        List<Flights> flightList = fldao.getFlightsByAirportAndDate(depAStrs, desAStrs, parsedDate);

        // Số chuyến bay mỗi trang
        int flightsPerPage = 3;

        // Lấy trang hiện tại từ request, mặc định là trang 1 nếu không có
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        // Tính toán vị trí bắt đầu và kết thúc của trang hiện tại
        int startIndex = (currentPage - 1) * flightsPerPage;
        int endIndex = Math.min(startIndex + flightsPerPage, flightList.size());

        // Lấy danh sách chuyến bay thuộc trang hiện tại
        List<Flights> paginatedFlights = flightList.subList(startIndex, endIndex);

        // Tổng số trang
        int totalPages = (int) Math.ceil((double) flightList.size() / flightsPerPage);

        request.setAttribute("flightTickets", paginatedFlights);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("views/public/ViewFlight.jsp").forward(request, resp);
    }

}
