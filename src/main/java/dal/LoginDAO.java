package dal;

import org.mindrot.jbcrypt.BCrypt;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

public class LoginDAO extends DBConnect{
    public boolean checkUsername(String emailOrPhoneNumber) {
        String sql = "SELECT * FROM Accounts WHERE Email = ? OR Phone = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, emailOrPhoneNumber);
            st.setString(2, emailOrPhoneNumber);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String email = rs.getString("Email");
                String phoneNumber = rs.getString("Phone");
                if (emailOrPhoneNumber.equals(email) || emailOrPhoneNumber.equals(phoneNumber)) {
                    return true;
                }
            }
        } catch (SQLException e) {
        }

        return false;
    }

    public boolean checkPassword(String emailOrPhoneNumber, String password) {
        String sql = "SELECT Password FROM Accounts WHERE Email=? OR Phone=?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, emailOrPhoneNumber);
            st.setString(2, emailOrPhoneNumber);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String hashedPassword = rs.getString("Password");
                return BCrypt.checkpw(password, hashedPassword);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkStatus(String emailOrPhoneNumber) {
        String sql = "SELECT * FROM Accounts WHERE (Email=? OR Phone=?) AND Status = 2 ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, emailOrPhoneNumber);
            st.setString(2, emailOrPhoneNumber);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
        }
        return false;
    }





    //Test method

    public static void main(String[] args) {
        LoginDAO dao = new LoginDAO();
        System.out.println(dao.checkStatus("admin@example.coms"));

    }





}
