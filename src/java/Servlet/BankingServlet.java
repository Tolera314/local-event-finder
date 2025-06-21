package Servlet;

import java.io.IOException;
import java.sql.*;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/BankingServlet")
public class BankingServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(BankingServlet.class.getName());

    private Connection connectToDatabase() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/event_finder";
        String user = "root";
        String password = "Toli314@";
        return DriverManager.getConnection(url, user, password);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = connectToDatabase();
            switch (action) {
                case "withdraw" -> handleWithdraw(request, response, conn);
                case "deposit" -> handleDeposit(request, response, conn);
                case "transfer" -> handleTransfer(request, response, conn);
                case "balance" -> handleBalance(request, response, conn);
                case "account" -> handleAccount(request, response, conn);
                case "pay" -> handlePay(request, response, conn);
                default -> response.getWriter().write("Invalid action");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error", e);
            response.getWriter().write("Database error: " + e.getMessage());
        } catch (ClassNotFoundException ex) {
            LOGGER.log(Level.SEVERE, "JDBC Driver not found", ex);
        }
    }

    private void handleWithdraw(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException, SQLException {
        String accountNumber = request.getParameter("accountNumber");
        String amountStr = request.getParameter("amount");

        if (!isValidAccountNumber(accountNumber) || !isValidAmount(amountStr)) {
            response.getWriter().write("Invalid account number or amount.");
            return;
        }

        double amount = Double.parseDouble(amountStr);
        
        String query = "UPDATE bank SET balance = balance - ?, withdraw_amount = withdraw_amount + ? WHERE account_number = ? AND balance >= ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDouble(1, amount);
            stmt.setDouble(2, amount);
            stmt.setString(3, accountNumber);
            stmt.setDouble(4, amount);
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.getWriter().write("Withdrawal successful.");
            } else {
                response.getWriter().write("Insufficient balance or invalid account.");
            }
        }
    }

    private void handleDeposit(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException, SQLException {
        String accountNumber = request.getParameter("accountNumber");
        String amountStr = request.getParameter("amount");

        if (!isValidAccountNumber(accountNumber) || !isValidAmount(amountStr)) {
            response.getWriter().write("Invalid account number or amount.");
            return;
        }

        double amount = Double.parseDouble(amountStr);
        String query = "UPDATE bank SET balance = balance + ?, deposit_amount = deposit_amount + ? WHERE account_number = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDouble(1, amount);
            stmt.setDouble(2, amount);
            stmt.setString(3, accountNumber);
            stmt.executeUpdate();
            response.getWriter().write("Deposit successful.");
        }
    }

    private void handleTransfer(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException, SQLException {
        String fromAccount = request.getParameter("fromAccount");
        String toAccount = request.getParameter("toAccount");
        String amountStr = request.getParameter("amount");

        if (!isValidAccountNumber(fromAccount) || !isValidAccountNumber(toAccount) || !isValidAmount(amountStr)) {
            response.getWriter().write("Invalid account number or amount.");
            return;
        }

        double amount = Double.parseDouble(amountStr);
        conn.setAutoCommit(false);
        try {
            String withdrawQuery = "UPDATE bank SET balance = balance - ?, withdraw_amount = withdraw_amount + ? WHERE account_number = ? AND balance >= ?";
            try (PreparedStatement stmt = conn.prepareStatement(withdrawQuery)) {
                stmt.setDouble(1, amount);
                stmt.setDouble(2, amount);
                stmt.setString(3, fromAccount);
                stmt.setDouble(4, amount);
                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated == 0) {
                    conn.rollback();
                    response.getWriter().write("Insufficient balance or invalid from account.");
                    return;
                }
            }

            String depositQuery = "UPDATE bank SET balance = balance + ?, deposit_amount = deposit_amount + ? WHERE account_number = ?";
            try (PreparedStatement stmt = conn.prepareStatement(depositQuery)) {
                stmt.setDouble(1, amount);
                stmt.setDouble(2, amount);
                stmt.setString(3, toAccount);
                stmt.executeUpdate();
            }

            conn.commit();
            response.getWriter().write("Transfer successful.");
        } catch (SQLException e) {
            conn.rollback();
            LOGGER.log(Level.SEVERE, "Transfer failed", e);
            response.getWriter().write("Transfer failed due to an error.");
        } finally {
            conn.setAutoCommit(true);
        }
    }

    private void handleBalance(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException, SQLException {
        String accountNumber = request.getParameter("accountNumber");

        if (!isValidAccountNumber(accountNumber)) {
            response.getWriter().write("Invalid account number.");
            return;
        }

        String query = "SELECT balance FROM bank WHERE account_number = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, accountNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    double balance = rs.getDouble("balance");
                    response.getWriter().write("Balance: " + balance);
                } else {
                    response.getWriter().write("Invalid account number.");
                }
            }
        }
    }

    private void handleAccount(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException, SQLException {
        String fullname = request.getParameter("fullname");

        if (fullname == null || fullname.isEmpty()) {
            response.getWriter().write("Full name is required.");
            return;
        }

        String query = "SELECT account_number FROM users WHERE fullname = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, fullname);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String accountNumber = rs.getString("account_number");
                    response.getWriter().write("Account Number: " + accountNumber);
                } else {
                    response.getWriter().write("User not found.");
                }
            }
        }
    }

   private void handlePay(HttpServletRequest request, HttpServletResponse response, Connection conn) throws IOException, SQLException {
    HttpSession session = request.getSession(false);
    String fullname = (String) session.getAttribute("user");
    String priceType = (String) session.getAttribute("priceType"); // Fetch priceType from session
    String priceStr = (String) session.getAttribute("price"); // Fetch price from session
    String eventName = (String) session.getAttribute("eventName"); // Fetch eventName from session

    LOGGER.log(Level.INFO, "Received payment request: fullname={0}, priceType={1}, price={2}, eventName={3}",
            new Object[]{fullname, priceType, priceStr, eventName});

    if (fullname == null || fullname.isEmpty()) {
        response.getWriter().write("Full name is required.");
        return;
    }
    if (priceType == null || priceType.isEmpty()) {
        response.getWriter().write("Price type is required.");
        return;
    }
    if (priceStr == null || !isValidAmount(priceStr)) {
        response.getWriter().write("Invalid price amount.");
        return;
    }
    if (eventName == null || eventName.isEmpty()) {
        response.getWriter().write("Event name is required.");
        return;
    }

    double price = Double.parseDouble(priceStr);
    String adminAccountNumber = "1000000000005"; // Admin account number for payments

    // Fetch user and balance
    String userQuery = "SELECT users.id, bank.balance FROM users INNER JOIN bank ON users.id = bank.user_id WHERE users.fullname = ?";
    try (PreparedStatement userStmt = conn.prepareStatement(userQuery)) {
        userStmt.setString(1, fullname);
        try (ResultSet userRs = userStmt.executeQuery()) {
            if (!userRs.next()) {
                response.getWriter().write("User not found.");
                return;
            }
            int userId = userRs.getInt("id");
            double userBalance = userRs.getDouble("balance");

            // Check if the user has sufficient balance
            if (userBalance < price) {
                response.getWriter().write("Insufficient balance.");
                return;
            }

            // Check if the event exists
            String eventQuery = "SELECT id FROM events WHERE name = ?";
            int eventId;
            try (PreparedStatement eventStmt = conn.prepareStatement(eventQuery)) {
                eventStmt.setString(1, eventName);
                try (ResultSet eventRs = eventStmt.executeQuery()) {
                    if (!eventRs.next()) {
                        response.getWriter().write("Event not found.");
                        return;
                    }
                    eventId = eventRs.getInt("id");
                }
            }

            // Start transaction
            conn.setAutoCommit(false);
            try {
                // Deduct amount from user's account
                String deductQuery = "UPDATE bank SET balance = balance - ? WHERE user_id = ?";
                try (PreparedStatement deductStmt = conn.prepareStatement(deductQuery)) {
                    deductStmt.setDouble(1, price);
                    deductStmt.setInt(2, userId);
                    deductStmt.executeUpdate();
                }

                // Credit amount to the admin's account
                String creditQuery = "UPDATE bank SET balance = balance + ? WHERE account_number = ?";
                try (PreparedStatement creditStmt = conn.prepareStatement(creditQuery)) {
                    creditStmt.setDouble(1, price);
                    creditStmt.setString(2, adminAccountNumber);
                    creditStmt.executeUpdate();
                }

                // Generate ticket number and insert into tickets table
                String ticketNumber = generateTicketNumber(priceType, eventName);
                String ticketQuery = "INSERT INTO tickets (fullname, ticket_number, event_id, user_id, price_type, price) VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement ticketStmt = conn.prepareStatement(ticketQuery)) {
                    ticketStmt.setString(1, fullname);
                    ticketStmt.setString(2, ticketNumber);
                    ticketStmt.setInt(3, eventId);
                    ticketStmt.setInt(4, userId);
                    ticketStmt.setString(5, priceType);
                    ticketStmt.setDouble(6, price);
                    ticketStmt.executeUpdate();
                }

                // Commit the transaction
                conn.commit();
                response.getWriter().write("Ticket purchased successfully. Ticket Number: " + ticketNumber);
            } catch (SQLException e) {
                conn.rollback(); // Rollback on error
                LOGGER.log(Level.SEVERE, "Payment transaction failed", e);
                response.getWriter().write("Payment transaction failed.");
            } finally {
                conn.setAutoCommit(true); // Restore auto-commit behavior
            }
        }
    }
}
    private String generateTicketNumber(String priceType, String eventName) {
        Random random = new Random();
        String typeCode = priceType.equalsIgnoreCase("VIP") ? "V" : "R";
        int randomNumber = 10000 + random.nextInt(90000);
        return typeCode + eventName.substring(0, Math.min(3, eventName.length())).toUpperCase() + randomNumber;
    }

    private boolean isValidAccountNumber(String accountNumber) {
        return accountNumber != null && !accountNumber.isEmpty();
    }

    private boolean isValidAmount(String amountStr) {
        if (amountStr == null || amountStr.isEmpty()) {
            return false;
        }
        try {
            double amount = Double.parseDouble(amountStr);
            return amount > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}