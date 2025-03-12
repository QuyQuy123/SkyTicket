package dal;

import model.Seats;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SeatsDAO extends DBConnect{
    public List<Seats> getAllSeatByFlightId(int id) {
        List<Seats> seatsList = new ArrayList<>();
        String sql = "SELECT * FROM Seats WHERE FlightId = ?";

        try ( PreparedStatement st = connection.prepareStatement(sql)){
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Seats seat = new Seats(
                        rs.getInt("SeatId"),
                        rs.getInt("AirlineId"),
                        rs.getInt("Status"),
                        rs.getInt("SeatNumber"),
                        rs.getString("SeatClass"),
                        rs.getInt("IsBooked")
                );
                seatsList.add(seat);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return seatsList;
    }
    public List<Seats> getAllSeatByAirlineId(int id) {
        List<Seats> seatCategories = new ArrayList<>();
        String sql = "SELECT * FROM Seats WHERE AirlineId = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Seats seat = new Seats(
                        rs.getInt("SeatId"),
                        rs.getInt("AirlineId"),
                        rs.getInt("Status"),
                        rs.getInt("SeatNumber"),
                        rs.getString("SeatClass"), // Giả định SeatClass là danh mục ghế
                        rs.getInt("IsBooked")
                );
                seatCategories.add(seat);
            }
            return seatCategories;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        SeatsDAO seatsDAO = new SeatsDAO();
        List<Seats> seatsList = seatsDAO.getAllSeatByAirlineId(4);
        for (Seats seat : seatsList) {
            System.out.println(seat);
        }
    }


    public Seats getSeatById(int id) {
        String sql = "SELECT * FROM Seats WHERE SeatId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Seats(
                            rs.getInt("SeatId"),
                            rs.getInt("AirlineId"),
                            rs.getInt("Status"),
                            rs.getInt("SeatNumber"),
                            rs.getString("SeatClass"),
                            rs.getInt("IsBooked")
                    );
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createSeat(Seats seat) {
        String sql = "INSERT INTO Seats (AirlineId, Status, SeatNumber, SeatClass, IsBooked) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, seat.getAirlineId());
            ps.setInt(2, seat.getStatus());
            ps.setInt(3, seat.getSeatNumber());
            ps.setString(4, seat.getSeatClass());
            ps.setInt(5, seat.getIsBooked());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }







}
