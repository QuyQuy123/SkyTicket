package dal;

import model.Accounts;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Random;

// static com.oracle.wls.shaded.org.apache.xalan.xsltc.compiler.Constants.CHARACTERS;

public class AccountDAO extends DBConnect {


    public Accounts getAccountsById(int id) {
        String sql = "SELECT * FROM Accounts WHERE AccountId = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Accounts a = new Accounts(rs.getInt("AccountId"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Phone"),
                        rs.getString("Address"),
                        rs.getString("Img"),
                        rs.getDate("Dob"),
                        rs.getInt("Status"),
                        rs.getInt("RoleId"));
                return a;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }


    public int getIdByEmailOrPhoneNumber(String emailOrPhoneNumber) {
        String sql = "SELECT AccountId FROM Accounts WHERE Email = ? OR Phone = ?";
        int userId = -1;

        try (PreparedStatement st = connection.prepareStatement(sql)) {

            st.setString(1, emailOrPhoneNumber);
            st.setString(2, emailOrPhoneNumber);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("AccountId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userId;
    }


    public void infoUpdate(Accounts account) {
        String sqlUpdate = "UPDATE Accounts\n"
                + "SET\n"
                + "`FullName` = ?,\n"
                + "`dob` = ?,\n"
                + "`email` = ?,\n"
                + "`phone` = ?,\n"
                + "`address` = ?,\n"
                + "`img` = ?\n"
                + "WHERE `AccountId` = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sqlUpdate);
            pre.setString(1, account.getFullName());
            pre.setDate(2, account.getDob());
            pre.setString(3, account.getEmail());
            pre.setString(4, account.getPhone());
            pre.setString(5, account.getAddress());
            pre.setString(6, account.getImg());
            pre.setInt(7, account.getAccountId());
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    public void changePassword(String idAccount, String newPassword) {
        String sqlupdate = "UPDATE `Accounts`\n"
                + "SET\n"
                + "`password` = ?\n"
                + "WHERE `AccountId` = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sqlupdate);
//            String encode = encryptAES(newPassword, SECRET_KEY);
            pre.setString(1, newPassword);
            pre.setString(2, idAccount);

            pre.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }








    //Test method
    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();
        int a = dao.getIdByEmailOrPhoneNumber("admin@example.com");
        System.out.println(a);
    }


    // Phần này nên tạo riêng 1 DAO lưu các method phía dưới
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

    public int findIdByEmail(String email) {
        String sql = "select id from Accounts where email = ?";
        int userId = -1;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, email);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                userId = rs.getInt("id");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return userId;
    }

    public boolean checkEmailExist(String email) {
        String sql = "select * from Accounts where email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                return false;
            } else {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }


}
