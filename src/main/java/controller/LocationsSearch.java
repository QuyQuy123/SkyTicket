package controller;

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
import java.util.List;

@WebServlet("/searchLocations")
public class LocationsSearch extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 6;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String locationName = req.getParameter("search");
        String statusStr = req.getParameter("status");

        // Chuyển đổi status từ String → Integer
        Integer status = (statusStr != null && !statusStr.isEmpty()) ? Integer.parseInt(statusStr) : null;
        System.out.println("Giá trị:"+status);

        // Xác định số trang hiện tại
        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        LocationsDAO dao = new LocationsDAO();
        CountriesDAO cdao = new CountriesDAO();

        // Lấy danh sách kết quả tìm kiếm theo trang
        List<Locations> searchResults = dao.searchLocationByPage(locationName, status, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        int totalRecords = dao.getTotalSearchRecords(locationName, status);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Nếu page lớn hơn totalPages nhưng không có dữ liệu, đưa về trang cuối cùng có dữ liệu
        if (page > totalPages) page = totalPages;

        // Nếu danh sách tìm kiếm rỗng mà page > 1, quay lại trang trước
        if (searchResults.isEmpty() && page > 1) {
            page--;
            searchResults = dao.searchLocationByPage(locationName, status, (page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }

        // Đưa dữ liệu vào request attribute
        List<Countries> listCountries = cdao.getAllCountries();
        req.setAttribute("countries", listCountries);
        req.setAttribute("locations", searchResults);
        req.setAttribute("searchName", locationName);
        req.setAttribute("searchStatus", statusStr);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/views/admin/jsp/viewListLocations.jsp").forward(req, resp);
    }
}
