package controller;

import dal.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Accounts;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.sql.Date;
@WebServlet(name = "InforUpdateController", urlPatterns = {"/updateURL"})
public class InforUpdateController extends HttpServlet {


    private static final String UPLOAD_DIR = "img";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AccountDAO ad = new AccountDAO();
        try {
            String image = "img/" + req.getParameter("image");
            String name = req.getParameter("name");
            String dobStr = req.getParameter("birth");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");
            int id = Integer.parseInt(req.getParameter("id"));

//            Part filePart = req.getPart("image");
//            String fileName = filePart.getSubmittedFileName();
//            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
//            File uploadDir = new File(uploadPath);
//            if (!uploadDir.exists()) uploadDir.mkdir();
//
//            String filePath = uploadPath + File.separator + fileName;
//            filePart.write(filePath);
//
            if (image.equals("img/")) {
                image = ad.getAccountsById(id).getImg();
            }
            Date dob = Date.valueOf(dobStr);
            Accounts newAcc = new Accounts(id, name, email, phone, address, image, dob);
            ad.infoUpdate(newAcc);

            // Lấy lại thông tin tài khoản sau khi update
            Accounts updatedAcc = ad.getAccountsById(id);

            // Đặt thông tin vào requestScope
            req.setAttribute("account", updatedAcc);
            req.setAttribute("successMessage", "Profile updated successfully!");
            req.getRequestDispatcher("views/customer/ViewProfile.jsp").forward(req, resp);

//            resp.sendRedirect("Infor?success=1");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}









