package controller;

import dal.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Accounts;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet(name = "Register", urlPatterns = {"/RegisterURL"})
public class Register extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("views/public/Register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullName = req.getParameter("name");
        String dob = req.getParameter("dob");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String rePassword = req.getParameter("rePassword");

        // Kiểm tra mật khẩu nhập lại có trùng khớp không
        if (!password.equals(rePassword)) {
            req.setAttribute("error", "Mật khẩu nhập lại không khớp!");
            req.getRequestDispatcher("views/public/Register.jsp").forward(req, resp);
            return;
        }

        AccountDAO accountDAO = new AccountDAO();

        // Kiểm tra email hoặc số điện thoại đã tồn tại chưa
        try {
            if (accountDAO.getLogin(email, password) != null || accountDAO.getLogin(phone, password) != null) {
                req.setAttribute("error", "Email hoặc số điện thoại đã tồn tại!");
                req.getRequestDispatcher("views/public/Register.jsp").forward(req, resp);
                return;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        // Tạo tài khoản mới
        Accounts newAccount = new Accounts();
        newAccount.setFullName(fullName);
        newAccount.setDob(Date.valueOf(dob));
        newAccount.setPhone(phone);
        newAccount.setEmail(email);
        newAccount.setPassword(password);

        try {
            boolean success = accountDAO.registerAccount(newAccount);
            if (success) {
                resp.sendRedirect("views/public/Login.jsp"); // Chuyển hướng đến trang đăng nhập nếu đăng ký thành công
            } else {
                req.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại!");
                req.getRequestDispatcher("views/public/Register.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}