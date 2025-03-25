package controller;

import dal.AirlinesDAO;
import dal.BaggageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airlines;
import model.Baggages;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BaggagesSearch", value = "/baggagesSearch")
public class BaggagesSearch extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 10;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BaggageDAO baggageDAO = new BaggageDAO();
        AirlinesDAO airlinesDAO = new AirlinesDAO();

        // Lấy các tham số từ request
        String baggageId = request.getParameter("BaggageID");
        String airlinesName = request.getParameter("AirlineName");
        String orderWeight = request.getParameter("orderWeight");
        String orderPrice = request.getParameter("orderPrice");

        // Xử lý trang hiện tại
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            try {
                currentPage = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                currentPage = 1; // Nếu lỗi, về trang đầu tiên
            }
        }

        // Tính tổng số bản ghi dựa trên kết quả lọc
        int totalRecords = baggageDAO.getTotalRecordsFiltered(baggageId, airlinesName);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Đảm bảo currentPage nằm trong phạm vi hợp lệ
        if (currentPage < 1) {
            currentPage = 1;
        } else if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages; // Không cho vượt quá tổng số trang (trừ khi totalPages = 0)
        }

        // Lấy danh sách hành lý đã lọc
        List<Baggages> baggages = baggageDAO.searchBaggages(baggageId, airlinesName, orderWeight, orderPrice, currentPage, RECORDS_PER_PAGE);
        List<Airlines> airlines = airlinesDAO.getAllAirlines();

        // Đặt các thuộc tính để gửi về JSP
        request.setAttribute("baggages", baggages);
        request.setAttribute("airlines", airlines);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        // Lưu các tham số lọc để JSP có thể sử dụng trong liên kết phân trang
        request.setAttribute("baggageId", baggageId);
        request.setAttribute("airlinesName", airlinesName);
        request.setAttribute("orderWeight", orderWeight);
        request.setAttribute("orderPrice", orderPrice);

        request.getRequestDispatcher("/views/admin/jsp/viewListBaggages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Gọi lại doGet nếu cần xử lý POST
    }
}