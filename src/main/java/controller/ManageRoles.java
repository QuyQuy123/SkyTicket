package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dal.RolesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Roles;

@WebServlet(name = "ManageRoles", value = "/manageRoles")
public class ManageRoles extends HttpServlet {
    private static final int RECORDS_PER_PAGE = 5;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        RolesDAO rolesDAO = new RolesDAO();
        if (action == null) {
            action = "list";
        }
        List<Roles> rolesList = rolesDAO.getAllRoles();
        request.setAttribute("rolesList", rolesList);
        switch (action) {
            case "list":
                request.setAttribute("rolesList", rolesDAO.getAllRoles());
                request.getRequestDispatcher("/views/admin/jsp/viewListRoles.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}