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
    private static final String URL = "jdbc:mysql://localhost:3306/zakat_management?zeroDateTimeBehavior=CONVERT_TO_NULL"; // Modify the URL according to your setup
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static Connection connection = null;

    // Method to establish connection
    public static Connection getConnection() {
        try {
            if (connection == null) {
                // Load MySQL JDBC driver (optional with newer versions of Java)
                Class.forName("com.mysql.cj.jdbc.Driver");
                // Establish connection
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("MySQL Database connected!");
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Connection failed: " + e.getMessage());
        }
        return connection;
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

    // Example usage
    public static void main(String[] args) {
        // Connect to MySQL DB
        getConnection();
        // Perform database operations here...

        // Close the connection after operations
        closeConnection();
    }
}