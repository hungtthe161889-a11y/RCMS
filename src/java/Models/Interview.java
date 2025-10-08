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
public class Interview {

    private int interviewId;
    private int applicationId;
    private LocalDateTime scheduledAt;
    private int locationId;
    private String interviewerFullname;
    private String notes;

    // Default constructor
    public Interview() {
    }

    // Parameterized constructor
    public Interview(int interviewId, int applicationId, LocalDateTime scheduledAt, int locationId, String interviewerFullname, String notes) {
        this.interviewId = interviewId;
        this.applicationId = applicationId;
        this.scheduledAt = scheduledAt;
        this.locationId = locationId;
        this.interviewerFullname = interviewerFullname;
        this.notes = notes;
    }

    // Getters and Setters
    public int getInterviewId() {
        return interviewId;
    }

    public void setInterviewId(int interviewId) {
        this.interviewId = interviewId;
    }

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public LocalDateTime getScheduledAt() {
        return scheduledAt;
    }

    public void setScheduledAt(LocalDateTime scheduledAt) {
        this.scheduledAt = scheduledAt;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getInterviewerFullname() {
        return interviewerFullname;
    }

    public void setInterviewerFullname(String interviewerFullname) {
        this.interviewerFullname = interviewerFullname;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    @Override
    public String toString() {
        return "Interview{"
                + "interviewId=" + interviewId
                + ", applicationId=" + applicationId
                + ", scheduledAt=" + scheduledAt
                + ", interviewerFullname='" + interviewerFullname + '\''
                + '}';
    }
}
