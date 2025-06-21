package Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


@WebServlet("/DeleteEventServlet")
public class DeleteEventServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventName = request.getParameter("eventName");

        try {
            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Query to delete event
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_finder", "root", "Toli314@")) {
                // Query to delete event
                String query = "DELETE FROM events WHERE name = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, eventName);
                
                int result = ps.executeUpdate();
                
                if (result > 0) {
                    request.setAttribute("message", "Event deleted successfully.");
                } else {
                    request.setAttribute("message", "Failed to delete event. Please try again.");
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            request.setAttribute("message", "Error occurred while deleting the event.");
        }

        // Forward to JSP
        request.getRequestDispatcher("deleteevent.jsp").forward(request, response);
    }
}
