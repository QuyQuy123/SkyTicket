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
                        rs.getString("airlineName"),
                        rs.getString("image"),
                        rs.getString("information"),
                        rs.getInt("status"),
                        rs.getInt("ClassVipCapacity"),
                        rs.getInt("ClassEconomyCapacity")
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
                            rs.getString("airlineName"),
                            rs.getString("image"),
                            rs.getString("information"),
                            rs.getInt("status"),
                            rs.getInt("ClassVipCapacity"),
                            rs.getInt("ClassEconomyCapacity")
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
        String query = "INSERT INTO Airlines (airlineName, image, information, status, classVipCapacity, classEconomyCapacity) VALUES (?, ?, ?, ?, ?, ?)";
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

    public boolean updateAirlineStatus(int id, int status) {
        String query = "UPDATE Airlines SET status = ? WHERE airlineId = ?";
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

    // Lấy danh sách hãng hàng không theo trang
    public List<Airlines> getAirlinesByPage(int start, int total) {
        List<Airlines> list = new ArrayList<>();
        String query = "SELECT * FROM Airlines LIMIT ?, ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Airlines(
                        rs.getInt("airlineId"),
                        rs.getString("airlineName"),
                        rs.getString("image"),
                        rs.getString("information"),
                        rs.getInt("status"),
                        rs.getInt("ClassVipCapacity"),
                        rs.getInt("ClassEconomyCapacity")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm tổng số hãng hàng không
    public int getTotalAirlines() {
        String query = "SELECT COUNT(*) FROM Airlines";
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

    // Tìm kiếm hãng hàng không theo tên, thông tin và trạng thái
    public List<Airlines> searchAirlines(String search, Integer status, int start, int total) {
        List<Airlines> list = new ArrayList<>();
        String query = "SELECT * FROM Airlines WHERE 1=1";

        if (search != null && !search.trim().isEmpty()) {
            query += " AND airlineName LIKE ?";
        }
        if (status != null) {
            query += " AND status = ?";
        }
        query += " LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
            }
            if (status != null) {
                ps.setInt(index++, status);
            }
            ps.setInt(index++, start);
            ps.setInt(index++, total);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Airlines(
                        rs.getInt("airlineId"),
                        rs.getString("airlineName"),
                        rs.getString("image"),
                        rs.getString("information"),
                        rs.getInt("status"),
                        rs.getInt("ClassVipCapacity"),
                        rs.getInt("ClassEconomyCapacity")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }



    public int countFilteredAirlines(String search, Integer status) {
        String query = "SELECT COUNT(*) FROM Airlines WHERE 1=1";

        if (search != null && !search.trim().isEmpty()) {
            query += " AND airlineName LIKE ?";
        }
        if (status != null) {
            query += " AND status = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
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

    // Kiểm tra xem airlineName đã tồn tại chưa
    public boolean isAirlineNameExists(String airlineName) {
        String query = "SELECT COUNT(*) FROM Airlines WHERE airlineName = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, airlineName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String getImageById(int id) {
        String sql = "select image from airlines where AirlineId =?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("image");
            }
        } catch (Exception e) {
        }
        return null;
    }
    public String getNameById(int id) {
        String sql = "select AirlineName from airlines where AirlineId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("AirlineName");
            }
        } catch (Exception e) {
        }
        return null;
    }

    public static void main(String[] args) {
        AirlinesDAO airlinesDAO = new AirlinesDAO();
        System.out.println(airlinesDAO.getNameById(4));
    }



}
