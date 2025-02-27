package controller;

import dal.AirlinesDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/deleteLocation")
public class LocationsDelete extends HttpServlet {
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
                resp.sendRedirect(req.getContextPath() + "/listLocationsURL");
                return;
            }

            int id = Integer.parseInt(idParam);
            LocationsDAO locationsDAO = new LocationsDAO();
            boolean result = false;

            // Xử lý theo action
            if ("deactivate".equals(action)) {
                result = locationsDAO.updateLocationStatus(id, 0);
                session.setAttribute("message", result ? "Location deactivated successfully!" : "Failed to deactivate location.");
            } else if ("restore".equals(action)) {
                result = locationsDAO.updateLocationStatus(id, 1);
                session.setAttribute("message", result ? "Location restored successfully!" : "Failed to restore location.");
            } else {
                session.setAttribute("message", "Invalid action.");
            }

            // Chuyển hướng về danh sách locations
            resp.sendRedirect(req.getContextPath() + "/listLocationsURL");
        } catch (NumberFormatException e) {
            session.setAttribute("message", "Invalid location ID.");
            resp.sendRedirect(req.getContextPath() + "/listLocationsURL");
        } catch (Exception e) {
            session.setAttribute("message", "An error occurred while processing.");
            resp.sendRedirect(req.getContextPath() + "/listLocationsURL");
        }
    }
}
