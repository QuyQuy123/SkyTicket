package dal;


import model.Locations;

import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


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

    public static void main(String[] args) {
        LocationsDAO dao = new LocationsDAO();
        System.out.println(dao.getLocationsByCountryId(3));
    }











}
