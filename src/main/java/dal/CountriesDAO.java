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

    public int getStatus(int countryId) {
        String sql = "SELECT status FROM Countries WHERE countryId = ?";
        int status = 0;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, countryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                status = rs.getInt("status");
            }
        } catch (SQLException ex) {
            System.out.println("Error fetching status: " + ex.getMessage());
        }
        return status;
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

    public List<Countries> getCountriesByPage(int start, int total) {
        List<Countries> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM Countries LIMIT ?, ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Countries(
                        rs.getInt("countryid"),
                        rs.getInt("status"),
                        rs.getString("countryname")
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
            String query = "SELECT COUNT(*) FROM Countries";
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

    public List<Countries> searchCountryByPage(String name, Integer status, int offset, int limit) {
        List<Countries> list = new ArrayList<>();
        String sql = "SELECT * FROM Countries WHERE 1=1";

        if (name != null && !name.trim().isEmpty()) {
            sql += " AND countryName LIKE ?";
        }
        if (status != null) {
            sql += " AND status = ?";
        }
        sql += " LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            int index = 1;
            if (name != null && !name.trim().isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (status != null) {
                ps.setInt(index++, status);
            }
            ps.setInt(index++, offset);
            ps.setInt(index, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Countries(
                        rs.getInt("countryId"),
                        rs.getInt("status"),
                        rs.getString("countryName")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalSearchRecords(String name, Integer status) {
        String sql = "SELECT COUNT(*) FROM Countries WHERE 1=1";

        if (name != null && !name.trim().isEmpty()) {
            sql += " AND countryName LIKE ?";
        }
        if (status != null) {
            sql += " AND status = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            int index = 1;
            if (name != null && !name.trim().isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (status != null) {
                ps.setInt(index++, status);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean updateCountry(Countries country) {
        String query = "UPDATE Countries SET countryName=?, status=? WHERE countryId=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, country.getCountryName());
            ps.setInt(2, country.getStatus());
            ps.setInt(3, country.getCountryId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCountryStatus(int id, int status) {
        String query = "UPDATE Countries SET status = ? WHERE countryId = ?";
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

    public static void main(String[] args) {
        CountriesDAO dao = new CountriesDAO();
        System.out.println("Hello" + dao.getStatus(1));
    }
}
