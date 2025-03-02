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

    //Lấy danh sách tất cả ghế
    public List<Seats> getAllSeats() {
        List<Seats> seatsList = new ArrayList<>();
        String query = "SELECT * FROM Seats";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                seatsList.add( new Seats(
                        rs.getInt("SeatId"),
                        rs.getInt("FlightId"),
                        rs.getInt("Status"),
                        rs.getInt("SeatNumber"),
                        rs.getString("SeatClass"),
                        rs.getInt("IsBooked")
                ));
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return seatsList;
    }

    // Lấy thông tin gh theo ID
    public Seats getSeatById(int id) {
        String sql = "SELECT * FROM Seats WHERE SeatId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Seats(
                            rs.getInt("SeatId"),
                            rs.getInt("FlightId"),
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

    // Thêm ghế mới
    public boolean addSeat(Seats seat) {
        String query = "INSERT INTO Seats (FlightId, Status, SeatNumber, SeatClass, IsBooked) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, seat.getFlightId());
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
    // Cập nhật thông tin ghế
    public boolean updateSeat(Seats seat) {
        String query = "UPDATE Seats SET FlightId=?, Status=?, SeatNumber=?, SeatClass=?, IsBooked=? WHERE SeatId=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, seat.getFlightId());
            ps.setInt(2, seat.getStatus());
            ps.setInt(3, seat.getSeatNumber());
            ps.setString(4, seat.getSeatClass());
            ps.setInt(5, seat.getIsBooked());
            ps.setInt(6, seat.getSeatId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa ghế theo ID
    public boolean deleteSeat(int id) {
        String query = "DELETE FROM Seats WHERE SeatId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật trạng thái đặt chỗ của ghế
    public boolean updateSeatBookingStatus(int id, int isBooked) {
        String query = "UPDATE Seats SET IsBooked = ? WHERE SeatId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, isBooked);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getTotalRecords() {
        String query = "SELECT COUNT(*) FROM Seats";
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Seats> getSeatsByPage(int start, int total) {
        List<Seats> seatsList = new ArrayList<>();
        String query = "SELECT * FROM Seats LIMIT ?, ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                seatsList.add(new Seats(
                        rs.getInt("SeatId"),
                        rs.getInt("FlightId"),
                        rs.getInt("Status"),
                        rs.getInt("SeatNumber"),
                        rs.getString("SeatClass"),
                        rs.getInt("IsBooked")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seatsList;
    }

    public List<Seats> searchSeats(Integer seatId, Integer flightId, Integer status, Integer isBooked, int start, int total) {
        List<Seats> seats = new ArrayList<>();
        String query = "SELECT * FROM Seats WHERE 1=1";

        if (seatId != null) query += " AND SeatId = ?";
        if (flightId != null) query += " AND FlightId = ?";
        if (status != null) query += " AND Status = ?";
        if (isBooked != null) query += " AND IsBooked = ?";
        query += " LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            int index = 1;
            if (seatId != null) ps.setInt(index++, seatId);
            if (flightId != null) ps.setInt(index++, flightId);
            if (status != null) ps.setInt(index++, status);
            if (isBooked != null) ps.setInt(index++, isBooked);
            ps.setInt(index++, start);
            ps.setInt(index, total);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                seats.add(new Seats(
                        rs.getInt("SeatId"),
                        rs.getInt("FlightId"),
                        rs.getInt("Status"),
                        rs.getInt("SeatNumber"),
                        rs.getString("SeatClass"),
                        rs.getInt("IsBooked")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return seats;
    }

    public int countFilteredSeats(Integer seatId, Integer flightId, Integer status, Integer isBooked) {
        String query = "SELECT COUNT(*) FROM Seats WHERE 1=1";

        if (seatId != null) query += " AND SeatId = ?";
        if (flightId != null) query += " AND FlightId = ?";
        if (status != null) query += " AND Status = ?";
        if (isBooked != null) query += " AND IsBooked = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            int index = 1;
            if (seatId != null) ps.setInt(index++, seatId);
            if (flightId != null) ps.setInt(index++, flightId);
            if (status != null) ps.setInt(index++, status);
            if (isBooked != null) ps.setInt(index++, isBooked);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }



    public static void main(String[] args) {
        SeatsDAO seatsDAO = new SeatsDAO();
        // Lấy tất cả ghế
        System.out.println("Danh sách ghế:");
        for (Seats seat : seatsDAO.getAllSeats()) {
            System.out.println(seat);
        }

        // Lấy ghế theo ID
        System.out.println("Thông tin ghế có ID 1: " + seatsDAO.getSeatById(1));

        // Thêm ghế mới
        Seats newSeat = new Seats(0, 2, 1, 15, "Business", 0);
        System.out.println("Thêm ghế mới: " + seatsDAO.addSeat(newSeat));

        // Cập nhật ghế
        Seats updatedSeat = new Seats(1, 2, 1, 16, "Economy", 1);
        System.out.println("Cập nhật ghế: " + seatsDAO.updateSeat(updatedSeat));

        // Xóa ghế
        System.out.println("Xóa ghế có ID 3: " + seatsDAO.deleteSeat(3));

        // Cập nhật trạng thái đặt chỗ
        System.out.println("Cập nhật trạng thái đặt chỗ của ghế ID 2: " + seatsDAO.updateSeatBookingStatus(2, 1));
    }




}
