package controller;

import dal.AirportsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Airports;

import java.io.IOException;

@WebServlet(name = "AirportAddServlet", value = "/AirportAddServlet")
public class AirportAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String submit = request.getParameter("submit");

        if (submit != null) {
            String airportName = request.getParameter("name");
            int locationId = Integer.parseInt(request.getParameter("locationId"));
            String statusStr = request.getParameter("status"); // active hoặc deactive
            int status = statusStr.equals("active") ? 1 : 0; // Chuyển về số

            Airports air = new Airports(airportName, locationId, status);
            AirportsDAO dao = new AirportsDAO();
            int n = dao.addAirport(air);

            if (n > 0) {
                session.setAttribute("message", "Airport added successfully");
                response.sendRedirect(request.getContextPath() + "/AirportListURL");
                // request.getRequestDispatcher("/views/admin/jsp/addAirdport.jsp").forward(request, response);
                // request.getRequestDispatcher(request.getContextPath() + "/AirportAddServlet");
            } else {
                request.setAttribute("error", "Add failed!!! Try again");
                request.getRequestDispatcher("/views/admin/jsp/addAirdport.jsp").forward(request, response);
            }
        }
    }
}
