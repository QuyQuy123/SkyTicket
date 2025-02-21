package controller;

import dal.AirlinesDAO;
import dal.CountriesDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airlines;
import model.Countries;
import model.Locations;

import java.io.IOException;

@WebServlet("/viewLocation")
public class LocationsDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        LocationsDAO locationsDAO = new LocationsDAO();

        Locations location = new Locations();
        location = locationsDAO.getLocationById(id);

        if (location == null) {
            req.setAttribute("error", "Location not found");
            req.getRequestDispatcher("views/admin/jsp/updateLocation.jsp").forward(req, resp);
        }else{
            req.setAttribute("location", location);
            req.getRequestDispatcher("views/admin/jsp/viewDetailLocation.jsp").forward(req, resp);
        }
    }
}
