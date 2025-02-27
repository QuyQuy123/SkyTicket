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
        // Xử lý logic nếu cần
    }
}
