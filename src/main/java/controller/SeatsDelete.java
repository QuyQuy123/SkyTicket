package controller;

import dal.AirportsDAO;
import dal.SeatsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "SeatsDelete", value = "/SeatDelete")
public class SeatsDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy Seat Id từ request
        String seatIdStr = request.getParameter("seatId");
        if(seatIdStr != null && !seatIdStr.isEmpty()){
            try {
                int seatId = Integer.parseInt(seatIdStr);

                // Goi Dao
                SeatsDAO dao = new SeatsDAO();
                boolean result = dao.deleteSeat(seatId);

                if(result){
                    request.setAttribute("msg" , "Seat deleted successfully");
                }else {
                    request.setAttribute("msg" , "Failed to delete seat!");
                }

            }catch (NumberFormatException e){
                request.setAttribute("msg", "Invalid SeatId");
            }
        }
        response.sendRedirect(request.getContextPath()+"/listSeats");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}