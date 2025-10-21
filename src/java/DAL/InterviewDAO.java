/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Data.RCMSDbContext;
import Models.Interview;
import Models.InterviewFeedback;
import Models.JobPosting;
import java.math.BigDecimal;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tú
 */
public class InterviewDAO extends RCMSDbContext {

    // === INTERVIEW METHODS ===
    // Tạo lịch phỏng vấn mới
    public boolean createInterview(Interview interview) {
        String sql = "INSERT INTO [interview] (application_id, scheduled_at, location_id, interviewer_fullname, notes) "
                + "VALUES (?, ?, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = getConnection();
            connection.setAutoCommit(false);
            stmt = connection.prepareStatement(sql);

            stmt.setInt(1, interview.getApplicationId());
            stmt.setTimestamp(2, Timestamp.valueOf(interview.getScheduledAt()));
            stmt.setInt(3, interview.getLocationId());
            stmt.setString(4, interview.getInterviewerFullname());
            stmt.setString(5, interview.getNotes());

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

    // Lấy thông tin phỏng vấn theo ID
    public Interview getInterviewById(int interviewId) {
        String sql = "SELECT * FROM [interview] WHERE interview_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, interviewId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return extractInterviewFromResultSet(rs);
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

    // Lấy tất cả lịch phỏng vấn
    public List<Interview> getAllInterviews() {
        List<Interview> interviews = new ArrayList<>();
        String sql = "SELECT * FROM [interview] ORDER BY scheduled_at DESC";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Interview interview = extractInterviewFromResultSet(rs);
                interviews.add(interview);
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
        return interviews;
    }

    // Lấy lịch phỏng vấn theo application ID
    public List<Interview> getInterviewsByApplicationId(int applicationId) {
        List<Interview> interviews = new ArrayList<>();
        String sql = "SELECT * FROM [interview] WHERE application_id = ? ORDER BY scheduled_at DESC";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, applicationId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Interview interview = extractInterviewFromResultSet(rs);
                interviews.add(interview);
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
        return interviews;
    }

    // Cập nhật thông tin phỏng vấn
    public boolean updateInterview(Interview interview) {
        String sql = "UPDATE [interview] SET application_id = ?, scheduled_at = ?, location_id = ?, "
                + "interviewer_fullname = ?, notes = ? WHERE interview_id = ?";

        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = getConnection();
            connection.setAutoCommit(false);
            stmt = connection.prepareStatement(sql);

            stmt.setInt(1, interview.getApplicationId());
            stmt.setTimestamp(2, Timestamp.valueOf(interview.getScheduledAt()));
            stmt.setInt(3, interview.getLocationId());
            stmt.setString(4, interview.getInterviewerFullname());
            stmt.setString(5, interview.getNotes());
            stmt.setInt(6, interview.getInterviewId());

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

    // Xóa lịch phỏng vấn
    public boolean deleteInterview(int interviewId) {
        String sql = "DELETE FROM [interview] WHERE interview_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = getConnection();
            connection.setAutoCommit(false);
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, interviewId);
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

    // Kiểm tra xem application đã có lịch phỏng vấn chưa
    public boolean hasScheduledInterview(int applicationId) {
        String sql = "SELECT COUNT(*) FROM [interview] WHERE application_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, applicationId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
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
        return false;
    }

    // INTERVIEW FEEDBACK METHODS 
    // Tạo feedback mới
    public boolean createFeedback(InterviewFeedback feedback) {
        String sql = "INSERT INTO [interview_feedback] (interview_id, reviewer_id, rating, comment, created_at) "
                + "VALUES (?, ?, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = getConnection();
            connection.setAutoCommit(false);
            stmt = connection.prepareStatement(sql);

            stmt.setInt(1, feedback.getInterviewId());
            stmt.setInt(2, feedback.getReviewerId());
            stmt.setBigDecimal(3, feedback.getRating());
            stmt.setString(4, feedback.getComment());
            stmt.setTimestamp(5, Timestamp.valueOf(feedback.getCreatedAt()));

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

    // Lấy feedback theo ID
    public InterviewFeedback getFeedbackById(int feedbackId) {
        String sql = "SELECT * FROM [interview_feedback] WHERE feedback_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, feedbackId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return extractFeedbackFromResultSet(rs);
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

    // Lấy tất cả feedback của một cuộc phỏng vấn
    public List<InterviewFeedback> getFeedbacksByInterviewId(int interviewId) {
        List<InterviewFeedback> feedbacks = new ArrayList<>();
        String sql = "SELECT * FROM [interview_feedback] WHERE interview_id = ? ORDER BY created_at DESC";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, interviewId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                InterviewFeedback feedback = extractFeedbackFromResultSet(rs);
                feedbacks.add(feedback);
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
        return feedbacks;
    }

    // Cập nhật feedback
    public boolean updateFeedback(InterviewFeedback feedback) {
        String sql = "UPDATE [interview_feedback] SET rating = ?, comment = ? WHERE feedback_id = ?";

        Connection connection = null;
        PreparedStatement stmt = null;

        try {
            connection = getConnection();
            connection.setAutoCommit(false);
            stmt = connection.prepareStatement(sql);

            stmt.setBigDecimal(1, feedback.getRating());
            stmt.setString(2, feedback.getComment());
            stmt.setInt(3, feedback.getFeedbackId());

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

    // Tính điểm trung bình của một cuộc phỏng vấn
    public BigDecimal getAverageRatingByInterviewId(int interviewId) {
        String sql = "SELECT AVG(CAST(rating AS DECIMAL(10,2))) as avg_rating FROM [interview_feedback] WHERE interview_id = ?";
        Connection connection = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, interviewId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getBigDecimal("avg_rating");
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

    // === COMBINED METHODS - RẤT TIỆN LỢI KHI GỘP CHUNG ===
    // Lấy thông tin phỏng vấn kèm theo tất cả feedback
    public Interview getInterviewWithFeedbacks(int interviewId) {
        Interview interview = getInterviewById(interviewId);
        if (interview != null) {
            List<InterviewFeedback> feedbacks = getFeedbacksByInterviewId(interviewId);
            // Có thể set feedbacks vào interview nếu cần
        }
        return interview;
    }

    // Tạo phỏng vấn và feedback cùng lúc (cho trường hợp tạo nhanh)
    public boolean createInterviewWithFeedback(Interview interview, InterviewFeedback feedback) {
        Connection connection = null;
        PreparedStatement stmtInterview = null;
        PreparedStatement stmtFeedback = null;

        try {
            connection = getConnection();
            connection.setAutoCommit(false);

            // Tạo interview
            String sqlInterview = "INSERT INTO [interview] (application_id, scheduled_at, location_id, interviewer_fullname, notes) VALUES (?, ?, ?, ?, ?)";
            stmtInterview = connection.prepareStatement(sqlInterview, Statement.RETURN_GENERATED_KEYS);
            stmtInterview.setInt(1, interview.getApplicationId());
            stmtInterview.setTimestamp(2, Timestamp.valueOf(interview.getScheduledAt()));
            stmtInterview.setInt(3, interview.getLocationId());
            stmtInterview.setString(4, interview.getInterviewerFullname());
            stmtInterview.setString(5, interview.getNotes());

            int interviewRows = stmtInterview.executeUpdate();

            if (interviewRows > 0) {
                // Lấy interview_id vừa tạo
                ResultSet rs = stmtInterview.getGeneratedKeys();
                if (rs.next()) {
                    int newInterviewId = rs.getInt(1);

                    // Tạo feedback với interview_id vừa tạo
                    String sqlFeedback = "INSERT INTO [interview_feedback] (interview_id, reviewer_id, rating, comment, created_at) VALUES (?, ?, ?, ?, ?)";
                    stmtFeedback = connection.prepareStatement(sqlFeedback);
                    stmtFeedback.setInt(1, newInterviewId);
                    stmtFeedback.setInt(2, feedback.getReviewerId());
                    stmtFeedback.setBigDecimal(3, feedback.getRating());
                    stmtFeedback.setString(4, feedback.getComment());
                    stmtFeedback.setTimestamp(5, Timestamp.valueOf(feedback.getCreatedAt()));

                    int feedbackRows = stmtFeedback.executeUpdate();

                    if (feedbackRows > 0) {
                        connection.commit();
                        return true;
                    }
                }
            }

            connection.rollback();
            return false;

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
                if (stmtInterview != null) {
                    stmtInterview.close();
                }
                if (stmtFeedback != null) {
                    stmtFeedback.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // === HELPER METHODS ===
    private Interview extractInterviewFromResultSet(ResultSet rs) throws SQLException {
        Interview interview = new Interview();
        interview.setInterviewId(rs.getInt("interview_id"));
        interview.setApplicationId(rs.getInt("application_id"));

        Timestamp scheduledAt = rs.getTimestamp("scheduled_at");
        if (scheduledAt != null) {
            LocalDateTime scheduledDateTime = scheduledAt.toLocalDateTime();
            interview.setScheduledAt(scheduledDateTime);

            // QUAN TRỌNG: Format cho datetime-local input (THÊM PHẦN NÀY)
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            String formattedDateTime = scheduledDateTime.format(formatter);
            interview.setScheduledAtFormatted(formattedDateTime);
        }

        interview.setLocationId(rs.getInt("location_id"));
        interview.setInterviewerFullname(rs.getString("interviewer_fullname"));
        interview.setNotes(rs.getString("notes"));

        return interview;
    }

    private InterviewFeedback extractFeedbackFromResultSet(ResultSet rs) throws SQLException {
        InterviewFeedback feedback = new InterviewFeedback();
        feedback.setFeedbackId(rs.getInt("feedback_id"));
        feedback.setInterviewId(rs.getInt("interview_id"));
        feedback.setReviewerId(rs.getInt("reviewer_id"));
        feedback.setRating(rs.getBigDecimal("rating"));
        feedback.setComment(rs.getString("comment"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            feedback.setCreatedAt(createdAt.toLocalDateTime());
        }

        return feedback;
    }

    
    
}
