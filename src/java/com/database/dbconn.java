package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author nasru
 */
public class dbconn {
     // Database URL, username, and password
    private static final String URL = "jdbc:mysql://localhost:3306/zakat_management"; //original
//    private static final String URL = "jdbc:mysql://localhost:3306/zktManage2";
    private static final String USER = "root";
    private static final String PASSWORD = "";
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
    
    // Method to get count of staff by category
    public static int getStaffCountByCategory(String category) {
        int count = 0;
        String query = "SELECT COUNT(*) FROM staff WHERE staff_role = '?'"; // Adjust the table and column names as necessary

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
             
            pstmt.setString(1, category);
            ResultSet rs = pstmt.executeQuery();
            
            count = rs.getInt(1); // Get the count from the result set
            
        } catch (SQLException e) {
            System.out.println("Error retrieving staff count: " + e.getMessage());
        }

        return count;
    }
}