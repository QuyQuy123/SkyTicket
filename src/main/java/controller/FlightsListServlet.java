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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/listFlights")
public class FlightsListServlet extends HttpServlet {

    private static final int RECORDS_PER_PAGE = 40; // Số lượng bản ghi mỗi trang

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

        Double priceFrom = null;
        Double priceTo = null;
        Integer status = null;

        try {
            String priceFromStr = request.getParameter("priceFrom");
            if (priceFromStr != null && !priceFromStr.isEmpty()) {
                priceFrom = Double.valueOf(priceFromStr);
            }

            String priceToStr = request.getParameter("priceTo");
            if (priceToStr != null && !priceToStr.isEmpty()) {
                priceTo = Double.valueOf(priceToStr);
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
        List<Flights> flightsList = flightsDAO.searchFlights(deA, arA, dateFrom, dateTo, priceFrom, priceTo, airlineName, status);
//        request.setAttribute("listFlights", flightsList);

        // Nhận tham số trang hiện tại từ request (nếu không có thì mặc định là 1)
        int page = 1;
        int pageSize = 5; // Số lượng chuyến bay mỗi trang

        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }


// Xác định phạm vi dữ liệu hiển thị trên trang hiện tại
        int totalFlights = flightsList.size();
        int totalPages = (int) Math.ceil((double) totalFlights / pageSize);
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalFlights);

// Lấy danh sách chuyến bay cho trang hiện tại
        List<Flights> paginatedFlights = new ArrayList<>();
        if (fromIndex < totalFlights) {
            paginatedFlights = flightsList.subList(fromIndex, toIndex);
        }

// Gửi dữ liệu đến JSP
        request.setAttribute("listFlights", paginatedFlights);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/jsp/viewListFlights.jsp").forward(request, response);

    }
}
