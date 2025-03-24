package controller;

import dal.AirportsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AirportDeleteServlet", value = "/AirportDeleteServlet")
public class AirportDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String airportIdStr = request.getParameter("airportId");
        if (airportIdStr != null) {
            try {
                int airportId = Integer.parseInt(airportIdStr);


                AirportsDAO dao = new AirportsDAO();
                boolean isDeleted = dao.deleteAirport(airportId);


                if (isDeleted) {
                    request.getSession().setAttribute("message", "Airport deleted successfully!");
                } else {
                    request.getSession().setAttribute("message", "Failed to delete airport!");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("message", "Invalid airport ID!");
            }
        }

        response.sendRedirect(request.getContextPath() +"/AirportListURL");
        //request.getRequestDispatcher(request.getContextPath()+"/views/admin/jsp/viewListAirports.jsp").forward(request, response);
    }
}
