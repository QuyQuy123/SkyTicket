package controller;

import dal.AirportsDAO;
import dal.CountriesDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airports;
import model.Countries;
import model.Locations;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/listLocationsURL")
public class LocationsList extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 8;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        LocationsDAO locationDAO = new LocationsDAO();
        CountriesDAO countryDAO = new CountriesDAO();

        // Lấy tham số trang hiện tại
        int page = 1;
        int recordsPerPage = 6; // Số lượng bản ghi trên mỗi trang

        String pageStr = request.getParameter("page");
        if (pageStr != null) {
            page = Integer.parseInt(pageStr);
        }

        // Lấy danh sách location theo trang
        List<Locations> listLocations = locationDAO.getLocationsByPage((page - 1) * recordsPerPage, recordsPerPage);
        int totalRecords = locationDAO.getTotalRecords();
        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        request.setAttribute("locations", listLocations);
        request.setAttribute("countries", countryDAO.getAllCountries());

        // Thêm thông tin phân trang vào request
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/jsp/viewListLocations.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
