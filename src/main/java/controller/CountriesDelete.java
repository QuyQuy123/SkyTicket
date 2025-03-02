package controller;

import dal.AirlinesDAO;
import dal.CountriesDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/deleteCountry")
public class CountriesDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        try {
            // Lấy action và id từ request
            String action = req.getParameter("action");
            String idParam = req.getParameter("id");

            // Kiểm tra tham số hợp lệ
            if (idParam == null || action == null) {
                session.setAttribute("message", "Invalid request parameters.");
                resp.sendRedirect(req.getContextPath() + "/listCountriesURL");
                return;
            }

            int id = Integer.parseInt(idParam);
            CountriesDAO countriesDAO = new CountriesDAO();
            boolean result = false;

            // Xử lý theo action
            if ("deactivate".equals(action)) {
                result = countriesDAO.updateCountryStatus(id, 0);
                session.setAttribute("message", result ? "Country deactivated successfully!" : "Failed to deactivate Country.");
            } else if ("restore".equals(action)) {
                result = countriesDAO.updateCountryStatus(id, 1);
                session.setAttribute("message", result ? "Country restored successfully!" : "Failed to restore Country.");
            } else {
                session.setAttribute("message", "Invalid action.");
            }

            // Chuyển hướng về danh sách Country
            resp.sendRedirect(req.getContextPath() + "/listCountriesURL");
        } catch (NumberFormatException e) {
            session.setAttribute("message", "Invalid Country ID.");
            resp.sendRedirect(req.getContextPath() + "/listCountriesURL");
        } catch (Exception e) {
            session.setAttribute("message", "An error occurred while processing.");
            resp.sendRedirect(req.getContextPath() + "/listCountriesURL");
        }
    }
}
