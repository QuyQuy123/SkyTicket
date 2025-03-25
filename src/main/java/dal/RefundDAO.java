package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Refund;
import java.sql.Timestamp;
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

            // Test getAllRefunds
            System.out.println("Danh sách tất cả yêu cầu hoàn tiền:");
            List<Refund> refunds = refundDAO.getAllRefunds();
            for (Refund refund : refunds) {
                System.out.println(refund);
            }

            // Test getRefundsByStatus
            int testStatus = 1;
            System.out.println("\nDanh sách yêu cầu hoàn tiền với trạng thái " + testStatus + ":");
            List<Refund> refundsByStatus = refundDAO.getRefundsByStatus(testStatus);
            for (Refund refund : refundsByStatus) {
                System.out.println(refund);
            }

            // Test getRefundById
            int testRefundId = 1;
            System.out.println("\nChi tiết yêu cầu hoàn tiền với RefundId = " + testRefundId + ":");
            Refund refund = refundDAO.getRefundById(testRefundId);
            System.out.println(refund);

            // Test addRefund
            System.out.println("\nThêm mới yêu cầu hoàn tiền:");
            Refund newRefund = new Refund();
            newRefund.setTicketId(2);
            newRefund.setBankAccount("123456789");
            newRefund.setBankName("ABC Bank");
            newRefund.setRequestDate(new Timestamp(System.currentTimeMillis()));
            newRefund.setRefundPrice(500.0);
            newRefund.setStatus(0); // Pending
            refundDAO.addRefund(newRefund);
            System.out.println("Thêm yêu cầu hoàn tiền thành công.");

            // Test updateRefundStatus
            System.out.println("\nCập nhật trạng thái hoàn tiền:");
            refundDAO.updateRefundStatus(testRefundId, 2); // 2 = Refund Success
            System.out.println("Cập nhật trạng thái thành công.");

            // Test deleteRefund
            System.out.println("\nXóa yêu cầu hoàn tiền:");
            refundDAO.deleteRefund(testRefundId);
            System.out.println("Xóa yêu cầu hoàn tiền thành công.");
        }
}