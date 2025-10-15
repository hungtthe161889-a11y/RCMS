/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Data.RCMSDbContext;
import Models.JobCategory;
import Models.JobPosting;
import Models.Location;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class JobPostingDAO extends RCMSDbContext {

    // Tạo mới tin tuyển dụng
    public boolean createJobPosting(JobPosting job) {
        String sql = "INSERT INTO job_posting (category_id, location_id, title, experience, level, "
                + "education, quantity, work_type, description, requirement, income, interest, "
                + "min_salary, max_salary, status, posted_at, expired_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            Connection connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, job.getCategoryId());
            stmt.setInt(2, job.getLocationId());
            stmt.setString(3, job.getTitle());
            stmt.setString(4, job.getExperience());
            stmt.setString(5, job.getLevel());
            stmt.setString(6, job.getEducation());
            stmt.setString(7, job.getQuantity());
            stmt.setString(8, job.getWorkType());
            stmt.setString(9, job.getDescription());
            stmt.setString(10, job.getRequirement());
            stmt.setString(11, job.getIncome());
            stmt.setString(12, job.getInterest());
            stmt.setBigDecimal(13, job.getMinSalary());
            stmt.setBigDecimal(14, job.getMaxSalary());
            stmt.setString(15, job.getStatus());
            stmt.setTimestamp(16, Timestamp.valueOf(job.getPostedAt()));
            stmt.setTimestamp(17, Timestamp.valueOf(job.getExpiredAt()));
            stmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật tin tuyển dụng
    public boolean updateJobPosting(JobPosting job) {
        String sql = "UPDATE job_posting SET category_id=?, location_id=?, title=?, experience=?, "
                + "level=?, education=?, quantity=?, work_type=?, description=?, requirement=?, "
                + "income=?, interest=?, min_salary=?, max_salary=?, status=?, expired_at=? "
                + "WHERE job_id=?";

        try {
            Connection connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, job.getCategoryId());
            stmt.setInt(2, job.getLocationId());
            stmt.setString(3, job.getTitle());
            stmt.setString(4, job.getExperience());
            stmt.setString(5, job.getLevel());
            stmt.setString(6, job.getEducation());
            stmt.setString(7, job.getQuantity());
            stmt.setString(8, job.getWorkType());
            stmt.setString(9, job.getDescription());
            stmt.setString(10, job.getRequirement());
            stmt.setString(11, job.getIncome());
            stmt.setString(12, job.getInterest());
            stmt.setBigDecimal(13, job.getMinSalary());
            stmt.setBigDecimal(14, job.getMaxSalary());
            stmt.setString(15, job.getStatus());
            stmt.setTimestamp(16, Timestamp.valueOf(job.getExpiredAt()));
            stmt.setInt(17, job.getJobId());

            stmt.executeUpdate();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy tin tuyển dụng theo ID
    public JobPosting getJobPostingById(int jobId) {
        String sql = "SELECT * FROM job_posting WHERE job_id = ?";

        try {
            Connection connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, jobId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
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
                return job;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Lấy tất cả danh mục công việc
    public List<JobCategory> getAllCategories() {
        List<JobCategory> categories = new ArrayList<>();
        String sql = "SELECT * FROM job_category";

        try {
            Connection connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                JobCategory category = new JobCategory();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                categories.add(category);
            }
        } catch (Exception e) {
        }
        return categories;
    }

    // 1. Lấy tất cả địa điểm (location) - quan trọng cho dropdown
    public List<Location> getAllLocations() {
        List<Location> location = new ArrayList<>();
        String sql = "SELECT * FROM location ";

        try {
            Connection connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Location lct = new Location();
                lct.setLocationId(rs.getInt("location_id"));
                lct.setProvince(rs.getString("province"));
                lct.setWard(rs.getString("ward"));
                lct.setDetail(rs.getString("detail"));
                location.add(lct);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return location;
    }

    // 2. Lấy tất cả tin tuyển dụng (cho danh sách)
    public List<JobPosting> getAllJobPostings() {
        List<JobPosting> job = new ArrayList<>();
        String sql = "SELECT * FROM job_posting";

        try {
            Connection connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                JobPosting j = new JobPosting();
                j.setJobId(rs.getInt("job_id"));
                j.setCategoryId(rs.getInt("category_id"));
                j.setLocationId(rs.getInt("location_id"));
                j.setTitle(rs.getString("title"));
                j.setExperience(rs.getString("experience"));
                j.setLevel(rs.getString("level"));
                j.setEducation(rs.getString("education"));
                j.setQuantity(rs.getString("quantity"));
                j.setWorkType(rs.getString("work_type"));
                j.setDescription(rs.getString("description"));
                j.setRequirement(rs.getString("requirement"));
                j.setIncome(rs.getString("income"));
                j.setInterest(rs.getString("interest"));
                j.setMinSalary(rs.getBigDecimal("min_salary"));
                j.setMaxSalary(rs.getBigDecimal("max_salary"));
                j.setStatus(rs.getString("status"));
                j.setPostedAt(rs.getTimestamp("posted_at").toLocalDateTime());
                j.setExpiredAt(rs.getTimestamp("expired_at").toLocalDateTime());
                job.add(j);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return job;
    }

    // 3. Lấy tin tuyển dụng theo trạng thái
    public List<JobPosting> getJobPostingsByStatus(String status) {
        List<JobPosting> job = new ArrayList<>();
        String sql = "SELECT * FROM job_posting WHERE status = ? ";

        try {
            Connection connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, status);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                JobPosting j = new JobPosting();
                j.setJobId(rs.getInt("job_id"));
                j.setCategoryId(rs.getInt("category_id"));
                j.setLocationId(rs.getInt("location_id"));
                j.setTitle(rs.getString("title"));
                j.setExperience(rs.getString("experience"));
                j.setLevel(rs.getString("level"));
                j.setEducation(rs.getString("education"));
                j.setQuantity(rs.getString("quantity"));
                j.setWorkType(rs.getString("work_type"));
                j.setDescription(rs.getString("description"));
                j.setRequirement(rs.getString("requirement"));
                j.setIncome(rs.getString("income"));
                j.setInterest(rs.getString("interest"));
                j.setMinSalary(rs.getBigDecimal("min_salary"));
                j.setMaxSalary(rs.getBigDecimal("max_salary"));
                j.setStatus(rs.getString("status"));
                j.setPostedAt(rs.getTimestamp("posted_at").toLocalDateTime());
                j.setExpiredAt(rs.getTimestamp("expired_at").toLocalDateTime());
                job.add(j);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return job;
    }

    // 4. Xóa tin tuyển dụng (delete theo JobID)
    public void deleteJobPosting(int jobId) {
        if (getJobPostingById(jobId) == null) {
            return;
        }
        String sql = "DELETE FROM [dbo].[job_posting]\n"
                + "      WHERE job_id = ?";

        try {
            Connection connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, jobId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 5. Lấy danh mục theo ID
    public JobCategory getCategoryById(int categoryId) {
        String sql = "SELECT * FROM job_category WHERE category_id = ?";
        JobCategory category = new JobCategory();

        try {
            Connection connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return category;
    }

    // 6. Lấy địa điểm theo ID
    public Location getLocationById(int locationId) {
        String sql = "SELECT * FROM location WHERE location_id = ?";
        Location location = new Location();

        try {
            Connection connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, locationId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                location.setLocationId(rs.getInt("location_id"));
                location.setProvince(rs.getString("province"));
                location.setWard(rs.getString("ward"));
                location.setDetail(rs.getString("detail"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return location;
    }

    // 7. Tìm kiếm tin tuyển dụng theo tiêu đề 
    public List<JobPosting> searchJobPostings(String title) {
        List<JobPosting> job = new ArrayList<>();

        // SQL tìm kiếm trong title, description và requirement
        String sql = "SELECT * FROM job_posting WHERE title = ?";

        try {
            Connection connection = getConnection();
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, title); // tìm đúng tiêu đề
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                JobPosting j = new JobPosting();
                j.setJobId(rs.getInt("job_id"));
                j.setCategoryId(rs.getInt("category_id"));
                j.setLocationId(rs.getInt("location_id"));
                j.setTitle(rs.getString("title"));
                j.setExperience(rs.getString("experience"));
                j.setLevel(rs.getString("level"));
                j.setEducation(rs.getString("education"));
                j.setQuantity(rs.getString("quantity"));
                j.setWorkType(rs.getString("work_type"));
                j.setDescription(rs.getString("description"));
                j.setRequirement(rs.getString("requirement"));
                j.setIncome(rs.getString("income"));
                j.setInterest(rs.getString("interest"));
                j.setMinSalary(rs.getBigDecimal("min_salary"));
                j.setMaxSalary(rs.getBigDecimal("max_salary"));
                j.setStatus(rs.getString("status"));
                j.setPostedAt(rs.getTimestamp("posted_at").toLocalDateTime());
                j.setExpiredAt(rs.getTimestamp("expired_at").toLocalDateTime());
                job.add(j);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }            
        return job;
    }
}
