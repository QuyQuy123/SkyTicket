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
    private static final int Records_Per_Page = 10;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        int page = 1;
        if (req.getParameter("page") != null) {
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int start = (page - 1) * Records_Per_Page;

        AirportsDAO airportsDAO = new AirportsDAO();
        LocationsDAO locDao = new LocationsDAO();
            //String sql = "SELECT *  FROM airports";
            List<Airports> listAirports = airportsDAO.getAirportsByPage(start, Records_Per_Page);
            List<Locations> listLocations = locDao.getAllLocation();
            int totalRecords = airportsDAO.getTotalAirports();
            int totalPages = (int) Math.ceil((double) totalRecords / Records_Per_Page);

            req.setAttribute("airports", listAirports);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPage", totalPages);
            req.setAttribute("locations", listLocations);
            req.getRequestDispatcher("/views/admin/jsp/viewListAirports.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
