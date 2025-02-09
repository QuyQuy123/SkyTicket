package controller;

import dal.NewsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "NewsController", urlPatterns = {"/NewsURL"})
public class NewsController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        NewsDAO nw = new NewsDAO();
        HttpSession session = req.getSession();
        Integer idd = (Integer) session.getAttribute("id");

        if (idd != null) {
            int i = (idd != null) ? idd : -1;
        }
        req.setAttribute("listNew", nw.getNews());
        req.getRequestDispatcher("views/public/News.jsp").forward(req, resp);


    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
