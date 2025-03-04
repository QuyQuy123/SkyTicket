package controller;

import dal.AirlinesDAO;
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

@WebServlet("/viewCountry")
public class CountriesDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        CountriesDAO countriesDAO = new CountriesDAO();

        Countries countries = new Countries();
        countries = countriesDAO.getCountryById(id);

        if (countries == null) {
            req.setAttribute("error", "Country not found");
            req.getRequestDispatcher("views/admin/jsp/updateCountry.jsp").forward(req, resp);
        }else{
            req.setAttribute("country", countries);
            req.getRequestDispatcher("views/admin/jsp/viewDetailCountry.jsp").forward(req, resp);
        }
    }
}
