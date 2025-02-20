package controller;

import dal.RegisterDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Accounts;

import java.io.IOException;

@WebServlet(name = "VerifyController", urlPatterns = {"/VerifyURL"})

public class VerifyController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("views/public/VerifyOTP.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String pass = request.getParameter("pass");

        String userInputOTP = request.getParameter("otpcode");
        String generatedOTP = request.getParameter("genotp");
        if (generatedOTP != null && generatedOTP.equals(userInputOTP)) {

            RegisterDAO d = new RegisterDAO();
            Accounts a = new Accounts(name, email, pass, phoneNumber,"defaultlogo.jpg",2);
            d.addNewAccount(a);
            request.setAttribute("notice", "Register successfully, please login");
            request.getRequestDispatcher("views/public/Login.jsp").forward(request, response);
        } else {
            request.setAttribute("otp", generatedOTP);
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("pass", pass);
            request.setAttribute("otpenter", userInputOTP);
            request.setAttribute("error", "Invalid OTP code, try again.");
            request.getRequestDispatcher("views/public/VerifyOTP.jsp").forward(request, response);
        }
    }
}
