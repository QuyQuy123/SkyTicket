package dal;

import model.Airports;
import model.Flights;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FlightsDAO extends DBConnect {
    public int insertFlight(Flights fl) {
        int n = 0;
        String sql = "INSERT INTO flights "
                + "(FlightId, ArrivalTime, DepartureTime, ArrivalAirportId, DepartureAirportId, Status, AirlineId, ClassVipPrice, ClassEconomyPrice) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, fl.getFlightId());
            pre.setObject(2, fl.getArrivalTime());
            pre.setObject(3, fl.getDepartureTime());
            pre.setInt(4, fl.getArrivalAirportId());
            pre.setInt(5, fl.getDepartureAirportId());
            pre.setString(6, fl.getStatus());
            pre.setInt(7, fl.getAirlineId());
            pre.setDouble(8, fl.getClassVipPrice());
            pre.setDouble(9, fl.getClassEconomyPrice());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return n;
    }

//    public List<Airports> getAllAirports(String sql){
//        List<Airports> list = new ArrayList<>();
//        try(PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
//            while(rs.next()){
//                Airports airports = new Airports();
//                airports.setAirportId(rs.getInt("AirportId"));
//                airports.setAirportName(rs.getString("AirportName"));
//                airports.setLocationId(rs.getInt("LocationId"));
//                airports.setStatus(rs.getInt("Status"));
//                list.add(airports);
//            }
//        }catch (SQLException e){
//            e.printStackTrace();
//        }
//        return list;
//    }
    public List<Flights> getAllFlights(String sql) {
        List<Flights> list = new ArrayList<>();
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Flights flights1 = new Flights();
                flights1.setFlightId(rs.getInt("FlightId"));
                flights1.setArrivalTime(rs.getDate("ArrivalTime"));
                flights1.setDepartureTime(rs.getDate("DepartureTime"));
                flights1.setArrivalAirportId(rs.getInt("ArrivalAirportId"));
                flights1.setDepartureAirportId(rs.getInt("DepartureAirportId"));
                flights1.setStatus(rs.getString("Status"));
                flights1.setAirlineId(rs.getInt("AirlineId"));
                flights1.setClassVipPrice(rs.getDouble("ClassVipPrice"));
                flights1.setClassEconomyPrice(rs.getDouble("ClassEconomyPrice"));
                list.add(flights1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public static void main(String[] args) {
        FlightsDAO dao = new FlightsDAO();
//        List <Flights> fl = dao.getAllFlights("select * from flights");
//        for (Flights fl1 : fl) {
//            System.out.println(fl);
//        }
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

        try {
            Date arrivalTime = new Date(sdf.parse("2/9/2025").getTime());
            Date departureTime = new Date(sdf.parse("5/9/2025").getTime());

            Flights flight = new Flights(1, arrivalTime, departureTime, 1, 1, "GOOD", 999, 5000000, 4000000);
            int n = dao.insertFlight(flight);
            if (n > 0) {
                System.out.println("Inserted flight successfully");
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
