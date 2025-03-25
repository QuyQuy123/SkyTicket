package dal;

import model.Baggages;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BaggageDAO extends DBConnect {

    public List<Baggages> getAllBaggages() throws SQLException {
        List<Baggages> baggages = new ArrayList<>();
        String sql = "SELECT * FROM Baggages";
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            baggages.add(new Baggages(rs.getInt("BaggageId"), rs.getFloat("Weight"), rs.getDouble("Price"),rs.getInt("AirlineId"),
                    rs.getInt("Status")));
        }
        return baggages;
    }

    public int addBaggage(Baggages baggage) {
        int n = 0;
        String sql = "INSERT INTO Baggages (Weight, Price, AirlineId, Status) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setFloat(1, baggage.getWeight());
            pre.setDouble(2, baggage.getPrice());
            pre.setInt(3, baggage.getAirlineId());
            pre.setInt(4, baggage.getStatus());
            n = pre.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return n;
    }


    public int updateBaggage(Baggages baggage) throws SQLException {
        String sql = "UPDATE Baggages SET Weight = ?, Price = ?, AirlineId = ?, Status = ? WHERE BaggageId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setFloat(1, baggage.getWeight());
            stmt.setDouble(2, baggage.getPrice());
            stmt.setInt(3, baggage.getAirlineId());
            stmt.setInt(4, baggage.getStatus());
            stmt.setInt(5, baggage.getBaggageId());
            return stmt.executeUpdate(); // Trả về số dòng bị ảnh hưởng
        }
    }


    public void deleteBaggage(int id) throws SQLException {
        String sql = "DELETE FROM Baggages WHERE BaggageId = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    public List<Baggages> getFilteredBaggages(String sortBy, String order) throws SQLException {
        List<Baggages> baggages = new ArrayList<>();
        String sql = "SELECT * FROM Baggages";

        if ("weight".equalsIgnoreCase(sortBy) || "price".equalsIgnoreCase(sortBy)) {
            sql += " ORDER BY " + sortBy + " " + ("desc".equalsIgnoreCase(order) ? "DESC" : "ASC");
        }

        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            baggages.add(new Baggages(
                    rs.getInt("BaggageId"),
                    rs.getFloat("Weight"),
                    rs.getDouble("Price"),
                    rs.getInt("AirlineId"),
                    rs.getInt("Status")
            ));
        }
        return baggages;
    }


    public int getTotalRecords() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Baggages";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    // Lấy danh sách hành lý theo trang
    public List<Baggages> getBaggagesByPage(int start, int total) {
        List<Baggages> baggages = new ArrayList<>();
        String sql = "SELECT * FROM Baggages LIMIT ?, ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, start);
            pstmt.setInt(2, total);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                baggages.add(new Baggages(
                        rs.getInt("BaggageId"),
                        rs.getFloat("Weight"),
                        rs.getDouble("Price"),
                        rs.getInt("AirlineId"),
                        rs.getInt("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return baggages;
    }

    public List<Baggages> searchBaggages(String baggageId, String orderWeight, String orderPrice, int currentPage, int recordsPerPage) {
        List<Baggages> baggages = new ArrayList<>();
        String sql = "SELECT * FROM Baggages WHERE 1=1";

        if (baggageId != null && !baggageId.isEmpty()) {
            sql = sql + " AND BaggageId = ?";
        }

        if ("asc".equalsIgnoreCase(orderWeight)) {
            sql = sql + " ORDER BY Weight ASC";
        } else if ("desc".equalsIgnoreCase(orderWeight)) {
            sql = sql + " ORDER BY Weight DESC";
        }

        if ("asc".equalsIgnoreCase(orderPrice)) {
            sql = sql + (orderWeight == null ? " ORDER BY Price ASC" : ", Price ASC");
        } else if ("desc".equalsIgnoreCase(orderPrice)) {
            sql = sql + (orderWeight == null ? " ORDER BY Price DESC" : ", Price DESC");
        }

        sql = sql + " LIMIT ?, ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            if (baggageId != null && !baggageId.isEmpty()) {
                pstmt.setInt(paramIndex++, Integer.parseInt(baggageId));
            }
            pstmt.setInt(paramIndex++, (currentPage - 1) * recordsPerPage);
            pstmt.setInt(paramIndex, recordsPerPage);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                baggages.add(new Baggages(
                        rs.getInt("BaggageId"),
                        rs.getFloat("Weight"),
                        rs.getDouble("Price"),
                        rs.getInt("AirlineId"),
                        rs.getInt("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return baggages;
    }




    public List<Baggages> getAllBaggagesByAirline(int airlineId) {
        List<Baggages> baggages = new ArrayList<>();
        String sql = "SELECT * FROM Baggages WHERE AirlineId = ?";

        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, airlineId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                baggages.add(new Baggages(
                        rs.getInt("BaggageId"),
                        rs.getFloat("Weight"),
                        rs.getDouble("Price"),
                        rs.getInt("AirlineId"),
                        rs.getInt("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return baggages;
    }
    public List<Baggages> searchBaggages(String baggageId, String airlineName, String orderWeight, String orderPrice, int currentPage, int recordsPerPage) {
        List<Baggages> baggages = new ArrayList<>();
        String sql = "SELECT b.* FROM Baggages b JOIN Airlines a ON b.AirlineId = a.AirlineId WHERE 1=1";

        // Điều kiện lọc
        if (baggageId != null && !baggageId.trim().isEmpty()) {
            sql += " AND b.BaggageId = ?"; // Sửa lại thành tìm chính xác thay vì LIKE
        }
        if (airlineName != null && !airlineName.trim().isEmpty()) {
            sql += " AND a.AirlineName LIKE ?";
        }

        // Sắp xếp
        if (orderWeight != null && !orderWeight.isEmpty()) {
            sql += " ORDER BY b.Weight " + (orderWeight.equals("asc") ? "ASC" : "DESC");
        } else if (orderPrice != null && !orderPrice.isEmpty()) {
            sql += " ORDER BY b.Price " + (orderPrice.equals("asc") ? "ASC" : "DESC");
        } else {
            // Mặc định sắp xếp theo BaggageId tăng dần nếu không có tiêu chí sắp xếp nào
            sql += " ORDER BY b.BaggageId ASC";
        }

        // Thêm phân trang
        sql += " LIMIT ? OFFSET ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (baggageId != null && !baggageId.trim().isEmpty()) {
                try {
                    ps.setInt(index++, Integer.parseInt(baggageId)); // Tìm chính xác BaggageId
                } catch (NumberFormatException e) {
                    // Nếu baggageId không phải số hợp lệ, có thể bỏ qua hoặc xử lý khác
                    return baggages; // Trả về danh sách rỗng nếu lỗi
                }
            }
            if (airlineName != null && !airlineName.trim().isEmpty()) {
                ps.setString(index++, "%" + airlineName + "%");
            }

            // Set giá trị cho LIMIT và OFFSET
            ps.setInt(index++, recordsPerPage);
            ps.setInt(index++, (currentPage - 1) * recordsPerPage);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                baggages.add(new Baggages(
                        rs.getInt("BaggageId"),
                        rs.getFloat("Weight"),
                        rs.getDouble("Price"),
                        rs.getInt("AirlineId"),
                        rs.getInt("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return baggages;
    }
    public List<Baggages> getSortedBaggage(String sortBy, String order, int offset, int limit) {
        List<Baggages> baggages = new ArrayList<>();
        String query = "SELECT * FROM baggage ORDER BY " + (sortBy != null ? sortBy : "weight") + " "
                + ("desc".equals(order) ? "DESC" : "ASC") + " LIMIT ? OFFSET ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                baggages.add(new Baggages(
                        rs.getInt("baggageId"),
                        rs.getFloat("weight"),
                        rs.getDouble("price"),
                        rs.getInt("airlineId"),
                        rs.getInt("status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return baggages;
    }
    public int getTotalRecordsFiltered(String baggageId, String airlineName) {
        String sql = "SELECT COUNT(*) FROM Baggages b JOIN Airlines a ON b.AirlineId = a.AirlineId WHERE 1=1";
        if (baggageId != null && !baggageId.trim().isEmpty()) {
            sql += " AND b.BaggageId = ?";
        }
        if (airlineName != null && !airlineName.trim().isEmpty()) {
            sql += " AND a.AirlineName LIKE ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (baggageId != null && !baggageId.trim().isEmpty()) {
                ps.setInt(index++, Integer.parseInt(baggageId));
            }
            if (airlineName != null && !airlineName.trim().isEmpty()) {
                ps.setString(index++, "%" + airlineName + "%");
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

    public Baggages getBaggageById(int baggageId) {
        Baggages baggage = null;
        String sql = "SELECT * FROM Baggages WHERE BaggageId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, baggageId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                baggage = new Baggages(
                        rs.getInt("BaggageId"),
                        rs.getFloat("Weight"),
                        rs.getDouble("Price"),
                        rs.getInt("AirlineId"),
                        rs.getInt("Status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return baggage;
    }

    // Hàm main để test các chức năng
    public static void main(String[] args) {
        BaggageDAO baggageDAO = new BaggageDAO();
//        List<Baggages> baggages = baggageDAO.getAllBaggagesByAirline(3);
//        for (Baggages baggage : baggages) {
//            System.out.println(baggage);
//        }

    }
}
