package Servlet;

import java.io.*;
import java.sql.*;
import java.util.Base64;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(60 * 60);

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not authenticated");
            return;
        }

        String messageText = request.getParameter("message");
        Part filePart = request.getPart("file");

        // Check if messageText is not empty
        if (messageText == null || messageText.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Message text cannot be empty");
            return;
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_finder", "root", "Toli314@")) {
            // Get admin ID
            int adminId = getAdminId(conn);

            // Insert message into the database
            String sql = "INSERT INTO messages (sender_id, receiver_id, message_text, file_data) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                stmt.setInt(2, adminId);
                stmt.setString(3, messageText); // Store message text

                // Handle file upload
                if (filePart != null && filePart.getSize() > 0) {
                    stmt.setBlob(4, filePart.getInputStream());
                } else {
                    stmt.setNull(4, Types.BLOB); // No file uploaded
                }

                // Execute the update
                stmt.executeUpdate();
                response.setStatus(HttpServletResponse.SC_OK);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Database error\"}");
        }
    }

    private int getAdminId(Connection conn) throws SQLException {
        String adminQuery = "SELECT id FROM admins LIMIT 1";
        try (PreparedStatement adminStmt = conn.prepareStatement(adminQuery);
             ResultSet adminRs = adminStmt.executeQuery()) {
            if (adminRs.next()) {
                return adminRs.getInt("id");
            } else {
                throw new SQLException("Admin not found in the database");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(60 * 60);

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"User not authenticated\"}");
            return;
        }

        response.setContentType("application/json");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_finder", "root", "Toli314@")) {
            String sql = "SELECT * FROM messages WHERE sender_id = ? OR receiver_id = ? ORDER BY timestamp ASC";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                stmt.setInt(2, userId);

                try (ResultSet rs = stmt.executeQuery()) {
                    StringBuilder json = new StringBuilder("[");
                    boolean first = true;

                    while (rs.next()) {
                        if (!first) json.append(",");
                        first = false;

                        json.append("{")
                            .append("\"id\":").append(rs.getInt("id")).append(",")
                            .append("\"sender_id\":").append(rs.getInt("sender_id")).append(",")
                            .append("\"receiver_id\":").append(rs.getInt("receiver_id")).append(",")
                            .append("\"message_text\":\"").append(rs.getString("message_text") != null
                                ? rs.getString("message_text").replace("\"", "\\\"") : "").append("\",")
                            .append("\"file_data\":\"").append(rs.getBytes("file_data") != null
                                ? Base64.getEncoder().encodeToString(rs.getBytes("file_data")) : "").append("\",")
                            .append("\"timestamp\":\"").append(rs.getTimestamp("timestamp")).append("\"")
                            .append("}");
                    }

                    json.append("]");
                    response.getWriter().write(json.toString());
                }
            }
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Database error\"}");
        }
    }
}