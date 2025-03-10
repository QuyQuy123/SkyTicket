package dal;

import model.Baggage;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BaggageDAO extends DBConnect {

    public List<Baggage> getAllBaggages() throws SQLException {
        List<Baggage> baggages = new ArrayList<>();
        String sql = "SELECT * FROM Baggages";
        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            baggages.add(new Baggage(rs.getInt("BaggageId"), rs.getFloat("Weight"), rs.getDouble("Price")));
        }
        return baggages;
    }

    public void addBaggage(Baggage baggage) throws SQLException {
        String sql = "INSERT INTO Baggages (Weight, Price) VALUES (?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setFloat(1, baggage.getWeight());
        stmt.setDouble(2, baggage.getPrice());
        stmt.executeUpdate();
    }

    public void updateBaggage(Baggage baggage) throws SQLException {
        String sql = "UPDATE Baggages SET Weight = ?, Price = ? WHERE BaggageId = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setFloat(1, baggage.getWeight());
        stmt.setDouble(2, baggage.getPrice());
        stmt.setInt(3, baggage.getBaggageId());
        stmt.executeUpdate();
    }

    public void deleteBaggage(int id) throws SQLException {
        String sql = "DELETE FROM Baggages WHERE BaggageId = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    public List<Baggage> getFilteredBaggages(String sortBy, String order) throws SQLException {
        List<Baggage> baggages = new ArrayList<>();
        String sql = "SELECT * FROM Baggages";

        if ("weight".equalsIgnoreCase(sortBy) || "price".equalsIgnoreCase(sortBy)) {
            sql += " ORDER BY " + sortBy + " " + ("desc".equalsIgnoreCase(order) ? "DESC" : "ASC");
        }

        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            baggages.add(new Baggage(rs.getInt("BaggageId"), rs.getFloat("Weight"), rs.getDouble("Price")));
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
    public List<Baggage> getBaggagesByPage(int start, int total) {
        List<Baggage> baggages = new ArrayList<>();
        String sql = "SELECT * FROM Baggages LIMIT ?, ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, start);
            pstmt.setInt(2, total);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                baggages.add(new Baggage(
                        rs.getInt("BaggageId"),
                        rs.getFloat("Weight"),
                        rs.getDouble("Price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return baggages;
    }
    public List<Baggage> searchBaggages(String baggageId, String orderWeight, String orderPrice, int currentPage, int recordsPerPage) {
        List<Baggage> baggages = new ArrayList<>();
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
                baggages.add(new Baggage(
                        rs.getInt("BaggageId"),
                        rs.getFloat("Weight"),
                        rs.getDouble("Price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return baggages;
    }

    // Hàm main để test các chức năng
    public static void main(String[] args) {
        BaggageDAO baggageDAO = new BaggageDAO();

        List<Baggage> baggages = baggageDAO.getBaggagesByPage(0,10);

        for (Baggage baggage : baggages) {
            System.out.println(baggage.toString());
        }
//
//        try {
//            // 1. Thêm hành lý mới
//            Baggage newBaggage = new Baggage(0, 20.0f, 50.0);
//            baggageDAO.addBaggage(newBaggage);
//            System.out.println("✔ Đã thêm hành lý mới.");
//
//            // 2. Lấy danh sách hành lý
//            List<Baggage> baggages = baggageDAO.getAllBaggages();
//            System.out.println("Danh sách hành lý:");
//            for (Baggage b : baggages) {
//                System.out.println(b);
//            }
//
//            // 3. Cập nhật hành lý (giả sử ID = 1)
//            Baggage updatedBaggage = new Baggage(1, 25.0f, 60.0);
//            baggageDAO.updateBaggage(updatedBaggage);
//            System.out.println("✔ Đã cập nhật hành lý có ID = 1.");
//
//            // 4. Xóa hành lý (giả sử ID = 1)
//            baggageDAO.deleteBaggage(1);
//            System.out.println("✔ Đã xóa hành lý có ID = 1.");
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }

//        BaggageDAO baggageDAO = new BaggageDAO();
//        try {
//            System.out.println("Test sắp xếp theo Weight tăng dần:");
//            List<Baggage> baggagesAsc = baggageDAO.getFilteredBaggages("weight", "asc");
//            for (Baggage b : baggagesAsc) {
//                System.out.println(b.getBaggageId() + " - " + b.getWeight() + "kg - " + b.getPrice() + "$");
//            }
//
//            System.out.println("\nTest sắp xếp theo Price giảm dần:");
//            List<Baggage> baggagesDesc = baggageDAO.getFilteredBaggages("price", "desc");
//            for (Baggage b : baggagesDesc) {
//                System.out.println(b.getBaggageId() + " - " + b.getWeight() + "kg - " + b.getPrice() + "$");
//            }
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }

    }
}
