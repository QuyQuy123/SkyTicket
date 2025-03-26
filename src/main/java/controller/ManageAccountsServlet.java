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
import java.util.Calendar;
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

    private void saveFormData(HttpServletRequest request, String fullName, String email, String password,
                              String phone, String address, String dobStr) {
        request.setAttribute("fullName", fullName);
        request.setAttribute("email", email);
        request.setAttribute("password", password);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);
        request.setAttribute("dob", dobStr);
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
                if (password == null || password.isEmpty()) {
                    request.setAttribute("msg", "Missing required fields!");
                    request.getRequestDispatcher("/views/admin/jsp/updateAccount.jsp").forward(request, response);
                    return;
                }
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
            String fullName = request.getParameter("fullName") != null ? request.getParameter("fullName").trim() : null;
            String email = request.getParameter("email") != null ? request.getParameter("email").trim() : null;
            String password = request.getParameter("password") != null ? request.getParameter("password").trim() : null;
            String phone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : null;
            String address = request.getParameter("address") != null ? request.getParameter("address").trim() : null;
            String dobStr = request.getParameter("dob");

            // Xử lý ngày sinh và kiểm tra tuổi
            Date dob = null;
            if (dobStr != null && !dobStr.trim().isEmpty()) {
                try {
                    dob = Date.valueOf(dobStr);
                    Calendar today = Calendar.getInstance();
                    Calendar birthDate = Calendar.getInstance();
                    birthDate.setTime(dob);
                    int age = today.get(Calendar.YEAR) - birthDate.get(Calendar.YEAR);
                    if (today.get(Calendar.DAY_OF_YEAR) < birthDate.get(Calendar.DAY_OF_YEAR)) {
                        age--;
                    }
                    if (age < 18) {
                        request.setAttribute("msg", "You must be at least 18 years old!");
                        saveFormData(request, fullName, email, password, phone, address, dobStr);
                        request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
                        return;
                    }
                } catch (IllegalArgumentException e) {
                    request.setAttribute("msg", "Invalid date format!");
                    saveFormData(request, fullName, email, password, phone, address, dobStr);
                    request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
                    return;
                }
            }

            // Kiểm tra Full Name
            if (fullName == null || !fullName.matches("[\\p{L}0-9\\s]+")) {
                request.setAttribute("msg", "Full name can only contain letters, numbers, and spaces!");
                saveFormData(request, fullName, email, password, phone, address, dobStr);
                request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
                return;
            }

            // Kiểm tra Email
            if (email == null || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$")) {
                request.setAttribute("msg", "Invalid email format! Only letters, numbers, and common email characters (.,_+-) are allowed.");
                saveFormData(request, fullName, email, password, phone, address, dobStr);
                request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
                return;
            }

            // Kiểm tra Phone
            if (phone == null || !phone.matches("^[0-9]{10}$")) {
                request.setAttribute("msg", "Phone number must contain exactly 10 digits, no letters or spaces allowed!");
                saveFormData(request, fullName, email, password, phone, address, dobStr);
                request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
                return;
            }

            // Kiểm tra Password
            if (password == null || password.length() <= 8) {
                request.setAttribute("msg", "Password must be at least 8 characters long!");
                saveFormData(request, fullName, email, password, phone, address, dobStr);
                request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
                return;
            }

            // Kiểm tra Address
            if (address == null || address.length() < 5 || address.length() > 100) {
                request.setAttribute("msg", "Address must be between 5 and 100 characters long!");
                saveFormData(request, fullName, email, password, phone, address, dobStr);
                request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
                return;
            }

            try {
                int status = Integer.parseInt(request.getParameter("status"));
                int roleId = Integer.parseInt(request.getParameter("roleId"));

                // Kiểm tra các trường bắt buộc
                if (fullName.isEmpty() || email.isEmpty() || password.isEmpty() ||
                        phone.isEmpty() || address.isEmpty() || dob == null) {
                    request.setAttribute("msg", "Missing required fields!");
                    saveFormData(request, fullName, email, password, phone, address, dobStr);
                    request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
                    return;
                }

                // Xử lý file upload
                Part filePart = request.getPart("accountImg");
                String fileName = request.getParameter("oldImage");

                if (filePart != null && filePart.getSize() > 0) {
                    fileName = filePart.getSubmittedFileName();
                    String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    String filePath = uploadPath + File.separator + fileName;
                    filePart.write(filePath);
                }

                Accounts account = new Accounts(fullName, email, password, phone, address, fileName, dob, status, roleId);
                boolean isAdded = accountDAO.addAccount(account);
                request.setAttribute("msg", isAdded ? "Add account successfully!" : "Add account failed!");
                request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);

            } catch (NumberFormatException ex) {
                request.setAttribute("msg", "Invalid input format!");
                saveFormData(request, fullName, email, password, phone, address, dobStr);
                request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
            } catch (Exception e) {
                request.setAttribute("msg", "Unexpected error: " + e.getMessage());
                saveFormData(request, fullName, email, password, phone, address, dobStr);
                request.getRequestDispatcher("/views/admin/jsp/addAccount.jsp").forward(request, response);
            }
        }
    }

}
