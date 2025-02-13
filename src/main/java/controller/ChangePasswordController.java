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
        HttpSession session = request.getSession();

        String newPass = request.getParameter("newPass");
        String idAccount = request.getParameter("idAccount");
        String newPass2 = request.getParameter("newPass2");
        String pass = request.getParameter("pass");
        String currentPass = request.getParameter("currentPassword");

        if (!currentPass.equals(pass)) {
//            request.setAttribute("errorCurrent", "Current password don't duplicated, please enter password again !");
            session.setAttribute("errorCurrent", "Current password incorrect, please enter password again !");
            response.sendRedirect("changePaswordURL");
        } else {
            if (!newPass.equals(newPass2)) {
//                request.setAttribute("errorNew", "New password don't duplicated, please enter new password again !");
                session.setAttribute("errorNew", "Re enter password not matches with new password , please enter new password again !");
                response.sendRedirect("changePaswordURL");
            } else {
                ad.changePassword(idAccount, newPass);
                int id = (int) session.getAttribute("id");
                Accounts acc = ad.getAccountsById(id);
                request.setAttribute("account", acc);
                request.getRequestDispatcher("views/customer/ChangePassSuccess.jsp").forward(request, response);

            }
        }

    }
}
