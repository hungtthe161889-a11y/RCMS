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
public class Contract {

    private int contractId;
    private int userId;
    private BigDecimal salary;
    private LocalDate startDate;
    private LocalDate endDate;
    private String contractType;
    private String filePath;
    private LocalDateTime createdAt;

    // Default constructor
    public Contract() {
    }

    // Parameterized constructor
    public Contract(int contractId, int userId, BigDecimal salary, LocalDate startDate, LocalDate endDate, String contractType, String filePath, LocalDateTime createdAt) {
        this.contractId = contractId;
        this.userId = userId;
        this.salary = salary;
        this.startDate = startDate;
        this.endDate = endDate;
        this.contractType = contractType;
        this.filePath = filePath;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getContractId() {
        return contractId;
    }

    public void setContractId(int contractId) {
        this.contractId = contractId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public BigDecimal getSalary() {
        return salary;
    }

    public void setSalary(BigDecimal salary) {
        this.salary = salary;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public String getContractType() {
        return contractType;
    }

    public void setContractType(String contractType) {
        this.contractType = contractType;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Contract{"
                + "contractId=" + contractId
                + ", userId=" + userId
                + ", salary=" + salary
                + ", contractType='" + contractType + '\''
                + '}';
    }
}
