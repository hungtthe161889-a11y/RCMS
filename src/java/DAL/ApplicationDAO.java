/*
 * @author Hung
 */
package DAL;

import Data.RCMSDbContext;
import Models.Application;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO extends RCMSDbContext {

    // ===================== 🔹 LẤY DANH SÁCH =====================

    /** Lấy toàn bộ đơn ứng tuyển (mới nhất trước) */
    public List<Application> getAllApplications() {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT * FROM application ORDER BY applied_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) list.add(mapApplication(rs));

        } catch (SQLException e) {
            System.err.println("❌ [getAllApplications] " + e.getMessage());
        }
        return list;
    }

    /** Lấy đơn ứng tuyển theo ID */
    public Application getApplicationById(int id) {
        String sql = "SELECT * FROM application WHERE application_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapApplication(rs);
            }

        } catch (SQLException e) {
            System.err.println("❌ [getApplicationById] " + e.getMessage());
        }
        return null;
    }

    /** Lọc ứng viên theo từ khóa + trạng thái */
    public List<Application> filterApplications(String keyword, String status) {
        List<Application> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
            SELECT a.*
            FROM application a
            JOIN [user] u ON u.user_id = a.user_id
            JOIN job_posting j ON j.job_id = a.job_id
            WHERE 1=1
        """);

        if (keyword != null && !keyword.trim().isEmpty())
            sql.append(" AND (u.fullname LIKE ? OR j.title LIKE ?)");
        if (status != null && !status.trim().isEmpty())
            sql.append(" AND a.status = ?");
        sql.append(" ORDER BY a.applied_at DESC");

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int idx = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String kw = "%" + keyword.trim() + "%";
                ps.setString(idx++, kw);
                ps.setString(idx++, kw);
            }
            if (status != null && !status.trim().isEmpty()) {
                ps.setString(idx++, status);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapApplication(rs));
            }

        } catch (SQLException e) {
            System.err.println("❌ [filterApplications] " + e.getMessage());
        }

        return list;
    }

    // ===================== 🔹 CẬP NHẬT TRẠNG THÁI =====================

    /** Tiến hoặc lùi trạng thái tự động */
    public boolean updateStatus(int appId, String direction) {
        String current = getCurrentStatus(appId);
        if (current == null) return false;

        String next = switch (direction.toLowerCase()) {
            case "forward" -> getNextStatus(current);
            case "backward" -> getPreviousStatus(current);
            default -> current;
        };

        String sql = "UPDATE application SET status = ? WHERE application_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, next);
            ps.setInt(2, appId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ [updateStatus] " + e.getMessage());
            return false;
        }
    }

    /** Cập nhật trực tiếp trạng thái (manual) */
    public boolean updateStatusDirect(int appId, String newStatus) {
        String sql = "UPDATE application SET status = ? WHERE application_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, appId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ [updateStatusDirect] " + e.getMessage());
            return false;
        }
    }

    /** Xóa đơn ứng tuyển */
    public boolean deleteApplication(int id) {
        String sql = "DELETE FROM application WHERE application_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ [deleteApplication] " + e.getMessage());
            return false;
        }
    }

    // ===================== 🔹 PRIVATE HELPERS =====================

    private Application mapApplication(ResultSet rs) throws SQLException {
        Application a = new Application();
        a.setApplicationId(rs.getInt("application_id"));
        a.setJobId(rs.getInt("job_id"));
        a.setUserId(rs.getInt("user_id"));
        a.setResumeId(rs.getInt("resume_id"));
        a.setStatus(rs.getString("status"));

        Timestamp ts = rs.getTimestamp("applied_at");
        if (ts != null) a.setAppliedAt(ts.toLocalDateTime());

        return a;
    }

    private String getCurrentStatus(int appId) {
        String sql = "SELECT status FROM application WHERE application_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, appId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getString("status");
            }
        } catch (SQLException e) {
            System.err.println("❌ [getCurrentStatus] " + e.getMessage());
        }
        return null;
    }

    private String getNextStatus(String current) {
        return switch (current) {
            case "Applied" -> "Interviewing";
            case "Interviewing" -> "Offer";
            case "Offer" -> "Hired";
            default -> "Hired";
        };
    }

    private String getPreviousStatus(String current) {
        return switch (current) {
            case "Hired" -> "Offer";
            case "Offer" -> "Interviewing";
            case "Interviewing" -> "Applied";
            default -> "Applied";
        };
    }
}
