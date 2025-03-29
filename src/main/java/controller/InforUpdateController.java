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
import java.io.File;

import java.io.IOException;

import java.sql.Date;
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet(name = "InforUpdateController", urlPatterns = {"/updateURL"})
public class InforUpdateController extends HttpServlet {


    private static final String UPLOAD_DIR = "views/customer";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        AccountDAO ad = new AccountDAO();
        try {

            String name = req.getParameter("name");
            String dobStr = req.getParameter("birth");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");
            int id = Integer.parseInt(req.getParameter("id"));

            Part filePart = req.getPart("image");
            String fileName = (filePart != null) ? System.currentTimeMillis() + "_" + filePart.getSubmittedFileName() : null;

            if (fileName == null || fileName.trim().isEmpty() || !fileName.matches(".*\\.(jpg|png|jepg)$")) {
                System.out.println("Invalid file name");
                Accounts updatedAcc = ad.getAccountsById(id);
                req.setAttribute("account", updatedAcc);
                req.setAttribute("error", "Invalid image format");
                req.getRequestDispatcher("views/customer/ViewProfile.jsp").forward(req, resp);
                return;
            }


            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();
            System.out.println("Upload path: " + uploadPath);
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);


            Date dob = Date.valueOf(dobStr);
            System.out.println("dob: " + dob);
            Accounts newAcc = new Accounts(id, name, email, phone, address, fileName, dob);
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









