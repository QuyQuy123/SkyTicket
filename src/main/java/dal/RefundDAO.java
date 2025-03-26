package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Baggages;
import model.Refund;

public class RefundDAO extends DBConnect {

    // Lấy danh sách tất cả yêu cầu hoàn tiền
    public List<Refund> getAllRefunds() {
        List<Refund> refundList = new ArrayList<>();
        String sql = "SELECT r.RefundId, r.TicketId, r.BankAccount, r.BankName, r.RequestDate, " +
                "r.RefundDate, r.RefundPrice, r.Status, t.Code " +
                "FROM Refund r JOIN Tickets t ON r.TicketId = t.TicketId";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Refund refund = new Refund();
                refund.setRefundId(rs.getInt("RefundId"));
                refund.setTicketId(rs.getInt("TicketId"));
                refund.setBankAccount(rs.getString("BankAccount"));
                refund.setBankName(rs.getString("BankName"));
                refund.setRequestDate(rs.getTimestamp("RequestDate"));
                refund.setRefundDate(rs.getTimestamp("RefundDate"));
                refund.setRefundPrice(rs.getDouble("RefundPrice"));
                refund.setStatus(rs.getInt("Status"));
                refund.setTicketCode(rs.getString("Code"));
                refundList.add(refund);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return refundList;
    }

    // Lấy danh sách yêu cầu hoàn tiền theo trạng thái
    public List<Refund> getRefundsByStatus(int status) {
        List<Refund> refundList = new ArrayList<>();
        String sql = "SELECT r.RefundId, r.TicketId, r.BankAccount, r.BankName, r.RequestDate, " +
                "r.RefundDate, r.RefundPrice, r.Status, t.Code " +
                "FROM Refund r JOIN Tickets t ON r.TicketId = t.TicketId " +
                "WHERE r.Status = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, status);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Refund refund = new Refund();
                    refund.setRefundId(rs.getInt("RefundId"));
                    refund.setTicketId(rs.getInt("TicketId"));
                    refund.setBankAccount(rs.getString("BankAccount"));
                    refund.setBankName(rs.getString("BankName"));
                    refund.setRequestDate(rs.getTimestamp("RequestDate"));
                    refund.setRefundDate(rs.getTimestamp("RefundDate"));
                    refund.setRefundPrice(rs.getDouble("RefundPrice"));
                    refund.setStatus(rs.getInt("Status"));
                    refund.setTicketCode(rs.getString("Code"));
                    refundList.add(refund);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return refundList;
    }

    // Lấy chi tiết một yêu cầu hoàn tiền theo RefundId
    public Refund getRefundById(int refundId) {
        String sql = "SELECT r.RefundId, r.TicketId, r.BankAccount, r.BankName, r.RequestDate, " +
                "r.RefundDate, r.RefundPrice, r.Status, t.Code " +
                "FROM Refund r JOIN Tickets t ON r.TicketId = t.TicketId " +
                "WHERE r.RefundId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, refundId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Refund refund = new Refund();
                    refund.setRefundId(rs.getInt("RefundId"));
                    refund.setTicketId(rs.getInt("TicketId"));
                    refund.setBankAccount(rs.getString("BankAccount"));
                    refund.setBankName(rs.getString("BankName"));
                    refund.setRequestDate(rs.getTimestamp("RequestDate"));
                    refund.setRefundDate(rs.getTimestamp("RefundDate"));
                    refund.setRefundPrice(rs.getDouble("RefundPrice"));
                    refund.setStatus(rs.getInt("Status"));
                    refund.setTicketCode(rs.getString("Code"));
                    return refund;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm mới một yêu cầu hoàn tiền
    public void addRefund(Refund refund) {
        String sql = "INSERT INTO Refund (TicketId, BankAccount, BankName, RequestDate, RefundPrice, Status) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, refund.getTicketId());
            stmt.setString(2, refund.getBankAccount());
            stmt.setString(3, refund.getBankName());
            stmt.setTimestamp(4, refund.getRequestDate());
            stmt.setDouble(5, refund.getRefundPrice());
            stmt.setInt(6, refund.getStatus());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Cập nhật trạng thái yêu cầu hoàn tiền (Approve hoặc Reject)
    public void updateRefundStatus(int refundId, int status) {
        String sql;
        if (status == 2) { // Refund Success
            sql = "UPDATE Refund SET Status = ?, RefundDate = NOW() WHERE RefundId = ?";
        } else { // Refund Failed hoặc Pending
            sql = "UPDATE Refund SET Status = ? WHERE RefundId = ?";
        }
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, status);
            stmt.setInt(2, refundId);
            stmt.executeUpdate();

            // Nếu phê duyệt hoàn tiền, cập nhật trạng thái vé thành "Cancelled"
            if (status == 2) {
                String updateTicketSql = "UPDATE Tickets SET Status = 'Cancelled', CancelledAt = NOW() " +
                        "WHERE TicketId = (SELECT TicketId FROM Refund WHERE RefundId = ?)";
                try (PreparedStatement ticketStmt = connection.prepareStatement(updateTicketSql)) {
                    ticketStmt.setInt(1, refundId);
                    ticketStmt.executeUpdate();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getTotalRecords() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Refund";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
    public List<Refund> getRefundByPage(int start, int total) {
        List<Refund> refunds = new ArrayList<>();
        String sql = "SELECT * FROM Refund LIMIT ?, ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, start);
            pstmt.setInt(2, total);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Refund refund = new Refund();
                refund.setRefundId(rs.getInt("RefundId"));
                refund.setTicketId(rs.getInt("TicketId"));
                refund.setBankAccount(rs.getString("BankAccount"));
                refund.setBankName(rs.getString("BankName"));
                refund.setRequestDate(rs.getTimestamp("RequestDate"));
                refund.setRefundDate(rs.getTimestamp("RefundDate"));
                refund.setRefundPrice(rs.getDouble("RefundPrice"));
                refund.setStatus(rs.getInt("Status"));
                refunds.add(refund);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return refunds;
    }

    public List<Refund> searchRefunds(String refundId, String ticketCode, String status, String orderPricet, int page, int recordsPerPage) throws SQLException {
        List<Refund> refundList = new ArrayList<>();
        String sql = "SELECT r.* FROM Refund r JOIN Tickets t ON r.TicketId = t.TicketId WHERE 1=1";

        if (refundId != null && !refundId.trim().isEmpty()) {
            sql += " AND r.RefundId = ?";
        }
        if (ticketCode != null && !ticketCode.trim().isEmpty()) {
            sql += " AND t.Code LIKE ?";
        }
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND r.Status = ?";
        }

        if ("asc".equals(orderPricet)) {
            sql += " ORDER BY r.RefundPrice ASC";
        } else if ("desc".equals(orderPricet)) {
            sql += " ORDER BY r.RefundPrice DESC";
        }

        int offset = (page - 1) * recordsPerPage;
        sql += " LIMIT ?, ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int index = 1;
            if (refundId != null && !refundId.trim().isEmpty()) {
                stmt.setString(index++, refundId);
            }
            if (ticketCode != null && !ticketCode.trim().isEmpty()) {
                stmt.setString(index++, "%" + ticketCode + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                stmt.setInt(index++, Integer.parseInt(status));
            }
            stmt.setInt(index++, offset);
            stmt.setInt(index++, recordsPerPage);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Refund refund = new Refund();
                refund.setRefundId(rs.getInt("RefundId"));
                refund.setTicketId(rs.getInt("TicketId"));
                refund.setBankAccount(rs.getString("BankAccount"));
                refund.setBankName(rs.getString("BankName"));
                refund.setRequestDate(rs.getTimestamp("RequestDate"));
                refund.setRefundDate(rs.getTimestamp("RefundDate"));
                refund.setRefundPrice(rs.getDouble("RefundPrice"));
                refund.setStatus(rs.getInt("Status"));
                refundList.add(refund);
            }
        }
        return refundList;
    }

    public int getTotalRecordsFiltered(String refundId, String ticketCode, String status) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Refund r JOIN Tickets t ON r.TicketId = t.TicketId WHERE 1=1";

        if (refundId != null && !refundId.trim().isEmpty()) {
            sql += " AND r.RefundId = ?";
        }
        if (ticketCode != null && !ticketCode.trim().isEmpty()) {
            sql += " AND t.Code LIKE ?";
        }
        if (status != null && !status.trim().isEmpty()) {
            sql += " AND r.Status = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            if (refundId != null && !refundId.trim().isEmpty()) {
                ps.setString(index++, refundId);
            }
            if (ticketCode != null && !ticketCode.trim().isEmpty()) {
                ps.setString(index++, "%" + ticketCode + "%");
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setInt(index++, Integer.parseInt(status));
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Kiểm tra Ticket Code và trả về TicketId nếu tồn tại
    public int getTicketIdByCode(String ticketCode) throws SQLException {
        String sql = "SELECT TicketId FROM Tickets WHERE Code = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, ticketCode);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("TicketId");
            }
        }
        return -1; // Trả về -1 nếu không tìm thấy
    }

    // Xóa một yêu cầu hoàn tiền
    public void deleteRefund(int refundId) {
        String sql = "DELETE FROM Refund WHERE RefundId = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, refundId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

        public static void main(String[] args) {
            RefundDAO refundDAO = new RefundDAO();
        }
}