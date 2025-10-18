/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Data.RCMSDbContext;
import Models.JobCategory;
import Models.JobPosting;
import Models.Location;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
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

        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = getConnection();
            connection.setAutoCommit(false);
            stmt = connection.prepareStatement(sql);

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

            int rowsAffected = stmt.executeUpdate();
            connection.commit();
            return rowsAffected > 0;

        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Cập nhật tin tuyển dụng
    public boolean updateJobPosting(JobPosting job) {
        String sql = "UPDATE job_posting SET category_id=?, location_id=?, title=?, experience=?, "
                + "level=?, education=?, quantity=?, work_type=?, description=?, requirement=?, "
                + "income=?, interest=?, min_salary=?, max_salary=?, status=?, expired_at=? "
                + "WHERE job_id=?";

        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = getConnection();
            connection.setAutoCommit(false);
            stmt = connection.prepareStatement(sql);

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

            int rowsAffected = stmt.executeUpdate();
            connection.commit();
            return rowsAffected > 0;

        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Lấy tin tuyển dụng theo ID
    public JobPosting getJobPostingById(int jobId) {
        String sql = "SELECT * FROM job_posting WHERE job_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, jobId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return extractJobPostingFromResultSet(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    // Lấy tất cả danh mục công việc
    public List<JobCategory> getAllCategories() {
        List<JobCategory> categories = new ArrayList<>();
        String sql = "SELECT * FROM job_category";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                JobCategory category = new JobCategory();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                categories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return categories;
    }

    // Lấy tất cả địa điểm (location)
    public List<Location> getAllLocations() {
        List<Location> locations = new ArrayList<>();
        String sql = "SELECT * FROM location";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Location location = new Location();
                location.setLocationId(rs.getInt("location_id"));
                location.setProvince(rs.getString("province"));
                location.setWard(rs.getString("ward"));
                location.setDetail(rs.getString("detail"));
                locations.add(location);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return locations;
    }

    // Lấy tất cả tin tuyển dụng
    public List<JobPosting> getAllJobPostings() {
        List<JobPosting> jobs = new ArrayList<>();
        String sql = "SELECT * FROM job_posting";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                JobPosting job = extractJobPostingFromResultSet(rs);
                jobs.add(job);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return jobs;
    }

    // Lấy tin tuyển dụng theo trạng thái
    public List<JobPosting> getJobPostingsByStatus(String status) {
        List<JobPosting> jobs = new ArrayList<>();
        String sql = "SELECT * FROM job_posting WHERE status = ?";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, status);
            rs = stmt.executeQuery();

            while (rs.next()) {
                JobPosting job = extractJobPostingFromResultSet(rs);
                jobs.add(job);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return jobs;
    }

    // Xóa tin tuyển dụng
    public boolean deleteJobPosting(int jobId) {
        String sql = "DELETE FROM job_posting WHERE job_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = getConnection();
            connection.setAutoCommit(false);
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, jobId);
            int rowsAffected = stmt.executeUpdate();
            connection.commit();
            return rowsAffected > 0;
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Lấy danh mục theo ID
    public JobCategory getCategoryById(int categoryId) {
        String sql = "SELECT * FROM job_category WHERE category_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, categoryId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                JobCategory category = new JobCategory();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                return category;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    // Lấy địa điểm theo ID
    public Location getLocationById(int locationId) {
        String sql = "SELECT * FROM location WHERE location_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, locationId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                Location location = new Location();
                location.setLocationId(rs.getInt("location_id"));
                location.setProvince(rs.getString("province"));
                location.setWard(rs.getString("ward"));
                location.setDetail(rs.getString("detail"));
                return location;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    // Tìm kiếm tin tuyển dụng
    public List<JobPosting> searchJobPostings(String keyword) {
        List<JobPosting> jobs = new ArrayList<>();
        String sql = "SELECT * FROM job_posting WHERE title LIKE ? OR description LIKE ? OR requirement LIKE ?";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            rs = stmt.executeQuery();

            while (rs.next()) {
                JobPosting job = extractJobPostingFromResultSet(rs);
                jobs.add(job);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return jobs;
    }

    // Phương thức helper để trích xuất dữ liệu từ ResultSet
    private JobPosting extractJobPostingFromResultSet(ResultSet rs) throws SQLException {
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

        // Xử lý BigDecimal có thể null
        BigDecimal minSalary = rs.getBigDecimal("min_salary");
        if (rs.wasNull()) {
            minSalary = null;
        }
        job.setMinSalary(minSalary);

        BigDecimal maxSalary = rs.getBigDecimal("max_salary");
        if (rs.wasNull()) {
            maxSalary = null;
        }
        job.setMaxSalary(maxSalary);

        job.setStatus(rs.getString("status"));

        // Xử lý null cho posted_at
        Timestamp postedAt = rs.getTimestamp("posted_at");
        if (postedAt != null) {
            job.setPostedAt(postedAt.toLocalDateTime());
        } else {
            job.setPostedAt(LocalDateTime.now());
        }

        // Xử lý null cho expired_at - ĐẢM BẢO KHÔNG BAO GIỜ NULL
        Timestamp expiredAt = rs.getTimestamp("expired_at");
        if (expiredAt != null) {
            job.setExpiredAt(expiredAt.toLocalDateTime());
        } else {
            // Nếu expired_at null, set mặc định là 1 tháng sau postedAt
            job.setExpiredAt(job.getPostedAt().plusMonths(1));
        }

        return job;
    }
}
