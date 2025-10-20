/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.User;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Hung
 */
public class UserDAO extends DAO {

    public static void main(String[] args) {
        UserDAO uDao = new UserDAO();
        System.out.println(uDao.GetUserByEmailAndPassword("admin.an.nguyen@company.com", "defaultpassword"));
    }

    public User GetUserByEmailAndPassword(String email, String password) {
        String sql = """
                     SELECT [user_id]
                           ,[role_id]
                           ,[status]
                           ,[fullname]
                           ,[email]
                           ,[phone_number]
                           ,[address]
                           ,[created_at]
                           ,[updated_at]
                       FROM [rcms].[dbo].[user] WHERE [email] = ? AND [password] = ?
                     """;

        User u = null;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setRoleId(rs.getInt("role_id"));
                u.setStatus(rs.getString("status"));
                u.setFullname(rs.getString("fullname"));
                u.setEmail(rs.getString("email"));
                u.setPhoneNumber(rs.getString("phone_number"));
                u.setAddress(rs.getString("address"));
                u.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                u.setUpdatedAt(rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
        }

        return u;
    }

    public Map<Integer, String> getAllUserNames() {
        Map<Integer, String> map = new HashMap<>();
        String sql = "SELECT user_id, fullname FROM [user]";
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getInt("user_id"), rs.getString("fullname"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }

    public List<User> getAllUsers() throws Exception {
        List<User> list = new ArrayList<>();
        String sql = "SELECT user_id, fullname FROM [user]";
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));
                list.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertUser(User user) {
        String sql = """
        INSERT INTO [rcms].[dbo].[user]
        ([role_id], [status], [fullname], [email], [password], [phone_number], [address], [created_at])
        VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())
    """;

        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, user.getRoleId());  // Mặc định role_id = 2 (User)
            ps.setString(2, user.getStatus()); // "Active"
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPassword()); // Hash trước khi lưu
            ps.setString(6, user.getPhoneNumber());
            ps.setString(7, user.getAddress());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            System.out.println("Error inserting user: " + e.getMessage());
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM [rcms].[dbo].[user] WHERE email = ?";
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
            }
        }
        return false;
    }

    public boolean isPhoneExists(String phone) {
        String sql = "SELECT COUNT(*) FROM [rcms].[dbo].[user] WHERE phone_number = ?";
        try {
            con = dbc.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, phone);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                this.closeResources();
            } catch (Exception e) {
            }
        }
        return false;
    }

}
