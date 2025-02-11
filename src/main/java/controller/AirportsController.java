package controller;

import dal.AirportsDAO;
import dal.LocationsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Airports;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


@WebServlet(name = "AirportsController", urlPatterns = {"/AirportURL"})
public class AirportsController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        resp.setContentType("text/html");
        AirportsDAO dao = new AirportsDAO();
        try(PrintWriter out = resp.getWriter()) {
            String service = "listAll";

            if(service.equals("listAll")) {
                    String submit = req.getParameter("submit");
                    String sql = "select * from airports";
                    if(submit != null) {
                        String locate = req.getParameter("airportName");
                        sql = "SELECT * \n" +
                                "FROM airports \n" +
                                "WHERE b.LocationName LIKE '%" + locate + "%'";
                    }
                    List<Airports> listAirports = dao.getAllAirportsHieu(sql);
                    session.setAttribute("airports", listAirports);
                   resp.sendRedirect(req.getContextPath() + "/views/admin/jsp/viewListAirports.jsp");
                   // req.getRequestDispatcher("/views/admin/jsp/viewListAirports.jsp").forward(req, resp);

            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
