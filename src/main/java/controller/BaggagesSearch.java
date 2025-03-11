package controller;

import dal.BaggageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Baggages;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BaggagesSearch", value = "/baggagesSearch")
public class BaggagesSearch extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 10;
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BaggageDAO baggageDAO = new BaggageDAO();
        String baggageId = request.getParameter("BaggageID");
        String orderWeight = request.getParameter("orderWeight");
        String orderPrice = request.getParameter("orderPrice");

        int currentPage = 1;
        if (request.getParameter("page") != null) {
            try {
                currentPage = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                currentPage = 1; // Nếu lỗi, về trang đầu tiên
            }
        }

        int totalRecords = baggageDAO.getTotalRecords();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Đảm bảo currentPage nằm trong phạm vi hợp lệ
        if (currentPage < 1) {
            currentPage = 1;
        } else if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages; // Không cho vượt quá tổng số trang (trừ khi totalPages = 0)
        }

        List<Baggages> baggages = baggageDAO.searchBaggages(baggageId, orderWeight, orderPrice, currentPage, RECORDS_PER_PAGE);

        request.setAttribute("baggages", baggages);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("/views/admin/jsp/viewListBaggages.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}