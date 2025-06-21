<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Digital Banking</title>
    <link rel="stylesheet" href="css/homepage.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/layout.css">
    
    <style>


.welcome-message h2 {
    margin: 10px 0;
    color: #007bff; /* Blue text for headings */
}
</style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <button id="closeSidebar" class="close-button">×</button>
        <div class="sidebar-content">
            <h2>EventHub</h2>
            <nav class="sidebar-menu">
                <a href="homepage.jsp" class="active"><span class="icon">🏠</span> Home</a>
                <a href="availableevent.jsp"><span class="icon">📅</span> Available Events</a>
                <a href="#request"><span class="icon">📝</span> Request</a>
                <a href="payment.jsp"><span class="icon">💳</span> Payment</a>
                <a href="aboutus.jsp"><span class="icon">ℹ️</span> About Us</a>
            </nav>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Navbar -->
        <nav class="navbar">
            <button id="sidebarToggle" class="menu-button">☰</button>
            <div class="logo">EventHub</div>
            <div class="nav-links">
                <a href="homepage.jsp" class="active">Home</a>
                <a href="availableevent.jsp">Available Events</a>
                <a href="#request">Request</a>
                <a href="payment.jsp">Payment</a>
                <a href="aboutus.jsp">About Us</a>
            </div>
        </nav>
<div class="container">
        <h1>Digital Banking</h1>
<%
    HttpSession userSession = request.getSession(false);
    String fullName = (userSession != null) ? (String) userSession.getAttribute("user") : null;

    if (fullName == null) {
%>
    <div class="error-message">
        <h2 style="color: red;">Full name is required to access this page.</h2>
        <p>Please log in to continue.</p>
        <a href="signinsignup.jsp">Login</a>
    </div>
<%
    } else {
%>
    <div class="welcome-message">
        <h2>Welcome, <%= fullName %>!</h2>
        <p>Select an operation to get started</p>
    </div>
    
    <div class="buttons-container">       
        <button class="operation-btn" data-form="withdraw">Withdraw</button>
        <button class="operation-btn" data-form="deposit">Deposit</button>
        <button class="operation-btn" data-form="transfer">Transfer</button>
        <button class="operation-btn" data-form="balance">Balance</button>
        <button class="operation-btn" data-form="pay">Pay</button>
        <button class="operation-btn" data-form="account">Account</button>
    </div>
    <div id="formContainer" class="form-container">
        <!-- The form for selected operations will be injected here -->
    </div>
<%
    }
%>
<!-- Contact Section -->
            <section class="contact-section">
                <div class="contact-content">
                    <h2>Get in Touch</h2>
                    <p>Phone: +251 93-040-5193</p>
                    <p>Have questions about our events? We're here to help!</p>
                </div>
            </section>

            <!-- Footer -->
            <footer class="footer">
                <div class="footer-content">
                    <div class="footer-section">
                        <h3>EventHub</h3>
                        <p>Making event planning and attendance easier for everyone.</p>
                    </div>
                    <div class="footer-section">
                        <h3>Quick Links</h3>
                        <a href="homepage.jsp">Home</a>
                        <a href="availableevent.jsp">Available Events</a>
                        <a href="aboutus.jsp">About Us</a>
                    </div>
                    <div class="footer-section">
                        <h3>Follow Us</h3>
                        <div class="social-links">
                            <a href="#" class="social-link">Twitter</a>
                            <a href="#" class="social-link">Facebook</a>
                            <a href="#" class="social-link">Instagram</a>
                        </div>
                    </div>
                </div>
                <div class="footer-bottom">
                    <p>&copy; 2024 EventHub. All rights reserved.</p>
                </div>
            </footer>
        </div>    

        <script>
            const formContainer = document.getElementById('formContainer');
            const buttons = document.querySelectorAll('.operation-btn');

            const forms = {
                withdraw: `
                    <h2 style="text-align: center; margin-bottom: 2rem; font-size: 1.5rem;">Withdraw Funds</h2>
                    <form id="withdrawForm" method="POST" action="BankingServlet">
                        <input type="hidden" name="action" value="withdraw">
                        <div class="form-group">
                            <label for="withdrawAccount">Account Number</label>
                            <input type="text" name="accountNumber" id="withdrawAccount" required placeholder="Enter account number">
                        </div>
                        <div class="form-group">
                            <label for="withdrawAmount">Amount</label>
                            <input type="number" name="amount" id="withdrawAmount" required min="1" placeholder="Enter amount">
                        </div>
                        <button type="submit" class="submit-btn">Withdraw</button>
                    </form>
                `,
                deposit: `
                    <h2 style="text-align: center; margin-bottom: 2rem; font-size: 1.5rem;">Deposit Funds</h2>
                    <form id="depositForm" method="POST" action="BankingServlet">
                        <input type="hidden" name="action" value="deposit">
                        <div class="form-group">
                            <label for="depositAccount">Account Number</label>
                            <input type="text" name="accountNumber" id="depositAccount" required placeholder="Enter account number">
                        </div>
                        <div class="form-group">
                            <label for="depositAmount">Amount</label>
                            <input type="number" name="amount" id="depositAmount" required min="1" placeholder="Enter amount">
                        </div>
                        <button type="submit" class="submit-btn">Deposit</button>
                    </form>
                `,
                transfer: `
                    <h2 style="text-align: center; margin-bottom: 2rem; font-size: 1.5rem;">Transfer Money</h2>
                    <form id="transferForm" method="POST" action="BankingServlet">
                        <input type="hidden" name="action" value="transfer">
                        <div class="form-group">
                            <label for="fromAccount">From Account</label>
                            <input type="text" name="fromAccount" id="fromAccount" required placeholder="Enter your account number">
                        </div>
                        <div class="form-group">
                            <label for="toAccount">To Account</label>
                            <input type="text" name="toAccount" id="toAccount" required placeholder="Enter recipient's account number">
                        </div>
                        <div class="form-group">
                            <label for="transferAmount">Amount</label>
                            <input type="number" name="amount" id="transferAmount" required min="1" placeholder="Enter amount">
                        </div>
                        <button type="submit" class="submit-btn">Transfer</button>
                    </form>
                `,
                balance: `
                    <h2 style="text-align: center; margin-bottom: 2rem; font-size: 1.5rem;">Check Balance</h2>
                    <form id="balanceForm" method="POST" action="BankingServlet">
                        <input type="hidden" name="action" value="balance">
                        <div class="form-group">
                            <label for="balanceAccount">Account Number</label>
                            <input type="text" name="accountNumber" id="balanceAccount" required placeholder="Enter account number">
                        </div>
                        <button type="submit" class="submit-btn">Check Balance</button>
                    </form>
                `,
                pay: `
                    <h2 style="text-align: center; margin-bottom: 2rem; font-size: 1.5rem;">Get Your Ticket</h2>
                    <form id="payForm" method="POST" action="BankingServlet">
                        <input type="hidden" name="action" value="pay">
                        <div class="form-group">
                            <label for="payAmount">Amount</label>
                            <input type="number" name="amount" id="payAmount" required min="1" placeholder="Enter amount">
                        </div>
                        <button type="submit" class="submit-btn">Pay</button>
                    </form>
                `,
                account: `
                    <h2 style="text-align: center; margin-bottom: 2rem; font-size: 1.5rem;">View Your Account Number</h2>
                    <form id="accountForm" method="POST" action="BankingServlet">
                        <input type="hidden" name="action" value="account">
                        <div class="form-group">
                            <label for="viewAccount">Enter Your Fullname</label>
                            <input type="text" name="fullname" id="viewAccount" required placeholder="Enter fullname">
                        </div>
                        <button type="submit" class="submit-btn">View Account Number</button>
                    </form>
                `
            };

            buttons.forEach(button => {
                button.addEventListener('click', () => {
                    // Remove active class from all buttons
                    buttons.forEach(b => b.classList.remove('active'));
                    // Add active class to clicked button
                    button.classList.add('active');
                    
                    // Get the form type from data attribute
                    const formType = button.getAttribute('data-form');
                    
                    // Hide form container
                    formContainer.style.opacity = '0';
                    formContainer.style.transform = 'translateY(20px)';
                    
                    // After animation, update content and show
                    setTimeout(() => {
                        formContainer.innerHTML = forms[formType];
                        formContainer.style.opacity = '1';
                        formContainer.style.transform = 'translateY(0)';
                    }, 300);
                });
            });
        </script>

        <script src="js/homepage.js"></script>
    </body>
</html>