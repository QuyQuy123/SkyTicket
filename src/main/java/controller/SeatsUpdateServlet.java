package controller;

import dal.SeatsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Seats;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SeatsUpdateServlet", value = "/updateSeatURL")
public class SeatsUpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("SeatId");

        // Kiểm tra nếu id bị null hoặc rỗng
        if (idStr == null || idStr.trim().isEmpty()) {
            request.setAttribute("msg", "Invalid Seat ID");
            request.getRequestDispatcher("views/admin/jsp/updateSeats.jsp").forward(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idStr);

            SeatsDAO seatsDAO = new SeatsDAO();
            Seats seat = seatsDAO.getSeatById(id);

            if (seat == null) {
                request.setAttribute("msg", "Seat not found");
            } else {
                request.setAttribute("seat", seat);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("msg", "Seat ID must be a number");
        }

        request.getRequestDispatcher("views/admin/jsp/updateSeats.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int seatId = Integer.parseInt(request.getParameter("SeatId"));
        int flightId = Integer.parseInt(request.getParameter("FlightId"));
        int status = Integer.parseInt(request.getParameter("Status"));
        int seatNumber = Integer.parseInt(request.getParameter("SeatNumber"));
        String seatClass = request.getParameter("SeatClass");
        int isBooked = Integer.parseInt(request.getParameter("isBooked"));

        SeatsDAO seatsDAO = new SeatsDAO();
        Seats existingSeat = seatsDAO.getSeatById(seatId);
        Seats updatedSeat = new Seats(seatId,flightId,status,seatNumber,seatClass,isBooked);
        int n = seatsDAO.updateSeat(updatedSeat);
        if(n>0){
            request.setAttribute("msg", "Seat successfully updated");
            request.setAttribute("seat", updatedSeat);
            request.getRequestDispatcher("/views/admin/jsp/updateSeats.jsp").forward(request, response);
            return;
        }else{
            request.setAttribute("error", "Seat not found");
            request.getRequestDispatcher("/views/admin/jsp/updateSeats.jsp").forward(request, response);
            return;
        }

    }


}