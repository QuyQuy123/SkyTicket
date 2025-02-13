package controller;

import dal.AirportsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airports;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AirportSearchServlet", value = "/AirportSearch")
public class AirportSearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy tham số từ form
        String airportName = request.getParameter("name");
        String statusStr = request.getParameter("status");

        // Chuyển đổi status từ String → Integer
        Integer status = (statusStr != null && !statusStr.isEmpty()) ? Integer.parseInt(statusStr) : null;

        // Gọi DAO để tìm kiếm
        AirportsDAO dao = new AirportsDAO();
        List<Airports> searchResults = dao.searchAirports(airportName, status);

        // Đưa kết quả tìm kiếm vào request attribute
        request.setAttribute("airports", searchResults);
        request.setAttribute("searchName", airportName);
        request.setAttribute("searchStatus", statusStr);

        // Forward về JSP để hiển thị kết quả
        request.getRequestDispatcher("/views/admin/jsp/viewListAirports.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}