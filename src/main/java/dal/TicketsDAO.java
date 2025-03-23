package dal;

import model.Airlines;
import model.Tickets;

import java.sql.*;
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

    public int createTicket(String code, int flightId, int seatId, int passengerId,
                            int bookingId, int baggageId, float price) {
        int n = 0;
        int ticketId = -1;
        String sql = "INSERT INTO Tickets (Code, FlightId, SeatId, PassengerId, Status, CreateAt, "
                + "BookingId, BaggageId, price) "
                + "VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, flightId);
            ps.setInt(2, seatId);
            ps.setInt(3, passengerId);
            ps.setInt(4, 1);
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            ps.setInt(6, bookingId);
            ps.setInt(7, baggageId);
            ps.setFloat(8, price);

            n = ps.executeUpdate();

            // Retrieve the generated TicketId
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    ticketId = generatedKeys.getInt(1);
                } else {
                    System.out.println("Failed to retrieve TicketId.");
                    return -1; // Return -1 if TicketId retrieval fails
                }
            }

            // Update the ticket code with airline name, flightId, and ticketId
            FlightsDAO fDAO = new FlightsDAO();
            AirlinesDAO aDAO = new AirlinesDAO();
            int aid = fDAO.getAirlineIdByFlightId(flightId);
            Airlines al = aDAO.getAirlineById(aid);
            String nameAirline = al.getAirlineName();
            String newCode = nameAirline + "_" + flightId + "_" + ticketId;

            String updateSql = "UPDATE Tickets SET Code = ? WHERE TicketId = ?";
            try (PreparedStatement updatePs = connection.prepareStatement(updateSql)) {
                updatePs.setString(1, newCode);
                updatePs.setInt(2, ticketId);
                updatePs.executeUpdate();
            }

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
            return -1;
        }
        return n;
    }

    public List<Tickets> getAllTicketsByBookingId(int bookingId) {
        List<Tickets> tickets = new ArrayList<>();
        String query = "SELECT * FROM Tickets WHERE BookingId = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookingId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Tickets ticket = new Tickets(
                            rs.getInt("TicketId"),
                            rs.getInt("SeatId"),
                            rs.getInt("PassengerId"),
                            rs.getString("Code"),
                            rs.getInt("Status"),
                            rs.getTimestamp("CreateAt"),
                            rs.getInt("BookingId"),
                            rs.getInt("FlightId"),
                            rs.getInt("BaggageId"),
                            rs.getFloat("Price"),
                            rs.getTimestamp("cancelledAt")
                    );
                    tickets.add(ticket);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return tickets;
    }






    public static void main(String[] args) {
        TicketsDAO dao = new TicketsDAO();
        List<Tickets> t = dao.getAllTicketsByBookingId(3);
        System.out.println(t);


    }














}
