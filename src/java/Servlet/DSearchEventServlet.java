package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DSearchEventServlet")
public class DSearchEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventName = request.getParameter("searchInput");
        String dbURL = "jdbc:mysql://localhost:3306/event_finder";
        String dbUser = "root";
        String dbPass = "Toli314@";
        EventD event = null;

        try {
            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM events WHERE name LIKE ?")) {

                stmt.setString(1, "%" + eventName + "%");

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        event = new EventD();
                        event.setName(rs.getString("name"));
                        event.setRegularPrice(rs.getDouble("regular_price"));
                        event.setVipPrice(rs.getDouble("vip_price"));
                        event.setLocation(rs.getString("location"));
                        event.setDatetime(rs.getString("event_date"));

                        // Handle image column (LONGBLOB)
                        byte[] imageBytes = rs.getBytes("image");
                        if (imageBytes != null) {
                            String base64Image = java.util.Base64.getEncoder().encodeToString(imageBytes);
                            event.setImage(base64Image); // Store Base64 string for display
                        } else {
                            event.setImage(null);
                        }

                        request.setAttribute("event", event);
                    } else {
                        request.setAttribute("message", "Event not found.");
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("message", "Database driver not found: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "SQL error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Unexpected error: " + e.getMessage());
        }

        // Forward to JSP
        request.getRequestDispatcher("deleteevent.jsp").forward(request, response);
    }
}
