package controller;

import dal.AccountDAO;
import dal.RolesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Accounts;
import model.Roles;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.List;

@WebServlet("/manageAccount")
public class ManageAccountsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "img";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RolesDAO rolesDAO = new RolesDAO();
        List<Roles> rolesList = rolesDAO.getAllRoles();

        request.setAttribute("rolesList", rolesList);
        request.getRequestDispatcher( "/views/admin/jsp/addAccount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Nhận dữ liệu từ form
        String fullName = request.getParameter("fullName");
        String dobStr = request.getParameter("dob");
        Date dob = Date.valueOf(dobStr);
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        int status = Integer.parseInt(request.getParameter("status"));
        int roleId = Integer.parseInt(request.getParameter("roleId"));



        // Xử lý file upload
        Part filePart = request.getPart("accountImg");
        String fileName = "";

        if (filePart != null && filePart.getSize() > 0) {  // Chỉ xử lý nếu có file mới
            fileName = filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs(); // Tạo thư mục nếu chưa có

            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
        } else {
            fileName = request.getParameter("oldImage"); // Lấy tên file cũ từ request
        }

        // Gọi DAO để lưu vào database
        AccountDAO accountDAO = new AccountDAO();
        boolean isAdded = accountDAO.addAccount(new Accounts(fullName, email, password, phone, address, fileName, dob, status, roleId));

        // Chuyển hướng hoặc hiển thị thông báo
        if (isAdded) {
            request.setAttribute("msg", "Thêm tài khoản thành công!");
        } else {
            request.setAttribute("msg", "Thêm tài khoản thất bại!");
        }

        // Quay lại trang Add Account
        request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
    }

}
