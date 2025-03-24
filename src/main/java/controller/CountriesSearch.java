package controller;

import dal.CountriesDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Countries;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchCountries")
public class CountriesSearch extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 6;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String countryName = req.getParameter("search");
        String statusStr = req.getParameter("status");


        Integer status = (statusStr != null && !statusStr.isEmpty()) ? Integer.parseInt(statusStr) : null;


        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        CountriesDAO cdao = new CountriesDAO();


        List<Countries> searchResults = cdao.searchCountryByPage(countryName, status, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        int totalRecords = cdao.getTotalSearchRecords(countryName, status);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);


        if (page > totalPages) page = totalPages;


        if (searchResults.isEmpty() && page > 1) {
            page--;
            searchResults = cdao.searchCountryByPage(countryName, status, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }


        req.setAttribute("countries", searchResults);
        req.setAttribute("searchName", countryName);
        req.setAttribute("searchStatus", statusStr);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/views/admin/jsp/viewListCountries.jsp").forward(req, resp);
    }
}
