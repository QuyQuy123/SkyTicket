package dal;

import model.Tickets;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TicketsDAO extends DBConnect{
    public List<String> getAllTicketCodesById(int flightlID, int seatId) {
        List<String> ls = new ArrayList<>();
        String sql = "SELECT t.Code \n" +
                "FROM Tickets t\n" +
                "JOIN Seats s ON t.SeatId = s.SeatId\n" +
                "JOIN Flights f ON s.FlightId = f.FlightId\n" +
                "WHERE f.FlightId = ? \n" +
                "AND s.SeatClass = ?;\n   ";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, flightlID);
            ps.setInt(2, seatId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    if (rs.getString("code") != null) {
                        ls.add(rs.getString("code"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ls;
    }


    public Tickets getTicketByCode(String code, int flightId, int seatId) {
        String sql = "SELECT t.* FROM Tickets t "
                + "JOIN Seats s ON t.SeatId = s.SeatId "
                + "WHERE t.Code = ? AND s.FlightId = ? "
                + "AND (t.Status = 10 OR t.Status = 12) AND s.SeatId = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, code);
            ps.setInt(2, flightId);
            ps.setInt(3, seatId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Tickets t = new Tickets(
                        rs.getInt("ticketId"),
                        rs.getInt("seatId"),
                        rs.getString("code"),
                        rs.getDouble("totalPrice"),
                        rs.getInt("bookingDetailId"),
                        rs.getInt("status"),
                        rs.getTimestamp("createAt")
                );
                return t;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }






}
