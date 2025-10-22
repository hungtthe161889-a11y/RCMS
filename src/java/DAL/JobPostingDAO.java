package DAL;

import Data.RCMSDbContext;
import Models.JobPosting;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class JobPostingDAO {

    private final RCMSDbContext dbContext;
    private final Logger logger = Logger.getLogger(JobPostingDAO.class.getName());

    public JobPostingDAO() {
        this.dbContext = new RCMSDbContext();
    }

    public static void main(String[] args) {
        JobPostingDAO j = new JobPostingDAO();
        List<JobPosting> l = j.getAllJobPostings();
        for (JobPosting j1 : l) {
            System.out.println(j1.getRecruiterName());
        }
    }

    // For all roles (public access)
    public List<JobPosting> getAllActiveJobPostings() {
        List<JobPosting> jobs = new ArrayList<>();
        String sql = "SELECT jp.*, jc.category_name, l.province, l.ward, u.fullname as recruiter_name "
                + "FROM job_posting jp "
                + "JOIN job_category jc ON jp.category_id = jc.category_id "
                + "JOIN location l ON jp.location_id = l.location_id "
                + "JOIN [user] u ON jp.createdBy = u.user_id "
                + "WHERE jp.status = 'Open' AND jp.approvedAt IS NOT NULL "
                + "ORDER BY jp.posted_at DESC";

        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                jobs.add(mapResultSetToJobPosting(rs));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting all active job postings", e);
        }
        return jobs;
    }

    // For Candidate - get applied jobs
    public List<JobPosting> getAppliedJobs(int userId) {
        List<JobPosting> jobs = new ArrayList<>();
        String sql = "SELECT jp.*, jc.category_name, l.province, l.ward, u.fullname as recruiter_name, a.status as application_status "
                + "FROM job_posting jp "
                + "JOIN application a ON jp.job_id = a.job_id "
                + "JOIN job_category jc ON jp.category_id = jc.category_id "
                + "JOIN location l ON jp.location_id = l.location_id "
                + "JOIN [user] u ON jp.createdBy = u.user_id "
                + "WHERE a.user_id = ? "
                + "ORDER BY a.applied_at DESC";

        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    JobPosting job = mapResultSetToJobPosting(rs);
                    // You can set application status if needed
                    jobs.add(job);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting applied jobs for user: " + userId, e);
        }
        return jobs;
    }

    // For Recruiter - get jobs by recruiter
    public List<JobPosting> getJobPostingsByRecruiter(int recruiterId) {
        List<JobPosting> jobs = new ArrayList<>();
        String sql = "SELECT jp.*, jc.category_name, l.province, l.ward, u.fullname as recruiter_name "
                + "FROM job_posting jp "
                + "JOIN job_category jc ON jp.category_id = jc.category_id "
                + "JOIN location l ON jp.location_id = l.location_id "
                + "JOIN [user] u ON jp.createdBy = u.user_id "
                + "WHERE jp.createdBy = ? "
                + "ORDER BY jp.posted_at DESC";

        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, recruiterId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    jobs.add(mapResultSetToJobPosting(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting job postings by recruiter: " + recruiterId, e);
        }
        return jobs;
    }

    // For Manager - get pending approval jobs
    public List<JobPosting> getAllPendingApprovalJobs() {
        List<JobPosting> jobs = new ArrayList<>();
        String sql = "SELECT jp.*, jc.category_name, l.province, l.ward, "
                + "u.fullname as recruiter_name, u.email as recruiter_email "
                + "FROM job_posting jp "
                + "JOIN job_category jc ON jp.category_id = jc.category_id "
                + "JOIN location l ON jp.location_id = l.location_id "
                + "JOIN [user] u ON jp.createdBy = u.user_id "
                + "WHERE jp.approvedAt IS NULL "
                + "ORDER BY jp.posted_at DESC";

        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                jobs.add(mapResultSetToJobPosting(rs));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting pending approval jobs", e);
        }
        return jobs;
    }

    // For Manager - get all jobs
    public List<JobPosting> getAllJobPostings() {
        List<JobPosting> jobs = new ArrayList<>();
        String sql = "SELECT jp.*, jc.category_name, l.province, l.ward, "
                + "u.fullname as recruiter_name, u.email as recruiter_email "
                + "FROM job_posting jp "
                + "JOIN job_category jc ON jp.category_id = jc.category_id "
                + "JOIN location l ON jp.location_id = l.location_id "
                + "JOIN [user] u ON jp.createdBy = u.user_id "
                + "ORDER BY jp.posted_at DESC";

        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                jobs.add(mapResultSetToJobPosting(rs));
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting all job postings", e);
        }
        return jobs;
    }

    // Get job by ID
    public JobPosting getJobPostingById(int jobId) {
        String sql = "SELECT jp.*, jc.category_name, l.province, l.ward, u.fullname as recruiter_name "
                + "FROM job_posting jp "
                + "JOIN job_category jc ON jp.category_id = jc.category_id "
                + "JOIN location l ON jp.location_id = l.location_id "
                + "JOIN [user] u ON jp.createdBy = u.user_id "
                + "WHERE jp.job_id = ?";

        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, jobId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToJobPosting(rs);
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting job posting by ID: " + jobId, e);
        }
        return null;
    }

    // Search job postings
    public List<JobPosting> searchJobPostings(String keyword, Integer categoryId, Integer locationId) {
        List<JobPosting> jobs = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT jp.*, jc.category_name, l.province, l.ward, u.fullname as recruiter_name "
                + "FROM job_posting jp "
                + "JOIN job_category jc ON jp.category_id = jc.category_id "
                + "JOIN location l ON jp.location_id = l.location_id "
                + "JOIN [user] u ON jp.createdBy = u.user_id "
                + "WHERE jp.status = 'Open' AND jp.expired_at > GETDATE() AND jp.approvedAt IS NOT NULL "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (jp.title LIKE ? OR jp.description LIKE ? OR jp.requirement LIKE ?) ");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        if (categoryId != null) {
            sql.append("AND jp.category_id = ? ");
            params.add(categoryId);
        }

        if (locationId != null) {
            sql.append("AND jp.location_id = ? ");
            params.add(locationId);
        }

        sql.append("ORDER BY jp.posted_at DESC");

        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    jobs.add(mapResultSetToJobPosting(rs));
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error searching job postings", e);
        }
        return jobs;
    }

    // Create new job posting (Recruiter)
    public boolean createJobPosting(JobPosting jobPosting) {
        String sql = "INSERT INTO job_posting (category_id, location_id, title, experience, level, "
                + "education, quantity, work_type, description, requirement, income, interest, "
                + "min_salary, max_salary, status, posted_at, expired_at, createdBy) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, jobPosting.getCategoryId());
            stmt.setInt(2, jobPosting.getLocationId());
            stmt.setString(3, jobPosting.getTitle());
            stmt.setString(4, jobPosting.getExperience());
            stmt.setString(5, jobPosting.getLevel());
            stmt.setString(6, jobPosting.getEducation());
            stmt.setString(7, jobPosting.getQuantity());
            stmt.setString(8, jobPosting.getWorkType());
            stmt.setString(9, jobPosting.getDescription());
            stmt.setString(10, jobPosting.getRequirement());
            stmt.setString(11, jobPosting.getIncome());
            stmt.setString(12, jobPosting.getInterest());
            stmt.setBigDecimal(13, jobPosting.getMinSalary());
            stmt.setBigDecimal(14, jobPosting.getMaxSalary());
            stmt.setString(15, "Pending");
            stmt.setTimestamp(16, Timestamp.valueOf(jobPosting.getPostedAt()));
            stmt.setTimestamp(17, Timestamp.valueOf(jobPosting.getExpiredAt()));
            stmt.setInt(18, jobPosting.getCreatedBy());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error creating job posting", e);
            return false;
        }
    }

    // Update job posting (Recruiter)
    public boolean updateJobPosting(JobPosting jobPosting) {
        String sql = "UPDATE job_posting SET category_id = ?, location_id = ?, title = ?, "
                + "experience = ?, level = ?, education = ?, quantity = ?, work_type = ?, "
                + "description = ?, requirement = ?, income = ?, interest = ?, "
                + "min_salary = ?, max_salary = ?, expired_at = ? "
                + "WHERE job_id = ? AND createdBy = ?";

        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, jobPosting.getCategoryId());
            stmt.setInt(2, jobPosting.getLocationId());
            stmt.setString(3, jobPosting.getTitle());
            stmt.setString(4, jobPosting.getExperience());
            stmt.setString(5, jobPosting.getLevel());
            stmt.setString(6, jobPosting.getEducation());
            stmt.setString(7, jobPosting.getQuantity());
            stmt.setString(8, jobPosting.getWorkType());
            stmt.setString(9, jobPosting.getDescription());
            stmt.setString(10, jobPosting.getRequirement());
            stmt.setString(11, jobPosting.getIncome());
            stmt.setString(12, jobPosting.getInterest());
            stmt.setBigDecimal(13, jobPosting.getMinSalary());
            stmt.setBigDecimal(14, jobPosting.getMaxSalary());
            stmt.setTimestamp(15, Timestamp.valueOf(jobPosting.getExpiredAt()));
            stmt.setInt(16, jobPosting.getJobId());
            stmt.setInt(17, jobPosting.getCreatedBy());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error updating job posting: " + jobPosting.getJobId(), e);
            return false;
        }
    }

    // Approve job posting (Manager)
    public boolean approveJobPosting(int jobId, int managerId) {
        String sql = "UPDATE job_posting SET status = 'Open', approvedAt = ? WHERE job_id = ?";

        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setTimestamp(1, Timestamp.valueOf(java.time.LocalDateTime.now()));
            stmt.setInt(2, jobId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error approving job posting: " + jobId, e);
            return false;
        }
    }

    // Reject job posting (Manager)
    public boolean rejectJobPosting(int jobId, int managerId) {
        String sql = "UPDATE job_posting SET status = 'Rejected', approvedAt = ? WHERE job_id = ?";

        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setTimestamp(1, Timestamp.valueOf(java.time.LocalDateTime.now()));
            stmt.setInt(2, jobId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error rejecting job posting: " + jobId, e);
            return false;
        }
    }

    // Delete job posting (Recruiter - soft delete if needed, or hard delete)
    public boolean deleteJobPosting(int jobId, int recruiterId) {
        String sql = "DELETE FROM job_posting WHERE job_id = ? AND createdBy = ?";

        try (Connection conn = dbContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, jobId);
            stmt.setInt(2, recruiterId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error deleting job posting: " + jobId, e);
            return false;
        }
    }

    // Helper method to map ResultSet to JobPosting object
    private JobPosting mapResultSetToJobPosting(ResultSet rs) throws SQLException {
        JobPosting job = new JobPosting();
        job.setJobId(rs.getInt("job_id"));
        job.setCategoryId(rs.getInt("category_id"));
        job.setLocationId(rs.getInt("location_id"));
        job.setTitle(rs.getString("title"));
        job.setExperience(rs.getString("experience"));
        job.setLevel(rs.getString("level"));
        job.setEducation(rs.getString("education"));
        job.setQuantity(rs.getString("quantity"));
        job.setWorkType(rs.getString("work_type"));
        job.setDescription(rs.getString("description"));
        job.setRequirement(rs.getString("requirement"));
        job.setIncome(rs.getString("income"));
        job.setInterest(rs.getString("interest"));
        job.setMinSalary(rs.getBigDecimal("min_salary"));
        job.setMaxSalary(rs.getBigDecimal("max_salary"));
        job.setStatus(rs.getString("status"));
        job.setPostedAt(rs.getTimestamp("posted_at").toLocalDateTime());
        job.setExpiredAt(rs.getTimestamp("expired_at").toLocalDateTime());

        // New fields
        if (hasColumn(rs, "createdBy")) {
            job.setCreatedBy(rs.getInt("createdBy"));
        }

        // Transient fields
        if (hasColumn(rs, "category_name")) {
            job.setCategoryName(rs.getString("category_name"));
        }
        if (hasColumn(rs, "province") && hasColumn(rs, "ward")) {
            job.setLocationName(rs.getString("province") + ", " + rs.getString("ward"));
        }
        if (hasColumn(rs, "recruiter_name")) {
            // You can set recruiter name if needed
        }
        if (hasColumn(rs, "approvedAt") && rs.getTimestamp("approvedAt") != null) {
            job.setApprovedAt(rs.getTimestamp("approvedAt").toLocalDateTime());
        }
        if (hasColumn(rs, "recruiter_name")) {
            job.setRecruiterName(rs.getString("recruiter_name"));
        }
        if (hasColumn(rs, "recruiter_email")) {
            job.setRecruiterEmail(rs.getString("recruiter_email"));
        }

        return job;
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
