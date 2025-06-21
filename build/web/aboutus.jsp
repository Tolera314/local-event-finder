
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - EventHub</title>
     <link rel="stylesheet" href="css/homepage.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, rgba(99,102,241,0.95) 0%, rgba(139,92,246,0.95) 100%);
            --card-gradient: linear-gradient(to bottom right, rgba(255, 255, 255, 0.9), rgba(255, 255, 255, 0.7));
            --transition-speed: 0.3s;
        }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            color: #333;
        }
        /* Navbar Styles */
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            height: 4rem;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            display: flex;
            align-items: center;
            padding: 0 2rem;
            z-index: 100;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .menu-button {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            display: none;
        }
        .logo {
            font-weight: 700;
            font-size: 1.5rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }
        .nav-links {
            margin-left: auto;
            display: flex;
            gap: 2rem;
        }
        .nav-links a {
            color: #666;
            text-decoration: none;
            font-weight: 500;
            transition: color var(--transition-speed);
        }
        .nav-links a:hover {
            color: #333;
        }
        /* About Us Hero Section */
        .about-hero {
            text-align: center;
            padding: 8rem 2rem 4rem;
            background: var(--primary-gradient);
            color: white;
        }
        .about-hero h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
            animation: fadeIn 1s ease-out;
        }
        .about-hero p {
            font-size: 1.25rem;
            max-width: 800px;
            margin: 0 auto;
            opacity: 0.9;
        }
        /* Team Section */
        .team-section {
            padding: 4rem 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }
        .team-card {
            background: var(--card-gradient);
            border-radius: 1rem;
            overflow: hidden;
            transition: transform var(--transition-speed);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .team-card:hover {
            transform: translateY(-5px);
        }
        .team-card img {
            width: 100%;
            height: 280px;
            object-fit: cover;
        }
        .team-content {
            padding: 1.5rem;
            text-align: center;
        }
        .team-content h3 {
            margin-bottom: 0.5rem;
        }
        .team-content p {
            color: #666;
        }
        /* Timeline Section */
        .timeline-section {
            padding: 4rem 2rem;
            background: rgba(255, 255, 255, 0.5);
        }
        .timeline {
            max-width: 800px;
            margin: 2rem auto;
            position: relative;
        }
        .timeline::before {
            content: '';
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            width: 2px;
            height: 100%;
            background: var(--primary-gradient);
        }
        .timeline-item {
            margin: 2rem 0;
            position: relative;
            width: 50%;
            padding: 0 2rem;
        }
        .timeline-item:nth-child(odd) {
            left: 0;
        }
        .timeline-item:nth-child(even) {
            left: 50%;
        }
        .timeline-content {
            background: var(--card-gradient);
            padding: 1.5rem;
            border-radius: 0.5rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .timeline-year {
            font-weight: 700;
            color: #6366f1;
            margin-bottom: 0.5rem;
        }
        /* Contact Section */
        .contact-section {
            background: var(--primary-gradient);
            color: white;
            padding: 4rem 2rem;
            text-align: center;
        }
        .contact-content {
            max-width: 600px;
            margin: 0 auto;
        }
        .contact-info {
            margin-top: 2rem;
        }
        .contact-info p {
            margin: 0.5rem 0;
        }
        /* Animations */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        /* Responsive Design */
        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            .menu-button {
                display: block;
            }
            .timeline::before {
                left: 0;
            }
            .timeline-item {
                width: 100%;
                left: 0 !important;
                padding-left: 2rem;
            }
            .about-hero h1 {
                font-size: 2rem;
            }
            .team-grid {
                grid-template-columns: 1fr;
            }
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
                <a href="chat.jsp">Request</a>
                <a href="payment.jsp">Payment</a>
                <a href="aboutus.jsp">About Us</a>
            </div>
        </nav>

    <!-- About Hero Section -->
    <section class="about-hero">
        <h1>About EventHub</h1>
        <p>Creating Unforgettable Experiences Since 2020</p>
    </section>
    <!-- Team Section -->
    <section class="team-section">
        <h2 class="text-center">Our Team</h2>
        <div class="team-grid">
            <div class="team-card">
                <img src="https://images.unsplash.com/photo-1581091226825-a6a2a5aee158?auto=format&fit=crop&w=300&q=80" alt="Sarah Johnson">
                <div class="team-content">
                    <h3>Tolera Fayisa</h3>
                    <p>Founder & CEO</p>
                </div>
            </div>
            <div class="team-card">
                <img src="https://images.unsplash.com/photo-1581092795360-fd1ca04f0952?auto=format&fit=crop&w=300&q=80" alt="Michael Chen">
                <div class="team-content">
                    <h3>Tolera Fayisa</h3>
                    <p>Head of Operations</p>
                </div>
            </div>
            <div class="team-card">
                <img src="https://images.unsplash.com/photo-1721322800607-8c38375eef04?auto=format&fit=crop&w=300&q=80" alt="Emily Rodriguez">
                <div class="team-content">
                    <h3>Tolera Fayisa</h3>
                    <p>Event Director</p>
                </div>
            </div>
        </div>
    </section>
    <!-- Timeline Section -->
    <section class="timeline-section">
        <h2 class="text-center">Our Journey</h2>
        <div class="timeline">
            <div class="timeline-item">
                <div class="timeline-content">
                    <div class="timeline-year">2020</div>
                    <h3>Company Founded</h3>
                    <p>EventHub was established with a vision to revolutionize event planning</p>
                </div>
            </div>
            <div class="timeline-item">
                <div class="timeline-content">
                    <div class="timeline-year">2021</div>
                    <h3>National Expansion</h3>
                    <p>Expanded operations to cover major cities across the country</p>
                </div>
            </div>
            <div class="timeline-item">
                <div class="timeline-content">
                    <div class="timeline-year">2022</div>
                    <h3>Digital Innovation</h3>
                    <p>Launched our state-of-the-art event management platform</p>
                </div>
            </div>
            <div class="timeline-item">
                <div class="timeline-content">
                    <div class="timeline-year">2023</div>
                    <h3>Industry Recognition</h3>
                    <p>Received multiple awards for excellence in event management</p>
                </div>
            </div>
        </div>
    </section>
    <!-- Contact Section -->
    <section class="contact-section">
        <div class="contact-content">
            <h2>Get in Touch</h2>
            <div class="contact-info">
                <p>Phone: +251 93-040-5193</p>
                <p>Email: Tolefayiss@gmail.com</p>
                <p>Have questions about our services or want to plan your next event? We'd love to hear from you!</p>
            </div>
        </div>
    </section>
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
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animation for team cards
            const observerOptions = {
                threshold: 0.1
            };
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);
            // Observe all team cards
            document.querySelectorAll('.team-card').forEach(card => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = 'opacity 0.5s ease-out, transform 0.5s ease-out';
                observer.observe(card);
            });
 
    </script>
    <script src="js/homepage.js"></script>
</body>
</html>