package controller;

import dal.AirlinesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Airlines;

import java.io.IOException;
import java.util.List;

@WebServlet("/listAirlines")
public class AirlinesListServlet extends HttpServlet {

    private static final int RECORDS_PER_PAGE = 5; // Số lượng bản ghi mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //HttpSession session = request.getSession();
        AirlinesDAO airlinesDAO = new AirlinesDAO();


        // Xác định trang hiện tại
        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Tính vị trí bắt đầu của dữ liệu
        int start = (page - 1) * RECORDS_PER_PAGE;

        // Lấy danh sách airlines theo trang
        List<Airlines> listAirlines = airlinesDAO.getAirlinesByPage(start, RECORDS_PER_PAGE);
        int totalRecords = airlinesDAO.getTotalAirlines();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);


        request.setAttribute("listAirlines", listAirlines);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        //response.sendRedirect(request.getContextPath() + "/views/admin/jsp/viewListAirlines.jsp");
        request.getRequestDispatcher("/views/admin/jsp/viewListAirlines.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
