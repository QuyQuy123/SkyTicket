package controller;

import dal.AirlinesDAO;
import dal.BaggageDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Airlines;
import model.Baggages;
import model.Locations;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "BaggageUpdate", value = "/updateBaggage")
public class BaggageUpdate extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        BaggageDAO bdao = new BaggageDAO();
        AirlinesDAO aDao = new AirlinesDAO();

        Baggages baggages = bdao.getBaggageById(id);
        List<Airlines> airlines = aDao.getAllAirlines();
        if(baggages == null){
            request.setAttribute("message", "Baggage not found");
            request.setAttribute("airlines", airlines);
            request.getRequestDispatcher("/views/admin/jsp/updateBaggage.jsp").forward(request, response);
        }else {
            request.setAttribute("baggages", baggages);
            request.setAttribute("airlines", airlines);
            request.getRequestDispatcher("/views/admin/jsp/updateBaggage.jsp").forward(request, response);
        }
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        BaggageDAO baggageDAO = new BaggageDAO();
        AirlinesDAO airlinesDAO = new AirlinesDAO();

        // Lấy dữ liệu từ form
        int baggageId = Integer.parseInt(req.getParameter("baggageId"));
        String weightStr = req.getParameter("Weight");
        String priceStr = req.getParameter("Price");
        int airlineId = Integer.parseInt(req.getParameter("AirlineId"));
        int status = Integer.parseInt(req.getParameter("status"));

        Baggages baggage = baggageDAO.getBaggageById(baggageId);

        // Kiểm tra dữ liệu đầu vào
        if (weightStr == null || weightStr.trim().isEmpty() || priceStr == null || priceStr.trim().isEmpty()) {
            req.setAttribute("error", "Weight and Price cannot be empty!");
            req.setAttribute("baggages", baggage);
            req.setAttribute("airlines", airlinesDAO.getAllAirlines());
            req.getRequestDispatcher("/views/admin/jsp/updateBaggage.jsp").forward(req, resp);
            return;
        }

        // Chuyển đổi dữ liệu
        float weight;
        double price;
        try {
            weight = Float.parseFloat(weightStr);
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Invalid format for Weight or Price!");
            req.setAttribute("baggages", baggage);
            req.setAttribute("airlines", airlinesDAO.getAllAirlines());
            req.getRequestDispatcher("/views/admin/jsp/updateBaggage.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra nếu baggage không tồn tại
        if (baggage == null) {
            req.setAttribute("message", "Baggage not found.");
            req.getRequestDispatcher("/views/admin/jsp/viewListBaggages.jsp").forward(req, resp);
            return;
        }

        // Cập nhật thông tin baggage
        baggage.setWeight(weight);
        baggage.setPrice(price);
        baggage.setAirlineId(airlineId);
        baggage.setStatus(status);

        try {
            boolean success = baggageDAO.updateBaggage(baggage) > 0; // updateBaggage trả về số dòng bị ảnh hưởng
            if (success) {
                req.setAttribute("msg", "Baggage updated successfully!");
                req.setAttribute("baggages", baggage);
                req.setAttribute("airlines", airlinesDAO.getAllAirlines());
                req.getRequestDispatcher("/views/admin/jsp/updateBaggage.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Update failed!");
                req.setAttribute("baggages", baggage);
                req.setAttribute("airlines", airlinesDAO.getAllAirlines());
                req.getRequestDispatcher("/views/admin/jsp/updateBaggage.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.setAttribute("baggages", baggage);
            req.setAttribute("airlines", airlinesDAO.getAllAirlines());
            req.getRequestDispatcher("/views/admin/jsp/updateBaggage.jsp").forward(req, resp);
        }
    }
}