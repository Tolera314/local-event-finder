package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UserAuth")
public class UserAuth extends HttpServlet {

    // Database connection settings
    private static final String DB_URL = "jdbc:mysql://localhost:3306/event_finder";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Toli314@";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Get form action (sign-up or sign-in)
        String action = request.getParameter("action");

        if ("signup".equals(action)) {
            handleSignUp(request, response, out);
        } else if ("signin".equals(action)) {
            handleSignIn(request, response, out);
        } else {
            out.println("<h3>Invalid action!</h3>");
        }
    }

    private void handleSignUp(HttpServletRequest request, HttpServletResponse response, PrintWriter out) throws IOException {
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Check if email already exists in users
                String checkEmailQuery = "SELECT COUNT(*) FROM users WHERE email = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkEmailQuery)) {
                    checkStmt.setString(1, email);
                    ResultSet rs = checkStmt.executeQuery();
                    if (rs.next() && rs.getInt(1) > 0) {
                        out.println("<h3>Email already exists. Please use a different email.</h3>");
                        return;
                    }
                }

                // Generate account number
                String accountNumber = generateAccountNumber(conn);

                // Insert user into the database and get the generated user_id
                String insertUserQuery = "INSERT INTO users (fullname, email, password, account_number) VALUES (?, ?, ?, ?)";
                try (PreparedStatement insertUserStmt = conn.prepareStatement(insertUserQuery, Statement.RETURN_GENERATED_KEYS)) {
                    insertUserStmt.setString(1, fullname);
                    insertUserStmt.setString(2, email);
                    insertUserStmt.setString(3, password);
                    insertUserStmt.setString(4, accountNumber);
                    insertUserStmt.executeUpdate();

                    // Get the generated user_id
                    ResultSet userKeys = insertUserStmt.getGeneratedKeys();
                    if (userKeys.next()) {
                        int userId = userKeys.getInt(1);

                        // Insert fullname and account_number into the bank table
                        String insertBankQuery = "INSERT INTO bank (user_id, fullname, account_number) VALUES (?, ?, ?)";
                        try (PreparedStatement insertBankStmt = conn.prepareStatement(insertBankQuery)) {
                            insertBankStmt.setInt(1, userId);
                            insertBankStmt.setString(2, fullname);
                            insertBankStmt.setString(3, accountNumber);
                            insertBankStmt.executeUpdate();
                        }

                        // Redirect to sign-in form
                        HttpSession session = request.getSession();
                        session.setAttribute("message", "Sign-up successful! Please sign in.");
                        response.sendRedirect("signinsignup.jsp");
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("<h3>Error occurred during sign-up. Please try again.</h3>");
        }
    }

    private void handleSignIn(HttpServletRequest request, HttpServletResponse response, PrintWriter out) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Check for user credentials
                String userQuery = "SELECT id, fullname FROM users WHERE email = ? AND password = ?";
                try (PreparedStatement userStmt = conn.prepareStatement(userQuery)) {
                    userStmt.setString(1, email);
                    userStmt.setString(2, password);
                    ResultSet userRs = userStmt.executeQuery();

                    if (userRs.next()) {
                        // User login successful
                        HttpSession session = request.getSession();
                        String fullname = userRs.getString("fullname");
                        int userId = userRs.getInt("id"); // Fetch user ID
                        session.setAttribute("user", fullname);
                        session.setAttribute("userId", userId); // Store user ID in session
                        response.sendRedirect("homepage.jsp");
                        return;
                    }
                }

                // Check for admin credentials
                String adminQuery = "SELECT id FROM admins WHERE email = ? AND password = ?";
                try (PreparedStatement adminStmt = conn.prepareStatement(adminQuery)) {
                    adminStmt.setString(1, email);
                    adminStmt.setString(2, password);
                    ResultSet adminRs = adminStmt.executeQuery();

                    if (adminRs.next()) {
                        // Admin login successful
                        HttpSession session = request.getSession();
                        int adminId = adminRs.getInt("id"); // Fetch admin ID
                        session.setAttribute("adminId", adminId); // Store admin ID in session
                        response.sendRedirect("adminhome.jsp");
                    } else {
                        out.println("<h3>Invalid email or password. Please try again.</h3>");
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<h3>Database driver not found. Please check your setup.</h3>");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<h3>Database error occurred: " + e.getMessage() + "</h3>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Unexpected error occurred: " + e.getMessage() + "</h3>");
        }
    }

    private String generateAccountNumber(Connection conn) throws SQLException {
        String query = "SELECT MAX(account_number) FROM users";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            if (rs.next() && rs.getString(1) != null) {
                long maxAccountNumber = Long.parseLong(rs.getString(1));
                return String.valueOf(maxAccountNumber + 1);
            } else {
                return "1000000000000"; // Starting account number
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("signinsignup.jsp"); // Redirect to the main page
    }
}
