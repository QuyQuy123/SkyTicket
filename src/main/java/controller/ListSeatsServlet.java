package controller;

import dal.AirlinesDAO;
import dal.SeatsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airlines;
import model.Seats;

import java.io.IOException;
import java.util.List;

@WebServlet("/listseats")
public class ListSeatsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        int id = Integer.parseInt(request.getParameter("id"));
        AirlinesDAO airlinesDAO = new AirlinesDAO();
        Airlines airline = airlinesDAO.getAirlineById(id);
        SeatsDAO seatsDAO = new SeatsDAO();
        List<Seats> seatsList = seatsDAO.getAllSeatByAirlineId(airline.getAirlineId());
        request.setAttribute("airline", airline);
        request.setAttribute("seats", seatsList);
        request.getRequestDispatcher("/views/admin/jsp/seatsMap.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        int seatId = Integer.parseInt(request.getParameter("seatId"));

        SeatsDAO seatDAO = new SeatsDAO();
        Seats seat = seatDAO.getSeatById(seatId);
        boolean isUpdated;
        if (seat.getStatus() == 1) {
            isUpdated = seatDAO.updateSeatStatus(seatId, 0);
        } else {
            isUpdated = seatDAO.updateSeatStatus(seatId, 1);
        }

        if (isUpdated) {
            int id = Integer.parseInt(request.getParameter("id"));
            AirlinesDAO airlinesDAO = new AirlinesDAO();
            Airlines airline = airlinesDAO.getAirlineById(id);
            SeatsDAO seatsDAO = new SeatsDAO();
            List<Seats> seatsList = seatsDAO.getAllSeatByAirlineId(airline.getAirlineId());
            request.setAttribute("airline", airline);
            request.setAttribute("seats", seatsList);
            request.getRequestDispatcher("/views/admin/jsp/seatsMap.jsp").forward(request, response);
        } else {
            response.getWriter().write("Cập nhật thất bại!");
        }
    }
}
