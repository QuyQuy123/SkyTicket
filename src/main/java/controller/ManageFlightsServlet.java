package controller;

import dal.AirlinesDAO;
import dal.AirportsDAO;
import dal.FlightsDAO;
import dal.SeatsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Airlines;
import model.Airports;
import model.Flights;

import java.io.IOException;
import java.util.List;

@WebServlet("/manageFlights") // Định danh Servlet tại URL "/template"
public class ManageFlightsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        AirlinesDAO airlinesDAO = new AirlinesDAO();
        AirportsDAO airportsDAO = new AirportsDAO();
        FlightsDAO flightsDAO = new FlightsDAO();


        if (action == null) {
            action = "list";
        }

        List<Airlines> airlinesList = airlinesDAO.getAllAirlines();
        List<Airports> airportsList = airportsDAO.getAllAirports();

        request.setAttribute("airlinesList", airlinesList);
        request.setAttribute("airportsList", airportsList);

        switch (action) {
            case "add":
                request.setAttribute("flight", null);
                request.setAttribute("isAdd", true);
                request.getRequestDispatcher("/views/admin/jsp/manageFlightsForm.jsp").forward(request, response);
                break;

            case "update":
                int id = Integer.parseInt(request.getParameter("id"));

                Flights flights = flightsDAO.getFlightById(id);
                request.setAttribute("flight", flights);
                request.setAttribute("isUpdate", true);
                request.getRequestDispatcher("/views/admin/jsp/manageFlightsForm.jsp").forward(request, response);
                break;

            case "delete":
                int idDelete = Integer.parseInt(request.getParameter("id"));
                boolean check = flightsDAO.updateFlightStatus(idDelete,0);
                request.setAttribute("msg", check ? "Deleted successfully!" : "Delete failed!");
                response.sendRedirect("/listFlights");
                break;

            case "restore":
                int idRetore = Integer.parseInt(request.getParameter("id"));
                boolean check1 = flightsDAO.updateFlightStatus(idRetore,1);
                request.setAttribute("msg", check1 ? "Restore successfully!" : "Restore failed!");
                response.sendRedirect("/listFlights");
                break;

            default:
                break;

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        AirlinesDAO airlinesDAO = new AirlinesDAO();
        AirportsDAO airportsDAO = new AirportsDAO();
        List<Airlines> airlinesList = airlinesDAO.getAllAirlines();
        List<Airports> airportsList = airportsDAO.getAllAirports();

        request.setAttribute("airlinesList", airlinesList);
        request.setAttribute("airportsList", airportsList);


        if (action == null) {
            action = "list";
        }


        int departureAirport = Integer.parseInt(request.getParameter("departureA"));
        System.out.println("departureAirport: " + departureAirport);
        int arrivalAirport = Integer.parseInt(request.getParameter("arrivalA"));
        System.out.println("arrivalAirport: " + arrivalAirport);

        String departureTime = request.getParameter("departureT");
        System.out.println(departureTime);

        String arrivalTime = request.getParameter("arrivalT");  // "2025-02-25T14:30"
        System.out.println(arrivalTime);


        // Chuyển đổi thành Timestamp
        arrivalTime = arrivalTime.replace("T", " ") + ":00";
        departureTime = departureTime.replace("T", " ") + ":00";

        java.sql.Timestamp sqlArrivalTimestamp = java.sql.Timestamp.valueOf(arrivalTime);
        java.sql.Timestamp sqlDepartureTimestamp = java.sql.Timestamp.valueOf(departureTime);

        double priceVip = Double.parseDouble(request.getParameter("classVip"));
        double priceEconomy = Double.parseDouble(request.getParameter("classEconomy"));
        int status = Integer.parseInt(request.getParameter("status"));
        int airlineId = Integer.parseInt(request.getParameter("airline"));

        FlightsDAO flightsDAO = new FlightsDAO();

        boolean check = false;


        switch (action) {
            case "add":
                request.setAttribute("isAdd", true);
                if(departureAirport == arrivalAirport){
                    request.setAttribute("msg", "Duplicate departure!");
                    request.getRequestDispatcher("/views/admin/jsp/manageFlightsForm.jsp").forward(request, response);
                    break;
                }

                if(!sqlDepartureTimestamp.before(sqlArrivalTimestamp)){
                    request.setAttribute("msg", "Departure time must be before Arrival time!");
                    request.getRequestDispatcher("/views/admin/jsp/manageFlightsForm.jsp").forward(request, response);
                    break;
                }

                Flights fly = new Flights();
                fly.setArrivalAirportId(arrivalAirport);
                fly.setDepartureAirportId(departureAirport);
                fly.setArrivalTime(sqlArrivalTimestamp);  // Lưu vào DB kiểu DATETIME
                fly.setDepartureTime(sqlDepartureTimestamp);
                fly.setClassVipPrice(priceVip);
                fly.setClassEconomyPrice(priceEconomy);
                fly.setStatus(status);
                fly.setAirlineId(airlineId);


                check = flightsDAO.addFlight(fly);


                if (check) {
                    request.setAttribute("msg", "Add flight successfully");
                } else {
                    request.setAttribute("msg", "Add flight failed");
                }
                request.getRequestDispatcher("/views/admin/jsp/manageFlightsForm.jsp").forward(request, response);
                break;

            case "update":

                int id = Integer.parseInt(request.getParameter("id"));
                Flights flyUpdate = flightsDAO.getFlightById(id);

                flyUpdate.setDepartureAirportId(departureAirport);
                System.out.println("de:"+flyUpdate.getDepartureAirportId());

                flyUpdate.setArrivalAirportId(arrivalAirport);
                System.out.println("ar"+flyUpdate.getArrivalAirportId());

                request.setAttribute("isUpdate", true);

                if(departureAirport == arrivalAirport){
                    request.setAttribute("flight", flyUpdate);
                    request.setAttribute("msg", "Duplicate departure!");
                    request.getRequestDispatcher("/views/admin/jsp/manageFlightsForm.jsp").forward(request, response);
                    break;
                }

                if(!sqlDepartureTimestamp.before(sqlArrivalTimestamp)){
                    request.setAttribute("flight", flyUpdate);
                    request.setAttribute("msg", "Departure time must be before Arrival time!");
                    request.getRequestDispatcher("/views/admin/jsp/manageFlightsForm.jsp").forward(request, response);
                    break;
                }


                flyUpdate.setArrivalTime(sqlArrivalTimestamp);  // Lưu vào DB kiểu DATETIME
                flyUpdate.setDepartureTime(sqlDepartureTimestamp);
                flyUpdate.setClassVipPrice(priceVip);
                flyUpdate.setClassEconomyPrice(priceEconomy);
                flyUpdate.setStatus(status);
                flyUpdate.setAirlineId(airlineId);


                check = flightsDAO.updateFlight(flyUpdate);

                request.setAttribute("flight", flyUpdate);


                if (check) {
                    request.setAttribute("msg", "Update flight successfully");
                } else {
                    request.setAttribute("msg", "Update flight failed");
                }
                request.getRequestDispatcher("/views/admin/jsp/manageFlightsForm.jsp").forward(request, response);
                break;

            default:
                break;

        }
    }
}
