package dal;


import model.Airlines;
import model.Airports;
import model.Countries;
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

    public List<Locations> searchLocation(String name, int Status) {
        List<Locations> list = new ArrayList<>();
        String sql = "select * from Locations where LocationName like ? AND Status like ?";
        try {
            PreparedStatement prepare = connection.prepareStatement(sql);
            prepare.setString(1, "%" + name + "%");
            prepare.setInt(2, Status);
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
        String sql = "SELECT l.LocationId, l.LocationName, l.CountryId, c.CountryName, l.Status " +
                "FROM Locations l " +
                "JOIN Countries c ON l.CountryId = c.CountryId " +
                "WHERE l.LocationId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int locationId = rs.getInt("LocationId");
                    String locationName = rs.getString("LocationName");
                    int countryId = rs.getInt("CountryId");
                    String countryName = rs.getString("CountryName");
                    int status = rs.getInt("Status");

                    Countries country = new Countries(countryId, status, countryName);
                    return new Locations(locationId, locationName, country, status);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
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

    public List<Locations> getLocationsByPage(int start, int total) {
        List<Locations> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM Locations LIMIT ?, ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Locations(
                        rs.getInt("locationid"),
                        rs.getString("locationname"),
                        rs.getInt("countryid"),
                        rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalRecords() {
        int total = 0;
        try {
            String query = "SELECT COUNT(*) FROM Locations";
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
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

    public boolean updateLocationStatus(int id, int status) {
        String query = "UPDATE Locations SET status = ? WHERE locationId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, status);
            ps.setInt(2, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateLocation(Locations location) {
        String query = "UPDATE Locations SET locationName=?, status=? WHERE locationId=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, location.getLocationName());
            ps.setInt(2, location.getStatus());
            ps.setInt(3, location.getLocationId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getLocationIdByAirportId(Integer airportId) {
        String sql = "SELECT l.LocationId FROM Locations l " +
                "JOIN Airports a ON l.LocationId = a.LocationId " +
                "WHERE a.AirportId = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql))
              {
            pstmt.setInt(1, airportId);

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("LocationId");
            }
        } catch (SQLException e) {
            e.printStackTrace();

            return 0;
        }
        return 0;
    }



    public static void main(String[] args) {
        LocationsDAO dao = new LocationsDAO();
        System.out.println(dao.getLocationIdByAirportId(1));
    }











}
