package controller;


import dal.AccountDAO;
import dal.CountriesDAO;
import dal.LocationsDAO;
import dal.PassengersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Accounts;
import model.Countries;
import model.Locations;
import model.Passengers;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchPassengers")
public class PassengersSearch extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 6;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("search");
        if (keyword == null) keyword = "";

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

        PassengersDAO pdao = new PassengersDAO();
        AccountDAO adao = new AccountDAO();

        List<Passengers> searchResults = pdao.searchPassengerByPage(keyword, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        int totalRecords = pdao.getTotalSearchRecords(keyword);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        if (page > totalPages) page = totalPages;

        if (searchResults.isEmpty() && page > 1) {
            page--;
            searchResults = pdao.searchPassengerByPage(keyword, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }

        List<Accounts> listAccounts = adao.getAllAccounts();
        req.setAttribute("accounts", listAccounts);
        req.setAttribute("passengers", searchResults);
        req.setAttribute("searchKeyword", keyword);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/views/admin/jsp/viewListPassengers.jsp").forward(req, resp);
    }
}
