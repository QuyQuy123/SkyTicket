package controller;

import dal.AirlinesDAO;
import dal.BaggageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airlines;
import model.Baggages;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "sortBaggages", value = "/sortBaggages")
public class sortBaggages extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 10;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sortBy = request.getParameter("sortBy");
        String order = request.getParameter("order");

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

        BaggageDAO baggageDAO = new BaggageDAO();
        int totalRecords = baggageDAO.getTotalRecords();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        if (page > totalPages) page = totalPages;

        List<Baggages> baggages = baggageDAO.getSortedBaggage(sortBy, order, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        List<Airlines> airlines = new AirlinesDAO().getAllAirlines();
        if (baggages.isEmpty() && page > 1) {
            page--;
            baggages = baggageDAO.getSortedBaggage(sortBy, order, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }

        request.setAttribute("airlines", airlines);
        request.setAttribute("baggages", baggages);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/views/admin/jsp/viewListBaggages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}