package controller;

import dal.AirlinesDAO;
import dal.BaggageDAO;
import dal.RolesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airlines;
import model.Baggages;
import model.Roles;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "RolesSearch", value = "/rolesSearch")
public class RolesSearch extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 5;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RolesDAO rolesDAO = new RolesDAO();

        // Lấy tham số RoleID (nếu có)
        String roleIdStr = request.getParameter("RoleID");
        Integer id = null;
        if (roleIdStr != null && !roleIdStr.trim().isEmpty()) {
            try {
                id = Integer.parseInt(roleIdStr);
            } catch (NumberFormatException e) {
                id = null; // Nếu RoleID không hợp lệ, bỏ qua tìm kiếm theo ID
            }
        }

        // Lấy tham số page cho phân trang
        int currentPage = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.trim().isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                currentPage = 1; // Nếu page không hợp lệ, về trang 1
            }
        }

        // Tính toán phân trang và lấy danh sách roles
        List<Roles> rolesList;
        int totalRecords;
        int totalPages;

        if (id != null) {
            // Nếu có RoleID, tìm kiếm theo ID mà không phân trang
            rolesList = rolesDAO.getRolesById1(id);
            totalRecords = rolesList.size(); // Số bản ghi dựa trên kết quả tìm kiếm
            totalPages = 1; // Không phân trang khi tìm kiếm
        } else {
            // Nếu không có RoleID, lấy toàn bộ danh sách roles với phân trang
            totalRecords = rolesDAO.getTotalRoles();
            totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);

            // Đảm bảo currentPage nằm trong phạm vi hợp lệ
            if (currentPage < 1) {
                currentPage = 1;
            } else if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }

            // Lấy danh sách roles theo trang
            int start = (currentPage - 1) * RECORDS_PER_PAGE;
            rolesList = rolesDAO.getRolesPaginated(start, RECORDS_PER_PAGE); // Cần thêm phương thức này trong RolesDAO
        }

        // Gửi dữ liệu về JSP
        request.setAttribute("listRoles", rolesList);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);

        request.getRequestDispatcher("/views/admin/jsp/viewListRoles.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}