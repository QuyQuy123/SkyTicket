package controller;

import dal.AirlinesDAO;
import dal.NewsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airlines;
import model.News;

import java.io.IOException;
import java.util.List;

@WebServlet("/viewNews")
public class ViewNewsListServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10; // Số tin tức trên mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        int page = 1; // Mặc định trang đầu tiên
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }

        NewsDAO newsDAO = new NewsDAO();
        int totalRecords = newsDAO.countNews(); // Lấy tổng số tin tức
        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

        List<News> listNews = newsDAO.getNewsPaginated((page - 1) * PAGE_SIZE, PAGE_SIZE);

        request.setAttribute("listNews", listNews);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/jsp/viewListNews.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        String searchKeyword = request.getParameter("search");
        String statusParam = request.getParameter("status");
        Integer status = (statusParam != null && !statusParam.isEmpty()) ? Integer.parseInt(statusParam) : null;

        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }

        NewsDAO newsDAO = new NewsDAO();
        int totalRecords = newsDAO.countNewsByFilter(searchKeyword, status);
        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

        List<News> newsList = newsDAO.searchNewsPaginated(searchKeyword, status, (page - 1) * PAGE_SIZE, PAGE_SIZE);

        request.setAttribute("listNews", newsList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", searchKeyword);
        request.setAttribute("status", status);

        request.getRequestDispatcher("/views/admin/jsp/viewListNews.jsp").forward(request, response);
    }
}


