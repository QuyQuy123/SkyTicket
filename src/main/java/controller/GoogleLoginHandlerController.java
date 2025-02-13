package controller;

import dal.AccountDAO;
import dal.LoginDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.UserGoogle;

import java.io.IOException;

public class GoogleLoginHandlerController extends HttpServlet {
    AccountDAO ad = new AccountDAO();
    LoginDAO ld = new LoginDAO();
    AccountDAO dao = new AccountDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        GoogleLogin gg = new GoogleLogin();
        String accesstoken = gg.getToken(code);
        UserGoogle data = gg.getUserInfo(accesstoken);
        UserGoogle acc = new UserGoogle(data.getName(), data.getEmail(), "KIymfC4XfLDNFnygtZuXNQ==", "0000000000", "img/jack.png", 3, 1, new Timestamp(System.currentTimeMillis()), 1);

        if (!dao.checkEmailExisted(data.getEmail())) {
            dao.addNewGoogleAccount(acc);
        } else if (ld.checkStatus(data.getEmail())) {
            request.setAttribute("error", "Tài khoản của bạn đã bị khóa");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        }
        int id = ad.getIdByEmailOrPhoneNumber(acc.getEmail());
        session.setAttribute("id", id);
        response.sendRedirect("home");

    }


}
