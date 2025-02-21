package dal;

import dal.DBConnect;
import model.Flights;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FlightsDAO extends DBConnect {
    private Connection connection;

    // Lấy tất cả các chuyến bay
    public List<Flights> getAllFlights() {
        List<Flights> flights = new ArrayList<>();
        String sql = "SELECT * FROM Flights";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Flights flight = mapResultSetToFlight(rs);
                flights.add(flight);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flights;
    }

    // Lấy thông tin chuyến bay theo ID
    public Flights getFlightById(int flightId) {
        String sql = "SELECT * FROM Flights WHERE FlightId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, flightId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToFlight(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm chuyến bay mới
    public boolean addFlight(Flights flight) {
        String sql = "INSERT INTO Flights (ArrivalTime, DepartureTime, ArrivalAirportId, DepartureAirportId, Status, AirlineId, ClassVipPrice, ClassEconomyPrice) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setFlightParams(ps, flight);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật chuyến bay
    public boolean updateFlight(Flights flight) {
        String sql = "UPDATE Flights SET ArrivalTime = ?, DepartureTime = ?, ArrivalAirportId = ?, DepartureAirportId = ?, Status = ?, AirlineId = ?, ClassVipPrice = ?, ClassEconomyPrice = ? WHERE FlightId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            setFlightParams(ps, flight);
            ps.setInt(9, flight.getFlightId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa chuyến bay
    public boolean deleteFlight(int flightId) {
        String sql = "DELETE FROM Flights WHERE FlightId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, flightId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Map dữ liệu từ ResultSet vào đối tượng Flights
    private Flights mapResultSetToFlight(ResultSet rs) throws SQLException {
        return new Flights(
                rs.getInt("FlightId"),
                rs.getTimestamp("ArrivalTime"),
                rs.getTimestamp("DepartureTime"),
                rs.getInt("ArrivalAirportId"),
                rs.getInt("DepartureAirportId"),
                rs.getString("Status"),
                rs.getInt("AirlineId"),
                rs.getDouble("ClassVipPrice"),
                rs.getDouble("ClassEconomyPrice")
        );
    }

    // Thiết lập tham số cho PreparedStatement
    private void setFlightParams(PreparedStatement ps, Flights flight) throws SQLException {
        ps.setTimestamp(1, flight.getArrivalTime());
        ps.setTimestamp(2, flight.getDepartureTime());
        ps.setInt(3, flight.getArrivalAirportId());
        ps.setInt(4, flight.getDepartureAirportId());
        ps.setString(5, flight.getStatus());
        ps.setInt(6, flight.getAirlineId());
        ps.setDouble(7, flight.getClassVipPrice());
        ps.setDouble(8, flight.getClassEconomyPrice());
    }
}