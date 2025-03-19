package dal;

import model.Bookings;

import java.sql.*;

public class BookingDAO extends DBConnect{


    public String createBooking(String contactName, String contactPhone, String contactEmail,float totalPrice, Integer accountId) {
        String sql = "INSERT INTO Bookings (code,contactName, contactPhone, contactEmail,TotalPrice, BookingDate, Status, AccountId) "
                + "VALUES (?, ?, ?, ?,?,?,?,?)";
        String code = "abc";

        try(PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, code);
            ps.setString(2, contactName);
            ps.setString(3, contactPhone);
            ps.setString(4, contactEmail);
            ps.setFloat(5, totalPrice);
            ps.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            ps.setInt(7, 1); // Giả định 1 là trạng thái "pending", bạn có thể thay đổi tùy theo hệ thống
            if (accountId != null) {
                ps.setInt(8, accountId);
            } else {
                ps.setNull(8, java.sql.Types.INTEGER);
            }

            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating booking failed, no rows affected.");
            }

            // Lấy BookingId vừa được tạo
            Integer bookingId = null;
            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) {
                bookingId = generatedKeys.getInt(1);
            } else {
                throw new SQLException("Creating booking failed, no ID obtained.");
            }

            return code;
        } catch (Exception e) {
            System.out.println("Error creating booking: " + e.getMessage());
            return null;
        }
    }

    public Bookings getBookingByCode(String code) {
        String sql = "SELECT BookingId, Code, TotalPrice, BookingDate, Status, AccountId FROM Bookings WHERE Code = ?";

        try( PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, code);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int bookingId = rs.getInt("BookingId");
                String bookingCode = rs.getString("Code");
                int totalPrice = rs.getInt("TotalPrice");
                Timestamp bookingDate = rs.getTimestamp("BookingDate");
                int status = rs.getInt("Status");
                Integer accountId = rs.getInt("AccountId");
                if (rs.wasNull()) {
                    accountId = null; // Xử lý trường hợp AccountId là NULL
                }

                return new Bookings(bookingId, bookingCode, totalPrice, bookingDate, status, accountId);
            }
        } catch (Exception e) {
            System.out.println("Error retrieving booking by code: " + e.getMessage());
        }

        return null; // Trả về null nếu không tìm thấy hoặc có lỗi
    }

    public void deleteOrderByCode(String code) {
        String sql = "DELETE FROM BOOKINGS WHERE code = ?";
        try(  PreparedStatement ps =  connection.prepareStatement(sql)) {

            ps.setString(1, code);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateTotalPrice(int orderId, int newTotalPrice) {
        String sql = "UPDATE bookings SET totalPrice = ? WHERE bookingid = ?";
        try( PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, newTotalPrice);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public Bookings getLatestBooking() {
        String sql = "SELECT * FROM Bookings ORDER BY BookingDate DESC, BookingId DESC LIMIT 1";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return new Bookings(
                        rs.getInt("BookingId"),
                        rs.getString("Code"),
                        rs.getString("ContactName"),
                        rs.getString("ContactPhone"),
                        rs.getString("ContactEmail"),
                        rs.getDouble("TotalPrice"),
                        rs.getTimestamp("BookingDate"),
                        rs.getInt("Status"),
                        rs.getInt("AccountId")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }



    public static void main(String[] args) {
        BookingDAO bookingDAO = new BookingDAO();
        System.out.println(bookingDAO.getLatestBooking());
    }





}

