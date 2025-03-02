package controller;

import dal.AirlinesDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Airlines;
import model.Locations;

import java.io.File;
import java.io.IOException;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet("/updateLocation")
public class LocationsUpdate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        LocationsDAO locationsDAO = new LocationsDAO();

        Locations locations = new Locations();
        locations = locationsDAO.getLocationById(id);

        if (locations == null) {
            req.setAttribute("error", "Location not found");
            req.getRequestDispatcher("/views/admin/jsp/updateLocation.jsp").forward(req, resp);
        }else{
            req.setAttribute("locations", locations);
            req.getRequestDispatcher("views/admin/jsp/updateLocation.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        LocationsDAO locationsDAO = new LocationsDAO();

        int id = Integer.parseInt(req.getParameter("locationId"));
        String locationName = req.getParameter("name");
        int status = Integer.parseInt(req.getParameter("status"));
        Locations locations = locationsDAO.getLocationById(id);

        if (locationName == null || locationName.trim().isEmpty()) {
            req.setAttribute("error", "Location is not empty!");
            req.setAttribute("locations", locations);
            req.getRequestDispatcher("/views/admin/jsp/updateLocation.jsp").forward(req, resp);
            return;
        } else if (locationsDAO.getIdByLocationName(locationName) != -1 && locationsDAO.getStatus(id) == status) {
            req.setAttribute("error", "Location already exists!");
            req.setAttribute("locations", locations);
            req.getRequestDispatcher("/views/admin/jsp/updateLocation.jsp").forward(req, resp);
            return;
        } else {
            if (locations == null) {
                req.setAttribute("message", "Location not found.");
                req.getRequestDispatcher("/views/admin/jsp/viewListLocation.jsp").forward(req, resp);
                return;
            }

            locations.setLocationName(locationName);
            locations.setStatus(status);

            boolean success = locationsDAO.updateLocation(locations);
            if (success) {
                req.setAttribute("msg", "Location updated successfully!");
                req.setAttribute("locations", locations);
                req.getRequestDispatcher("/views/admin/jsp/updateLocation.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Update failed!");
                req.setAttribute("locations", locations);
                req.getRequestDispatcher("/views/admin/jsp/updateLocation.jsp").forward(req, resp);
            }
        }

    }

}

