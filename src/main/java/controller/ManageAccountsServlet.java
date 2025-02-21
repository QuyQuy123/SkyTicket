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

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet("/manageAccount")
public class ManageAccountsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "/img";
    private static final int RECORDS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AccountDAO accountDAO = new AccountDAO();
        RolesDAO rolesDAO = new RolesDAO();
        List<Roles> rolesList = rolesDAO.getAllRoles();
        request.setAttribute("rolesList", rolesList);

        String action = request.getParameter("action");

        if ("view".equals(action)) {
            int page = 1;
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

            // Tính vị trí bắt đầu của dữ liệu
            int start = (page - 1) * RECORDS_PER_PAGE;

            // Lấy danh sách tài khoản theo trang
            List<Accounts> accountList = accountDAO.getAccountsByPage(start, RECORDS_PER_PAGE);
            int totalRecords = accountDAO.getTotalAccounts();
            int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

            request.setAttribute("accountList", accountList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("/views/admin/jsp/viewListAccounts.jsp").forward(request, response);

        } else if ("viewDetail".equals(action)) {
            // Hiển thị form sửa tài khoản
            int accountId = Integer.parseInt(request.getParameter("id"));
            Accounts account = accountDAO.getAccountsById(accountId);

            request.setAttribute("account", account);
            request.getRequestDispatcher("/views/admin/jsp/viewDetailAccount.jsp").forward(request, response);

        } else if ("update".equals(action)) {
            // Hiển thị form sửa tài khoản
            int accountId = Integer.parseInt(request.getParameter("id"));
            Accounts account = accountDAO.getAccountsById(accountId);

            request.setAttribute("account", account);
            request.getRequestDispatcher("/views/admin/jsp/updateAccount.jsp").forward(request, response);

        } else if ("delete".equals(action)) {
            // Xóa tài khoản
            int accountId = Integer.parseInt(request.getParameter("id"));
            boolean isDeleted = accountDAO.updateAccountStatus(accountId,0);

            request.setAttribute("msg", isDeleted ? "Deleted successfully!" : "Delete failed!");
            response.sendRedirect("manageAccount?action=view");

        } else if ("restore".equals(action)) {
            // restore tài khoản
            int accountId = Integer.parseInt(request.getParameter("id"));
            boolean isDeleted = accountDAO.updateAccountStatus(accountId,1);

            request.setAttribute("msg", isDeleted ? "Restore successfully!" : "Restore failed!");
            response.sendRedirect("manageAccount?action=view");
        } else {
            // Mặc định chuyển đến trang thêm tài khoản
            request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO accountDAO = new AccountDAO();
        RolesDAO rolesDAO = new RolesDAO();
        List<Roles> rolesList = rolesDAO.getAllRoles();
        request.setAttribute("rolesList", rolesList);

        String action = request.getParameter("action");

        if ("update".equals(action)) {

            // Nhận dữ liệu từ form

            String password = request.getParameter("password");


            try {
                int status = Integer.parseInt(request.getParameter("status"));
                int roleId = Integer.parseInt(request.getParameter("roleId"));

                // Kiểm tra null hoặc trống
                if (password == null || password.isEmpty() ) {
                    request.setAttribute("msg", "Missing required fields!");
                    request.getRequestDispatcher("/views/admin/jsp/updateAccount.jsp").forward(request, response);
                    return;
                }


                System.out.println("status: " + status);
                System.out.println("roleId: " + roleId);


                // Sửa tài khoản
                int accountId = Integer.parseInt(request.getParameter("accountId"));
                System.out.println("id: : " + accountId);
                Accounts account = accountDAO.getAccountsById(accountId);


                account.setPassword(password);
                account.setRoleId(roleId);
                account.setStatus(status);

                boolean isUpdated = accountDAO.updateAccount(account);

                request.setAttribute("msg", isUpdated ? "Account updated successfully!" : "Update failed!");

                request.setAttribute("account", account);
                request.getRequestDispatcher("/views/admin/jsp/updateAccount.jsp").forward(request, response);

            } catch (NumberFormatException ex) {
                request.setAttribute("msg", "Invalid input format!");
                request.getRequestDispatcher("/views/admin/jsp/updateAccount.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("msg", "Unexpected error: " + e.getMessage());
                request.getRequestDispatcher("/views/admin/jsp/updateAccount.jsp").forward(request, response);
            }

        } else {
            // Nhận dữ liệu từ form
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String dobStr = request.getParameter("dob");

            Date dob = null;
            if (dobStr != null && !dobStr.isEmpty()) {
                try {
                    dob = Date.valueOf(dobStr);
                } catch (IllegalArgumentException e) {
                    request.setAttribute("msg", "Invalid date format!");
                    request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
                    return;
                }
            }

            try {
                int status = Integer.parseInt(request.getParameter("status"));
                int roleId = Integer.parseInt(request.getParameter("roleId"));

                // Kiểm tra null hoặc trống
                if (fullName == null || fullName.isEmpty() ||
                        email == null || email.isEmpty() ||
                        password == null || password.isEmpty() ||
                        phone == null || phone.isEmpty() ||
                        address == null || address.isEmpty() ||
                        dob == null) {
                    request.setAttribute("msg", "Missing required fields!");
                    request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
                    return;
                }

                // Xử lý file upload
                Part filePart = request.getPart("accountImg");
                String fileName = request.getParameter("oldImage"); // Lấy file cũ mặc định

                if (filePart != null && filePart.getSize() > 0) {  // Nếu có file mới
                    fileName = filePart.getSubmittedFileName();
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs(); // Tạo thư mục nếu chưa có
                    }

                    String filePath = uploadPath + File.separator + fileName;
                    filePart.write(filePath);
                }

                System.out.println("fullName: " + fullName);
                System.out.println("email: " + email);
                System.out.println("password: " + password);
                System.out.println("phone: " + phone);
                System.out.println("address: " + address);
                System.out.println("fileName: " + fileName);
                System.out.println("dob: " + dob);
                System.out.println("status: " + status);
                System.out.println("roleId: " + roleId);


                // Thêm tài khoản
                Accounts account = new Accounts(fullName, email, password, phone, address, fileName, dob, status, roleId);
                boolean isAdded = accountDAO.addAccount(account);

                request.setAttribute("msg", isAdded ? "Add account successfully!" : "Add account failed!");



                request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);

            } catch (NumberFormatException ex) {
                request.setAttribute("msg", "Invalid input format!");
                request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("msg", "Unexpected error: " + e.getMessage());
                request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
            }

        }
    }
}
