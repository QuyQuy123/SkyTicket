package controller;

import dal.AirlinesDAO;
import dal.CountriesDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Airlines;
import model.Countries;
import model.Locations;

import java.io.File;
import java.io.IOException;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet("/updateCountry")
public class CountriesUpdate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        CountriesDAO countriesDAO = new CountriesDAO();

        Countries countries = new Countries();
        countries = countriesDAO.getCountryById(id);

        if (countries == null) {
            req.setAttribute("error", "Country not found");
            req.getRequestDispatcher("/views/admin/jsp/updateCountry.jsp").forward(req, resp);
        }else{
            req.setAttribute("countries", countries);
            req.getRequestDispatcher("views/admin/jsp/updateCountry.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        CountriesDAO countriesDAO = new CountriesDAO();

        int id = Integer.parseInt(req.getParameter("countryId"));
        String countryName = req.getParameter("name");
        int status = Integer.parseInt(req.getParameter("status"));
        Countries countries = countriesDAO.getCountryById(id);

        if (countryName == null || countryName.trim().isEmpty()) {
            req.setAttribute("error", "Country is not empty!");
            req.setAttribute("countries", countries);
            req.getRequestDispatcher("/views/admin/jsp/updateCountry.jsp").forward(req, resp);
            return;
        } else if (countriesDAO.getIdByCountryName(countryName) != -1 && countriesDAO.getStatus(id) == status) {
            req.setAttribute("error", "Country already exists!");
            req.setAttribute("countries", countries);
            req.getRequestDispatcher("/views/admin/jsp/updateCountry.jsp").forward(req, resp);
            return;
        } else {
            if (countries == null) {
                req.setAttribute("message", "Country not found.");
                req.getRequestDispatcher("/views/admin/jsp/viewListCountries.jsp").forward(req, resp);
                return;
            }

            countries.setCountryName(countryName);
            countries.setStatus(status);

            boolean success = countriesDAO.updateCountry(countries);
            if (success) {
                req.setAttribute("msg", "Country updated successfully!");
                req.setAttribute("countries", countries);
                req.getRequestDispatcher("/views/admin/jsp/updateCountry.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Update failed!");
                req.setAttribute("countries", countries);
                req.getRequestDispatcher("/views/admin/jsp/updateCountry.jsp").forward(req, resp);
            }
        }

    }

}

