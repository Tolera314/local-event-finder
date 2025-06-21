<%@ page import="java.sql.*" %>
<%@ page import="Servlet.EventD" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/adminhome.css">
    <link rel="stylesheet" href="css/deleteevent.css">
    <title>Delete Event</title>
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
<div class="container">
    <!-- Message Display Section -->
    <div class="message">
        <%
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
            <p><%= message %></p>
        <%
            }
        %>
    </div>

    <!-- Search Section -->
    <div class="search-section">
        <h2>Search Event to Delete</h2>
        <div class="search-box">
            <form action="DSearchEventServlet" method="post">
                <input type="text" name="searchInput" placeholder="Enter event name to search..." required>
                <button type="submit">Search</button>
            </form>
        </div>
    </div>

    <!-- Event Details Section -->
    <div class="event-details">
        <h2>Event Details</h2>
        <%
            EventD event = (EventD) request.getAttribute("event");
            if (event != null) {
        %>
            <img class="event-image" src="<%= event.getImage() %>" alt="Event image">
            <div class="event-info">
                <p><strong>Event Name:</strong> <%= event.getName() %></p>
                <p><strong>Regular Price:</strong> $<%= event.getRegularPrice() %></p>
                <p><strong>VIP Price:</strong> $<%= event.getVipPrice() %></p>
                <p><strong>Location:</strong> <%= event.getLocation() %></p>
                <p><strong>Date & Time:</strong> <%= event.getDatetime() %></p>
            </div>
            <form action="DeleteEventServlet" method="post">
                <input type="hidden" name="eventName" value="<%= event.getName() %>">
                <button type="submit" class="delete-btn">Delete Event</button>
            </form>
        <%
            } else {
        %>
            <p>No event found. Please search for an event.</p>
        <%
            }
        %>
    </div>
</div>
    <script src="js/deleteevent.js"></script>
     <script src="js/adminhome.js"></script>
     
</body>
</html>