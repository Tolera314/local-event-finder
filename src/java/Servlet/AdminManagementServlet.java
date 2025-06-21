
// Updated Servlet Code
package Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/AdminManagementServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 100) // 100MB
public class AdminManagementServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/event_finder";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Toli314@";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        response.setContentType("text/html;charset=UTF-8");

        try {
            switch (action) {
                case "addAdmin" -> addAdmin(request, response);
                case "deleteAdmin" -> deleteAdmin(request, response);
                default -> response.getWriter().println("<h3>Invalid action</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error occurred: " + e.getMessage() + "</h3>");
        }
    }

    private void addAdmin(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String fullName = request.getParameter("fullName");
        int age = Integer.parseInt(request.getParameter("age"));
        String address = request.getParameter("address");
        String identityNumber = request.getParameter("identityNumber");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        String houseNumber = request.getParameter("houseNumber");

        Part profileImagePart = request.getPart("profileImage");
        InputStream profileImageStream = profileImagePart.getInputStream();
        
  try {
    // Load the MySQL driver
    Class.forName("com.mysql.cj.jdbc.Driver");
    
    // Establish a connection to the database
    try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
        // SQL query to insert admin data
        String sql = "INSERT INTO admins (fullname, age, address, identity_number, email, password, phone_number, house_number, profile_image) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Set query parameters
            stmt.setString(1, fullName);
            stmt.setInt(2, age);
            stmt.setString(3, address);
            stmt.setString(4, identityNumber);
            stmt.setString(5, email);
            stmt.setString(6, password);
            stmt.setString(7, phoneNumber);
            stmt.setString(8, houseNumber);
            stmt.setBlob(9, profileImageStream);
            
            // Execute the query
            int rowsInserted = stmt.executeUpdate();
            
     if (rowsInserted > 0) {
                request.setAttribute("message", "Admin added successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Failed to add admin. Please try again.");
                request.setAttribute("messageType", "error");
            }
        }
    }
} catch (ClassNotFoundException e) {
    response.getWriter().write("Database driver not found: " + e.getMessage());
} catch (SQLException e) {
    response.getWriter().write("Error while storing admin data: " + e.getMessage());
}}
    private void deleteAdmin(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String email = request.getParameter("email");
  try {
    // Load the MySQL driver
    Class.forName("com.mysql.cj.jdbc.Driver");
       try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
        String sql = "DELETE FROM admins WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                request.setAttribute("message", "Admin deleted successfully!");
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "No admin found with the given email.");
                request.setAttribute("messageType", "error");
            }
         }
     }
  }
  catch (ClassNotFoundException | SQLException e) {
        request.setAttribute("message", "Error while deleting admin: " + e.getMessage());
        request.setAttribute("messageType", "error");
    }
  request.getRequestDispatcher("adminmanagement.jsp").forward(request, response);
}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().println("<h3>Use POST method to perform actions</h3>");
    }
}