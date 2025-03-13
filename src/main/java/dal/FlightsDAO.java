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

    public boolean updateFlightStatus(int flightId, int status) {
        String query = "UPDATE Flights SET Status = ? WHERE FlightId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, status);
            ps.setInt(2, flightId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
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


    public List<Flights> getSearchFlightsByPage(int start, int total, String deA, String arA, Date dateFrom, Date dateTo, Double priceVipFrom, Double priceVipTo, Double priceEcoFrom, Double priceEcoTo, String airlineName, Integer status) {
        List<Flights> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = sqlSearchFlights(deA, arA, dateFrom, dateTo, priceVipFrom, priceVipTo, priceEcoFrom, priceEcoTo, airlineName, status, params);
        sql.append(" LIMIT ?, ?");
        params.add(start);
        params.add(total);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            prepareStatementParams(ps, params);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToFlight(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Flights> searchFlights(String deA, String arA, Date dateFrom, Date dateTo, Double priceVipFrom, Double priceVipTo, Double priceEcoFrom, Double priceEcoTo, String airlineName, Integer status) {
        List<Flights> flights = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder sql = sqlSearchFlights(deA, arA, dateFrom, dateTo, priceVipFrom, priceVipTo, priceEcoFrom, priceEcoTo, airlineName, status, params);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            prepareStatementParams(ps, params);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                flights.add(mapResultSetToFlight(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flights;
    }

    private StringBuilder sqlSearchFlights(String deA, String arA, Date dateFrom, Date dateTo, Double priceVipFrom, Double priceVipTo, Double priceEcoFrom, Double priceEcoTo, String airlineName, Integer status, List<Object> params) {
        StringBuilder sql = new StringBuilder("SELECT * FROM Flights WHERE 1=1");

        if (deA != null && !deA.isEmpty()) {
            sql.append(" AND DepartureAirportId IN (SELECT AirportId FROM Airports WHERE airportName LIKE ?)");
            params.add("%" + deA.trim() + "%");
        }
        if (arA != null && !arA.isEmpty()) {
            sql.append(" AND ArrivalAirportId IN (SELECT AirportId FROM Airports WHERE airportName LIKE ?)");
            params.add("%" + arA.trim() + "%");
        }
        if (dateFrom != null) {
            sql.append(" AND DATE(DepartureTime) >= ?");
            params.add(dateFrom);
        }
        if (dateTo != null) {
            sql.append(" AND DATE(DepartureTime) <= ?");
            params.add(dateTo);
        }
        if (priceVipFrom != null) {
            sql.append(" AND ClassVipPrice >= ?");
            params.add(priceVipFrom);
        }
        if (priceVipTo != null) {
            sql.append(" AND ClassVipPrice <= ?");
            params.add(priceVipTo);
        }
        if (priceEcoFrom != null) {
            sql.append(" AND ClassEconomyPrice >= ?");
            params.add(priceEcoFrom);
        }
        if (priceEcoTo != null) {
            sql.append(" AND ClassEconomyPrice <= ?");
            params.add(priceEcoTo);
        }
        if (airlineName != null && !airlineName.isEmpty()) {
            sql.append(" AND AirlineId IN (SELECT AirlineId FROM Airlines WHERE airlineName LIKE ?)");
            params.add("%" + airlineName.trim() + "%");
        }
        if (status != null) {
            sql.append(" AND Status = ?");
            params.add(status);
        }

        return sql;
    }

    private void prepareStatementParams(PreparedStatement ps, List<Object> params) throws SQLException {
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
    }





    public static void main(String[] args) {
        FlightsDAO dao = new FlightsDAO();
        int depAirportId = 5;
        int arrAirportId = 1;
        String depDateStr = "2025-02-23"; // Định dạng: dd-MM-yyyy

        try {
            Date parsedDate = Date.valueOf(depDateStr);

            // Gọi method để lấy danh sách chuyến bay
            List<Flights> flights = dao.getFlightsByAirportAndDate(depAirportId, arrAirportId, parsedDate);

            // In kết quả
            System.out.println("Danh sách chuyến bay:");
            System.out.println(flights);
            for (Flights flight : flights) {
                System.out.println(flight);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



}

