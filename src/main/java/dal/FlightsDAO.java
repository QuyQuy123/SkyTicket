package dal;

import model.Flights;

import java.sql.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class FlightsDAO extends DBConnect {


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

    public List<Flights> getFlightsByAirportAndDate(int depAirportId, int arrAirportId, Date date) {
        List<Flights> flights = new ArrayList<>();
        String sql = "SELECT * FROM flights " +
                "WHERE DepartureAirportId = ? " +
                "AND ArrivalAirportId = ? " +
                "AND DATE(DepartureTime) = ? " +  // Chỉ so sánh phần ngày
                "ORDER BY DepartureTime ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, depAirportId);
            ps.setInt(2, arrAirportId);
            ps.setDate(3,date); // Truyền java.sql.Date trực tiếp vào

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                flights.add(new Flights(
                        rs.getInt("FlightId"),
                        rs.getTimestamp("ArrivalTime"),
                        rs.getTimestamp("DepartureTime"),
                        rs.getInt("ArrivalAirportId"),
                        rs.getInt("DepartureAirportId"),
                        rs.getInt("Status"),
                        rs.getInt("AirlineId"),
                        rs.getDouble("ClassVipPrice"),
                        rs.getDouble("ClassEconomyPrice")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Cần logging thay vì in lỗi ra console
        }
        return flights;
    }



    public int getAirlineIdByFlightId(int flightId) {
        String sql = "SELECT AirlineId FROM Flights WHERE FlightId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, flightId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("AirlineId");
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        return -1; // Trả về -1 nếu không tìm thấy dữ liệu
    }
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







    public static void main(String[] args) {
        FlightsDAO dao = new FlightsDAO();
        int depAirportId = 5;
        int arrAirportId = 1;
        String depDateStr = "2025-02-22"; // Định dạng: dd-MM-yyyy

        try {
            Date parsedDate = Date.valueOf(depDateStr);

            // Gọi method để lấy danh sách chuyến bay
            List<Flights> flights = dao.getFlightsByAirportAndDate(depAirportId, arrAirportId, parsedDate);

            // In kết quả
            System.out.println("Danh sách chuyến bay:");
            for (Flights flight : flights) {
                System.out.println(flight);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }



}

