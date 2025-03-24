package controller;

import dal.AccountDAO;
import dal.NewsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;

import java.io.IOException;


@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AccountDAO ad = new AccountDAO();
        NewsDAO nw = new NewsDAO();
        HttpSession session = req.getSession();
        session.removeAttribute("flightDetailId2");
        session.removeAttribute("flightDetailId");

        Integer idd = (Integer) session.getAttribute("id");
        int i = (idd != null) ? idd : -1;
        Accounts acc = ad.getAccountsById(i);

        req.setAttribute("account", acc);
        req.setAttribute("listNew", nw.getNews());
        req.getRequestDispatcher("views/public/Home.jsp").forward(req, resp);


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
