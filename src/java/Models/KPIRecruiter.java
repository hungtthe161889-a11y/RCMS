/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.time.LocalDateTime;
import java.util.Date;

/**
 *
 * @author Hung
 */
public class KPIRecruiter {

    private int kpiId;
    private int recruiterId;
    private Integer managerId;
    private Date periodStart;
    private Date periodEnd;

    // --- Target (Mục tiêu) ---
    private Integer targetJobsPosted;
    private Integer targetApplicationsProcessed;
    private Integer targetInterviewsConducted;
    private Integer targetHires;
    private Double targetOfferAcceptanceRate;
    private Double targetTimeToHire;

    // --- Actual (Thực tế) ---
    private Integer actualJobsPosted;
    private Integer actualApplicationsProcessed;
    private Integer actualInterviewsConducted;
    private Integer actualHires;
    private Double actualOfferAcceptanceRate;
    private Double actualTimeToHire;

    // --- Evaluation ---
    private Double completionRate;
    private String performanceRating;
    private String remarks;
    private LocalDateTime evaluatedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public KPIRecruiter() {
    }

    public KPIRecruiter(int kpiId, int recruiterId, Integer managerId, Date periodStart, Date periodEnd, Integer targetJobsPosted, Integer targetApplicationsProcessed, Integer targetInterviewsConducted, Integer targetHires, Double targetOfferAcceptanceRate, Double targetTimeToHire, Integer actualJobsPosted, Integer actualApplicationsProcessed, Integer actualInterviewsConducted, Integer actualHires, Double actualOfferAcceptanceRate, Double actualTimeToHire, Double completionRate, String performanceRating, String remarks, LocalDateTime evaluatedAt, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.kpiId = kpiId;
        this.recruiterId = recruiterId;
        this.managerId = managerId;
        this.periodStart = periodStart;
        this.periodEnd = periodEnd;
        this.targetJobsPosted = targetJobsPosted;
        this.targetApplicationsProcessed = targetApplicationsProcessed;
        this.targetInterviewsConducted = targetInterviewsConducted;
        this.targetHires = targetHires;
        this.targetOfferAcceptanceRate = targetOfferAcceptanceRate;
        this.targetTimeToHire = targetTimeToHire;
        this.actualJobsPosted = actualJobsPosted;
        this.actualApplicationsProcessed = actualApplicationsProcessed;
        this.actualInterviewsConducted = actualInterviewsConducted;
        this.actualHires = actualHires;
        this.actualOfferAcceptanceRate = actualOfferAcceptanceRate;
        this.actualTimeToHire = actualTimeToHire;
        this.completionRate = completionRate;
        this.performanceRating = performanceRating;
        this.remarks = remarks;
        this.evaluatedAt = evaluatedAt;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getKpiId() {
        return kpiId;
    }

    public void setKpiId(int kpiId) {
        this.kpiId = kpiId;
    }

    public int getRecruiterId() {
        return recruiterId;
    }

    public void setRecruiterId(int recruiterId) {
        this.recruiterId = recruiterId;
    }

    public Integer getManagerId() {
        return managerId;
    }

    public void setManagerId(Integer managerId) {
        this.managerId = managerId;
    }

    public Date getPeriodStart() {
        return periodStart;
    }

    public void setPeriodStart(Date periodStart) {
        this.periodStart = periodStart;
    }

    public Date getPeriodEnd() {
        return periodEnd;
    }

    public void setPeriodEnd(Date periodEnd) {
        this.periodEnd = periodEnd;
    }

    public Integer getTargetJobsPosted() {
        return targetJobsPosted;
    }

    public void setTargetJobsPosted(Integer targetJobsPosted) {
        this.targetJobsPosted = targetJobsPosted;
    }

    public Integer getTargetApplicationsProcessed() {
        return targetApplicationsProcessed;
    }

    public void setTargetApplicationsProcessed(Integer targetApplicationsProcessed) {
        this.targetApplicationsProcessed = targetApplicationsProcessed;
    }

    public Integer getTargetInterviewsConducted() {
        return targetInterviewsConducted;
    }

    public void setTargetInterviewsConducted(Integer targetInterviewsConducted) {
        this.targetInterviewsConducted = targetInterviewsConducted;
    }

    public Integer getTargetHires() {
        return targetHires;
    }

    public void setTargetHires(Integer targetHires) {
        this.targetHires = targetHires;
    }

    public Double getTargetOfferAcceptanceRate() {
        return targetOfferAcceptanceRate;
    }

    public void setTargetOfferAcceptanceRate(Double targetOfferAcceptanceRate) {
        this.targetOfferAcceptanceRate = targetOfferAcceptanceRate;
    }

    public Double getTargetTimeToHire() {
        return targetTimeToHire;
    }

    public void setTargetTimeToHire(Double targetTimeToHire) {
        this.targetTimeToHire = targetTimeToHire;
    }

    public Integer getActualJobsPosted() {
        return actualJobsPosted;
    }

    public void setActualJobsPosted(Integer actualJobsPosted) {
        this.actualJobsPosted = actualJobsPosted;
    }

    public Integer getActualApplicationsProcessed() {
        return actualApplicationsProcessed;
    }

    public void setActualApplicationsProcessed(Integer actualApplicationsProcessed) {
        this.actualApplicationsProcessed = actualApplicationsProcessed;
    }

    public Integer getActualInterviewsConducted() {
        return actualInterviewsConducted;
    }

    public void setActualInterviewsConducted(Integer actualInterviewsConducted) {
        this.actualInterviewsConducted = actualInterviewsConducted;
    }

    public Integer getActualHires() {
        return actualHires;
    }

    public void setActualHires(Integer actualHires) {
        this.actualHires = actualHires;
    }

    public Double getActualOfferAcceptanceRate() {
        return actualOfferAcceptanceRate;
    }

    public void setActualOfferAcceptanceRate(Double actualOfferAcceptanceRate) {
        this.actualOfferAcceptanceRate = actualOfferAcceptanceRate;
    }

    public Double getActualTimeToHire() {
        return actualTimeToHire;
    }

    public void setActualTimeToHire(Double actualTimeToHire) {
        this.actualTimeToHire = actualTimeToHire;
    }

    public Double getCompletionRate() {
        return completionRate;
    }

    public void setCompletionRate(Double completionRate) {
        this.completionRate = completionRate;
    }

    public String getPerformanceRating() {
        return performanceRating;
    }

    public void setPerformanceRating(String performanceRating) {
        this.performanceRating = performanceRating;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public LocalDateTime getEvaluatedAt() {
        return evaluatedAt;
    }

    public void setEvaluatedAt(LocalDateTime evaluatedAt) {
        this.evaluatedAt = evaluatedAt;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

}
