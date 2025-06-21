package Servlet;
import java.io.IOException;
import java.io.InputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/addEvent")
@MultipartConfig
public class AddEventServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/event_finder";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Toli314@";

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String name = request.getParameter("name");
    String regularPrice = request.getParameter("regular_price");
    String vipPrice = request.getParameter("vip_price");
    String location = request.getParameter("location");
    String eventDate = request.getParameter("event_date");
    String regularNo = request.getParameter("regular_no");
    String vipNo = request.getParameter("vip_no");
    
    // Retrieve the file part
    Part filePart = request.getPart("image"); // Ensure this matches the name in the form
    if (filePart == null) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "File part is missing.");
        return;
    }

    byte[] imageBytes;
    try (InputStream inputStream = filePart.getInputStream()) {
        imageBytes = inputStream.readAllBytes(); // Read image as bytes
    }

        // Store event data in database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "INSERT INTO events (name, image, regular_price, vip_price, location, event_date, regular_nobench, vip_nobench) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setBytes(2, imageBytes); // Store image as bytes
                stmt.setBigDecimal(3, new BigDecimal(regularPrice));
                stmt.setBigDecimal(4, new BigDecimal(vipPrice));
                stmt.setString(5, location);
                stmt.setString(6, eventDate);
                stmt.setString(7, regularNo);
                stmt.setString(8, vipNo);
                
                stmt.executeUpdate();
            }
        } catch (ClassNotFoundException | SQLException e) {
            response.getWriter().write("Error while storing event: " + e.getMessage());
            return;
        }

                    HttpSession session = request.getSession();
                    session.setAttribute("message", "Uploaded successfully!");
                    response.sendRedirect("adminInput.jsp");
    }
}