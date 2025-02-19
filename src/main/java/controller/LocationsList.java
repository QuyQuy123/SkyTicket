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
        response.setContentType("text/html");
        LocationsDAO dao = new LocationsDAO();
        CountriesDAO cdao = new CountriesDAO();
        String sql = "SELECT *  FROM Locations";
        List<Locations> listLocations = dao.getAllLocation();
        request.setAttribute("locations", listLocations);
        List<Countries> listCountries = cdao.getAllLocation();
        request.setAttribute("countries", listCountries);
        request.getRequestDispatcher("/views/admin/jsp/viewListLocations.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
