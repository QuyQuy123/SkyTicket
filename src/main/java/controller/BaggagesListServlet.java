package controller;

import dal.AirlinesDAO;
import dal.BaggageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airlines;
import model.Baggage;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "BaggagesListServlet", value = "/BaggagesList")
public class BaggagesListServlet extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 10;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BaggageDAO baggageDAO = new BaggageDAO();

        int page = 1;
        String pageStr = request.getParameter("page");

        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Tổng số bản ghi
        int totalRecords = baggageDAO.getTotalRecords();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        if (page > totalPages) page = totalPages;

        // Lấy danh sách hành lý theo trang
        List<Baggage> listBaggages = baggageDAO.getBaggagesByPage((page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);

        // Nếu trang hiện tại không có dữ liệu và lớn hơn 1, giảm trang xuống
        if (listBaggages.isEmpty() && page > 1) {
            page--;
            listBaggages = baggageDAO.getBaggagesByPage((page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }

        request.setAttribute("baggages", listBaggages);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/jsp/viewListBaggages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}