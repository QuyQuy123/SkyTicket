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


@WebServlet("/searchAirlines")
public class AirlinesSearchServlet extends HttpServlet {

    private static final int RECORDS_PER_PAGE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AirlinesDAO airlinesDAO = new AirlinesDAO();

        String searchKeyword = request.getParameter("search");
        String statusParam = request.getParameter("status");

        Integer status = null;
        if (statusParam != null && !statusParam.isEmpty()) {
            try {
                status = Integer.parseInt(statusParam);
            } catch (NumberFormatException e) {
                status = null;
            }
        }


        int page = 1;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }


        int start = (page - 1) * RECORDS_PER_PAGE;


        List<Airlines> listAirlines = airlinesDAO.searchAirlines(searchKeyword, status, start, RECORDS_PER_PAGE);
        int totalRecords = airlinesDAO.countFilteredAirlines(searchKeyword, status);
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);


        request.setAttribute("listAirlines", listAirlines);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", searchKeyword);
        request.setAttribute("status", status);
        request.setAttribute("searchpage", "page");

        request.getRequestDispatcher("/views/admin/jsp/viewListAirlines.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.getWriter().println("<h1>Xin chào từ TemplateServlet!</h1>");
    }
}
