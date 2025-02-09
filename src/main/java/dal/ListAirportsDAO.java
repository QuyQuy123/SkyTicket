package dal;

import model.Airports;

import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class ListAirportsDAO extends  DBConnect{

    public List<Airports> getAllAirports(String sql){
        List<Airports> list = new ArrayList<>();
        try(PreparedStatement ps = connection.prepareStatement(sql);ResultSet rs = ps.executeQuery()) {
            while(rs.next()){
                Airports airports = new Airports();
                airports.setAirportId(rs.getInt("AirportId"));
                airports.setAirportName(rs.getString("AirportName"));
                airports.setLocationId(rs.getInt("LocationId"));
                airports.setStatus(rs.getInt("Status"));
                list.add(airports);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }

        return list;

    }
    public static void main(String[] args) {
      ListAirportsDAO dao = new ListAirportsDAO();
        List<Airports> airports = dao.getAllAirports("select * from Airports");

        for (Airports airport : airports) {
            System.out.println("Airport ID: " + airport.getAirportId() + ", Name: " + airport.getAirportName());
        }
    }











}
