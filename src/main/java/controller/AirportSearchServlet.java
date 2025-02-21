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
    private static final int RECORDS_PER_PAGE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AirportsDAO dao = new AirportsDAO();
        LocationsDAO locDao = new LocationsDAO();
        List<Locations> listLocations = locDao.getAllLocation();

        // Lấy tham số từ form
        String airportName = request.getParameter("search");
        String statusStr = request.getParameter("status");

        // Chuyển đổi status từ String → Integer
        Integer status = (statusStr != null && !statusStr.isEmpty()) ? Integer.parseInt(statusStr) : null;

        // Tính tổng số bản ghi và tổng số trang
        int totalRecords = dao.countFilteredAirport(airportName, status);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Xác định trang hiện tại
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Đảm bảo page luôn nằm trong phạm vi hợp lệ
        if (page < 1) {
            page = 1;
        } else if (page > totalPages && totalPages > 0) {
            page = totalPages;
        }

        // Tính vị trí bắt đầu của dữ liệu
        int start = (page - 1) * RECORDS_PER_PAGE;
        List<Airports> searchResults = dao.searchAirports(airportName, status, start, RECORDS_PER_PAGE);

        // Đưa kết quả tìm kiếm vào request attribute
        request.setAttribute("locations", listLocations);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("airports", searchResults);
        request.setAttribute("searchName", airportName);
        request.setAttribute("searchStatus", statusStr);
        request.setAttribute("searchpage", "page");

        // Forward về JSP để hiển thị kết quả
        request.getRequestDispatcher("/views/admin/jsp/viewListAirports.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
