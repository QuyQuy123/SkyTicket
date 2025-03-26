package controller;

import dal.AirportsDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airports;
import model.Locations;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AirportSearchServlet", value = "/AirportSearch")
public class AirportSearchServlet extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AirportsDAO dao = new AirportsDAO();
        LocationsDAO locDao = new LocationsDAO();
        List<Locations> listLocations = locDao.getAllLocation();

        String airportName = request.getParameter("search");
        String statusStr = request.getParameter("status");
        String pageStr = request.getParameter("page");

        // Xử lý status
        Integer status = null;
        if (statusStr != null && !statusStr.isEmpty()) {
            try {
                status = Integer.parseInt(statusStr);
            } catch (NumberFormatException e) {
                status = null; // Nếu status không hợp lệ, lấy tất cả
            }
        }

        // Tính tổng số trang
        int totalRecords = dao.countFilteredAirport(airportName, status);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Xử lý page
        int page = 1; // Giá trị mặc định
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1; // Nếu page không hợp lệ, mặc định là 1
            }
        }

        // Giới hạn page trong khoảng hợp lệ
        if (page < 1) {
            page = 1;
        } else if (page > totalPages && totalPages > 0) {
            page = totalPages;
        }

        // Lấy danh sách airports
        int start = (page - 1) * RECORDS_PER_PAGE;
        List<Airports> searchResults = dao.searchAirports(airportName, status, start, RECORDS_PER_PAGE);

        // Set attributes
        request.setAttribute("locations", listLocations);
        request.setAttribute("totalPages", totalPages); // Giữ tên attribute là totalPages
        request.setAttribute("currentPage", page);
        request.setAttribute("airports", searchResults);
        request.setAttribute("searchName", airportName);
        request.setAttribute("searchStatus", statusStr);
        request.setAttribute("searchpage", "page");

        // Forward đến JSP
        request.getRequestDispatcher("/views/admin/jsp/viewListAirports.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
