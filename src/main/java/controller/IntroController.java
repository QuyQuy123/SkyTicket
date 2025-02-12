package controller;

import dal.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;

import java.io.IOException;

@WebServlet(name = "IntroController", urlPatterns = {"/IntroURL"})



public class IntroController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        AccountDAO ad = new AccountDAO();
        Integer idd = (Integer) session.getAttribute("id");
        int i = (idd != null) ? idd : -1;
        Accounts acc = ad.getAccountsById(i);

        req.setAttribute("account", acc);
        req.getRequestDispatcher("views/public/Intro.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

}
