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

@WebServlet(name = "InforsController", urlPatterns = {"/Infor"})
public class InforsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        AccountDAO accountDao = new AccountDAO();
        Integer id = (Integer) session.getAttribute("id");
        int i = (id != null) ? id : -1;
        Accounts acc = accountDao.getAccountsById(i);
        req.setAttribute("account", acc);
        req.getRequestDispatcher("views/customer/ViewProfile.jsp").forward(req, resp);
    }



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
