package Servlet;

import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

@WebServlet("/FetchTicketsServlet")
public class FetchTicketsServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/event_finder";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Toli314@";
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        List<JSONObject> tickets = new ArrayList<>();
        
        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT ticket_number, fullname FROM tickets";
                try (PreparedStatement stmt = conn.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    
                    while (rs.next()) {
                        JSONObject ticket = new JSONObject();
                        ticket.put("ticketNumber", rs.getString("ticket_number"));
                        ticket.put("fullname", rs.getString("fullname"));
                        tickets.add(ticket);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException | JSONException e) {
            e.printStackTrace();
        }

        // Convert the list to JSON and write to response
        JSONArray jsonArray = new JSONArray(tickets);
        response.getWriter().write(jsonArray.toString());
    }
}