package dal;

import model.Countries;
import model.Locations;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CountriesDAO extends DBConnect {
    public List<Countries> getAllCountries() {
        List<Countries> list = new ArrayList<>();
        String sql = "select * from Countries";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("CountryID");
                String name = rs.getString("CountryName");
                int status = rs.getInt("status");
                list.add(new Countries(id, status, name));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    // get contries by id

    public Countries getCountryById(int id) {
        String sql = "select * from countries where CountryId = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int countryId = rs.getInt("CountryId");
                String name = rs.getString("CountryName");
                Countries c = new Countries(countryId, name);
                return c;
            }
        } catch (Exception ex) {
        }

        return null;
    }

    public int getIdByCountryName(String name) {
        String sql = "Select * from Countries where CountryName = ?";
        try {
            PreparedStatement prepare = connection.prepareStatement(sql);
            prepare.setString(1, name);
            ResultSet resultSet = prepare.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("CountryId");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return -1;
    }

    public boolean addCountry(Countries country) {
        String sql = "INSERT INTO Countries (CountryName, Status) VALUES (?, ?)";
        try (Connection conn = this.connection;
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, country.getCountryName());
            ps.setInt(2, country.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        CountriesDAO dao = new CountriesDAO();
        Countries countries = new Countries("Hong Kong", 1);
        System.out.println(dao.addCountry(countries));
    }
}
