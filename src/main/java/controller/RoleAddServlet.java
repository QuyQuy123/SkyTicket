package controller;

import dal.AccountDAO;
import dal.RolesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Accounts;
import model.Roles;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "RoleAddServlet", value = "/addRole")
@MultipartConfig
public class RoleAddServlet extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Khởi tạo RolesDAO
        RolesDAO rolesDAO = new RolesDAO();

        // Tính toán totalPages
        int totalRecords = rolesDAO.getTotalRoles();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

        // Ghi log để kiểm tra
        System.out.println("doGet - Total Records: " + totalRecords + ", Total Pages: " + totalPages);

        // Gửi totalPages về JSP
        request.setAttribute("totalPages", totalPages);

        // Chuyển hướng đến addRole.jsp
        request.getRequestDispatcher("/views/admin/jsp/addRole.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String roleName = request.getParameter("roleName");

        // Khởi tạo RolesDAO để tương tác với cơ sở dữ liệu
        RolesDAO rolesDAO = new RolesDAO();

        // Validate roleName
        String errorMessage = null;

        // 1. Kiểm tra null hoặc rỗng
        if (roleName == null || roleName.trim().isEmpty()) {
            errorMessage = "Role name cannot be empty.";
        }
        // 2. Kiểm tra chỉ chứa chữ cái và khoảng trắng (không chứa số hoặc ký tự đặc biệt)
        else if (!roleName.matches("^[a-zA-Z\\s]+$")) {
            errorMessage = "Role name can only contain letters and spaces (no numbers or special characters).";
        }
        // 3. Kiểm tra roleName đã tồn tại
        else if (rolesDAO.checkRoleNameExists(roleName.trim())) {
            errorMessage = "Role name already exists.";
        }

        // Nếu có lỗi, gửi thông báo lỗi về JSP
        if (errorMessage != null) {
            request.setAttribute("msg", errorMessage);
            request.setAttribute("msgType", "danger"); // Loại thông báo: lỗi

            // Tính lại totalPages để gửi về JSP
            int totalRecords = rolesDAO.getTotalRoles();
            int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);
            System.out.println("doPost (Error) - Total Records: " + totalRecords + ", Total Pages: " + totalPages);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/views/admin/jsp/addRole.jsp").forward(request, response);
            return;
        }

        // Nếu không có lỗi, tạo đối tượng Roles và thêm vào cơ sở dữ liệu
        Roles role = new Roles();
        role.setRoleName(roleName.trim()); // Loại bỏ khoảng trắng thừa

        boolean isAdded = rolesDAO.addRole(role);

        // Kiểm tra kết quả thêm
        if (isAdded) {
            // Nếu thêm thành công, gửi thông báo thành công về JSP
            request.setAttribute("msg", "Role added successfully!");
            request.setAttribute("msgType", "success"); // Loại thông báo: thành công
        } else {
            // Nếu thêm thất bại, gửi thông báo lỗi
            request.setAttribute("msg", "Failed to add role. Please try again.");
            request.setAttribute("msgType", "danger"); // Loại thông báo: lỗi
        }

        // Tính toán lại totalPages sau khi thêm role mới
        int totalRecords = rolesDAO.getTotalRoles();
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);
        System.out.println("doPost (After Add) - Total Records: " + totalRecords + ", Total Pages: " + totalPages);
        request.setAttribute("totalPages", totalPages);

        // Chuyển hướng lại trang addRole.jsp để hiển thị thông báo
        request.getRequestDispatcher("/views/admin/jsp/addRole.jsp").forward(request, response);
    }
}