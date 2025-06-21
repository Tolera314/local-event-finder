
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

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("id");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_finder", "root", "Toli314@");
            String query = "DELETE FROM users WHERE id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, userId);
            ps.executeUpdate();

            response.sendRedirect("admin.jsp");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}