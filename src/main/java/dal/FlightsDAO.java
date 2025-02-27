package dal;

import model.Airports;
import model.Flights;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FlightsDAO extends DBConnect {

    // Lấy danh sách tất cả chuyến bay
    public List<Flights> getAllFlights() {
        List<Flights> flights = new ArrayList<>();
        String sql = "SELECT * FROM Flights";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                flights.add(mapResultSetToFlight(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flights;
    }

    // Lấy chuyến bay theo ID
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

    // Cập nhật thông tin chuyến bay
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

    // Xóa chuyến bay theo ID
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

    public List<Flights> getFlightsByPage(int start, int total) {
        List<Flights> list = new ArrayList<>();
        String query = "SELECT * FROM Flights LIMIT ?, ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToFlight(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


    // Đếm tổng số chuyến bay
    public int getTotalFlights() {
        String query = "SELECT COUNT(*) FROM Flights";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }


    // Chuyển đổi ResultSet thành đối tượng Flights
    private Flights mapResultSetToFlight(ResultSet rs) throws SQLException {
        return new Flights(
                rs.getInt("FlightId"),
                rs.getTimestamp("ArrivalTime"),
                rs.getTimestamp("DepartureTime"),
                rs.getInt("ArrivalAirportId"),
                rs.getInt("DepartureAirportId"),
                rs.getInt("Status"),
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
        ps.setInt(5, flight.getStatus());
        ps.setInt(6, flight.getAirlineId());
        ps.setDouble(7, flight.getClassVipPrice());
        ps.setDouble(8, flight.getClassEconomyPrice());
    }
}