package Models;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class CandidateDocument {

    private int documentId;
    private int userId;
    private String title;
    private String filePath;
    private long fileSize;
    private String docType;
    private String issuedBy;
    private LocalDate issuedAt;
    private LocalDate expiresAt;
    private String status;
    private Integer verifiedBy;
    private LocalDateTime verifiedAt;
    private String note;
    private LocalDateTime uploadedAt;
    private LocalDateTime updatedAt;

    public CandidateDocument() {
    }

    public CandidateDocument(int documentId, int userId, String title, String filePath, long fileSize, String docType, String issuedBy, LocalDate issuedAt, LocalDate expiresAt, String status, Integer verifiedBy, LocalDateTime verifiedAt, String note, LocalDateTime uploadedAt, LocalDateTime updatedAt) {
        this.documentId = documentId;
        this.userId = userId;
        this.title = title;
        this.filePath = filePath;
        this.fileSize = fileSize;
        this.docType = docType;
        this.issuedBy = issuedBy;
        this.issuedAt = issuedAt;
        this.expiresAt = expiresAt;
        this.status = status;
        this.verifiedBy = verifiedBy;
        this.verifiedAt = verifiedAt;
        this.note = note;
        this.uploadedAt = uploadedAt;
        this.updatedAt = updatedAt;
    }

    public int getDocumentId() {
        return documentId;
    }

    public void setDocumentId(int documentId) {
        this.documentId = documentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public long getFileSize() {
        return fileSize;
    }

    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }

    public String getDocType() {
        return docType;
    }

    public void setDocType(String docType) {
        this.docType = docType;
    }

    public String getIssuedBy() {
        return issuedBy;
    }

    public void setIssuedBy(String issuedBy) {
        this.issuedBy = issuedBy;
    }

    public LocalDate getIssuedAt() {
        return issuedAt;
    }

    public void setIssuedAt(LocalDate issuedAt) {
        this.issuedAt = issuedAt;
    }

    public LocalDate getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(LocalDate expiresAt) {
        this.expiresAt = expiresAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getVerifiedBy() {
        return verifiedBy;
    }

    public void setVerifiedBy(Integer verifiedBy) {
        this.verifiedBy = verifiedBy;
    }

    public LocalDateTime getVerifiedAt() {
        return verifiedAt;
    }

    public void setVerifiedAt(LocalDateTime verifiedAt) {
        this.verifiedAt = verifiedAt;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public LocalDateTime getUploadedAt() {
        return uploadedAt;
    }

    public void setUploadedAt(LocalDateTime uploadedAt) {
        this.uploadedAt = uploadedAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

   
    @Override
    public String toString() {
        return "CandidateDocument{"
                + "documentId=" + documentId
                + ", userId=" + userId
                + ", title='" + title + '\''
                + ", docType='" + docType + '\''
                + ", issuedBy='" + issuedBy + '\''
                + ", status='" + status + '\''
                + ", uploadedAt=" + uploadedAt
                + '}';
    }
}
