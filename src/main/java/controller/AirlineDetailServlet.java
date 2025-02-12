
package controller;

import dal.AirlinesDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airlines;

import java.io.IOException;

@WebServlet("/viewAirline") //
public class AirlineDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        AirlinesDAO airlinesDAO = new AirlinesDAO();

        Airlines airline = new Airlines();
        airline = airlinesDAO.getAirlineById(id);

        if (airline == null) {
            request.setAttribute("error", "Airline not found");
            request.getRequestDispatcher("views/admin/jsp/update.jsp").forward(request, response);
        }else{
            request.setAttribute("airline", airline);
            request.getRequestDispatcher("views/admin/jsp/viewDetailAirline.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        response.getWriter().println("<h1>Xin chào từ TemplateServlet!</h1>");
    }
}
