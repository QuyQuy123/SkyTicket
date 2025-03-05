package controller;

import dal.CountriesDAO;
import model.Countries;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(urlPatterns = {"/CountryAdd"})
public class CountriesAdd extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("views/admin/jsp/addCountry.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        CountriesDAO countriesDAO = new CountriesDAO();

        String countryName = request.getParameter("name").trim();
        int status = request.getParameter("status").equals("active") ? 1 : 0;

        if (countryName.isEmpty()) {
            session.setAttribute("errorMsg", "Country name cannot be empty.");
            response.sendRedirect(request.getContextPath() + "/views/admin/jsp/addCountry.jsp");
            return;
        } else if (!countryName.matches("[a-zA-Z ]+")) {
            session.setAttribute("errorMsg", "Country name cannot be digits.");
            response.sendRedirect(request.getContextPath() + "/views/admin/jsp/addCountry.jsp");
            return;
        }else if (countriesDAO.getIdByCountryName(countryName) != -1) {
            session.setAttribute("errorMsg", "Country name already exists.");
            response.sendRedirect(request.getContextPath() + "/views/admin/jsp/addCountry.jsp");
            return;
        } else {
            Countries countries = new Countries(countryName, status);
            boolean isAdded = countriesDAO.addCountry(countries);

            if (isAdded) {
                session.setAttribute("successMsg", "Country added successfully!");
            } else {
                session.setAttribute("errorMsg", "Failed to add country.");
            }

            response.sendRedirect(request.getContextPath() + "/views/admin/jsp/addCountry.jsp");
        }

    }
}
