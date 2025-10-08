/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 *
 * @author Hung
 */
public class JobPosting {

    private int jobId;
    private int categoryId;
    private int locationId;
    private String title;
    private String experience;
    private String level;
    private String education;
    private String quantity;
    private String workType;
    private String description;
    private String requirement;
    private String income;
    private String interest;
    private BigDecimal minSalary;
    private BigDecimal maxSalary;
    private String status;
    private LocalDateTime postedAt;
    private LocalDateTime expiredAt;

    // Default constructor
    public JobPosting() {
    }

    // Parameterized constructor
    public JobPosting(int jobId, int categoryId, int locationId, String title, String experience, String level, String education, String quantity, String workType, String description, String requirement, String income, String interest, BigDecimal minSalary, BigDecimal maxSalary, String status, LocalDateTime postedAt, LocalDateTime expiredAt) {
        this.jobId = jobId;
        this.categoryId = categoryId;
        this.locationId = locationId;
        this.title = title;
        this.experience = experience;
        this.level = level;
        this.education = education;
        this.quantity = quantity;
        this.workType = workType;
        this.description = description;
        this.requirement = requirement;
        this.income = income;
        this.interest = interest;
        this.minSalary = minSalary;
        this.maxSalary = maxSalary;
        this.status = status;
        this.postedAt = postedAt;
        this.expiredAt = expiredAt;
    }

    // Getters and Setters
    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getExperience() {
        return experience;
    }

    public void setExperience(String experience) {
        this.experience = experience;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
    }

    public String getQuantity() {
        return quantity;
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getWorkType() {
        return workType;
    }

    public void setWorkType(String workType) {
        this.workType = workType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getRequirement() {
        return requirement;
    }

    public void setRequirement(String requirement) {
        this.requirement = requirement;
    }

    public String getIncome() {
        return income;
    }

    public void setIncome(String income) {
        this.income = income;
    }

    public String getInterest() {
        return interest;
    }

    public void setInterest(String interest) {
        this.interest = interest;
    }

    public BigDecimal getMinSalary() {
        return minSalary;
    }

    public void setMinSalary(BigDecimal minSalary) {
        this.minSalary = minSalary;
    }

    public BigDecimal getMaxSalary() {
        return maxSalary;
    }

    public void setMaxSalary(BigDecimal maxSalary) {
        this.maxSalary = maxSalary;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getPostedAt() {
        return postedAt;
    }

    public void setPostedAt(LocalDateTime postedAt) {
        this.postedAt = postedAt;
    }

    public LocalDateTime getExpiredAt() {
        return expiredAt;
    }

    public void setExpiredAt(LocalDateTime expiredAt) {
        this.expiredAt = expiredAt;
    }

    @Override
    public String toString() {
        return "JobPosting{"
                + "jobId=" + jobId
                + ", title='" + title + '\''
                + ", status='" + status + '\''
                + '}';
    }
}
