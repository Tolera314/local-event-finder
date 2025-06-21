<%@ page import="java.sql.*, java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/homepage.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/availableevent.css">
    <title>Available Events</title>
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
                <a href="chat.jsp"><span class="icon">?</span> Request</a>
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
                <a href="chat.jsp">Request</a>
                <a href="payment.jsp">Payment</a>
                <a href="aboutus.jsp">About Us</a>
            </div>
        </nav>

        <!-- Events Grid -->
        <div class="events-container">
            <h1>Available Events</h1>
            <div class="events-grid">
                <!-- Event cards will be inserted here by JavaScript -->
            </div>
        </div>

        <!-- Event Details Modal -->
        <div id="eventModal" class="modal">
            <div class="modal-content">
                <span class="close-modal">&times;</span>
                <div id="modalContent">
                    <!-- This will be filled dynamically -->
                </div>
            </div>
        </div>

        <!-- Contact Section -->
        <section class="contact-section">
            <div class="contact-content">
                <h2>Get in Touch</h2>
                <p>Phone: +251 93-040-5193</p>
                <p>Email: Tolefayiss@gmail.com</p>
                <p>Have questions about our services or want to plan your next event? We'd love to hear from you!</p>           
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

    <script src="js/availableevent.js">
       
    </script>
</body>
</html>