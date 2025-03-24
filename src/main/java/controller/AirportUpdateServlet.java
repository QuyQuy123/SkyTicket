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

@WebServlet(name = "AirportUpdateServlet", value = "/AirportUpdateURL")
public class AirportUpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("airportId"));

        AirportsDAO airportsDAO = new AirportsDAO();
        LocationsDAO locationsDAO = new LocationsDAO();
        Airports airport = airportsDAO.getAirportById(id);
        Locations location = locationsDAO.getLocationById(airport.getLocationId());

        if(airport == null){
            request.setAttribute("error", "Airport not found");
            request.getRequestDispatcher("views/admin/jsp/updateAirport.jsp").forward(request, response);
        }else {
            request.setAttribute("airport", airport);
            request.setAttribute("location", location);
            request.getRequestDispatcher("views/admin/jsp/updateAirport.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int airportId = Integer.parseInt(request.getParameter("airportId"));
        String airportName = request.getParameter("airportName").trim();
        int status = Integer.parseInt(request.getParameter("status"));


        AirportsDAO airportsDAO = new AirportsDAO();
        Airports existingAirport = airportsDAO.getAirportById(airportId);
        LocationsDAO locationsDAO = new LocationsDAO();
        Locations location = locationsDAO.getLocationById(existingAirport.getLocationId());

        Airports updatedAirport = new Airports(airportId, airportName, existingAirport.getLocationId(), status);
        int n = airportsDAO.updateAirport(updatedAirport);

        if (n > 0) {
            request.setAttribute("airport", updatedAirport);
            request.setAttribute("location", location);
            request.getSession().setAttribute("msg", "Cập nhật sân bay thành công!");
            request.getRequestDispatcher("views/admin/jsp/updateAirport.jsp").forward(request, response);
        } else {
            request.getSession().setAttribute("msg", "Cập nhật sân bay thất bại.");
        }

        response.sendRedirect(request.getContextPath() + "/AirportURL");
    }
}