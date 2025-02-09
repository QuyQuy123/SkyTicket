package controller;

import dal.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Random;

@WebServlet(name = "ResetPassword", urlPatterns = {"/ResetPassordURL"})
public class ResetPassword extends HttpServlet {

    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000); // 6 chữ số
        return String.valueOf(code);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String resetCode = req.getParameter("resetCode");
        String newPassword = req.getParameter("password");
        String rePassword = req.getParameter("repassword");

        AccountDAO accountDAO = new AccountDAO();
        HttpSession session = req.getSession();

        try {
            // Bước 1: Gửi mã xác thực
            if (email != null) {
                if (!accountDAO.checkEmailExists(email)) {
                    req.setAttribute("error", "Email không tồn tại trong hệ thống!");
                    req.getRequestDispatcher("ResetPassword.jsp").forward(req, resp);
                    return;
                }
                String verificationCode = generateVerificationCode();
                session.setAttribute("resetCode", verificationCode);
                session.setAttribute("resetEmail", email);

                // Gửi email (ở đây có thể tích hợp JavaMail API)
                System.out.println("Mã xác thực: " + verificationCode); // Debug

                req.setAttribute("message", "Mã xác thực đã được gửi đến email của bạn!");
                req.getRequestDispatcher("ResetPassword.jsp").forward(req, resp);
            }

            // Bước 2: Xác minh mã và đặt lại mật khẩu
            if (resetCode != null && newPassword != null && rePassword != null) {
                String storedCode = (String) session.getAttribute("resetCode");
                String storedEmail = (String) session.getAttribute("resetEmail");

                if (storedCode == null || !storedCode.equals(resetCode)) {
                    req.setAttribute("error", "Mã xác thực không đúng!");
                    req.getRequestDispatcher("ResetPassword.jsp").forward(req, resp);
                    return;
                }
                if (!newPassword.equals(rePassword)) {
                    req.setAttribute("error", "Mật khẩu nhập lại không khớp!");
                    req.getRequestDispatcher("ResetPassword.jsp").forward(req, resp);
                    return;
                }

                boolean updated = accountDAO.updatePassword(storedEmail, newPassword);
                if (updated) {
                    session.removeAttribute("resetCode");
                    session.removeAttribute("resetEmail");
                    resp.sendRedirect("Login.jsp?message=Đặt lại mật khẩu thành công!");
                } else {
                    req.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại!");
                    req.getRequestDispatcher("ResetPassword.jsp").forward(req, resp);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
