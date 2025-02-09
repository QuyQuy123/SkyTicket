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
