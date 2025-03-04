package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "VerifyOTP", urlPatterns = "/VerifyOTPURL")
public class VerifyOTP extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String sessionOTP = (String) session.getAttribute("otp");
        String userOTP = request.getParameter("otp");

        if (sessionOTP != null && sessionOTP.equals(userOTP)) {
            // OTP đúng, chuyển đến trang nhập mật khẩu mới
            request.getRequestDispatcher("views/public/NewPassword.jsp").forward(request, response);
        } else {
            // OTP sai, quay lại trang nhập OTP với thông báo lỗi
            request.setAttribute("error", "Invalid OTP. Please try again.");
            request.getRequestDispatcher("views/public/EnterOTP.jsp").forward(request, response);
        }
    }
}