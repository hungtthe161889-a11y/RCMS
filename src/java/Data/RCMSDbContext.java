/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author Hung
 * @version 0.1.0
 */
public class RCMSDbContext {

    ResourceBundle bundle = ResourceBundle.getBundle("Config.Database");

    private final Logger logger = Logger.getLogger(this.getClass().getName());

    private void log(Level level, String msg, Throwable e) {
        this.logger.log(level, msg, e);
    }

    public Connection getConnection() {
        try {
            Class.forName(bundle.getString("drivername"));
            String url = bundle.getString("url");
            String username = bundle.getString("username");
            String password = bundle.getString("password");
            Connection connection = DriverManager.getConnection(url, username, password);
            return connection;
        } catch (ClassNotFoundException e) {
            String msg = "ClassNotFoundException throw from method getConnection()";
            this.log(Level.SEVERE, msg, e);
        } catch (SQLException e) {
            String msg = "SQLException throw from method getConnection()";
            this.log(Level.SEVERE, msg, e);
        } catch (Exception e) {
            String msg = "Unexpected Exception throw from method getConnection()";
            this.log(Level.SEVERE, msg, e);
        }
        return null;
    }

    public static void main(String[] args) {
        RCMSDbContext db = new RCMSDbContext();
        if(db.getConnection() != null){
            System.out.println("Success");
        }
    }
}
