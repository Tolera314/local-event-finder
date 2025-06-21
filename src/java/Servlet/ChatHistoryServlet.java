package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
@WebServlet("/ChatHistoryServlet")
public class ChatHistoryServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/event_finder";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Toli314@";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.write("{\"error\":\"Unauthorized access\"}");
            return;
        }

        int senderId = (int) session.getAttribute("userId");
        int receiverId = Integer.parseInt(request.getParameter("receiverId"));
try{
    Class.forName("com.mysql.cj.jdbc.Driver");

        try 
            (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)){
            // Fetch messages between the two users
            String query = "SELECT * FROM messages WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) ORDER BY timestamp";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, senderId);
            stmt.setInt(2, receiverId);
            stmt.setInt(3, receiverId);
            stmt.setInt(4, senderId);
            ResultSet rs = stmt.executeQuery();

            StringBuilder jsonResponse = new StringBuilder("[");
            while (rs.next()) {
                if (jsonResponse.length() > 1) jsonResponse.append(",");
                jsonResponse.append("{\"senderId\":").append(rs.getInt("sender_id"))
                           .append(",\"message\":\"").append(rs.getString("message"))
                           .append("\",\"timestamp\":\"").append(rs.getTimestamp("timestamp")).append("\"}");
            }
            jsonResponse.append("]");
            out.write(jsonResponse.toString());

        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"error\":\"Database error\"}");
        }
    }   catch (ClassNotFoundException ex) {
            Logger.getLogger(ChatHistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
}}
