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
    public int addSeat(Seats seat) {
        int n = 0;
        String query = "INSERT INTO Seats (FlightId, Status, SeatNumber, SeatClass, IsBooked) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, seat.getFlightId());
            ps.setInt(2, seat.getStatus());
            ps.setInt(3, seat.getSeatNumber());
            ps.setString(4, seat.getSeatClass());
            ps.setInt(5, seat.getIsBooked());
            n = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
    }
    // Cập nhật thông tin ghế
    public int updateSeat(Seats seat) {
        int n = 0;
        String query = "UPDATE Seats SET FlightId=?, Status=?, SeatNumber=?, SeatClass=?, IsBooked=? WHERE SeatId=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, seat.getFlightId());
            ps.setInt(2, seat.getStatus());
            ps.setInt(3, seat.getSeatNumber());
            ps.setString(4, seat.getSeatClass());
            ps.setInt(5, seat.getIsBooked());
            ps.setInt(6, seat.getSeatId());
            n = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return n;
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
    public List<String> getSeatsByFlightId(String flightId) {
        List<String> seats = new ArrayList<>();
        String sql = "SELECT seat_number FROM Seats WHERE flight_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, flightId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                seats.add(rs.getString("seat_number"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return seats;
    }
    public boolean isSeatNumberExists(int seatNumber, int flightId) {
        try {
            String sql = "SELECT COUNT(*) FROM Seats WHERE seatNumber = ? AND flightId = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, seatNumber);
            ps.setInt(2, flightId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public static void main(String[] args) {
        SeatsDAO seatsDAO = new SeatsDAO();
//
//        // Tạo đối tượng Seat với dữ liệu cần update
//        Seats seat = new Seats(1, 1, 1, 1, "Business", 0); // Giả sử SeatId = 1
//
//        // Gọi phương thức updateSeat và in kết quả
//        boolean result = seatsDAO.updateSeat(seat);
//
//        if (result) {
//            System.out.println("Cập nhật ghế thành công!");
//        } else {
//            System.out.println("Cập nhật ghế thất bại!");
//        }
    }




}
