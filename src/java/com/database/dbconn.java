package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author nasru
 */
public class dbconn {
     // Database URL, username, and password
    private static final String URL = "jdbc:mysql://localhost:3306/zakat_management"; // Modify the URL according to your setup
    private static final String USER = "root";
    private static final String PASSWORD = "system";
    private static Connection connection = null;

    // Method to establish connection
    public static Connection getConnection() {
        try {
            // Load MySQL JDBC driver (optional with newer versions of Java)
            Class.forName("com.mysql.jdbc.Driver");
            // Establish connection
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Connection failed: " + e.getMessage());
            return null; // Return null if connection fails
        }
    }

    // Method to close connection
    public static void closeConnection() {
        try {
            if (connection != null) {
                connection.close();
                System.out.println("MySQL Database connection closed.");
            }
        } catch (SQLException e) {
            System.out.println("Failed to close connection: " + e.getMessage());
        }
    }
     
}