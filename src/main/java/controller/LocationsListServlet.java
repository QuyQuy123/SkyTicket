package controller;

import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Locations;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = "/listLocationsURL")
public class LocationsListServlet extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 8;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LocationsDAO locationsDAO = new LocationsDAO();

        // Xác định trang hiện tại
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Tính vị trí bắt đầu của dữ liệu
        int start = (page - 1) * RECORDS_PER_PAGE;

        // Lấy danh sách airlines theo trang
        List<Locations> listLocations = locationsDAO.getLocationsByPage(start, RECORDS_PER_PAGE);
        int totalRecords = locationsDAO.getTotalLocations();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);


        request.setAttribute("listLocations", listLocations);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/views/admin/jsp/viewListLocations.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
