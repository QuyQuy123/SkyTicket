package controller;

import dal.AccountDAO;
import dal.LoginDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.UserGoogle;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
@WebServlet(name = "GoogleLoginHandlerController", urlPatterns = {"/LoginGoogle"})
public class GoogleLoginHandlerController extends HttpServlet {
    AccountDAO ad = new AccountDAO();
    LoginDAO ld = new LoginDAO();
    AccountDAO dao = new AccountDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        GoogleLogin gg = new GoogleLogin();
        //String accesstoken = gg.getToken(code);
        String accesstoken = "ya29.a0AXeO80QXAbfi_SzrxdIwSDYiZHUq_hvOTUJKAz0CVY4FfoyK5HnfQXC8BtVq2bnGA9OD_cXfgRopGc5n4M48VMiOX8V1O9tRW_RLkJFDcBuhfQlQRmIeXXDWfzL1c6uWdIiENxJZJrzD9kdfAIvsNesvvLwdGnYkn1jiRGo3aCgYKAXoSAQ8SFQHGX2MiyoIjNZ9uCvSKYy4pl2_AIQ0175";



        UserGoogle data = gg.getUserInfo(accesstoken);
        UserGoogle acc = new UserGoogle(data.getName(), data.getEmail(),"123456", data.getPhoneNumber(),
                "img/member.jpg", 2, 1);

        if (!dao.checkEmailExists(data.getEmail())) {
            dao.addNewGoogleAccount(acc);}
//        } else if (ld.checkStatus(data.getEmail())) {
//            request.setAttribute("error", "Tài khoản của bạn đã bị khóa");
//            request.getRequestDispatcher("views/public/Login.jsp").forward(request, response);
//        }
        int id = ad.getIdByEmailOrPhoneNumber(acc.getEmail());
        session.setAttribute("id", id);
        response.sendRedirect("home");

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            processRequest(req,resp);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }



}
