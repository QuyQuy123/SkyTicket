package controller;

import dal.AirlinesDAO;
import dal.AirportsDAO;
import dal.CountriesDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airlines;
import model.Airports;
import model.Countries;
import model.Locations;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchLocations")
public class LocationsSearch extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 8;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String locationName = req.getParameter("search");
        String statusStr = req.getParameter("status");

        // Chuyển đổi status từ String → Integer
        Integer status = (statusStr != null && !statusStr.isEmpty()) ? Integer.parseInt(statusStr) : null;

        // Gọi DAO để tìm kiếm
        LocationsDAO dao = new LocationsDAO();
        CountriesDAO cdao = new CountriesDAO();
        List<Locations> searchResults = dao.searchLocation(locationName, status);

        // Đưa kết quả tìm kiếm vào request attribute
        List<Countries> listCountries = cdao.getAllLocation();
        req.setAttribute("countries", listCountries);
        req.setAttribute("locations", searchResults);
        req.setAttribute("searchName", locationName);
        req.setAttribute("searchStatus", statusStr);


        req.getRequestDispatcher("/views/admin/jsp/viewListLocations.jsp").forward(req, resp);
    }
}
