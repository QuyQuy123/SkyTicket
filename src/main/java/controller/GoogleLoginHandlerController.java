package controller;

import dal.AccountDAO;
import dal.LoginDAO;
import jakarta.servlet.http.HttpServlet;

public class GoogleLoginHandlerController extends HttpServlet {
    AccountDAO ad = new AccountDAO();
    LoginDAO ld = new LoginDAO();
    RegisterDAO dao = new RegisterDAO();


}
