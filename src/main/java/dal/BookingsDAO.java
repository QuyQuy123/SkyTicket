package dal;

import model.Accounts;
import model.Bookings;
import model.Passengers;
import model.Payments;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BookingsDAO extends DBConnect {
    public List<Bookings> getAllBookings() {
        List<Bookings> list = new ArrayList<>();
        String sql = "select * from Bookings";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("BookingId");
                String code = rs.getString("Code");
                String name = rs.getString("ContactName");
                String phone = rs.getString("ContactPhone");
                String email = rs.getString("ContactEmail");
                double totalPrice = rs.getDouble("TotalPrice");
                Date bookingDate = rs.getDate("BookingDate");
                String status = rs.getString("status");
                int accountId = rs.getInt("AccountId");
                list.add(new Bookings(id, code, name, phone, email, totalPrice, bookingDate, status, accountId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public Bookings getBookingsById(int id) {
        String sql = "SELECT * FROM Bookings WHERE bookingId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Bookings(rs.getInt("BookingId"),
                rs.getString("Code"),
                rs.getString("ContactName"),
                rs.getString("ContactPhone"),
                rs.getString("ContactEmail"),
                rs.getDouble("TotalPrice"),
                rs.getDate("BookingDate"),
                rs.getString("status"),
                rs.getInt("AccountId"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Bookings> getBookingsByPage(int start, int total) {
        List<Bookings> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM Bookings LIMIT ?, ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Bookings(
                        rs.getInt("bookingId"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getDouble("TotalPrice"),
                        rs.getTimestamp("bookingDate"),
                        rs.getString("status"),
                        rs.getInt("accountId")

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
            String query = "SELECT COUNT(*) FROM Bookings";
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

    public List<Bookings> searchBookingByPage(String name, String status, int offset, int limit) {
        List<Bookings> list = new ArrayList<>();
        String sql = "SELECT * FROM Bookings WHERE 1=1";

        if (name != null && !name.trim().isEmpty()) {
            sql += " AND (code LIKE ? OR contactName LIKE ? OR contactPhone LIKE ? OR contactEmail LIKE ?)";
        }
        if (status != null) {
            sql += " AND status LIKE ?";
        }
        sql += " LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            int index = 1;
            if (name != null && !name.trim().isEmpty()) {
                ps.setString(index++, "%" + name + "%");
                ps.setString(index++, "%" + name + "%");
                ps.setString(index++, "%" + name + "%");
                ps.setString(index++, "%" + name + "%");
            }
            if (status != null) {
                ps.setString(index++, "%" + status + "%");
            }
            ps.setInt(index++, offset);
            ps.setInt(index, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Bookings(
                        rs.getInt("bookingId"),
                        rs.getString("code"),
                        rs.getString("contactName"),
                        rs.getString("contactPhone"),
                        rs.getString("contactEmail"),
                        rs.getDouble("totalPrice"),
                        rs.getTimestamp("bookingDate"),
                        rs.getString("status"),
                        rs.getInt("accountId")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


    public int getTotalSearchRecords(String name, String status) {
        String sql = "SELECT COUNT(*) FROM Bookings WHERE 1=1";

        if (name != null && !name.trim().isEmpty()) {
            sql += " AND (code LIKE ? OR contactName LIKE ? OR contactPhone LIKE ? OR contactEmail LIKE ?)";
        }
        if (status != null) {
            sql += " AND status LIKE ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            int index = 1;
            if (name != null && !name.trim().isEmpty()) {
                ps.setString(index++, "%" + name + "%");
                ps.setString(index++, "%" + name + "%");
                ps.setString(index++, "%" + name + "%");
                ps.setString(index++, "%" + name + "%");
            }
            if (status != null) {
                ps.setString(index++, "%" + status + "%");
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

    public Bookings getBookingById(int id) {
        String sql = "SELECT * FROM Bookings WHERE bookingid = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int bookingid = rs.getInt("bookingid");
                    String code = rs.getString("code");
                    String contactName = rs.getString("contactName");
                    String contactPhone = rs.getString("contactPhone");
                    String contactEmail = rs.getString("contactEmail");
                    double totalPrice = rs.getDouble("totalPrice");
                    Date bookingdate = rs.getTimestamp("bookingdate");
                    String status = rs.getString("status");
                    int accountId = rs.getInt("accountId");
                    return new Bookings(bookingid, code, contactName, contactPhone, contactEmail, totalPrice, bookingdate, status, accountId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        BookingsDAO dao = new BookingsDAO();
        System.out.println(dao.searchBookingByPage("BK001",null, 1,6));
    }
}
