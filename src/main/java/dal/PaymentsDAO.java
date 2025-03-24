package dal;

import model.Locations;
import model.Passengers;
import model.Payments;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PaymentsDAO extends DBConnect {
    public List<Payments> getAllPayments() {
        List<Payments> list = new ArrayList<>();
        String sql = "select * from Payments";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int paymentID = rs.getInt("PaymentId");
                int bookingID = rs.getInt("BookingId");
                String paymentMethod = rs.getString("Paymentmethod");
                String paymentStatus = rs.getString("Paymentstatus");
                Date paymentDate = rs.getTimestamp("Paymentdate");
                double totalPrice = rs.getDouble("totalPrice");
                list.add(new Payments(paymentID, bookingID, paymentMethod, paymentStatus, paymentDate, totalPrice));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public List<Payments> getPaymentsByPage(int start, int total) {
        List<Payments> list = new ArrayList<>();
        try {
            String query = "SELECT paymentid, PaymentMethod, PaymentStatus, PaymentDate, TotalPrice FROM Payments LIMIT ?, ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Payments(
                        rs.getInt("paymentid"),
                        rs.getString("PaymentMethod"),
                        rs.getString("PaymentStatus"),
                        rs.getTimestamp("PaymentDate"),
                        rs.getDouble("TotalPrice")
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
            String query = "SELECT COUNT(*) FROM Payments";
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

    public List<Payments> searchPaymentByPage(String name, String status, int offset, int limit) {
        List<Payments> list = new ArrayList<>();
        String sql = "SELECT * FROM Payments WHERE 1=1";

        if (name != null && !name.trim().isEmpty()) {
            sql += " AND PaymentMethod LIKE ?";
        }
        if (status != null) {
            sql += " AND PaymentStatus LIKE ?";
        }
        sql += " LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            int index = 1;
            if (name != null && !name.trim().isEmpty()) {
                ps.setString(index++, "%" + name + "%");
            }
            if (status != null) {
                ps.setString(index++, "%" + status + "%");
            }
            ps.setInt(index++, offset);
            ps.setInt(index, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Payments(
                        rs.getInt("paymentId"),
                        rs.getInt("bookingId"),
                        rs.getString("paymentmethod"),
                        rs.getString("paymentstatus"),
                        rs.getTimestamp("paymentDate"),
                        rs.getDouble("totalPrice")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalSearchRecords(String name, String status) {
        String sql = "SELECT COUNT(*) FROM Payments WHERE 1=1";

        if (name != null && !name.trim().isEmpty()) {
            sql += " AND PaymentMethod LIKE ?";
        }
        if (status != null) {
            sql += " AND PaymentStatus LIKE ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            int index = 1;
            if (name != null && !name.trim().isEmpty()) {
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

    public Payments getPaymentById(int id) {
        String sql = "SELECT * FROM Payments WHERE paymentid = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int paymentid = rs.getInt("paymentid");
                    int bookingid = rs.getInt("bookingid");
                    String paymentmethod = rs.getString("paymentmethod");
                    String paymentstatus = rs.getString("paymentstatus");
                    Date paymentdate = rs.getTimestamp("paymentdate");
                    double totalPrice = rs.getDouble("totalPrice");
                    return new Payments(paymentid, bookingid, paymentmethod, paymentstatus, paymentdate, totalPrice);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getBookingidById(int id) {
        String sql = "SELECT bookingid FROM Payments WHERE paymentid = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("bookingid");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static void main(String[] args) {
        PaymentsDAO dao = new PaymentsDAO();
        System.out.println(dao.getAllPayments());
    }
}
