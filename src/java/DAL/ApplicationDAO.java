/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Data.RCMSDbContext;
import Models.Application;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Hung
 */
public class ApplicationDAO extends RCMSDbContext {

    // Lấy danh sách tất cả đơn ứng tuyển
    public List<Application> getAllApplications() throws Exception {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT * FROM application ORDER BY applied_at DESC";

        try {
            Connection conn = getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Application a = new Application();
                a.setApplicationId(rs.getInt("application_id"));
                a.setJobId(rs.getInt("job_id"));
                a.setUserId(rs.getInt("user_id"));
                a.setResumeId(rs.getInt("resume_id"));
                a.setStatus(rs.getString("status"));

                Timestamp ts = rs.getTimestamp("applied_at");
                if (ts != null) {
                    a.setAppliedAt(ts.toLocalDateTime());
                }

                list.add(a);
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return list;
    }

    // Lấy 1 application theo ID
    public Application getApplicationById(int id) throws Exception {
        Application app = null;
        String sql = "SELECT * FROM application WHERE application_id = ?";

        try {
            Connection conn = getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    app = new Application();
                    app.setApplicationId(rs.getInt("application_id"));
                    app.setJobId(rs.getInt("job_id"));
                    app.setUserId(rs.getInt("user_id"));
                    app.setResumeId(rs.getInt("resume_id"));
                    app.setStatus(rs.getString("status"));

                    Timestamp ts = rs.getTimestamp("applied_at");
                    if (ts != null) {
                        app.setAppliedAt(ts.toLocalDateTime());
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return app;
    }

    // Cập nhật trạng thái ứng viên
    public boolean updateStatus(int appId, String newStatus) throws Exception {
        String sql = "UPDATE application SET status = ? WHERE application_id = ?";
        try {
            Connection conn = getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, newStatus);
            st.setInt(2, appId);
            return st.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi cập nhật trạng thái ứng viên: " + e.getMessage());
            return false;
        }
    }

}
