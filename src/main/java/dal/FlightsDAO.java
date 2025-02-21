package dal;

import model.Airports;
import model.Flights;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FlightsDAO extends DBConnect {




    public List<Flights> getFlightsByAirportAndDate(int depAirportId, int arrAirportId, Date date) {
        List<Flights> flights = new ArrayList<>();
        String sql = "SELECT * FROM flights " +
                "WHERE DepartureAirportId = ? " +
                "AND ArrivalAirportId = ? " +
                "AND DATE(DepartureTime) = ? " +
                "ORDER BY DepartureTime ASC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, depAirportId);
            ps.setInt(2, arrAirportId);
            ps.setDate(3, date); // Không cần STR_TO_DATE

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                flights.add(new Flights(
                        rs.getInt("FlightId"),
                        rs.getTimestamp("ArrivalTime"),
                        rs.getTimestamp("DepartureTime"),
                        rs.getInt("ArrivalAirportId"),
                        rs.getInt("DepartureAirportId"),
                        rs.getString("Status"),
                        rs.getInt("AirlineId"),
                        rs.getDouble("ClassVipPrice"),
                        rs.getDouble("ClassEconomyPrice")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flights;
    }


    public static void main(String[] args) {
        FlightsDAO dao = new FlightsDAO();
        int depAirportId = 1;
        int arrAirportId = 2;

        // Chuyển đổi đúng định dạng ngày
        LocalDate localDate = LocalDate.of(2025, 2, 20);
        Date date = Date.valueOf(localDate);  // Chuyển thành java.sql.Date

        List<Flights> flights = dao.getFlightsByAirportAndDate(depAirportId, arrAirportId, date);

        if (flights.isEmpty()) {
            System.out.println("Không tìm thấy chuyến bay nào.");
        } else {
            System.out.println("Danh sách chuyến bay:");
            for (Flights flight : flights) {
                System.out.println(flight);
            }
        }
    }

}
