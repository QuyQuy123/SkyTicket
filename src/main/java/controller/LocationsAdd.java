package controller;

import dal.LocationsDAO;
import model.Locations;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LocationsAddServlet", urlPatterns = {"/LocationAdd"})
public class LocationsAdd extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("views/admin/jsp/addLocation.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        LocationsDAO locationsDAO = new LocationsDAO();

        String locationName = request.getParameter("name").trim();
        int countryId = Integer.parseInt(request.getParameter("countryID"));
        int status = request.getParameter("status").equals("active") ? 1 : 2;

        if (locationName.isEmpty()) {
            session.setAttribute("errorMsg", "Location name cannot be empty.");
            response.sendRedirect(request.getContextPath() + "/views/admin/jsp/addLocation.jsp");
            return;
        } else if (locationsDAO.getIdByLocationName(locationName) != -1) {
            session.setAttribute("errorMsg", "Location name already exists.");
            response.sendRedirect(request.getContextPath() + "/views/admin/jsp/addLocation.jsp");
            return;
        } else {
            Locations location = new Locations(locationName, countryId, status);
            boolean isAdded = locationsDAO.addLocation(location);

            if (isAdded) {
                session.setAttribute("successMsg", "Location added successfully!");
            } else {
                session.setAttribute("errorMsg", "Failed to add location.");
            }

            response.sendRedirect(request.getContextPath() + "/views/admin/jsp/addLocation.jsp");
        }

    }
}
