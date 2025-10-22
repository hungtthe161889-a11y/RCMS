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
import Models.Location;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LocationDAO {
    private final RCMSDbContext dbContext;
    private final Logger logger = Logger.getLogger(LocationDAO.class.getName());

    public LocationDAO() {
        this.dbContext = new RCMSDbContext();
    }

    public List<Location> getAllLocations() {
        List<Location> locations = new ArrayList<>();
        String sql = "SELECT * FROM location ORDER BY province, ward";
        
        try (Connection conn = dbContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Location location = new Location();
                location.setLocationId(rs.getInt("location_id"));
                location.setProvince(rs.getString("province"));
                location.setWard(rs.getString("ward"));
                location.setDetail(rs.getString("detail"));
                locations.add(location);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error getting all locations", e);
        }
        return locations;
    }
}
