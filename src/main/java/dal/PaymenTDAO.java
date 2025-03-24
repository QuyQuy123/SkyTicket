package dal;

import model.PaymenTs;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

public class PaymenTDAO extends DBConnect {


    public boolean insertPayment(int bookingId,String paymethod,String email,double price) {
        String sql = "INSERT INTO Payments ( BookingId, PaymentMethod, PaymentDate,email, TotalPrice) " +
                "VALUES ( ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, bookingId);
            pstmt.setString(2, paymethod);
            pstmt.setTimestamp(3,  new Timestamp(System.currentTimeMillis()));
            pstmt.setString(4, email);
            pstmt.setDouble(5, price);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }


        return false;
    }

    public static void main(String[] args) {
        PaymenTDAO p = new PaymenTDAO();
        boolean a = p.insertPayment(1,"qr","quyhslc11@gmailcom",10000);
        System.out.println(a);
    }






}
