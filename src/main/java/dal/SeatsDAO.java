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
                        rs.getInt("FlightId"),
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

    public List<Seats> getSeatClasses(int flightId) {
        List<Seats> seatList = new ArrayList<>();
        String sql = "SELECT  SeatClass \n" +
                "FROM Seats WHERE flightId =? && SeatClass IN ('Economy', 'Business') \n" +
                "GROUP BY SeatClass;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, flightId); // Truyền flightId vào SQL
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Seats seat = new Seats();
                seat.setSeatClass(rs.getString("SeatClass"));
                seatList.add(seat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seatList;
    }



    public static void main(String[] args) {
        SeatsDAO seatsDAO = new SeatsDAO();
        List<Seats> s = seatsDAO.getAllSeatByFlightId(16);

        System.out.println(s);
    }




}
