/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.time.LocalDateTime;

/**
 *
 * @author Hung
 */
public class CandidateDocument {

    private int documentId;
    private int userId;
    private String title;
    private String filePath;
    private String docType;
    private LocalDateTime uploadedAt;

    // Default constructor
    public CandidateDocument() {
    }

    // Parameterized constructor
    public CandidateDocument(int documentId, int userId, String title, String filePath, String docType, LocalDateTime uploadedAt) {
        this.documentId = documentId;
        this.userId = userId;
        this.title = title;
        this.filePath = filePath;
        this.docType = docType;
        this.uploadedAt = uploadedAt;
    }

    // Getters and Setters
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

    public String getDocType() {
        return docType;
    }

    public void setDocType(String docType) {
        this.docType = docType;
    }

    public LocalDateTime getUploadedAt() {
        return uploadedAt;
    }

    public void setUploadedAt(LocalDateTime uploadedAt) {
        this.uploadedAt = uploadedAt;
    }

    @Override
    public String toString() {
        return "CandidateDocument{"
                + "documentId=" + documentId
                + ", userId=" + userId
                + ", title='" + title + '\''
                + '}';
    }
}
