package Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/AChatServlet")
public class AChatServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/event_finder"; // Change as needed
    private static final String DB_USER = "root"; // Change as needed
    private static final String DB_PASS = "Toli314@"; // Change as needed

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    String senderId = (String) session.getAttribute("userId");
    
    if (senderId == null) {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.println("{\"status\":\"failure\", \"message\":\"User not logged in.\"}");
        return;
    }

    String message = request.getParameter("content");
    int receiverId = Integer.parseInt(request.getParameter("receiverId")); // Get receiver ID from request

    if (message == null || message.trim().isEmpty()) {
        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.println("{\"status\":\"failure\", \"message\":\"Message content cannot be empty.\"}");
        return;
    }

    byte[] fileData = null;

    // Handle file upload
    try {
        Part filePart = request.getPart("file");
        if (filePart != null && filePart.getSize() > 0) {
            fileData = filePart.getInputStream().readAllBytes();
        }
    } catch (ServletException | IOException e) {
        Logger.getLogger(AChatServlet.class.getName()).log(Level.SEVERE, "File upload error", e);
    }

    // Store message in the database
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String sql = "INSERT INTO messages (sender_id, receiver_id, message_text, file_data) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(senderId));
            pstmt.setInt(2, receiverId);
            pstmt.setString(3, message);
            pstmt.setBytes(4, fileData);
            
            int rowsAffected = pstmt.executeUpdate();
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();

            if (rowsAffected > 0) {
                out.println("{\"status\":\"success\", \"message\":\"Message sent!\"}");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.println("{\"status\":\"failure\", \"message\":\"Failed to store message in database.\"}");
            }
        } catch (SQLException e) {
            Logger.getLogger(AChatServlet.class.getName()).log(Level.SEVERE, "Database insertion error", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            PrintWriter out = response.getWriter();
            out.println("{\"status\":\"failure\", \"message\":\"Database error occurred.\"}");
        }
    } catch (ClassNotFoundException ex) {
        Logger.getLogger(AChatServlet.class.getName()).log(Level.SEVERE, "Database driver not found", ex);
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database driver error.");
    }
}
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("fetchUsers".equals(action)) {
            fetchUsers(response);
        } else {
            fetchMessages(request, response);
        }
    }

    private void fetchUsers(HttpServletResponse response) throws IOException {
        List<String> users = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sql = "SELECT id, fullname FROM users"; // Query for fetching user data
                try (PreparedStatement pstmt = conn.prepareStatement(sql);
                     ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String fullname = rs.getString("fullname");
                        // Construct JSON object for each user
                        users.add("{\"id\":" + id + ", \"fullname\":\"" + fullname + "\"}");
                    }
                }
            } catch (SQLException e) {
                Logger.getLogger(AChatServlet.class.getName()).log(Level.SEVERE, "Database retrieval error", e);
            }

            // Set response type to JSON and output user data
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.println("[ " + String.join(", ", users) + " ]");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AChatServlet.class.getName()).log(Level.SEVERE, "Database driver not found", ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database driver error.");
        }
    }

    private void fetchMessages(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.println("{\"status\":\"failure\", \"message\":\"User not logged in.\"}");
            return;
        }

        List<String> messages = new ArrayList<>();

        // Fetch messages from database for this user
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sqlMessages = "SELECT sender_id, message_text, file_data, timestamp FROM messages WHERE receiver_id = ? OR sender_id = ? ORDER BY timestamp";
                
                PreparedStatement pstmtMessages = conn.prepareStatement(sqlMessages);
                pstmtMessages.setInt(1, Integer.parseInt(userId)); // Fetch messages for this user
                pstmtMessages.setInt(2, Integer.parseInt(userId)); // Fetch messages sent by this user
                ResultSet rsMessages = pstmtMessages.executeQuery();

                while (rsMessages.next()) {
                    String sender = rsMessages.getString("sender_id");
                    String msg = rsMessages.getString("message_text");
                    byte[] file = rsMessages.getBytes("file_data");
                    String timeStamp = rsMessages.getString("timestamp");

                    StringBuilder messageDisplay = new StringBuilder(sender + ": " + msg);
                    if (file != null) {
                        String base64File = Base64.getEncoder().encodeToString(file);
                        messageDisplay.append(" [File: <a href='data:application/octet-stream;base64,")
                                      .append(base64File).append("' download='file'>Download</a>]");
                    }
                    messageDisplay.append(" <span class='message-time'>").append(timeStamp).append("</span>");
                    messages.add(messageDisplay.toString());
                }
            } catch (SQLException e) {
                Logger.getLogger(AChatServlet.class.getName()).log(Level.SEVERE, "Database retrieval error", e);
            }

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.println("{\"messages\":" + messages + "}");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AChatServlet.class.getName()).log(Level.SEVERE, "Database driver not found", ex);
        }
    }
}
