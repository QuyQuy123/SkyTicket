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
            baggages.add(new Baggages(rs.getInt("BaggageId"), rs.getFloat("Weight"), rs.getDouble("Price")));
        }
        return baggages;
    }

    public void addBaggage(Baggages baggage) throws SQLException {
        String sql = "INSERT INTO Baggages (Weight, Price) VALUES (?, ?)";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setFloat(1, baggage.getWeight());
        stmt.setDouble(2, baggage.getPrice());
        stmt.executeUpdate();
    }

    public void updateBaggage(Baggages baggage) throws SQLException {
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

    public List<Baggages> getFilteredBaggages(String sortBy, String order) throws SQLException {
        List<Baggages> baggages = new ArrayList<>();
        String sql = "SELECT * FROM Baggages";

        if ("weight".equalsIgnoreCase(sortBy) || "price".equalsIgnoreCase(sortBy)) {
            sql += " ORDER BY " + sortBy + " " + ("desc".equalsIgnoreCase(order) ? "DESC" : "ASC");
        }

        Statement stmt = connection.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            baggages.add(new Baggages(rs.getInt("BaggageId"), rs.getFloat("Weight"), rs.getDouble("Price")));
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
                        rs.getDouble("Price")
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
                        rs.getDouble("Price")
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
    public int getPriceBaggagesById(int id) {
        List<Baggages> list = new ArrayList<>();
        String sql = "select price from Baggages \n"
                + "where BaggageId = ?";
        try(PreparedStatement prepare = connection.prepareStatement(sql)) {
            prepare.setInt(1, id);
            ResultSet resultSet = prepare.executeQuery();
            while (resultSet.next()) {
                return resultSet.getInt("price");
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return 0;
    }



    // Hàm main để test các chức năng
    public static void main(String[] args) {
        BaggageDAO baggageDAO = new BaggageDAO();
        List<Baggages> baggages = baggageDAO.getAllBaggagesByAirline(3);
        for (Baggages baggage : baggages) {
            System.out.println(baggage);
        }

    }


}
