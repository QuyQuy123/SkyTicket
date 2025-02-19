package dal;


import model.Airlines;
import model.Airports;
import model.Locations;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class LocationsDAO extends  DBConnect{

    public  List<Locations> getAllLocation() {
        List<Locations> list = new ArrayList<>();
        String sql = "select * from Locations";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("LocationId");
                String name = rs.getString("LocationName");
                int Country_id = rs.getInt("CountryId");
                int status = rs.getInt("status");
                list.add(new Locations(id, name, Country_id, status));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public List<Locations> searchLocation(String name) {
        List<Locations> list = new ArrayList<>();
        String sql = "select * from Locations where LocationName like ?";
        try {
            PreparedStatement prepare = connection.prepareStatement(sql);
            prepare.setString(1, "%" + name + "%");
            ResultSet rs = prepare.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("LocationId");
                 name = rs.getString("LocationName");
                int Country_id = rs.getInt("CountryId");
                int status = rs.getInt("status");
                list.add(new Locations(id, name, Country_id, status));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public Locations getLocationById(int id) {
        String sql = "SELECT * FROM Locations WHERE LocationId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                 id = rs.getInt("LocationId");
                String name = rs.getString("LocationName");
                int Country_id = rs.getInt("CountryId");
                int status = rs.getInt("status");
                Locations locate = new Locations(id, name, Country_id, status);
                return locate;
            }
        } catch (Exception e) {
        }

        return null;
    }

    public int getIdByLocationName(String name) {
        String sql = "Select * from Locations where LocationName = ?";
        try {
            PreparedStatement prepare = connection.prepareStatement(sql);
            prepare.setString(1, name);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("LocationId");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return -1;
    }

    public List<Locations> getLocationsByCountryId(int cid) {
        List<Locations> list = new ArrayList<>();
        String sql = "select * from Locations WHERE CountryId = ?";
        try {
            PreparedStatement prepare = connection.prepareStatement(sql);
            prepare.setInt(1, cid);
            ResultSet rs = prepare.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("LocationId");
                String name = rs.getString("LocationName");
                int Country_id = rs.getInt("CountryId");
                int status = rs.getInt("status");
                list.add(new Locations(id, name, Country_id, status));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    // Đã test full

    // Lấy danh sách hãng hàng không theo trang
    public List<Locations> getLocationsByPage(int start, int total) {
        List<Locations> list = new ArrayList<>();
        String query = "SELECT * FROM Locations LIMIT ?, ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Locations(
                        rs.getInt("LocationID"),
                        rs.getString("LocationName"),
                        rs.getInt("CountryID"),
                        rs.getInt("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm tổng số location
    public int getTotalLocations() {
        String query = "SELECT COUNT(*) FROM Locations";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean addLocation(Locations location) {
        String sql = "INSERT INTO Locations (LocationName, CountryId, Status) VALUES (?, ?, ?)";
        try (Connection conn = this.connection;
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, location.getLocationName());
            ps.setInt(2, location.getCountryId());
            ps.setInt(3, location.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isLocationNameExists(String locationName) {
        String sql = "SELECT COUNT(*) FROM Locations WHERE LocationName = ?";
        try (Connection conn = this.connection;
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, locationName);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public static void main(String[] args) {
        LocationsDAO dao = new LocationsDAO();
        System.out.println(dao.isLocationNameExists("Hà Nội"));
    }











}
