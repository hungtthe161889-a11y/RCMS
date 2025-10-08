/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Hung
 */
public class CandidateSkill {

    private int userId;
    private int skillId;
    private String level;

    // Default constructor
    public CandidateSkill() {
    }

    // Parameterized constructor
    public CandidateSkill(int userId, int skillId, String level) {
        this.userId = userId;
        this.skillId = skillId;
        this.level = level;
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getSkillId() {
        return skillId;
    }

    public void setSkillId(int skillId) {
        this.skillId = skillId;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    @Override
    public String toString() {
        return "CandidateSkill{"
                + "userId=" + userId
                + ", skillId=" + skillId
                + ", level='" + level + '\''
                + '}';
    }
}
