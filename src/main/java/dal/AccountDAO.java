package dal;

import model.Accounts;
import model.Airlines;
import model.UserGoogle;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import static com.oracle.wls.shaded.org.apache.xalan.xsltc.compiler.Constants.CHARACTERS;


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
        String sqlupdate = "UPDATE Accounts \n"
                + "SET\n"
                + "password = ?\n"
                + "WHERE AccountId = ?";
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


    public void addNewAccount(Accounts a) {
        String sql = "INSERT INTO Accounts (FullName, email, password, Phone, RolesId, Status) VALUES (?,?,?,?,?,?)";


        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, a.getFullName());
            st.setString(2, a.getEmail());
//            String encode = encryptAES(a.getPassword(), SECRET_KEY);
            st.setString(3, a.getPassword());
            st.setString(4, a.getPhone());
            st.setInt(5, a.getRoleId());
            st.setInt(6, a.getStatus());
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void addNewGoogleAccount(UserGoogle a) {
        String sql = "INSERT INTO Accounts (FullName, email, password, Phone,img, RoleId, Status) VALUES (?,?,?,?,?,?,?)";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, a.getName());
            st.setString(2, a.getEmail());
            st.setString(3, a.getPassword());
            st.setString(4, a.getPhoneNumber());
            st.setString(5, a.getImage());
            st.setInt(6, a.getRoleId());
            st.setInt(7, a.getStatus());
            st.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }


    // Test method
    public static void main(String[] args) {
        AccountDAO dao = new AccountDAO();
        int id = dao.findIdByEmail("quyhslc11@gmail.com");
        System.out.println(id);
    }

    public String generateRandomString() {
        StringBuilder sb = new StringBuilder(8);
        Random r = new Random();
        for (int i = 0; i < 8; i++) {
            int index = r.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(index));
        }
        return sb.toString();
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
        } catch (SQLException e) {
            return false;
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
        String sql = "select accountId from Accounts where email = ?";
        int userId = -1;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, email);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                userId = rs.getInt("accountId");
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


    /*
        This method add account create by Duy Bo
     */
    public boolean addAccount(Accounts account) {
        if (checkEmailExist(account.getEmail())) {
            System.out.println("Email existed!!!: " + account.getEmail());
            return false;
        }

        String sql = "INSERT INTO Accounts (FullName, Email, Password, Phone, Address, Img, Dob, Status, RoleId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            System.out.println("Run SQL: " + sql);
            System.out.println("Data: " + account.toString());

            st.setString(1, account.getFullName());
            st.setString(2, account.getEmail());
            st.setString(3, account.getPassword());
            st.setString(4, account.getPhone());
            st.setString(5, account.getAddress());
            st.setString(6, account.getImg());
            st.setDate(7, account.getDob());
            st.setInt(8, account.getStatus());
            st.setInt(9, account.getRoleId());

            int rowsInserted = st.executeUpdate();
            System.out.println("Number of row effected: " + rowsInserted);

            return rowsInserted > 0;
        } catch (SQLException e) {
            System.out.println("Error: ");
            e.printStackTrace();
            return false;
        }
    }

    /*
        Get list Account create by Duy Bo
     */
    public List<Accounts> getAllAccounts() {
        List<Accounts> list = new ArrayList<>();
        String sql = "SELECT * FROM Accounts";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Accounts(
                        rs.getInt("AccountId"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Phone"),
                        rs.getString("Address"),
                        rs.getString("Img"),
                        rs.getDate("Dob"),
                        rs.getInt("Status"),
                        rs.getInt("RoleId")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


    public boolean updateAccountStatus(int accountId, int status) {
        String query = "UPDATE Accounts SET status = ? WHERE accountId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, status);
            ps.setInt(2, accountId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateAccount(Accounts account) {
        String sql = "UPDATE Accounts SET FullName = ?, Password = ?, Phone = ?, Address = ?, Img = ?, Dob = ?, Status = ?, RoleId = ? WHERE AccountId = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, account.getFullName());
            st.setString(2, account.getPassword());
            st.setString(3, account.getPhone());
            st.setString(4, account.getAddress());
            st.setString(5, account.getImg());
            st.setDate(6, account.getDob());
            st.setInt(7, account.getStatus());
            st.setInt(8, account.getRoleId());
            st.setInt(9, account.getAccountId());


            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật tài khoản: " + e.getMessage());
            return false;
        }
    }


    // Lấy danh sách hãng hàng không theo trang
    public List<Accounts> getAccountsByPage(int start, int total) {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT * FROM Accounts LIMIT ?, ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, start);
            ps.setInt(2, total);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Accounts(
                        rs.getInt("AccountId"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Phone"),
                        rs.getString("Address"),
                        rs.getString("Img"),
                        rs.getDate("Dob"),
                        rs.getInt("Status"),
                        rs.getInt("RoleId")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalAccounts() {
        String sql = "SELECT COUNT(*) AS total FROM Accounts";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Accounts> searchAccounts(String search, Integer roleId, Integer status, int start, int total) {
        List<Accounts> list = new ArrayList<>();
        String query = "SELECT * FROM Accounts WHERE 1=1";

        if (search != null && !search.trim().isEmpty()) {
            query += " AND (FullName LIKE ? OR email LIKE ? OR phone LIKE ?)";
        }
        if (roleId != null) {
            query += " AND roleId = ?";
        }
        if (status != null) {
            query += " AND status = ?";
        }
        query += " LIMIT ?, ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
                ps.setString(index++, "%" + search + "%");
                ps.setString(index++, "%" + search + "%");
            }
            if (roleId != null) {
                ps.setInt(index++, roleId);
            }
            if (status != null) {
                ps.setInt(index++, status);
            }
            ps.setInt(index++, start);
            ps.setInt(index++, total);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Accounts(
                        rs.getInt("AccountId"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("Phone"),
                        rs.getString("Address"),
                        rs.getString("Img"),
                        rs.getDate("Dob"),
                        rs.getInt("Status"),
                        rs.getInt("RoleId")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm số lượng tài khoản phù hợp
    public int countFilteredAccounts(String search, Integer roleId, Integer status) {
        String query = "SELECT COUNT(*) FROM Accounts WHERE 1=1";

        if (search != null && !search.trim().isEmpty()) {
            query += " AND (fullName LIKE ? OR email LIKE ? OR phone LIKE ?)";
        }
        if (roleId != null) {
            query += " AND roleId = ?";
        }
        if (status != null) {
            query += " AND status = ?";
        }

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            int index = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(index++, "%" + search + "%");
                ps.setString(index++, "%" + search + "%");
                ps.setString(index++, "%" + search + "%");
            }
            if (roleId != null) {
                ps.setInt(index++, roleId);
            }
            if (status != null) {
                ps.setInt(index++, status);
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

}
