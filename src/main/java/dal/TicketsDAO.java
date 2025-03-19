package dal;

import model.Tickets;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
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
            System.out.println(e.getMessage());
        }
        return ls;
    }

    public Tickets getTicketByCode(String code, int flightId, int seatId) {
        String sql = "SELECT * FROM Tickets WHERE Code = ? AND FlightId = ? AND SeatId = ? AND Status=1";

        try( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setInt(2, flightId);
            ps.setInt(3, seatId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Tickets(
                        rs.getInt("TicketId"),
                        rs.getInt("SeatId"),
                        rs.getInt("PassengerId"),
                        rs.getString("Code"),
                        rs.getInt("Status"),
                        rs.getTimestamp("CreateAt"),
                        rs.getInt("BookingId"),
                        rs.getInt("FlightId"),
                        rs.getInt("BaggageId"),
                        rs.getTimestamp("CancelledAt")
                );
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public int createTicket(String code, int flightId, int seatId, int passengerId
                            , int bookingId, int baggageId,float price) {
        int n = 0;
        String sql = "INSERT INTO Tickets (Code, FlightId, SeatId, PassengerId, Status, CreateAt "
                + ", BookingId, BaggageId,price) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";

        try(PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.setInt(2, flightId);
            ps.setInt(3, seatId);
            ps.setInt(4, passengerId);
            ps.setInt(5, 1);
            ps.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            ps.setInt(7, bookingId);
            ps.setInt(8, baggageId);
            ps.setFloat(9, price);
            n = ps.executeUpdate();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return n;
    }

    public static void main(String[] args) {
        TicketsDAO dao = new TicketsDAO();

    }














}
