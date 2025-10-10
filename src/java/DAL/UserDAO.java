/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.User;
import java.sql.SQLException;

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
}
