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

@WebServlet(name = "AirportUpdateServlet", value = "/airportUpdate")
public class AirportUpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        AirportsDAO airportsDAO = new AirportsDAO();
        LocationsDAO locationsDAO = new LocationsDAO();
        if (action.equals("update")){
            System.out.println("Fuck you bitch");
            int id = Integer.parseInt(request.getParameter("airportId"));


            Airports airport = airportsDAO.getAirportById(id);
            Locations location = locationsDAO.getLocationById(airport.getLocationId());

            if (airport == null) {
                request.setAttribute("error", "Airport not found");
                request.getRequestDispatcher("views/admin/jsp/updateAirport.jsp").forward(request, response);
            } else {
                request.setAttribute("airport", airport);
                request.setAttribute("location", location);
                request.getRequestDispatcher("views/admin/jsp/updateAirport.jsp").forward(request, response);
            }
        }
        if(action.equals("change")){
            System.out.println("Change nè");
            int airportId = Integer.parseInt(request.getParameter("airportId"));

            // Logic để lấy airport hiện tại từ database
            Airports airport = airportsDAO.getAirportById(airportId);

            // Đổi trạng thái
            int newStatus = airport.getStatus() == 1 ? 0 : 1;
            airport.setStatus(newStatus);

            // Cập nhật vào database
            airportsDAO.updateAirport(airport);

            // Redirect về trang list
            request.getRequestDispatcher("/AirportListURL").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int airportId = Integer.parseInt(request.getParameter("airportId"));
        String airportName = request.getParameter("airportName").trim();
        int status = Integer.parseInt(request.getParameter("status"));
        int locationId = Integer.parseInt(request.getParameter("locationId"));

        AirportsDAO airportsDAO = new AirportsDAO();
        Airports existingAirport = airportsDAO.getAirportById(airportId);
        LocationsDAO locationsDAO = new LocationsDAO();
        Locations location = locationsDAO.getLocationById(existingAirport.getLocationId());

        if (existingAirport.getAirportName().equals(airportName) && existingAirport.getStatus() == status) {
            request.setAttribute("errorMsg", "Airport name already exists!");
            request.setAttribute("airport", existingAirport);
            request.setAttribute("location", location);
            request.getRequestDispatcher("views/admin/jsp/updateAirport.jsp").forward(request, response);
            return;
        }
        // Validate airport name (Allow Vietnamese characters)
        if (airportName.isEmpty() || !airportName.matches("^[\\p{L}\\s]+$")) {
            request.setAttribute("errorMsg", "Invalid airport name! It can only contain letters and spaces.");
            request.setAttribute("airport", existingAirport);
            request.setAttribute("location", location);
            request.getRequestDispatcher("views/admin/jsp/updateAirport.jsp").forward(request, response);
            return;
        }

        // Check if airport name already exists
        Airports airportByName = airportsDAO.getAirportByName(airportName);
        if (airportByName != null && airportByName.getAirportId() != airportId) {
            request.setAttribute("errorMsg", "Airport name already exists! Please choose a different name.");
            request.setAttribute("airport", existingAirport);
            request.setAttribute("location", location);
            request.getRequestDispatcher("views/admin/jsp/updateAirport.jsp").forward(request, response);
            return;
        }

        Airports updatedAirport = new Airports(airportId, airportName, existingAirport.getLocationId(), status);
        int n = airportsDAO.updateAirport(updatedAirport);

        if (n > 0) {
            request.setAttribute("msg", "Airport updated successfully!");
        } else {
            request.setAttribute("msg", "Failed to update airport!");
        }
        request.setAttribute("airport", updatedAirport);
        request.setAttribute("location", location);
        request.getRequestDispatcher("views/admin/jsp/updateAirport.jsp").forward(request, response);
    }

}