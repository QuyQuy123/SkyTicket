package dal;

import model.Roles;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Statement;
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
    public List<Roles> getRolesById1(int id) {
        List<Roles> roles = new ArrayList<>();
        String sql = "SELECT * FROM Roles WHERE RoleId = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                roles.add(new Roles(
                        rs.getInt("RoleId"),
                        rs.getString("RoleName")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return roles;
    }

    public int getTotalRoles() {
        int total = 0;
        String sql = "Select count(*) from Roles";
        try (Statement stm = connection.createStatement();
             ResultSet rs = stm.executeQuery(sql)) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    public List<Roles> getRolesByPage(int start, int total) {
        List<Roles> roles = new ArrayList<>();
        String sql = "SELECT * FROM Roles LIMIT ?, ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, start);
            pstmt.setInt(2, total);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                roles.add(new Roles(
                        rs.getInt("RoleId"),
                        rs.getString("RoleName")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roles;
    }
    public List<Roles> getRolesPaginated(int start, int limit) {
        List<Roles> list = new ArrayList<>();
        String sql = "SELECT * FROM Roles LIMIT ?, ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, start);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Roles role = new Roles();
                role.setRoleId(rs.getInt("RoleID"));
                role.setRoleName(rs.getString("RoleName"));
                list.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean addRole(Roles role) {
        String sql = "INSERT INTO Roles (RoleName) VALUES (?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, role.getRoleName());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean checkRoleNameExists(String roleName) {
        String sql = "SELECT COUNT(*) FROM Roles WHERE RoleName = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, roleName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                boolean exists = rs.getInt(1) > 0;
                System.out.println("checkRoleNameExists - RoleName: " + roleName + ", Exists: " + exists);
                return exists;
            }
        } catch (SQLException e) {
            System.out.println("checkRoleNameExists - SQLException: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // Dã Test


    public static void main(String[] args) {
        RolesDAO rd = new RolesDAO();
//        System.out.println(rd.getNameById(1));
//        System.out.println(rd.getTotalRoles());
        List<Roles> roles = rd.getRolesById1(2);

        for (Roles role : roles) {
            System.out.println("Role ID: " + role.getRoleId() + ", Role Name: " + role.getRoleName());
        }
    }





}
