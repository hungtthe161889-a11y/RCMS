/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Data.RCMSDbContext;
import Models.Resume;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Hung
 */
public class ResumeDAO extends RCMSDbContext {

    public int getLatestResumeIdByUser(int userId) {
        String sql = """
            SELECT TOP 1 resume_id
            FROM resume
            WHERE user_id = ?
            ORDER BY created_at DESC
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("resume_id");
                }
            }
        } catch (SQLException e) {
            System.err.println("[getLatestResumeIdByUser] " + e.getMessage());
        }
        return -1;
    }

    public int insertResume(int userId, String title, String summary,
            String experience, String education, String skills, String filePath) {
        String sql = """
        INSERT INTO resume (user_id, title, summary, experience, education, skills_text, file_path, created_at)
        OUTPUT INSERTED.resume_id
        VALUES (?, ?, ?, ?, ?, ?, ?, SYSDATETIME())
    """;
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, title);
            ps.setString(3, summary);
            ps.setString(4, experience);
            ps.setString(5, education);
            ps.setString(6, skills);
            ps.setString(7, filePath);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("[insertResume] " + e.getMessage());
        }
        return -1;
    }

    public Resume getResumeById(int resumeId) {
        String sql = """
            SELECT resume_id, user_id, title, summary, experience, education, skills_text, created_at, file_path
            FROM resume
            WHERE resume_id = ?
        """;

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, resumeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Resume r = new Resume();
                    r.setResumeId(rs.getInt("resume_id"));
                    r.setUserId(rs.getInt("user_id"));
                    r.setTitle(rs.getString("title"));
                    r.setSummary(rs.getString("summary"));
                    r.setExperience(rs.getString("experience"));
                    r.setEducation(rs.getString("education"));
                    r.setSkillsText(rs.getString("skills_text"));
                    r.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    r.setFilePath(rs.getString("file_path"));
                    return r;
                }
            }

        } catch (SQLException e) {
            System.err.println("[getResumeById] " + e.getMessage());
        }
        return null;
    }

    public List<Resume> getResumesByUser(int userId) {
        List<Resume> list = new ArrayList<>();
        String sql = "SELECT * FROM resume WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Resume r = new Resume();
                r.setResumeId(rs.getInt("resume_id"));
                r.setUserId(userId);
                r.setTitle(rs.getString("title"));
                r.setFilePath(rs.getString("file_path"));
                list.add(r);
            }
        } catch (SQLException e) {
            System.err.println("[getResumesByUser] " + e.getMessage());
        }
        return list;
    }

}
