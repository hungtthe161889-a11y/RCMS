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
public class Resume {

    private int resumeId;
    private int userId;
    private String title;
    private String summary;
    private String experience;
    private String education;
    private String skillsText;
    private LocalDateTime createdAt;
    private String filePath;

    // Default constructor
    public Resume() {
    }

    // Parameterized constructor
    public Resume(int resumeId, int userId, String title, String summary, String experience, String education, String skillsText, LocalDateTime createdAt, String filePath) {
        this.resumeId = resumeId;
        this.userId = userId;
        this.title = title;
        this.summary = summary;
        this.experience = experience;
        this.education = education;
        this.skillsText = skillsText;
        this.createdAt = createdAt;
        this.filePath = filePath;
    }

    // Getters and Setters
    public int getResumeId() {
        return resumeId;
    }

    public void setResumeId(int resumeId) {
        this.resumeId = resumeId;
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

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getSkillsText() {
        return skillsText;
    }

    public void setSkillsText(String skillsText) {
        this.skillsText = skillsText;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    @Override
    public String toString() {
        return "Resume{"
                + "resumeId=" + resumeId
                + ", userId=" + userId
                + ", title='" + title + '\''
                + '}';
    }
}
