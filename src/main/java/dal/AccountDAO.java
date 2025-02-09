package dal;

import model.Accounts;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class AccountDAO extends DBConnect {
    public Accounts getLogin(String username, String password) throws SQLException {
        Accounts accounts = null;  // Để mặc định là null
        String sql = "SELECT * FROM accounts WHERE (Phone=? OR Email=?) AND Password=?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setString(2, username);
            st.setString(3, password);

            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    accounts = new Accounts(); // Khởi tạo đối tượng khi có dữ liệu
                    accounts.setAccountId(rs.getInt("AccountId"));
                    accounts.setFullName(rs.getString("FullName"));
                    accounts.setPassword(rs.getString("Password"));
                    accounts.setPhone(rs.getString("Phone"));
                    accounts.setEmail(rs.getString("Email"));
                    accounts.setAddress(rs.getString("Address"));
                    accounts.setImg(rs.getString("Img"));
                    accounts.setDob(rs.getDate("Dob"));
                    accounts.setStatus(rs.getInt("Status"));
                    accounts.setRoleId(rs.getInt("RoleId"));
                }
            }
        }
        return accounts; // Trả về null nếu không tìm thấy tài khoản
    }

    public boolean registerAccount(Accounts account) throws SQLException {
        String sql = "INSERT INTO accounts (FullName, Dob, Phone, Email, Password, RoleId, Status) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, account.getFullName());
            st.setDate(2, account.getDob());
            st.setString(3, account.getPhone());
            st.setString(4, account.getEmail());
            st.setString(5, account.getPassword());
            st.setInt(6, 2); // Giả sử 2 là roleId mặc định cho user
            st.setInt(7, 1); // 1 là trạng thái hoạt động

            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0; // Trả về true nếu thêm thành công
        }
    }

    public boolean checkEmailExists(String email) throws SQLException {
        String sql = "SELECT * FROM accounts WHERE Email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                return rs.next(); // Trả về true nếu email tồn tại
            }
        }
    }

    public boolean updatePassword(String email, String newPassword) throws SQLException {
        String sql = "UPDATE accounts SET Password = ? WHERE Email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, newPassword);
            st.setString(2, email);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0; // Trả về true nếu cập nhật thành công
        }
    }

    public static void main(String[] args) {

    }
}
