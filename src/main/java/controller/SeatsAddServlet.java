package controller;

import dal.FlightsDAO;
import dal.SeatsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Flights;
import model.Seats;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SeatsAddServlet", value = "/addSeats")
public class SeatsAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        FlightsDAO flightsDAO = new FlightsDAO();
        SeatsDAO seatsDAO = new SeatsDAO();
        List<Flights> flights = flightsDAO.getAllFlights();
        request.setAttribute("flights", flights);

        String selectedFlightId = request.getParameter("FlightId");
        if (selectedFlightId != null && !selectedFlightId.isEmpty()) {
            List<String> existingSeats = seatsDAO.getSeatsByFlightId(selectedFlightId);
            request.setAttribute("existingSeats", existingSeats);
            request.setAttribute("selectedFlightId", selectedFlightId);
        }

        request.getRequestDispatcher("/views/admin/jsp/addSeats.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String flightIdStr = request.getParameter("FlightId");
            String seatNumberStr = request.getParameter("SeatNumber");
            String seatClass = request.getParameter("SeatClass");
            String statusStr = request.getParameter("Status");
            String isBookedStr = request.getParameter("isBooked");


            int flightId = Integer.parseInt(flightIdStr);
            int seatNumber = Integer.parseInt(seatNumberStr);
            int status = Integer.parseInt(statusStr);
            int isBooked = Integer.parseInt(isBookedStr);

            SeatsDAO seatsDAO = new SeatsDAO();



        // Kiểm tra SeatNumber có bị trùng trong database không
        boolean isDuplicate = seatsDAO.isSeatNumberExists(seatNumber, flightId);
        if (isDuplicate) {
            FlightsDAO flightsDAO = new FlightsDAO();
            List<Flights> flights = flightsDAO.getAllFlights();
            request.setAttribute("flights", flights);
            request.setAttribute("msg", "Seat Number already exists for this flight. Please choose another.");
            request.getRequestDispatcher("/views/admin/jsp/addSeats.jsp").forward(request, response);
            return;
        }

            Seats seat = new Seats(flightId, status, seatNumber, seatClass, isBooked);

            int n = seatsDAO.addSeat(seat);

            if (n > 0) {
                request.setAttribute("msg", "Seat added successfully");
            } else {
                request.setAttribute("msg", "Seat not added successfully");
            }
            request.getRequestDispatcher("/views/admin/jsp/addSeats.jsp").forward(request, response);

    }
}