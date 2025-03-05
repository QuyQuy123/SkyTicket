package controller;

import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UpdatePassword", urlPatterns = "/UpdatePasswordURL")
public class UpdatePassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        AccountDAO ad = new AccountDAO();

        String email = (String) session.getAttribute("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("views/public/NewPassword.jsp").forward(request, response);
        } else {
            int id = ad.findIdByEmail(email);
            ad.changePassword(String.valueOf(id), newPassword);
            session.invalidate(); // Xóa session sau khi hoàn tất
            request.setAttribute("notice", "Enter New Password to Login ");
            request.getRequestDispatcher("views/public/Login.jsp").forward(request, response);
        }
    }
}