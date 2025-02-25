package dal;

import model.Countries;


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


    public static void main(String[] args) {
        CountriesDAO dao = new CountriesDAO();
        System.out.println(dao.getCountryById(2));
    }
}
