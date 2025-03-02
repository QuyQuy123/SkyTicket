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

@WebServlet(name = "SeatsSearchServlet", value = "/seatsSearch")
public class SeatsSearchServlet extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SeatsDAO dao = new SeatsDAO();

        // Lấy tham số tìm kiếm từ request
        String seatIdStr = request.getParameter("search");  // Tìm theo SeatId
        String flightIdStr = request.getParameter("flightId");  // Tìm theo FlightId
        String statusStr = request.getParameter("status");
        String isBookedStr = request.getParameter("isBooked");

        // Chuyển đổi kiểu dữ liệu
        Integer seatId = (seatIdStr != null && !seatIdStr.isEmpty()) ? Integer.parseInt(seatIdStr) : null;
        Integer flightId = (flightIdStr != null && !flightIdStr.isEmpty()) ? Integer.parseInt(flightIdStr) : null;
        Integer status = (statusStr != null && !statusStr.isEmpty()) ? Integer.parseInt(statusStr) : null;
        Integer isBooked = (isBookedStr != null && !isBookedStr.isEmpty()) ? Integer.parseInt(isBookedStr) : null;

        // Tính tổng số trang
        int totalRecords = dao.countFilteredSeats(seatId, flightId, status, isBooked);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        int page = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        if (page > totalPages && totalPages > 0) {
            page = totalPages;
        }

        int start = (page - 1) * RECORDS_PER_PAGE;
        List<Seats> searchResults = dao.searchSeats(seatId, flightId, status, isBooked, start, RECORDS_PER_PAGE);

        // Set attributes và forward về JSP
        request.setAttribute("seats", searchResults);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("searchSeatId", seatIdStr);
        request.setAttribute("searchFlightId", flightIdStr);
        request.setAttribute("searchStatus", statusStr);
        request.setAttribute("searchIsBooked", isBookedStr);

        request.getRequestDispatcher("/views/admin/jsp/viewListSeats.jsp").forward(request, response);
    }
}

