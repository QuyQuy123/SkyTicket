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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        NewsDAO newsDAO = new NewsDAO();
        List<News> listNews = newsDAO.getNews();
        request.setAttribute("listNews", listNews);
        request.getRequestDispatcher("/views/admin/jsp/viewListNews.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.getWriter().println("<h1>Xin chào từ TemplateServlet!</h1>");
    }
}
