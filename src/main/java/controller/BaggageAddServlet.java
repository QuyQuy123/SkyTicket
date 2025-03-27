package controller;

import java.io.IOException;
import java.util.List;

import dal.AirlinesDAO;
import dal.BaggageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Airlines;
import model.Baggages;

@WebServlet(name = "BaggageAddServlet", value = "/addBaggage")
public class BaggageAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AirlinesDAO airlinesDAO = new AirlinesDAO();
        List<Airlines> airlines = airlinesDAO.getAllAirlines();
        request.setAttribute("airlines", airlines);
        request.getRequestDispatcher("/views/admin/jsp/addBaggage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String weightStr = request.getParameter("Weight");
            String priceStr = request.getParameter("Price");
            String airlineIdStr = request.getParameter("airlineId");
            String statusStr = request.getParameter("status");

            if (weightStr == null || priceStr == null || airlineIdStr == null || statusStr == null) {
                request.setAttribute("msg", "All fields are required.");
            } else {
                if (!weightStr.matches("^[0-9]+(\\.?[0-9]+)?$") || !priceStr.matches("^[0-9]+(\\.?[0-9]+)?$")) {
                    request.setAttribute("msg", "Weight and Price must contain only numbers and an optional decimal point.");
                } else {
                    float weight = Float.parseFloat(weightStr);
                    double price = Double.parseDouble(priceStr);
                    int airlineId = Integer.parseInt(airlineIdStr);
                    int status = Integer.parseInt(statusStr);

                    if (weight <= 0 || price <= 0) {
                        request.setAttribute("msg", "Weight and Price must be greater than zero.");
//                    } else if (weight > 100 || price > 10000) {
//                        request.setAttribute("msg", "Weight or Price exceeds allowed limit.");
                    } else {
                        Baggages baggages = new Baggages(weight, price, airlineId, status);
                        BaggageDAO baggagesDAO = new BaggageDAO();
                        int success = baggagesDAO.addBaggage(baggages);

                        if (success > 0) {
                            request.setAttribute("msg", "Baggages added successfully!");
                        } else {
                            request.setAttribute("msg", "Failed to add baggages.");
                        }
                    }
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("msg", "Invalid input format.");
        }

        // Tải danh sách airlines từ DAO
        AirlinesDAO airlinesDAO = new AirlinesDAO();
        List<Airlines> airlineList = airlinesDAO.getAllAirlines(); // Giả sử phương thức này tồn tại
        request.setAttribute("airlines", airlineList);

        // Forward về JSP
        request.getRequestDispatcher("/views/admin/jsp/addBaggage.jsp").forward(request, response);
    }
}