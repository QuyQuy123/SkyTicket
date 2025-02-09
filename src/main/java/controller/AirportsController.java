package controller;

import dal.ListAirportsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airports;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


@WebServlet(name = "AirportsController", urlPatterns = {"/AirportURL"})
public class AirportsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        ListAirportsDAO dao = new ListAirportsDAO();
        try(PrintWriter out = resp.getWriter()) {
            String service = req.getParameter("service");
            if(service == null) {
                service = "listAll";
            }
            if(service.equals("listAll")) {
                    String submit = req.getParameter("submit");
                    String sql = "select * from airports";
                    if(submit != null) {
                        String locate = req.getParameter("airport");
                        sql = "SELECT * FROM airports WHERE Location LIKE '%" + locate + "%'";
                    }
                    List<Airports> listAirports = dao.getAllAirports(sql);
                    req.setAttribute("airports", listAirports);
                    req.getRequestDispatcher("views/public/ListAirports.jsp").forward(req, resp);

            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
