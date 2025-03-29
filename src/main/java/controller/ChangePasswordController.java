package controller;

import dal.AccountDAO;
import dal.LoginDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Accounts;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
@WebServlet(name = "ChangePaswordController", urlPatterns = {"/changePaswordURL"})
public class ChangePasswordController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        AccountDAO ad = new AccountDAO();

        String errorCurrent = (String) session.getAttribute("errorCurrent");
        String errorNew = (String) session.getAttribute("errorNew");

        if (errorCurrent != null) {
            request.setAttribute("error", errorCurrent);
            session.removeAttribute("errorCurrent");
        }
        if (errorNew != null) {
            request.setAttribute("errorNew", errorNew);
            session.removeAttribute("errorNew");
        }

        int id = (int) session.getAttribute("id");
        Accounts acc = ad.getAccountsById(id);
        request.setAttribute("account", acc);
        request.getRequestDispatcher("views/customer/changePasword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AccountDAO ad = new AccountDAO();
        LoginDAO login = new LoginDAO();
        HttpSession session = request.getSession();

        String newPass = request.getParameter("newPass");
        String newPass2 = request.getParameter("newPass2");
        String currentPass = request.getParameter("currentPassword");

        int id = (int) session.getAttribute("id");
        Accounts acc = ad.getAccountsById(id);

        if (login.checkPassword(acc.getEmail(), currentPass)) {
            session.setAttribute("errorCurrent", "Current password incorrect, please enter password again!");
            response.sendRedirect("changePaswordURL");
            return;
        }

        if (!newPass.equals(newPass2)) {
            session.setAttribute("errorNew", "Re-entered password does not match new password, please try again!");
            response.sendRedirect("changePaswordURL");
            return;
        }

        ad.changePassword(String.valueOf(id), newPass);

        request.setAttribute("account", acc);
        request.getRequestDispatcher("views/customer/ChangePassSuccess.jsp").forward(request, response);
    }

}
