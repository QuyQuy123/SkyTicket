package dal;

import model.Roles;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

public class RolesDAO extends DBConnect {
    public List<Roles> getAllRoles(){
        List<Roles> ls = new ArrayList<>();
        String sql = "SELECT * FROM Roles";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Roles r = new Roles(rs.getInt("RoleId"), rs.getString("RoleName"));
                ls.add(r);
            }
            return ls;
        } catch (SQLException e) {
        }
        return null;
    }

    public String getNameById(int id){
        String sql = "SELECT * FROM Roles WHERE RoleId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getString("RoleName");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }





    // Dã Test


    public static void main(String[] args) {
        RolesDAO rd = new RolesDAO();
        System.out.println(rd.getNameById(1));
    }





}
