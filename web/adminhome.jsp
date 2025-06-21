<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/adminhome.css"> 
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background: url('images/decoration.avif') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            position: relative;
        }
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(26, 31, 44, 0.85);
            backdrop-filter: blur(5px);
            z-index: 0;
        }
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 1rem;
            display: flex;
            justify-content: right;
            gap: 2rem;
            z-index: 100;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .navbar a:hover {
            background: rgba(155, 135, 245, 0.3);
        }
        .toggle-sidebar {
            position: fixed;
            left: 20px;
            top: 20px;
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            z-index: 101;
            transition: all 0.3s ease;
        }
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            width: 250px;
            background: rgba(26, 31, 44, 0.95);
            padding-top: 80px;
            transition: all 0.3s ease;
            z-index: 99;
        }
        .sidebar a {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 2rem;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .sidebar a:hover {
            background: rgba(155, 135, 245, 0.2);
        }
        .sidebar.collapsed {
            transform: translateX(-250px);
        }
        .main-content {
            position: relative;
            padding: 100px 40px 40px;
            margin-left: 250px;
            min-height: 100vh;
            transition: all 0.3s ease;
            z-index: 1;
        }
        .main-content.expanded {
            margin-left: 0;
        }
        .welcome-container {
            text-align: center;
            color: white;
            opacity: 0;
            transform: translateY(20px);
            animation: fadeInUp 1s ease forwards;
        }
        .welcome-container h1 {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            background: linear-gradient(45deg, #9b87f5, #7E69AB);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .welcome-subtitle {
            font-size: 1.5rem;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 2rem;
        }
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }
        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s ease;
            animation: fadeIn 1s ease forwards;
            animation-delay: 0.5s;
            opacity: 0;
        }
        .stat-card:hover {
            transform: translateY(-5px);
        }
        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #9b87f5;
            margin-bottom: 0.5rem;
        }
        .stat-label {
            color: rgba(255, 255, 255, 0.8);
            font-size: 1.1rem;
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        @media (max-width: 768px) {
            .navbar {
                display: none;
            }
            .sidebar {
                width: 100%;
                background: rgba(26, 31, 44, 0.98);
            }
            .main-content {
                margin-left: 0;
                padding: 80px 20px 20px;
            }
            .welcome-container h1 {
                font-size: 2.5rem;
            }
            .welcome-subtitle {
                font-size: 1.2rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <a href="adminhome.jsp"><i class="fas fa-home"></i> Home</a>
        <a href="adminchat.jsp"><i class="fas fa-inbox"></i> Request</a>
        <a href="admin.jsp"><i class="fas fa-user"></i> Account</a>
        <a href="adminInput.jsp"><i class="fas fa-plus"></i> Add Event</a>
        <a href="editevent.jsp"><i class="fas fa-edit"></i> Edit Event</a>
    </nav>
    <!-- Sidebar Toggle Button -->
    <button class="toggle-sidebar">
        <i class="fas fa-bars"></i>
    </button>
    <!-- Sidebar -->
    <div class="sidebar">
        <a href="adminhome.jsp"><i class="fas fa-home"></i>Home</a>
        <a href="adminchat.jsp"><i class="fas fa-inbox"></i>Request</a>
        <a href="admin.jsp"><i class="fas fa-user"></i>Account</a>
        <a href="adminmanagement.jsp"><i class="fas fa-plus"></i>Admin Management</a>
        <a href="adminInput.jsp"><i class="fas fa-plus"></i>Add Event</a>
        <a href="editevent.jsp"><i class="fas fa-edit"></i>Edit Event</a>
         <a href="deleteevent.jsp"><i class="fas fa-trash"></i> Delete Event</a>
       <a href="admintickets.jsp"><i class="fas fa-ticket-alt"></i> Tickets</a>
    </div>
    <!-- Main Content Area -->
    <div class="main-content">
        <div class="welcome-container">
            <h1>Welcome to Admin Dashboard</h1>
            <p class="welcome-subtitle">Manage your events and users efficiently</p>
            
            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-number">150+</div>
                    <div class="stat-label">Total Events</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">1.2K</div>
                    <div class="stat-label">Active Users</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">98%</div>
                    <div class="stat-label">Satisfaction Rate</div>
                </div>
            </div>
        </div>
    </div>
    <script>
        // Toggle Sidebar Functionality
        const toggleBtn = document.querySelector('.toggle-sidebar');
        const sidebar = document.querySelector('.sidebar');
        const mainContent = document.querySelector('.main-content');
        toggleBtn.addEventListener('click', () => {
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('expanded');
            toggleBtn.classList.toggle('moved');
        });
        // Responsive Sidebar Toggle
        if (window.innerWidth <= 768) {
            sidebar.classList.add('collapsed');
            mainContent.classList.add('expanded');
            toggleBtn.classList.add('moved');
        }
        // Update on Window Resize
        window.addEventListener('resize', () => {
            if (window.innerWidth <= 768) {
                sidebar.classList.add('collapsed');
                mainContent.classList.add('expanded');
                toggleBtn.classList.add('moved');
            } else {
                sidebar.classList.remove('collapsed');
                mainContent.classList.remove('expanded');
                toggleBtn.classList.remove('moved');
            }
        });
    </script>
</body>
</html>