package dal;

import model.Countries;
import model.Locations;
import model.Passengers;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class PassengersDAO extends DBConnect {
    public List<Passengers> getAllPassengers() {
        List<Passengers> list = new ArrayList<>();
        String sql = "select * from Passengers";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("PassengerId");
                String name = rs.getString("PassengerName");
                String phone = rs.getString("Phone");
                String address = rs.getString("Address");
                Date birthDate = rs.getDate("Dob");
                String gender = rs.getString("Gender");
                int accountId = rs.getInt("AccountId");
                list.add(new Passengers(id, name, phone, address, birthDate, gender, accountId));
            }
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return list;
    }

    public List<Passengers> getPassengersByPage(int start, int total) {
        List<Passengers> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM Passengers LIMIT ?, ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Passengers(
                        rs.getInt("passengerid"),
                        rs.getString("passengername"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getDate("dob"),
                        rs.getString("gender"),
                        rs.getInt("accountid")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalRecords() {
        int total = 0;
        try {
            String query = "SELECT COUNT(*) FROM Passengers";
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<Passengers> searchPassengerByPage(String keyword, String status, int offset, int limit) {
        List<Passengers> list = new ArrayList<>();
        String sql = "SELECT * FROM Passengers WHERE 1=1";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (passengername LIKE ? OR phone LIKE ?)";
        }
        if (status != null) {
            sql += " AND Gender LIKE ?";
        }
        sql += " LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
                ps.setString(index++, "%" + keyword + "%");
            }
            if (status != null) {
                ps.setString(index++, "%" + status + "%");
            }
            ps.setInt(index++, offset);
            ps.setInt(index, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Passengers(
                        rs.getInt("passengerid"),
                        rs.getString("passengername"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getDate("dob"),
                        rs.getString("gender"),
                        rs.getInt("accountid")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalSearchRecords(String keyword, String status) {
        String sql = "SELECT COUNT(*) FROM Passengers WHERE 1=1";

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (passengername LIKE ? OR phone LIKE ?)";
        }
        if (status != null) {
            sql += " AND gender LIKE ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
                ps.setString(index++, "%" + keyword + "%");
            }
            if (status != null) {
                ps.setString(index++, "%" + status + "%");
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Passengers getPassengerById(int id) {
        String sql = "SELECT * FROM Passengers WHERE passengerid = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int passengerId = rs.getInt("passengerid");
                    String passengerName = rs.getString("passengername");
                    String phone = rs.getString("phone");
                    String address = rs.getString("Address");
                    Date birthDate = rs.getDate("Dob");
                    String gender = rs.getString("Gender");
                    int accountId = rs.getInt("AccountId");
                    return new Passengers(passengerId, passengerName, phone, address, birthDate, gender, accountId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createPassenger(String passengerName, String phone,Date dob,String gender, Integer idAcc, int bookId) {
        String sql = "INSERT INTO Passengers (PassengerName, Phone, Dob, Gender, AccountId,BookingId ) " +
                "VALUES (?, ?, ?, ?, ?,?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1,passengerName);
            stmt.setString(2,phone);
            stmt.setDate(3, (java.sql.Date) dob); // Đảm bảo dob là LocalDate
            stmt.setString(4,gender);
            if (idAcc != null) {
                stmt.setInt(5, idAcc);
            } else {
                stmt.setNull(5, java.sql.Types.INTEGER);
            }
            stmt.setInt(6, bookId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Passengers> getPassengersByBookingId(int bookingId) {
        String sql = "SELECT * FROM Passengers WHERE BookingId = ?";
        List<Passengers> passengers = new ArrayList<>();

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) { // Duyệt qua tất cả kết quả thay vì chỉ lấy 1
                    Passengers passenger = new Passengers();
                    passenger.setPassengerID(rs.getInt("PassengerId"));
                    passenger.setPassengerName(rs.getString("PassengerName"));
                    passenger.setPhone(rs.getString("Phone"));
                    passenger.setAddress(rs.getString("Address"));
                    passenger.setDateOfBirth(rs.getDate("Dob"));
                    passenger.setGender(rs.getString("Gender"));
                    passenger.setAccountID(rs.getInt("AccountId"));

                    passengers.add(passenger); // Thêm vào danh sách
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return passengers;
    }
    public int getBookingidById(int id) {
        String sql = "SELECT bookingid FROM Passengers WHERE passengerid = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("bookingid");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Passengers getLatestPassengerByBookingId(int bookingId) {
        String sql = "SELECT * FROM Passengers WHERE BookingId = ? ORDER BY PassengerId DESC LIMIT 1";
        Passengers passenger = null;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, bookingId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) { // Chỉ lấy 1 bản ghi (mới nhất)
                    passenger = new Passengers();
                    passenger.setPassengerID(rs.getInt("PassengerId"));
                    passenger.setPassengerName(rs.getString("PassengerName"));
                    passenger.setPhone(rs.getString("Phone"));
                    passenger.setAddress(rs.getString("Address"));
                    passenger.setDateOfBirth(rs.getDate("Dob"));
                    passenger.setGender(rs.getString("Gender"));
                    passenger.setAccountID(rs.getInt("AccountId"));
                    passenger.setBookingId(rs.getInt("BookingId")); // Thêm BookingId
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return passenger;
    }
    public int getPassengerIdByTicketId(int ticketId)  {
        int passengerId = -1;
        String query = "SELECT PassengerId FROM Tickets WHERE TicketId = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, ticketId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    passengerId = rs.getInt("PassengerId");
                } else {
                    throw new SQLException("No ticket found with TicketId: " + ticketId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return passengerId;
    }


    public static void main(String[] args) {
        System.out.println("Xin chao cac ban");
    }
    


}

