package dal;

import model.Bookings;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO extends DBConnect{


    public String createBooking(String contactName, String contactPhone, String contactEmail,float totalPrice, Integer accountId) {
        String sql = "INSERT INTO Bookings (code,contactName, contactPhone, contactEmail,TotalPrice, BookingDate, Status, AccountId) "
                + "VALUES (?, ?, ?, ?,?,?,?,?)";
        AccountDAO acc = new AccountDAO();
        String code = acc.generateRandomString();

        try(PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, code);
            ps.setString(2, contactName);
            ps.setString(3, contactPhone);
            ps.setString(4, contactEmail);
            ps.setFloat(5, totalPrice);
            ps.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            ps.setInt(7, 1);
            if (accountId != null) {
                ps.setInt(8, accountId);
            } else {
                ps.setNull(8, java.sql.Types.INTEGER);
            }

            int affectedRows = ps.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating booking failed, no rows affected.");
            }
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


    public Bookings getBookingById(int id) {
        String sql = "SELECT BookingId, Code, ContactName, ContactPhone, ContactEmail, TotalPrice, BookingDate, Status, AccountId " +
                "FROM Bookings WHERE BookingId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Bookings(
                            rs.getInt("BookingId"),
                            rs.getString("Code"),
                            rs.getString("ContactName"),
                            rs.getString("ContactPhone"),
                            rs.getString("ContactEmail"),
                            rs.getInt("TotalPrice"),
                            rs.getTimestamp("BookingDate"),
                            rs.getInt("Status"),
                            rs.getInt("AccountId")
                    );
                }
            } catch (SQLException e) {
                System.err.println("Error executing query to get booking by ID: " + e.getMessage());
                e.printStackTrace();
                throw new RuntimeException("Failed to retrieve booking with ID: " + id, e);
            }
        } catch (SQLException e) {
            System.err.println("Error preparing statement for getting booking by ID: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to prepare statement for booking retrieval with ID: " + id, e);
        }

        return null;
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

    public void updateTotalPrice(int bookingid, float newTotalPrice) {
        String sql = "UPDATE bookings SET totalPrice = ? WHERE bookingid = ?";
        try( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setFloat(1, newTotalPrice);
            ps.setInt(2, bookingid);
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

    public List<Bookings> getOrdersByStatusAndAccountId(int status, int accountId) {
        List<Bookings> list = new ArrayList<>();
        String sql = "select * from Bookings\n"
                + "where Status=? and AccountId = ? order by BookingId desc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bookings b = new Bookings(rs.getInt("BookingId"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getTimestamp("BookingDate"),
                        rs.getInt("Status"),
                        rs.getInt("AccountId")
                );
                list.add(b);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public List<Bookings> getListOrderByCodeAndAccountId(String code, int accountId) {
        List<Bookings> list = new ArrayList<>();
        String sql = "select * from Bookings\n"
                + "where code=? and AccountId = ? order by BookingId desc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, code);
            ps.setInt(2, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bookings b = new Bookings(rs.getInt("BookingId"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getTimestamp("BookingDate"),
                        rs.getInt("Status"),
                        rs.getInt("AccountId")
                );
                list.add(b);
            }
            return list;

        } catch (Exception e) {
        }
        return null;
    }

    public int getNumberAllOrdersByAccountId( int accountId) {
        List<Bookings> list = new ArrayList<>();
        String sql = "select * from Bookings\n"
                + "where  AccountId = ? order by BookingId desc";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bookings b = new Bookings(rs.getInt("BookingId"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getTimestamp("BookingDate"),
                        rs.getInt("Status"),
                        rs.getInt("AccountId")
                );
                list.add(b);
            }
            return list.size();

        } catch (Exception e) {
        }
        return 0;
    }



    public List<Bookings> getAllOrdersByAccountId(int accountId, int index) {
        List<Bookings> list = new ArrayList<>();
        int limit = 2;
        int offset = (index - 1) * limit;
        String sql = "SELECT * FROM Bookings WHERE AccountId = ? ORDER BY BookingId DESC LIMIT ? OFFSET ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, accountId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bookings b = new Bookings(
                        rs.getInt("BookingId"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getInt("totalPrice"),
                        rs.getTimestamp("BookingDate"),
                        rs.getInt("Status"),
                        rs.getInt("AccountId")
                );
                list.add(b);
            }

            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public float getTotalPriceAllTickets(int bookingId) {
        float totalPrice = 0;
        String query = "SELECT TotalPrice from Bookings  WHERE BookingId = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, bookingId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    totalPrice = resultSet.getFloat("TotalPrice");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalPrice;
    }
    public float getTotalPriceCancelledTicket(int id) {
        String sql = "SELECT Price as total FROM Tickets WHERE ticketId = ? and (Status = 3 or Status = 4 or Status=5)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getFloat("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void canceBookingById(int id) {
        String sql = "UPDATE Bookings SET Status = 3 WHERE bookingId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        BookingDAO dao = new BookingDAO();
        dao.canceBookingById(1);



    }








}

