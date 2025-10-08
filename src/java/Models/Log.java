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
public class Log {

    private int logId;
    private LocalDateTime logTime;
    private String logType;
    private String logFrom;
    private String requestBy;
    private String logContent;

    // Default constructor
    public Log() {
    }

    // Parameterized constructor
    public Log(int logId, LocalDateTime logTime, String logType, String logFrom, String requestBy, String logContent) {
        this.logId = logId;
        this.logTime = logTime;
        this.logType = logType;
        this.logFrom = logFrom;
        this.requestBy = requestBy;
        this.logContent = logContent;
    }

    // Getters and Setters
    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public LocalDateTime getLogTime() {
        return logTime;
    }

    public void setLogTime(LocalDateTime logTime) {
        this.logTime = logTime;
    }

    public String getLogType() {
        return logType;
    }

    public void setLogType(String logType) {
        this.logType = logType;
    }

    public String getLogFrom() {
        return logFrom;
    }

    public void setLogFrom(String logFrom) {
        this.logFrom = logFrom;
    }

    public String getRequestBy() {
        return requestBy;
    }

    public void setRequestBy(String requestBy) {
        this.requestBy = requestBy;
    }

    public String getLogContent() {
        return logContent;
    }

    public void setLogContent(String logContent) {
        this.logContent = logContent;
    }

    @Override
    public String toString() {
        return "Log{"
                + "logId=" + logId
                + ", logTime=" + logTime
                + ", logType='" + logType + '\''
                + ", requestBy='" + requestBy + '\''
                + '}';
    }
}
