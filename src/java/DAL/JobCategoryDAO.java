/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

/**
 *
 * @author Admin
 */


import Data.RCMSDbContext;
import Models.JobCategory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class JobCategoryDAO {
    private final RCMSDbContext dbContext;
    private final Logger logger = Logger.getLogger(JobCategoryDAO.class.getName());

    public JobCategoryDAO() {
        this.dbContext = new RCMSDbContext();
    }

    public List<JobCategory> getAllCategories() {
        List<JobCategory> categories = new ArrayList<>();
        String sql = "SELECT * FROM job_category ORDER BY category_name";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                JobCategory category = new JobCategory();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                categories.add(category);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting all categories", e);
        }
        return categories;
    }
}
