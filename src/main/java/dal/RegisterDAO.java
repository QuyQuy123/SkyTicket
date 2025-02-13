/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

//import controller.GoogleLogin;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Accounts;

import static controller.EncodeController.SECRET_KEY;
import static controller.EncodeController.encryptAES;
//import model.UserGoogleDto;

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
        String sql = "INSERT INTO Accounts (fullname, email, password, phone, roleid) " +
                "VALUES (?, ?, ?, ?, 2)";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, a.getFullName());
            st.setString(2, a.getEmail());
            st.setString(3, a.getPassword());
            st.setString(4, a.getPhone());

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
        Accounts a = new Accounts("Nguyen Kien", "nguyentrungkien11502@gmail.com", "123", "0862852423");
        if (rd.checkEmailExisted(a.getEmail())) {
            System.out.println("Email already exists!");
            return;
        }
        if (rd.checkPhoneNumberExisted(a.getPhone())) {
            System.out.println("Phone number already exists!");
            return;
        }
        rd.addNewAccount(a);
        System.out.println("Account registered successfully!");
    }
}