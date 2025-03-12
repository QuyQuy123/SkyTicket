package controller;

import dal.AirlinesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airlines;

import java.io.IOException;

@WebServlet("/listseats")
public class ListSeatsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        int id = Integer.parseInt(request.getParameter("id"));
        AirlinesDAO airlinesDAO = new AirlinesDAO();
        Airlines airline = airlinesDAO.getAirlineById(id);
        request.setAttribute("airline", airline);
        request.getRequestDispatcher("/views/admin/jsp/seatsMap.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.getWriter().println("<h1>Xin chào từ TemplateServlet!</h1>");
    }
}
