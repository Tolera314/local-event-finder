<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/adminhome.css"> 
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background: #1A1F2C;
            color: white;
            
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
       
        button {
            padding: 5px 10px;
            cursor: pointer;
            color: green;
        }
        h1, h2{
            text-align: center;
            margin-bottom: 1rem;            
            background: linear-gradient(to right, #4f46e5, #6366f1);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            padding: 1rem;  
            text-align: center;
        }
        h1{
            font-size: 2.5rem;
           
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
    <h1 style="text-align: center; margin-top: 6rem;">Admin Dashboard</h1>
    <h2 style="text-align: center;">Manage Users</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/event_finder", "root", "Toli314@");
                    
                    String query = "SELECT id, fullname, email FROM users";
                    pstmt = con.prepareStatement(query);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String fullname = rs.getString("fullname");
                        String email = rs.getString("email");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= fullname %></td>
                <td><%= email %></td>
                <td>
                    <form action="UserManagementServlet" method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="<%= id %>">
                        <button type="submit">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                    if (con != null) try { con.close(); } catch (SQLException e) {}
                }
            %>
        </tbody>
    </table>
        <script src="js/adminhome.js"></script>
</body>
</html>