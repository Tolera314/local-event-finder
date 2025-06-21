package Servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/UpdateEventServlet")
@MultipartConfig
public class UpdateEventServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        String name = request.getParameter("name");
        double regularPrice = Double.parseDouble(request.getParameter("regularPrice"));
        double vipPrice = Double.parseDouble(request.getParameter("vipPrice"));
        String location = request.getParameter("location");

        String datetimeString = request.getParameter("datetime");
        Timestamp eventDate = null;

        // Parse the datetime string
        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            java.util.Date parsedDate = formatter.parse(datetimeString);
            eventDate = new Timestamp(parsedDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            response.sendRedirect("editevent.jsp?update=failure&error=invalid_date");
            return; // Exit method if parsing fails
        }

        Part filePart = request.getPart("image");
        InputStream imageInputStream = (filePart != null) ? filePart.getInputStream() : null;

        String dbURL = "jdbc:mysql://localhost:3306/event_finder";
        String dbUser = "root";
        String dbPass = "Toli314@";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                 PreparedStatement stmt = conn.prepareStatement("UPDATE events SET name=?, image=?, regular_price=?, vip_price=?, location=?, event_date=? WHERE id=?")) {
                 
                stmt.setString(1, name);
                if (imageInputStream != null) {
                    stmt.setBlob(2, imageInputStream);
                } else {
                    stmt.setNull(2, Types.BLOB);
                }
                stmt.setDouble(3, regularPrice);
                stmt.setDouble(4, vipPrice);
                stmt.setString(5, location);
                stmt.setTimestamp(6, eventDate);
                stmt.setInt(7, eventId);
                stmt.executeUpdate();
            }
            response.sendRedirect("editevent.jsp?update=success");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("editevent.jsp?update=failure");
        }
    }
}