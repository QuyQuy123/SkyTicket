package controller;

import dal.AccountDAO;
import dal.RolesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Accounts;
import model.Roles;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchAccount")
public class AccountsSearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int RECORDS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO accountDAO = new AccountDAO();
        RolesDAO rolesDAO = new RolesDAO();
        List<Roles> rolesList = rolesDAO.getAllRoles();
        request.setAttribute("rolesList", rolesList);

        // Lấy tham số tìm kiếm từ form
        String search = request.getParameter("search");
        String roleIdStr = request.getParameter("roleId");
        String statusStr = request.getParameter("status");
        String pageStr = request.getParameter("page");

        Integer roleId = (roleIdStr != null && !roleIdStr.isEmpty()) ? Integer.parseInt(roleIdStr) : null;
        Integer status = (statusStr != null && !statusStr.isEmpty()) ? Integer.parseInt(statusStr) : null;
        int page = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
        int total = RECORDS_PER_PAGE; // Số tài khoản trên mỗi trang
        int start = (page - 1) * total;

        // Lấy danh sách tài khoản
        List<Accounts> accounts = accountDAO.searchAccounts(search, roleId, status, start, total);
        int totalAccounts = accountDAO.countFilteredAccounts(search, roleId, status);
        int totalPages = (int) Math.ceil((double) totalAccounts / total);

        // Gửi dữ liệu qua JSP
        request.setAttribute("accountList", accounts);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("search", search);
        request.setAttribute("roleId", roleId);
        request.setAttribute("status", status);
        request.setAttribute("searchpage", "page");

        request.getRequestDispatcher("views/admin/jsp/viewListAccounts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.getWriter().println("<h1>Xin chào từ TemplateServlet!</h1>");
    }
}
