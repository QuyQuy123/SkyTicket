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
                "JOIN Flights f ON t.FlightId = f.FlightId\n" +
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









}
