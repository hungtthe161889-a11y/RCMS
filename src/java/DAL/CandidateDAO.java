package DAL;

import Data.RCMSDbContext;

import Models.Application;
import Models.Candidate;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CandidateDAO {
    private final RCMSDbContext dbContext;
    private final Logger logger = Logger.getLogger(CandidateDAO.class.getName());

    public CandidateDAO() {
        this.dbContext = new RCMSDbContext();
    }

    // Get candidates by recruiter (candidates who applied to recruiter's jobs)
    public List<Candidate> getCandidatesByRecruiter(int recruiterId) {
        List<Candidate> candidates = new ArrayList<>();
        String sql = "SELECT DISTINCT " +
                    "u.user_id, u.fullname, u.email, u.phone_number, u.status as user_status, " +
                    "u.created_at, r.resume_id, r.title as resume_title, " +
                    "a.application_id, a.status as application_status, a.applied_at, " +
                    "jp.job_id, jp.title as job_title " +
                    "FROM [user] u " +
                    "JOIN application a ON u.user_id = a.user_id " +
                    "JOIN job_posting jp ON a.job_id = jp.job_id " +
                    "LEFT JOIN resume r ON u.user_id = r.user_id " +
                    "WHERE jp.createdBy = ? AND u.role_id = 2 " +
                    "ORDER BY a.applied_at DESC";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, recruiterId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    candidates.add(mapResultSetToCandidate(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting candidates by recruiter: " + recruiterId, e);
        }
        return candidates;
    }

    // Get candidates by job (for a specific job posting)
    public List<Candidate> getCandidatesByJob(int jobId, int recruiterId) {
        List<Candidate> candidates = new ArrayList<>();
        String sql = "SELECT " +
                    "u.user_id, u.fullname, u.email, u.phone_number, u.status as user_status, " +
                    "u.created_at, r.resume_id, r.title as resume_title, " +
                    "a.application_id, a.status as application_status, a.applied_at, " +
                    "jp.job_id, jp.title as job_title " +
                    "FROM [user] u " +
                    "JOIN application a ON u.user_id = a.user_id " +
                    "JOIN job_posting jp ON a.job_id = jp.job_id " +
                    "LEFT JOIN resume r ON u.user_id = r.user_id " +
                    "WHERE jp.job_id = ? AND jp.createdBy = ? " +
                    "ORDER BY a.applied_at DESC";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, jobId);
            stmt.setInt(2, recruiterId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    candidates.add(mapResultSetToCandidate(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting candidates by job: " + jobId, e);
        }
        return candidates;
    }

    // Get candidate detail by ID
    public Candidate getCandidateDetail(int candidateId, int recruiterId) {
        String sql = "SELECT " +
                    "u.user_id, u.fullname, u.email, u.phone_number, u.address, " +
                    "u.status as user_status, u.created_at, u.updated_at, " +
                    "r.resume_id, r.title as resume_title, r.summary, r.experience, " +
                    "r.education, r.skills_text, r.file_path as resume_file, " +
                    "a.application_id, a.status as application_status, a.applied_at, " +
                    "jp.job_id, jp.title as job_title, jp.category_id " +
                    "FROM [user] u " +
                    "JOIN application a ON u.user_id = a.user_id " +
                    "JOIN job_posting jp ON a.job_id = jp.job_id " +
                    "LEFT JOIN resume r ON u.user_id = r.user_id " +
                    "WHERE u.user_id = ? AND jp.createdBy = ? " +
                    "ORDER BY a.applied_at DESC";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, candidateId);
            stmt.setInt(2, recruiterId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCandidate(rs);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting candidate detail: " + candidateId, e);
        }
        return null;
    }

    // Get candidate's applications
    public List<Application> getCandidateApplications(int candidateId, int recruiterId) {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.*, jp.title as job_title, jc.category_name " +
                    "FROM application a " +
                    "JOIN job_posting jp ON a.job_id = jp.job_id " +
                    "JOIN job_category jc ON jp.category_id = jc.category_id " +
                    "WHERE a.user_id = ? AND jp.createdBy = ? " +
                    "ORDER BY a.applied_at DESC";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, candidateId);
            stmt.setInt(2, recruiterId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    applications.add(mapResultSetToApplication(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting candidate applications: " + candidateId, e);
        }
        return applications;
    }

    // Update application status
    public boolean updateApplicationStatus(int applicationId, String status, int recruiterId) {
        String sql = "UPDATE a " +
                    "SET a.status = ? " +
                    "FROM application a " +
                    "JOIN job_posting jp ON a.job_id = jp.job_id " +
                    "WHERE a.application_id = ? AND jp.createdBy = ?";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, applicationId);
            stmt.setInt(3, recruiterId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating application status: " + applicationId, e);
            return false;
        }
    }

    // Search candidates
    public List<Candidate> searchCandidates(int recruiterId, String keyword, String status, Integer jobId) {
        List<Candidate> candidates = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT DISTINCT " +
            "u.user_id, u.fullname, u.email, u.phone_number, u.status as user_status, " +
            "u.created_at, r.resume_id, r.title as resume_title, " +
            "a.application_id, a.status as application_status, a.applied_at, " +
            "jp.job_id, jp.title as job_title " +
            "FROM [user] u " +
            "JOIN application a ON u.user_id = a.user_id " +
            "JOIN job_posting jp ON a.job_id = jp.job_id " +
            "LEFT JOIN resume r ON u.user_id = r.user_id " +
            "WHERE jp.createdBy = ? AND u.role_id = 2 "
        );
        
        List<Object> params = new ArrayList<>();
        params.add(recruiterId);
        
        if (keyword != null && !keyword.isEmpty()) {
            sql.append("AND (u.fullname LIKE ? OR u.email LIKE ? OR r.skills_text LIKE ?) ");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        
        if (status != null && !status.isEmpty()) {
            sql.append("AND a.status = ? ");
            params.add(status);
        }
        
        if (jobId != null) {
            sql.append("AND jp.job_id = ? ");
            params.add(jobId);
        }
        
        sql.append("ORDER BY a.applied_at DESC");
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    candidates.add(mapResultSetToCandidate(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error searching candidates", e);
        }
        return candidates;
    }

    // Helper methods
    private Candidate mapResultSetToCandidate(ResultSet rs) throws SQLException {
        Candidate candidate = new Candidate();
        candidate.setUserId(rs.getInt("user_id"));
        candidate.setFullname(rs.getString("fullname"));
        candidate.setEmail(rs.getString("email"));
        candidate.setPhoneNumber(rs.getString("phone_number"));
        candidate.setStatus(rs.getString("user_status"));
        candidate.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        
        // Resume info
        if (hasColumn(rs, "resume_id") && rs.getObject("resume_id") != null) {
            candidate.setResumeId(rs.getInt("resume_id"));
            candidate.setResumeTitle(rs.getString("resume_title"));
        }
        
        // Application info
        if (hasColumn(rs, "application_id")) {
            candidate.setApplicationId(rs.getInt("application_id"));
            candidate.setApplicationStatus(rs.getString("application_status"));
            candidate.setAppliedAt(rs.getTimestamp("applied_at").toLocalDateTime());
        }
        
        // Job info
        if (hasColumn(rs, "job_id")) {
            candidate.setJobId(rs.getInt("job_id"));
            candidate.setJobTitle(rs.getString("job_title"));
        }
        
        // Additional fields for detail view
        if (hasColumn(rs, "address")) {
            candidate.setAddress(rs.getString("address"));
        }
        if (hasColumn(rs, "summary")) {
            candidate.setSummary(rs.getString("summary"));
        }
        if (hasColumn(rs, "experience")) {
            candidate.setExperience(rs.getString("experience"));
        }
        if (hasColumn(rs, "education")) {
            candidate.setEducation(rs.getString("education"));
        }
        if (hasColumn(rs, "skills_text")) {
            candidate.setSkillsText(rs.getString("skills_text"));
        }
        if (hasColumn(rs, "resume_file")) {
            candidate.setResumeFilePath(rs.getString("resume_file"));
        }
        
        return candidate;
    }
    
    private Application mapResultSetToApplication(ResultSet rs) throws SQLException {
        Application application = new Application();
        application.setApplicationId(rs.getInt("application_id"));
        application.setJobId(rs.getInt("job_id"));
        application.setUserId(rs.getInt("user_id"));
        application.setResumeId(rs.getInt("resume_id"));
        application.setStatus(rs.getString("status"));
        application.setAppliedAt(rs.getTimestamp("applied_at").toLocalDateTime());
        
        if (hasColumn(rs, "job_title")) {
            application.setJobTitle(rs.getString("job_title"));
        }
        if (hasColumn(rs, "category_name")) {
            // You can set category if needed
        }
        
        return application;
    }
    
    private boolean hasColumn(ResultSet rs, String columnName) {
        try {
            rs.findColumn(columnName);
            return true;
        } catch (SQLException e) {
            return false;
        }
    }
}