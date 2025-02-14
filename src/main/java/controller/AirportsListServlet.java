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

@WebServlet(name = "AirportListServlet", urlPatterns = {"/AirportListURL"})
public class AirportsListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        AirportsDAO dao = new AirportsDAO();
        LocationsDAO locDao = new LocationsDAO();
            String sql = "SELECT *  FROM airports";
            List<Airports> listAirports = dao.getAllAirportsHieu(sql);
            req.setAttribute("airports", listAirports);
        List<Locations> listLocations = locDao.getAllLocation();
        req.setAttribute("locations", listLocations);
        req.getRequestDispatcher("/views/admin/jsp/viewListAirports.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
