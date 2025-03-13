package controller;


import dal.AccountDAO;
import dal.LocationsDAO;
import dal.PassengersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Locations;
import model.Passengers;

import java.io.IOException;

@WebServlet("/viewPassenger")
public class PassengersDetail extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        PassengersDAO passengersDAO = new PassengersDAO();
        AccountDAO accountDAO = new AccountDAO();

        Passengers passengers = new Passengers();
        passengers = passengersDAO.getPassengerById(id);

        if (passengers == null) {
            req.setAttribute("error", "Passenger not found");
            req.getRequestDispatcher("views/admin/jsp/viewListPassengers.jsp").forward(req, resp);
        }else{
            req.setAttribute("passenger", passengers);
            req.setAttribute("account", accountDAO.getAccountsById(passengers.getAccountID()));
            req.getRequestDispatcher("views/admin/jsp/viewDetailPassenger.jsp").forward(req, resp);
        }
    }
}
