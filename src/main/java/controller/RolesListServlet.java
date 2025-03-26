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

@WebServlet(name = "RolesListServlet", value = "/listRoles")
public class RolesListServlet extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 5;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RolesDAO rolesDAO = new RolesDAO();
        int page = 1;

        String pageStr = request.getParameter("page");
        if (pageStr != null) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            }catch (NumberFormatException e){
                page = 1;
            }
        }

        int totalRecords = rolesDAO.getTotalRoles();
        int totalPages = (int) Math.ceil((double) totalRecords / (double) RECORDS_PER_PAGE);

        if(page > totalPages){page = totalPages;}

        List<Roles> listRoles = rolesDAO.getRolesByPage((page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);

        if(listRoles.isEmpty() && page > 1){
            page--;
            listRoles = rolesDAO.getRolesByPage((page - 1) * RECORDS_PER_PAGE, RECORDS_PER_PAGE);
        }

        request.setAttribute("listRoles", listRoles);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/views/admin/jsp/viewListRoles.jsp").forward(request, response);
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}