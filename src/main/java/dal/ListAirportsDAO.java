package dal;

import model.Airports;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


public class ListAirportsDAO extends  DBConnect{

    public List<Airports> getAllAirports(){
        List<Airports> list = new ArrayList<Airports>();
        String sql = "select * from airports";
        try(PreparedStatement ps = connection.prepareStatement()) {

        }catch (SQLException e){
            e.printStackTrace();
        }


        return list;

    }











}
