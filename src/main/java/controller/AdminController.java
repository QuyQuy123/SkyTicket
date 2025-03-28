package controller;

import dal.BookingDAO;
import dal.TicketsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.util.Map;

@WebServlet("/dashboardAdmin")
public class AdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        TicketsDAO td = new TicketsDAO();
        BookingDAO bd = new BookingDAO();
        int year = 2025;
        request.getRequestDispatcher("views/admin/jsp/Dashboard.jsp").forward(request, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

}


