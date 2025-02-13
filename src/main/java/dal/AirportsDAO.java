package dal;

import model.Airports;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

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

    public int updateAirport(Airports ap) {
        int n = 0;
        String sql = "UPDATE `skytickets`.`airports`\n" +
                "SET\n" +
                "`AirportId` = ?,\n" +
                "`AirportName` = ?,\n" +
                "`LocationId` = ?,\n" +
                "`Status` = ?\n" +
                "WHERE `AirportId` = ?;";
        try( PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, ap.getAirportId());
            pre.setString(2, ap.getAirportName());
            pre.setInt(3, ap.getLocationId());
            pre.setInt(4, ap.getStatus());
            n = pre.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return n;
    }

    public List<Airports> getAllAirports(){
        String sql = "select * from airports";
        List<Airports> list = new ArrayList<>();
        try(PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
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
    public List<Airports> getAllAirportsHieu(String sql){
        List<Airports> list = new ArrayList<>();
        try(PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
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
        AirportsDAO dao = new AirportsDAO();
//        Airports ap = new Airports(7,1, 7, "Phú Quốc International Airports");
//        int n = dao.insertAirport(ap);
//        if(n > 0){
//            System.out.println("Inserted " + n + " airports");
//        }else
//            System.out.println("Insertion failed");
        //  3. Test lấy danh sách tất cả sân bay
        List<Airports> airportList = dao.getAllAirports();
        System.out.println(" Danh sách sân bay:");
        for (Airports airport : airportList) {
            System.out.println("ID: " + airport.getAirportId() +
                    ", Name: " + airport.getAirportName() +
                    ", Location ID: " + airport.getLocationId() +
                    ", Status: " + airport.getStatus());
        }



    }
}
