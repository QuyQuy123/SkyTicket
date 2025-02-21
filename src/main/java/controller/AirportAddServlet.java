package controller;

import dal.AirportsDAO;
import model.Airports;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "AirportAddServlet", urlPatterns = {"/AirportAddServlet"})
public class AirportAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/admin/jsp/addAirport.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        AirportsDAO dao = new AirportsDAO();

        String airportName = request.getParameter("airportName").trim();
        String locationIdStr = request.getParameter("locationId");
        String statusStr = request.getParameter("status");

        // Validate input
        if (airportName.isEmpty()) {
            session.setAttribute("errorMsg", "Airport name cannot be empty.");
            response.sendRedirect(request.getContextPath() + "/views/admin/jsp/addAirport.jsp");
            return;
        }
        if (dao.isAirportExist(airportName)) {
            session.setAttribute("errorMsg", "Airport name already exists.");
            response.sendRedirect(request.getContextPath() + "/views/admin/jsp/addAirport.jsp");
            return;
        }

        int locationId;
        try {
            locationId = Integer.parseInt(locationIdStr);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Invalid location ID.");
            response.sendRedirect(request.getContextPath() + "/views/admin/jsp/addAirport.jsp");
            return;
        }

        int status = "active".equals(statusStr) ? 1 : 0;

        Airports airport = new Airports(airportName, locationId, status);
        boolean isAdded = dao.addAirport(airport) > 0;

        if (isAdded) {
            session.setAttribute("successMsg", "Airport added successfully!");
        } else {
            session.setAttribute("errorMsg", "Failed to add airport.");
        }

        response.sendRedirect(request.getContextPath() + "/views/admin/jsp/addAirport.jsp");
    }
}
