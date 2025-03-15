package dal;

import model.Accounts;
import model.Bookings;
import model.Passengers;

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

    public static void main(String[] args) {
        BookingsDAO dao = new BookingsDAO();
        System.out.println(dao.getBookingsById(1));
    }
}
