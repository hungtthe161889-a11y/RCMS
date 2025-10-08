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
public class InterviewFeedback {

    private int feedbackId;
    private int interviewId;
    private int reviewerId;
    private BigDecimal rating;
    private String comment;
    private LocalDateTime createdAt;

    // Default constructor
    public InterviewFeedback() {
    }

    // Parameterized constructor
    public InterviewFeedback(int feedbackId, int interviewId, int reviewerId, BigDecimal rating, String comment, LocalDateTime createdAt) {
        this.feedbackId = feedbackId;
        this.interviewId = interviewId;
        this.reviewerId = reviewerId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getInterviewId() {
        return interviewId;
    }

    public void setInterviewId(int interviewId) {
        this.interviewId = interviewId;
    }

    public int getReviewerId() {
        return reviewerId;
    }

    public void setReviewerId(int reviewerId) {
        this.reviewerId = reviewerId;
    }

    public BigDecimal getRating() {
        return rating;
    }

    public void setRating(BigDecimal rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "InterviewFeedback{"
                + "feedbackId=" + feedbackId
                + ", interviewId=" + interviewId
                + ", reviewerId=" + reviewerId
                + ", rating=" + rating
                + '}';
    }
}
