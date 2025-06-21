<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EventHub - Modern Event Platform</title>
    <link rel="stylesheet" href="css/homepage.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
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
                <a href="chat.jsp"><span class="icon">📝</span> Request</a>
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

        <!-- Hero Section -->
        <section class="hero">
            <h1>Welcome to EventHub</h1>
            <p>Discover and book amazing events happening around you</p>
        </section>

        <!-- Events Grid -->
        <section class="events-grid">
            <div class="event-card">
                <img src="images/festival.jpg" alt="Summer Music Festival">
                <div class="event-content">
                    <h3>Summer Music Festival</h3>
                    <p>Join us for three days of amazing music performances under the summer sky.</p>
                </div>
            </div>
            <div class="event-card">
                <img src="images/festival.jpg" alt="Tech Conference 2024">
                <div class="event-content">
                    <h3>Tech Conference 2024</h3>
                    <p>Explore the latest in technology with industry leaders and innovators.</p>
                </div>
            </div>
            <div class="event-card">
                <img src="images/festival.jpg" alt="Food & Wine Expo">
                <div class="event-content">
                    <h3>Food & Wine Expo</h3>
                    <p>Experience culinary delights and fine wines from around the world.</p>
                </div>
            </div>
        </section>

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

    <script src="js/homepage.js"></script>
</body>
</html>