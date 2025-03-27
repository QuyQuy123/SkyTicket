package controller;

import dal.BaggageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BaggagesDelete", value = "/deleteBaggage")
public class BaggagesDelete extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String baggageIdStr = request.getParameter("id");
        // Lấy số trang hiện tại từ parameter
        String currentPageStr = request.getParameter("page");
        int currentPage = 1; // Default là trang 1

        if (currentPageStr != null) {
            try {
                currentPage = Integer.parseInt(currentPageStr);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        try {
            int baggageId = Integer.parseInt(baggageIdStr);
            BaggageDAO baggageDAO = new BaggageDAO();
            boolean success = baggageDAO.deleteBaggageById(baggageId);

            String message = success ? "Baggage deleted successfully!" : "Failed to delete baggage!";
            // Redirect về trang list với page hiện tại
            response.sendRedirect(request.getContextPath() + "/BaggagesList?page=" + currentPage +
                    "&message=" + java.net.URLEncoder.encode(message, "UTF-8"));

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/BaggagesList?page=" + currentPage +
                    "&message=" + java.net.URLEncoder.encode("Invalid baggage ID!", "UTF-8"));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}