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
import java.sql.SQLException;

@WebServlet(name = "Login", urlPatterns = {"/LoginURL"})
public class Login extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String error = " ";

        AccountDAO ad = new AccountDAO();
        Accounts account = null;
        try {
            account = ad.getLogin(username, password);
            if (account == null) {
                error = "Tài khoản hoặc mật khẩu không đúng";
                req.setAttribute("error", error);
                req.getRequestDispatcher("Login.jsp").forward(req, resp);
            } else {
                HttpSession session = req.getSession();
                session.setAttribute("account", account);
                resp.sendRedirect("Home.jsp"); // Điều hướng đến trang chính sau khi đăng nhập thành công
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
