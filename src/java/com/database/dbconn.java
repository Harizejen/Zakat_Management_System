/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author nasru
 */
public class dbconn {
    private static final String URL = "jdbc:mysql://localhost:3306/zakat_management"; // Change to your database URL
    private static final String USER = "root"; // Change to your database username
    private static final String PASSWORD = ""; // Change to your database password

    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connection established successfully.");
        } catch (SQLException e) {
            System.out.println("Connection failed: " + e.getMessage());
        }
        return connection;
    }

    public static void main(String[] args) {
        getConnection(); // Test the connection
    }
}
