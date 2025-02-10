package dal;

import model.Airlines;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AirlinesDAO extends DBConnect {

    // Lấy danh sách tất cả hãng hàng không
    public List<Airlines> getAllAirlines() {
        List<Airlines> list = new ArrayList<>();
        String query = "SELECT * FROM Airlines";
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Airlines(
                        rs.getInt("airlineId"),
                        rs.getInt("ClassEconomyCapacity"),
                        rs.getInt("ClassVipCapacity"),
                        rs.getString("information"),
                        rs.getString("image"),
                        rs.getString("airlineName"),
                        rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy thông tin hãng hàng không theo ID
    public Airlines getAirlineById(int id) {
        String query = "SELECT * FROM Airlines WHERE airlineId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Airlines(
                            rs.getInt("airlineId"),
                            rs.getInt("ClassEconomyCapacity"),
                            rs.getInt("ClassVipCapacity"),
                            rs.getString("information"),
                            rs.getString("image"),
                            rs.getString("airlineName"),
                            rs.getInt("status")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm hãng hàng không mới
    public boolean addAirline(Airlines airline) {
        String query = "INSERT INTO Airlines (airlineName, image, information, status, ClassVipCapacity, ClassEconomyCapacity) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, airline.getAirlineName());
            ps.setString(2, airline.getImage());
            ps.setString(3, airline.getInformation());
            ps.setInt(4, airline.getStatus());
            ps.setInt(5, airline.getClassVipCapacity());
            ps.setInt(6, airline.getClassEconomyCapacity());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin hãng hàng không
    public boolean updateAirline(Airlines airline) {
        String query = "UPDATE Airlines SET airlineName=?, image=?, information=?, status=?, ClassVipCapacity=?, ClassEconomyCapacity=? WHERE airlineId=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, airline.getAirlineName());
            ps.setString(2, airline.getImage());
            ps.setString(3, airline.getInformation());
            ps.setInt(4, airline.getStatus());
            ps.setInt(5, airline.getClassVipCapacity());
            ps.setInt(6, airline.getClassEconomyCapacity());
            ps.setInt(7, airline.getAirlineId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa hãng hàng không theo ID
    public boolean deleteAirline(int id) {
        String query = "DELETE FROM Airlines WHERE airlineId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
