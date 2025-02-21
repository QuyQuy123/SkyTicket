package dal;

import model.Airports;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Statement;
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
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
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

    public List<Airports> getAllAirports() {
        String sql = "select * from airports";
        List<Airports> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Airports airports = new Airports();
                airports.setAirportId(rs.getInt("AirportId"));
                airports.setAirportName(rs.getString("AirportName"));
                airports.setLocationId(rs.getInt("LocationId"));
                airports.setStatus(rs.getInt("Status"));
                list.add(airports);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Airports> getAirportsByPage(int start, int total) {
        List<Airports> list = new ArrayList<>();
        String query = "SELECT * FROM Airports LIMIT ?, ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Airports(
                        rs.getInt("airportId"),
                        rs.getString("airportName"),
                        rs.getInt("LocationId"),
                        rs.getInt("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalAirports() {
        String sql = "select count(*) from airports";
        try {
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public List<Airports> getAllAirportsHieu(String sql) {
        List<Airports> list = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Airports airports = new Airports();
                airports.setAirportId(rs.getInt("AirportId"));
                airports.setAirportName(rs.getString("AirportName"));
                airports.setLocationId(rs.getInt("LocationId"));
                airports.setStatus(rs.getInt("Status"));
                list.add(airports);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int removeAirport(String airportID) {
        int n = 0;
        String sql = "DELETE FROM `skytickets`.`airports`\n" +
                "WHERE AirportId = " + airportID;
        try {
            Statement state = connection.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return n;
    }

    public int addAirport(Airports ap) {
        int n = 0;
        String sql = "INSERT INTO Airports (AirportName, LocationId, Status)\n" +
                "VALUES (?,?,?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, ap.getAirportName());
            pre.setInt(2, ap.getLocationId());
            pre.setInt(3, ap.getStatus());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return n;
    }

    //    public List<Airports> searchAirports(String airportName, Integer status){
//
//        List<Airports> list = new ArrayList<>();
//        String sql = "select * from Airports where 1=1";
//
//        if(airportName != null && !airportName.trim().isEmpty()){
//            sql += " and AirportName like ?";
//        }
//        if(status != null){
//            sql += " and Status = ?";
//        }
//
//        try(PreparedStatement ps = connection.prepareStatement(sql)) {
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                list.add(new Airports(
//                        rs.getInt("airportID"),
//                        rs.getString("airportName"),
//                        rs.getInt("locationID"),
//                        rs.getInt("status")
//                ));
//            }
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//        return list;
//    }
    public List<Airports> searchAirports(String search, Integer status, int start, int total) {
        List<Airports> list = new ArrayList<>();
        String query = "SELECT * FROM Airports WHERE 1=1";

        if (search != null && !search.trim().isEmpty()) {
            query += " AND airportName LIKE ?";
        }
        if (status != null) {
            query += " AND status = ?";
        }

        query += " LIMIT ?, ?"; // Thêm phân trang

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }
            if (status != null) {
                ps.setInt(index++, status);
            }

            ps.setInt(index++, start); // Vị trí bắt đầu
            ps.setInt(index, total);   // Số lượng bản ghi mỗi trang

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Airports(
                        rs.getInt("airportID"),
                        rs.getString("airportName"),
                        rs.getInt("locationID"),
                        rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countFilteredAirport(String airportName, Integer status) {
        String query = "SELECT COUNT(*) FROM Airports WHERE 1=1";

        if (airportName != null && !airportName.trim().isEmpty()) {
            query += " AND airportName LIKE ?";
        }
        if (status != null) {
            query += " AND status = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            int index = 1;
            if (airportName != null && !airportName.trim().isEmpty()) {
                ps.setString(index++, "%" + airportName + "%");
            }
            if (status != null) {
                ps.setInt(index++, status);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Lấy tổng số lượng bản ghi
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0; // Trả về 0 nếu có lỗi hoặc không tìm thấy bản ghi nào
    }


    public boolean deleteAirport(int airportId) {
        String sql = "DELETE FROM Airports WHERE airportId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, airportId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isAirportExist(String airportName) {
        String sql = "SELECT 1 FROM airports WHERE airportName LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + airportName + "%"); // Tìm kiếm một phần tên sân bay
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Nếu có kết quả, tức là đã tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //quyquy

    public Airports getAirportById(int id) {
        String sql = "select * from airports where AirportId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int airportId = rs.getInt("AirportId");
                String name = rs.getString("AirportName");
                int locationId = rs.getInt("LocationId");
                Airports a = new Airports(airportId, name, locationId);
                return a;
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return null;
    }


    // test

    public static void main(String[] args) {
        AirportsDAO dao = new AirportsDAO();
        Airports ap = dao.getAirportById(1);
        System.out.println(ap);

    }

}

