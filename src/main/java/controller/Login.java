package controller;

import dal.AccountDAO;
import dal.LoginDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Accounts;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "Login", urlPatterns = {"/LoginURL"})
public class Login extends HttpServlet {

    private static final String LOGIN_VIEW = "views/public/Login.jsp";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher(LOGIN_VIEW).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {

            String u = request.getParameter("username").trim();
            String p = request.getParameter("password");
            String r = request.getParameter("rem");


//            String encode = ec.encryptAES(p, SECRET_KEY);

            LoginDAO ld = new LoginDAO();
            AccountDAO ad = new AccountDAO();
            HttpSession session = request.getSession();
            if (!ld.checkUsername(u)) {
                request.setAttribute("error", "Your account does not exist!");
                request.getRequestDispatcher(LOGIN_VIEW).forward(request, response);
            } else if (!ld.checkPassword(u, p)) {
                request.setAttribute("error", "Your password is incorrect!");
                request.getRequestDispatcher(LOGIN_VIEW).forward(request, response);

            } else {
                Cookie cu = new Cookie("cuser", u);
                Cookie cp = new Cookie("cpass", p);
                Cookie cr = new Cookie("crem", r);
                if (r != null) {
                    cu.setMaxAge(60 * 60 * 24 * 7);//7 days
                    cp.setMaxAge(60 * 60 * 24 * 7);
                    cr.setMaxAge(60 * 60 * 24 * 7);
                } else {
                    cu.setMaxAge(0);
                    cp.setMaxAge(0);
                    cr.setMaxAge(0);
                }
                //save to browser
                response.addCookie(cu);
                response.addCookie(cp);
                response.addCookie(cr);
                int id = ad.getIdByEmailOrPhoneNumber(u);
                session.setAttribute("id", id);
                response.sendRedirect("home");
            }
        } catch (Exception ex) {
        }
    }
}
