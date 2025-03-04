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


@WebServlet(name = "SeatsListServlet", value = "/listSeats")
public class SeatsListServlet extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 10;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SeatsDAO seatsDAO = new SeatsDAO();

        int page = 1;
        String pageStr = request.getParameter("page");

        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if(page < 1 ) page = 1;
            }catch (NumberFormatException e) {
                page = 1;
            }
        }

        int totalRecords = seatsDAO.getTotalRecords();
        int totalPages = (int) Math.ceil((double)totalRecords / (double)RECORDS_PER_PAGE);

        if(page > totalPages) page = totalPages;

        List<Seats> listSeats = seatsDAO.getSeatsByPage((page-1)*RECORDS_PER_PAGE, RECORDS_PER_PAGE);

        if(listSeats.isEmpty() && page > 1){
            page --;
            listSeats = seatsDAO.getSeatsByPage((page-1)*RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }

        request.setAttribute("seats", listSeats);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/jsp/viewListSeats.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}