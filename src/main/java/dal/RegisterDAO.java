
package dal;

//import controller.GoogleLogin;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Accounts;



public class RegisterDAO extends DBConnect {

    public boolean checkPhoneNumberExisted(String phone) {
        String sql = "select * from Accounts where phone=?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, phone);
            try (ResultSet rs = st.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            return false;
        }
    }

    public boolean checkEmailExisted(String email) {
        String sql = "select * from Accounts where email=?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            return false;
        }
    }

    public void addNewAccount(Accounts a) {
        String sql = "INSERT INTO Accounts (fullname, email, password, phone,img, roleid) " +
                "VALUES (?, ?, ?, ?,?, 2)";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, a.getFullName());
            st.setString(2, a.getEmail());
            st.setString(3, a.getPassword());
            st.setString(4, a.getPhone());
            st.setString(5, a.getImg());


            int rowsAffected = st.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Account added successfully.");
            } else {
                System.out.println("Failed to add account.");
            }
        } catch (SQLException e) {
            System.err.println("Error executing SQL: " + e.getMessage());
            e.printStackTrace();
        }
    }


    public static void main(String[] args) {
        RegisterDAO rd = new RegisterDAO();
        Accounts a = new Accounts("quycoi","quynv123@gmail.com","1234567","0989148758","logo.jpg",2);
        rd.addNewAccount(a);

    }
}