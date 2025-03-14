package controller;

import dal.AirlinesDAO;
import dal.AirportsDAO;
import dal.FlightsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airlines;
import model.Airports;
import model.Flights;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet("/listFlights")
public class FlightsListServlet extends HttpServlet {

    private static final int RECORDS_PER_PAGE = 5; // Số lượng bản ghi mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        FlightsDAO flightsDAO = new FlightsDAO();
        AirlinesDAO airlinesDAO = new AirlinesDAO();
        AirportsDAO airportsDAO = new AirportsDAO();

        List<Airlines> airlineList = airlinesDAO.getAllAirlines();
        List<Airports> airportList = airportsDAO.getAllAirports();
        request.setAttribute("airlineList", airlineList);
        request.setAttribute("airportList", airportList);

        // Xác định trang hiện tại
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Tính vị trí bắt đầu của dữ liệu
        int start = (page - 1) * RECORDS_PER_PAGE;

        // Lấy danh sách chuyến bay theo trang
        List<Flights> listFlights = flightsDAO.getFlightsByPage(start, RECORDS_PER_PAGE);
        System.out.println(listFlights.isEmpty());
        int totalRecords = flightsDAO.getTotalFlights();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        request.setAttribute("listFlights", listFlights);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/jsp/viewListFlights.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String deA = request.getParameter("deA");
        String arA = request.getParameter("arA");
        String dateFromStr = request.getParameter("dateFrom");
        String dateToStr = request.getParameter("dateTo");
        Date dateFrom = null;
        Date dateTo = null;

        try {
            if (dateFromStr != null && !dateFromStr.isEmpty()) {
                dateFrom = Date.valueOf(dateFromStr);
            }
            if (dateToStr != null && !dateToStr.isEmpty()) {
                dateTo = Date.valueOf(dateToStr);
            }
        } catch (IllegalArgumentException e) {
            e.printStackTrace(); // Ghi log lỗi để debug
        }

        Double priceVipFrom = null;
        Double priceVipTo = null;
        Double priceEcoFrom = null;
        Double priceEcoTo = null;
        Integer status = null;

        try {
            String priceVipFromStr = request.getParameter("priceVipFrom");
            if (priceVipFromStr != null && !priceVipFromStr.isEmpty()) {
                priceVipFrom = Double.valueOf(priceVipFromStr);
            }

            String priceVipToStr = request.getParameter("priceVipTo");
            if (priceVipToStr != null && !priceVipToStr.isEmpty()) {
                priceVipTo = Double.valueOf(priceVipToStr);
            }

            String priceEcoFromStr = request.getParameter("priceEcoFrom");
            if (priceEcoFromStr != null && !priceEcoFromStr.isEmpty()) {
                priceEcoFrom = Double.valueOf(priceEcoFromStr);
            }

            String priceEcoToStr = request.getParameter("priceEcoTo");
            if (priceEcoToStr != null && !priceEcoToStr.isEmpty()) {
                priceEcoTo = Double.valueOf(priceEcoToStr);
            }

            String statusStr = request.getParameter("status");
            if (statusStr != null && !statusStr.isEmpty()) {
                status = Integer.parseInt(statusStr);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        String airlineName = request.getParameter("airlineName");


        AirlinesDAO airlinesDAO = new AirlinesDAO();
        AirportsDAO airportsDAO = new AirportsDAO();

        List<Airlines> airlineList = airlinesDAO.getAllAirlines();
        List<Airports> airportList = airportsDAO.getAllAirports();
        request.setAttribute("airlineList", airlineList);
        request.setAttribute("airportList", airportList);

        FlightsDAO flightsDAO = new FlightsDAO();
        // Xác định trang hiện tại
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        // Tính vị trí bắt đầu của dữ liệu
        int start = (page - 1) * RECORDS_PER_PAGE;
        List<Flights> flightsList = flightsDAO.searchFlights(deA, arA, dateFrom, dateTo, priceVipFrom, priceVipTo, priceEcoFrom, priceEcoTo, airlineName, status);
        List<Flights> flightsListByPage = flightsDAO.getSearchFlightsByPage(start, RECORDS_PER_PAGE, deA, arA, dateFrom, dateTo, priceVipFrom, priceVipTo, priceEcoFrom, priceEcoTo, airlineName, status);

        int totalPages = (int) Math.ceil((double) flightsList.size() / RECORDS_PER_PAGE);

        request.setAttribute("listFlights", flightsListByPage);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/jsp/viewListFlights.jsp").forward(request, response);

    }
}
