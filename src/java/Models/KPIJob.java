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
public class KPIJob {

    private int kpiId;
    private int jobId;
    private Integer analyzedBy;
    private Date periodStart;
    private Date periodEnd;

    // --- Metrics ---
    private Integer totalApplications;
    private Integer interviewedCount;
    private Integer offerSentCount;
    private Integer offerAcceptedCount;
    private Integer hiredCount;

    // --- Performance ---
    private Double avgDaysToFill;
    private Double interviewPassRate;
    private Double offerAcceptanceRate;
    private Double hireConversionRate;

    private String status;
    private String remarks;
    private LocalDateTime evaluatedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public KPIJob() {
    }

    public KPIJob(int kpiId, int jobId, Integer analyzedBy, Date periodStart, Date periodEnd, Integer totalApplications, Integer interviewedCount, Integer offerSentCount, Integer offerAcceptedCount, Integer hiredCount, Double avgDaysToFill, Double interviewPassRate, Double offerAcceptanceRate, Double hireConversionRate, String status, String remarks, LocalDateTime evaluatedAt, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.kpiId = kpiId;
        this.jobId = jobId;
        this.analyzedBy = analyzedBy;
        this.periodStart = periodStart;
        this.periodEnd = periodEnd;
        this.totalApplications = totalApplications;
        this.interviewedCount = interviewedCount;
        this.offerSentCount = offerSentCount;
        this.offerAcceptedCount = offerAcceptedCount;
        this.hiredCount = hiredCount;
        this.avgDaysToFill = avgDaysToFill;
        this.interviewPassRate = interviewPassRate;
        this.offerAcceptanceRate = offerAcceptanceRate;
        this.hireConversionRate = hireConversionRate;
        this.status = status;
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

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public Integer getAnalyzedBy() {
        return analyzedBy;
    }

    public void setAnalyzedBy(Integer analyzedBy) {
        this.analyzedBy = analyzedBy;
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

    public Integer getTotalApplications() {
        return totalApplications;
    }

    public void setTotalApplications(Integer totalApplications) {
        this.totalApplications = totalApplications;
    }

    public Integer getInterviewedCount() {
        return interviewedCount;
    }

    public void setInterviewedCount(Integer interviewedCount) {
        this.interviewedCount = interviewedCount;
    }

    public Integer getOfferSentCount() {
        return offerSentCount;
    }

    public void setOfferSentCount(Integer offerSentCount) {
        this.offerSentCount = offerSentCount;
    }

    public Integer getOfferAcceptedCount() {
        return offerAcceptedCount;
    }

    public void setOfferAcceptedCount(Integer offerAcceptedCount) {
        this.offerAcceptedCount = offerAcceptedCount;
    }

    public Integer getHiredCount() {
        return hiredCount;
    }

    public void setHiredCount(Integer hiredCount) {
        this.hiredCount = hiredCount;
    }

    public Double getAvgDaysToFill() {
        return avgDaysToFill;
    }

    public void setAvgDaysToFill(Double avgDaysToFill) {
        this.avgDaysToFill = avgDaysToFill;
    }

    public Double getInterviewPassRate() {
        return interviewPassRate;
    }

    public void setInterviewPassRate(Double interviewPassRate) {
        this.interviewPassRate = interviewPassRate;
    }

    public Double getOfferAcceptanceRate() {
        return offerAcceptanceRate;
    }

    public void setOfferAcceptanceRate(Double offerAcceptanceRate) {
        this.offerAcceptanceRate = offerAcceptanceRate;
    }

    public Double getHireConversionRate() {
        return hireConversionRate;
    }

    public void setHireConversionRate(Double hireConversionRate) {
        this.hireConversionRate = hireConversionRate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
