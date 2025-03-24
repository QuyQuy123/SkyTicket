package controller;

import dal.AirportsDAO;
import dal.CountriesDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Countries;
import model.Locations;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/listCountriesURL")
public class CountriesList extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 6;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CountriesDAO countryDAO = new CountriesDAO();

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

        int totalRecords = countryDAO.getTotalRecords();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);


        if (page > totalPages) page = totalPages;

        List<Countries> listCountries = countryDAO.getCountriesByPage((page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);


        if (listCountries.isEmpty() && page > 1) {
            page--;
            listCountries = countryDAO.getCountriesByPage((page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }

        request.setAttribute("countries", listCountries);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/jsp/viewListCountries.jsp").forward(request, response);
    }
}
