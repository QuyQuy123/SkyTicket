package dal;

import model.Baggages;
import model.Discounts;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DiscountDAO extends DBConnect {
    // Các câu lệnh SQL
    private static final String SELECT_ALL_DISCOUNTS = "SELECT * FROM discounts";
    private static final String SELECT_DISCOUNT_BY_ID = "SELECT * FROM discounts WHERE DiscountId = ?";
    private static final String INSERT_DISCOUNT = "INSERT INTO discounts (Percent, AccountId, Points) VALUES (?, ?, ?)";
    private static final String UPDATE_DISCOUNT = "UPDATE discounts SET Percent = ?, AccountId = ?, Points = ? WHERE DiscountId = ?";
    private static final String DELETE_DISCOUNT = "DELETE FROM discounts WHERE DiscountId = ?";

    // Lấy danh sách tất cả discount
    public List<Discounts> getAllDiscounts() throws SQLException {
        List<Discounts> discounts = new ArrayList<>();
        try (PreparedStatement ps = connection.prepareStatement(SELECT_ALL_DISCOUNTS);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Discounts discount = new Discounts();
                discount.setDiscountId(rs.getInt("DiscountId"));
                discount.setPercent(rs.getDouble("Percent"));
                discount.setAccountId(rs.getInt("AccountId"));
                discount.setPoints(rs.getInt("Points"));
                discounts.add(discount);
            }
        }
        return discounts;
    }

    // Lấy discount theo ID
    public Discounts getDiscountById(int discountId) throws SQLException {
        Discounts discount = null;
        try (PreparedStatement ps = connection.prepareStatement(SELECT_DISCOUNT_BY_ID)) {
            ps.setInt(1, discountId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    discount = new Discounts();
                    discount.setDiscountId(rs.getInt("DiscountId"));
                    discount.setPercent(rs.getDouble("Percent"));
                    discount.setAccountId(rs.getInt("AccountId"));
                    discount.setPoints(rs.getInt("Points"));
                }
            }
        }
        return discount;
    }

    // Thêm discount mới
    public void addDiscount(Discounts discount) throws SQLException {
        try (PreparedStatement ps = connection.prepareStatement(INSERT_DISCOUNT)) {
            ps.setDouble(1, discount.getPercent());
            ps.setInt(2, discount.getAccountId());
            ps.setInt(3, discount.getPoints());
            ps.executeUpdate();
        }
    }

    // Cập nhật discount
    public void updateDiscount(Discounts discount) throws SQLException {
        try (PreparedStatement ps = connection.prepareStatement(UPDATE_DISCOUNT)) {
            ps.setDouble(1, discount.getPercent());
            ps.setInt(2, discount.getAccountId());
            ps.setInt(3, discount.getPoints());
            ps.setInt(4, discount.getDiscountId());
            ps.executeUpdate();
        }
    }

    public int getTotalRecords() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Discounts";
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

    // Lấy danh sách discount theo trang
    public List<Discounts> getDiscountsByPage(int start, int total)  {
        List<Discounts> discounts = new ArrayList<>();
        String sql = "SELECT * FROM Discounts LIMIT ?, ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, start);
            pstmt.setInt(2, total);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                discounts.add(new Discounts(
                        rs.getInt("DiscountId"),
                        rs.getDouble("Percent"),
                        rs.getInt("AccountId"),
                        rs.getInt("Points")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return discounts;
    }
    public int getTotalRecordsFiltered(String search) {
        String sql = "SELECT COUNT(*) as total FROM discounts d " +
                "LEFT JOIN accounts a ON d.AccountId = a.AccountId " +
                "WHERE d.DiscountId LIKE ? OR a.FullName LIKE ?";
        int total = 0;

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            String searchPattern = "%" + search + "%";
            preparedStatement.setString(1, searchPattern);
            preparedStatement.setString(2, searchPattern);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                total = resultSet.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    // Tìm kiếm discount với phân trang
    public List<Discounts> searchDiscounts(String search, int page, int recordsPerPage) {
        List<Discounts> discountsList = new ArrayList<>();
        String sql = "SELECT d.DiscountId, d.AccountId, d.Percent, d.Points " +
                "FROM discounts d " +
                "LEFT JOIN accounts a ON d.AccountId = a.AccountId " +
                "WHERE d.DiscountId LIKE ? OR a.FullName LIKE ? " +
                "LIMIT ?, ?";

        int offset = (page - 1) * recordsPerPage;

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            String searchPattern = "%" + search + "%";
            preparedStatement.setString(1, searchPattern);
            preparedStatement.setString(2, searchPattern);
            preparedStatement.setInt(3, offset);
            preparedStatement.setInt(4, recordsPerPage);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Discounts discount = new Discounts();
                discount.setDiscountId(resultSet.getInt("DiscountId"));
                discount.setAccountId(resultSet.getInt("AccountId"));
                discount.setPercent(resultSet.getFloat("Percent"));
                discount.setPoints(resultSet.getInt("Points"));
                discountsList.add(discount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return discountsList;
    }

    // Hàm update Discount
    public boolean discountUpdate(Discounts discount) throws SQLException {
        String sql = "UPDATE discounts SET Percent = ?, Points = ? WHERE DiscountId = ?";
        boolean rowUpdated = false;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setDouble(1, discount.getPercent());
            ps.setInt(2, discount.getPoints());
            ps.setInt(3, discount.getDiscountId());

            rowUpdated = ps.executeUpdate() > 0; // Trả về true nếu có ít nhất 1 row được update
        }
        return rowUpdated;
    }
    public boolean deleteDiscount(int discountId) throws SQLException {
        String sql = "DELETE FROM discounts WHERE DiscountId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, discountId);
            return ps.executeUpdate() > 0;
        }
    }
    public boolean insertDiscountAuto(int accountId) throws SQLException {
        String sql = "INSERT INTO discounts (Percent, AccountId, Points) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDouble(1, 5.0); // Percent mặc định là 10.0
            ps.setInt(2, accountId); // Account ID từ account mới
            ps.setInt(3, 0); // Points mặc định là 0
            return ps.executeUpdate() > 0;
        }
    }
    // Thêm phương thức mới để insert với percent và points tùy chỉnh
    public boolean insertDiscount(int accountId, double percent, int points) throws SQLException {
        String sql = "INSERT INTO discounts (Percent, AccountId, Points) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setDouble(1, percent);
            ps.setInt(2, accountId);
            ps.setInt(3, points);
            return ps.executeUpdate() > 0;
        }
    }

    // Hàm main để test các phương thức
    public static void main(String[] args) {
        DiscountDAO discountDAO = new DiscountDAO();

        try {
            // Test case 1: Update một discount có discountId = 1
            Discounts discount = discountDAO.getDiscountById(2);
            if (discount != null) {
                System.out.println("Before update: " + discount);

                // Thay đổi giá trị percent và points
                discount.setPercent(50.5);  // Ví dụ: cập nhật percent thành 50.5
                discount.setPoints(100);    // Ví dụ: cập nhật points thành 100

                boolean updated = discountDAO.discountUpdate(discount);
                if (updated) {
                    System.out.println("Discount updated successfully!");
                    Discounts updatedDiscount = discountDAO.getDiscountById(2);
                    System.out.println("After update: " + updatedDiscount);
                } else {
                    System.out.println("Failed to update discount!");
                }
            } else {
                System.out.println("Discount with ID 1 not found!");
            }

            // Test case 2: Update một discount không tồn tại
            Discounts nonExistentDiscount = new Discounts(999, 25.0, 1, 50);
            boolean updatedNonExistent = discountDAO.discountUpdate(nonExistentDiscount);
            if (!updatedNonExistent) {
                System.out.println("Update for non-existent discount (ID 999) failed as expected.");
            }

        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
