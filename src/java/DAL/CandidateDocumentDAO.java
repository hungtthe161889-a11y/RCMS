/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Data.RCMSDbContext;
import Models.CandidateDocument;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Hung
 */
public class CandidateDocumentDAO extends RCMSDbContext {

    //Hùng - Chức năng tải lên chứng chỉ và cv
    public boolean uploadDocument(CandidateDocument doc) {
        String sql = """
            INSERT INTO candidate_document
            (user_id, title, file_path, file_size, doc_type, issued_by, issued_at, expires_at,
             status, uploaded_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'PENDING', GETDATE())
            """;

        try {
            Connection conn = getConnection();
            PreparedStatement st = conn.prepareStatement(sql);

            st.setInt(1, doc.getUserId());
            st.setString(2, doc.getTitle());
            st.setString(3, doc.getFilePath());
            st.setLong(4, doc.getFileSize());
            st.setString(5, doc.getDocType());
            st.setString(6, doc.getIssuedBy());

            if (doc.getIssuedAt() != null) {
                st.setDate(7, java.sql.Date.valueOf(doc.getIssuedAt()));
            } else {
                st.setNull(7, java.sql.Types.DATE);
            }

            if (doc.getExpiresAt() != null) {
                st.setDate(8, java.sql.Date.valueOf(doc.getExpiresAt()));
            } else {
                st.setNull(8, java.sql.Types.DATE);
            }

            int rows = st.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi upload tài liệu: " + e.getMessage());
            return false;
        }
    }

    //Hùng - Lấy danh sách tài liệu theo user_id
    public List<CandidateDocument> getDocumentsByUser(int userId) {
        List<CandidateDocument> list = new ArrayList<>();
        String sql = """
            SELECT document_id, user_id, title, file_path, file_size, doc_type,
                   issued_by, issued_at, expires_at, status, uploaded_at
            FROM candidate_document
            WHERE user_id = ?
            ORDER BY uploaded_at DESC
            """;

        try (Connection conn = getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {

            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                CandidateDocument d = new CandidateDocument();
                d.setDocumentId(rs.getInt("document_id"));
                d.setUserId(rs.getInt("user_id"));
                d.setTitle(rs.getString("title"));
                d.setFilePath(rs.getString("file_path"));
                d.setFileSize(rs.getLong("file_size"));
                d.setDocType(rs.getString("doc_type"));
                d.setIssuedBy(rs.getString("issued_by"));
                d.setIssuedAt(rs.getDate("issued_at") != null ? rs.getDate("issued_at").toLocalDate() : null);
                d.setExpiresAt(rs.getDate("expires_at") != null ? rs.getDate("expires_at").toLocalDate() : null);
                d.setStatus(rs.getString("status"));
                d.setUploadedAt(rs.getTimestamp("uploaded_at").toLocalDateTime());
                list.add(d);
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy danh sách tài liệu: " + e.getMessage());
        }

        return list;
    }

    // Hùng -  Tìm kiếm & lọc tài liệu theo user, tiêu đề, loại tài liệu
    public List<CandidateDocument> searchDocuments(int userId, String keyword, String type) {
        List<CandidateDocument> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
            SELECT document_id, user_id, title, file_path, file_size, doc_type,
                   issued_by, issued_at, expires_at, status, uploaded_at
            FROM candidate_document
            WHERE user_id = ?
            """);

        // Ghép điều kiện động
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND title LIKE ? ");
        }
        if (type != null && !type.trim().isEmpty()) {
            sql.append(" AND doc_type = ? ");
        }

        sql.append(" ORDER BY uploaded_at DESC");

        try (Connection conn = getConnection(); PreparedStatement st = conn.prepareStatement(sql.toString())) {

            int index = 1;
            st.setInt(index++, userId);

            if (keyword != null && !keyword.trim().isEmpty()) {
                st.setString(index++, "%" + keyword.trim() + "%");
            }
            if (type != null && !type.trim().isEmpty()) {
                st.setString(index++, type);
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CandidateDocument d = new CandidateDocument();
                d.setDocumentId(rs.getInt("document_id"));
                d.setUserId(rs.getInt("user_id"));
                d.setTitle(rs.getString("title"));
                d.setFilePath(rs.getString("file_path"));
                d.setFileSize(rs.getLong("file_size"));
                d.setDocType(rs.getString("doc_type"));
                d.setIssuedBy(rs.getString("issued_by"));
                d.setIssuedAt(rs.getDate("issued_at") != null ? rs.getDate("issued_at").toLocalDate() : null);
                d.setExpiresAt(rs.getDate("expires_at") != null ? rs.getDate("expires_at").toLocalDate() : null);
                d.setStatus(rs.getString("status"));
                d.setUploadedAt(rs.getTimestamp("uploaded_at").toLocalDateTime());
                list.add(d);
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi tìm kiếm tài liệu: " + e.getMessage());
        }

        return list;
    }

    //Hùng - tìm chứng chỉ theo id 
    public CandidateDocument getDocumentById(int id) {
        String sql = """
        SELECT document_id, user_id, title, file_path, file_size, doc_type,
               issued_by, issued_at, expires_at, status, uploaded_at
        FROM candidate_document
        WHERE document_id = ?
        """;

        try (Connection conn = getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {

            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                CandidateDocument d = new CandidateDocument();
                d.setDocumentId(rs.getInt("document_id"));
                d.setUserId(rs.getInt("user_id"));
                d.setTitle(rs.getString("title"));
                d.setFilePath(rs.getString("file_path"));
                d.setFileSize(rs.getLong("file_size"));
                d.setDocType(rs.getString("doc_type"));
                d.setIssuedBy(rs.getString("issued_by"));
                d.setIssuedAt(rs.getDate("issued_at") != null ? rs.getDate("issued_at").toLocalDate() : null);
                d.setExpiresAt(rs.getDate("expires_at") != null ? rs.getDate("expires_at").toLocalDate() : null);
                d.setStatus(rs.getString("status"));
                d.setUploadedAt(rs.getTimestamp("uploaded_at").toLocalDateTime());
                return d;
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy tài liệu theo ID: " + e.getMessage());
        }
        return null;
    }

    //Hùng - xóa chứng chỉ
    public boolean deleteDocument(int id) {
        String sql = "DELETE FROM candidate_document WHERE document_id = ?";
        try (Connection conn = getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, id);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi xóa tài liệu: " + e.getMessage());
            return false;
        }
    }

    //Hùng - cập nhật chứng chỉ
    public boolean updateDocument(CandidateDocument doc) {
        String sql = """
        UPDATE candidate_document
        SET title = ?, doc_type = ?, issued_by = ?, issued_at = ?, expires_at = ?,
            file_path = COALESCE(?, file_path),
            file_size = COALESCE(?, file_size)
        WHERE document_id = ?
        """;

        try (Connection conn = getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {

            st.setString(1, doc.getTitle());
            st.setString(2, doc.getDocType());
            st.setString(3, doc.getIssuedBy());

            if (doc.getIssuedAt() != null) {
                st.setDate(4, java.sql.Date.valueOf(doc.getIssuedAt()));
            } else {
                st.setNull(4, java.sql.Types.DATE);
            }

            if (doc.getExpiresAt() != null) {
                st.setDate(5, java.sql.Date.valueOf(doc.getExpiresAt()));
            } else {
                st.setNull(5, java.sql.Types.DATE);
            }

            // Nếu có file mới, truyền path + size, nếu không -> null để giữ nguyên
            if (doc.getFilePath() != null) {
                st.setString(6, doc.getFilePath());
            } else {
                st.setNull(6, java.sql.Types.VARCHAR);
            }

            if (doc.getFileSize() > 0) {
                st.setLong(7, doc.getFileSize());
            } else {
                st.setNull(7, java.sql.Types.BIGINT);
            }

            st.setInt(8, doc.getDocumentId());

            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi cập nhật tài liệu: " + e.getMessage());
            return false;
        }
    }

    public List<CandidateDocument> getAllDocuments(String keyword, String type, String status) {
        List<CandidateDocument> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
        SELECT d.document_id, d.user_id, u.fullname AS candidate_name,
               d.title, d.file_path, d.file_size, d.doc_type, d.issued_by,
               d.issued_at, d.expires_at, d.status, d.uploaded_at,
               d.verified_by, d.verified_at, d.note
        FROM candidate_document d
        JOIN [user] u ON d.user_id = u.user_id
        WHERE d.is_deleted = 0
        """);

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (u.fullname LIKE ? OR d.title LIKE ?) ");
        }
        if (type != null && !type.trim().isEmpty()) {
            sql.append(" AND d.doc_type = ? ");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND d.status = ? ");
        }

        sql.append(" ORDER BY d.uploaded_at DESC");

        try (Connection conn = getConnection(); PreparedStatement st = conn.prepareStatement(sql.toString())) {
            int index = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                st.setString(index++, "%" + keyword.trim() + "%");
                st.setString(index++, "%" + keyword.trim() + "%");
            }
            if (type != null && !type.trim().isEmpty()) {
                st.setString(index++, type);
            }
            if (status != null && !status.trim().isEmpty()) {
                st.setString(index++, status);
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CandidateDocument d = new CandidateDocument();
                d.setDocumentId(rs.getInt("document_id"));
                d.setUserId(rs.getInt("user_id"));
                d.setTitle(rs.getString("title"));
                d.setFilePath(rs.getString("file_path"));
                d.setFileSize(rs.getLong("file_size"));
                d.setDocType(rs.getString("doc_type"));
                d.setIssuedBy(rs.getString("issued_by"));
                d.setIssuedAt(rs.getDate("issued_at") != null ? rs.getDate("issued_at").toLocalDate() : null);
                d.setExpiresAt(rs.getDate("expires_at") != null ? rs.getDate("expires_at").toLocalDate() : null);
                d.setStatus(rs.getString("status"));
                d.setUploadedAt(rs.getTimestamp("uploaded_at").toLocalDateTime());
                d.setVerifiedBy(rs.getInt("verified_by"));
                d.setVerifiedAt(rs.getTimestamp("verified_at") != null ? rs.getTimestamp("verified_at").toLocalDateTime() : null);
                d.setNote(rs.getString("note"));
                list.add(d);
            }

        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi lấy danh sách tài liệu (Admin): " + e.getMessage());
        }

        return list;
    }

    public boolean verifyDocument(int documentId, int adminId) {
        String sql = """
        UPDATE candidate_document
        SET status = 'ACTIVE',
            verified_by = ?,
            verified_at = GETDATE(),
            updated_at = GETDATE()
        WHERE document_id = ? AND is_deleted = 0
        """;
        try (Connection conn = getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, adminId);
            st.setInt(2, documentId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi duyệt tài liệu: " + e.getMessage());
            return false;
        }
    }

    public boolean rejectDocument(int documentId, int adminId, String note) {
        String sql = """
        UPDATE candidate_document
        SET status = 'REJECTED',
            note = ?,
            verified_by = ?,
            verified_at = GETDATE(),
            updated_at = GETDATE()
        WHERE document_id = ? AND is_deleted = 0
        """;
        try (Connection conn = getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            st.setString(1, note);
            st.setInt(2, adminId);
            st.setInt(3, documentId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi từ chối tài liệu: " + e.getMessage());
            return false;
        }
    }

    public boolean softDeleteDocument(int documentId, int adminId) {
        String sql = """
        UPDATE candidate_document
        SET is_deleted = 1, updated_at = GETDATE(), verified_by = ?
        WHERE document_id = ?
        """;
        try (Connection conn = getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            st.setInt(1, adminId);
            st.setInt(2, documentId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("❌ Lỗi khi xóa mềm tài liệu: " + e.getMessage());
            return false;
        }
    }

}
