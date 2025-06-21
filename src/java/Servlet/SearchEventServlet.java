package Servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SearchEventServlet")
public class SearchEventServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String eventName = request.getParameter("searchInput");

        String dbURL = "jdbc:mysql://localhost:3306/event_finder";
        String dbUser = "root";
        String dbPass = "Toli314@";

        Event event = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM events WHERE name LIKE ?")) {
                 
                stmt.setString(1, "%" + eventName + "%");
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        event = new Event(rs.getInt("id"), rs.getString("name"), rs.getBlob("image"),
                                rs.getDouble("regular_price"), rs.getDouble("vip_price"),
                                rs.getString("location"), rs.getTimestamp("event_date"));
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(); // Log the exception
        }

        request.setAttribute("event", event);
        request.getRequestDispatcher("editevent.jsp").forward(request, response);
    }
}