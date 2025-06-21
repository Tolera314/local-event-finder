package Servlet;

import java.io.IOException;
import java.sql.*;
import java.util.Base64;
import org.json.JSONArray;
import org.json.JSONObject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/FetchEventsServlet")
public class FetchEventsServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/event_finder";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Toli314@";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT name, image, regular_price, vip_price, location, event_date FROM events");

                JSONArray eventsArray = new JSONArray();

                while (rs.next()) {
                    JSONObject event = new JSONObject();
                    event.put("name", rs.getString("name"));

                    // Encode image to Base64
                    Blob imageBlob = rs.getBlob("image");
                    if (imageBlob != null) {
                        byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                        event.put("image", "data:image/jpeg;base64," + base64Image); // Fixed MIME type
                    } else {
                        event.put("image", ""); // Fallback if no image is provided
                    }

                    event.put("regularPrice", rs.getString("regular_price"));
                    event.put("vipPrice", rs.getString("vip_price"));
                    event.put("location", rs.getString("location"));
                    event.put("date", rs.getString("event_date"));

                    eventsArray.put(event);
                }

                response.getWriter().write(eventsArray.toString());
            }

        } catch (ClassNotFoundException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Database driver not found.\"}");
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Failed to fetch events.\"}");
        }
    }

    // New method to store event details in session
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Access the session
        HttpSession session = request.getSession();

        // Read the JSON body from the request
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = request.getReader().readLine()) != null) {
            sb.append(line);
        }

        // Parse the JSON data
        JSONObject jsonObject = new JSONObject(sb.toString());
        String eventName = jsonObject.getString("eventName");
        String priceType = jsonObject.getString("priceType");
        String price = jsonObject.getString("price");

        // Store event details in the session
        session.setAttribute("eventName", eventName);
        session.setAttribute("priceType", priceType);
        session.setAttribute("price", price);

        // Respond with a success message
        response.getWriter().write("{\"status\": \"success\"}");
    }
}