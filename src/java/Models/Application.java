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
public class Application {

    private int applicationId;
    private int jobId;
    private int userId;
    private int resumeId;
    private String status;
    private LocalDateTime appliedAt;
    private String jobTitle;

    // Default constructor
    public Application() {
    }

    // Parameterized constructor
    public Application(int applicationId, int jobId, int userId, int resumeId, String status, LocalDateTime appliedAt,String jobTitle) {
        this.applicationId = applicationId;
        this.jobId = jobId;
        this.userId = userId;
        this.resumeId = resumeId;
        this.status = status;
        this.appliedAt = appliedAt;
        this.jobTitle = jobTitle;
    }

    // Getters and Setters

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }
    
    
    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getResumeId() {
        return resumeId;
    }

    public void setResumeId(int resumeId) {
        this.resumeId = resumeId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getAppliedAt() {
        return appliedAt;
    }

    public void setAppliedAt(LocalDateTime appliedAt) {
        this.appliedAt = appliedAt;
    }

    @Override
    public String toString() {
        return "Application{"
                + "applicationId=" + applicationId
                + ", jobId=" + jobId
                + ", userId=" + userId
                + ", status='" + status + '\''
                + '}';
    }

    public String getAppliedAtFormatted() {
        if (appliedAt == null) {
            return "";
        }
        return appliedAt.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }

}
