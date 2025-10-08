/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author Hung
 */
public class Offer {

    private int offerId;
    private int applicationId;
    private String positionTitle;
    private BigDecimal offeredSalary;
    private String currency;
    private LocalDate startDate;
    private LocalDateTime expiredAt;
    private LocalDateTime offeredAt;
    private String status;
    private String notes;

    // Default constructor
    public Offer() {
    }

    // Parameterized constructor
    public Offer(int offerId, int applicationId, String positionTitle, BigDecimal offeredSalary, String currency, LocalDate startDate, LocalDateTime expiredAt, LocalDateTime offeredAt, String status, String notes) {
        this.offerId = offerId;
        this.applicationId = applicationId;
        this.positionTitle = positionTitle;
        this.offeredSalary = offeredSalary;
        this.currency = currency;
        this.startDate = startDate;
        this.expiredAt = expiredAt;
        this.offeredAt = offeredAt;
        this.status = status;
        this.notes = notes;
    }

    // Getters and Setters
    public int getOfferId() {
        return offerId;
    }

    public void setOfferId(int offerId) {
        this.offerId = offerId;
    }

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public String getPositionTitle() {
        return positionTitle;
    }

    public void setPositionTitle(String positionTitle) {
        this.positionTitle = positionTitle;
    }

    public BigDecimal getOfferedSalary() {
        return offeredSalary;
    }

    public void setOfferedSalary(BigDecimal offeredSalary) {
        this.offeredSalary = offeredSalary;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDateTime getExpiredAt() {
        return expiredAt;
    }

    public void setExpiredAt(LocalDateTime expiredAt) {
        this.expiredAt = expiredAt;
    }

    public LocalDateTime getOfferedAt() {
        return offeredAt;
    }

    public void setOfferedAt(LocalDateTime offeredAt) {
        this.offeredAt = offeredAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    @Override
    public String toString() {
        return "Offer{"
                + "offerId=" + offerId
                + ", applicationId=" + applicationId
                + ", positionTitle='" + positionTitle + '\''
                + ", status='" + status + '\''
                + '}';
    }
}
