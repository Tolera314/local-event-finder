<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Servlet.Event" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/adminhome.css"> 
    <link rel="stylesheet" href="css/editevent.css"> 
    <title>Edit Event</title>
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
        <div class="search-section">
            <h2 style="margin-bottom: 1.5rem;">Search Event</h2>
            <form action="SearchEventServlet" method="post">
                <input type="text" name="searchInput" placeholder="Enter event name to search..." required>
                <button type="submit">Search</button>
            </form>
        </div>

        <div class="edit-form" id="editForm" style="<%= request.getAttribute("event") == null ? "display: none;" : "display: block;" %>">
            <h2 style="margin-bottom: 1.5rem;">Edit Event</h2>
            <%
                Event event = (Event) request.getAttribute("event");
                if (event != null) {
            %>
            <form method="post" action="UpdateEventServlet" enctype="multipart/form-data">
                <input type="hidden" name="eventId" value="<%= event.getId() %>">
                <div class="form-group">
                    <label>Event Image</label>
                    <input type="file" accept="image/*" name="image">
                    <img src="<%= event.getImage() != null ? "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(event.getImage().getBytes(1, (int) event.getImage().length())) : "" %>" alt="Event preview">
                </div>
                <div class="form-group">
                    <label>Event Name</label>
                    <input type="text" name="name" value="<%= event.getName() %>" required>
                </div>
                <div class="form-group">
                    <label>Regular Price</label>
                    <input type="number" name="regularPrice" value="<%= event.getRegularPrice() %>" required>
                </div>
                <div class="form-group">
                    <label>VIP Price</label>
                    <input type="number" name="vipPrice" value="<%= event.getVipPrice() %>" required>
                </div>
                <div class="form-group">
                    <label>Location</label>
                    <input type="text" name="location" value="<%= event.getLocation() %>" required>
                </div>
                <div class="form-group">
                    <label>Date and Time</label>
                    <input type="datetime-local" name="datetime" value="<%= new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").format(event.getEventDate()) %>" required>
                </div>
                <button type="submit">Update Event</button>
            </form>
            <%
                } else {
            %>
            <div>No event found. Please search again.</div>
            <%
                }
            %>
        </div>
    </div>
    <script src="js/editEvent.js"></script>
    <script src="js/adminhome.js"></script>
</body>
</html>