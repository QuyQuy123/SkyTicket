package dal;

import model.Airports;

import java.sql.SQLException;
import java.sql.PreparedStatement;

public class AirportsDAO extends DBConnect {

    public int insertAirport(Airports ap) {
        int n = 0;
        String sql = "INSERT INTO `skytickets`.`airports`\n" +
                "(`AirportId`,\n" +
                "`AirportName`,\n" +
                "`LocationId`)\n" +
                "VALUES (?,?,?);";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, ap.getAirportId());
            ps.setString(2, ap.getAirportName());
            ps.setInt(3, ap.getLocationId());
            n = ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return n;
    }

    public static void main(String[] args) {
        AirportsDAO dao = new AirportsDAO();
        Airports ap = new Airports(7,1, 7, "Phú Quốc International Airports");
        int n = dao.insertAirport(ap);
        if(n > 0){
            System.out.println("Inserted " + n + " airports");
        }else
            System.out.println("Insertion failed");
    }
}
