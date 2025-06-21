<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("signinsignup.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Messaging</title>
    <style>
        .message-box {
            border: 1px solid #ccc;
            padding: 1rem;
            margin: 1rem 0;
        }
    </style>
</head>
<body>
    <h2>Messages with Admin</h2>
    <div id="messages"></div>

    <form id="messageForm" method="POST" enctype="multipart/form-data" action="MessagingServlet">
        <input type="hidden" name="action" value="sendMessage">
        <input type="hidden" name="userId" value="<%= userId %>">
        <textarea name="message" placeholder="Type your message" required></textarea><br>
        <input type="file" name="file"><br>
        <button type="submit">Send</button>
    </form>

    <script>
        async function loadMessages() {
            const response = await fetch('MessagingServlet?action=viewMessages&userId=<%= userId %>');
            const messages = await response.text();
            document.getElementById('messages').innerHTML = messages;
        }

        document.getElementById('messageForm').onsubmit = async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            await fetch('MessagingServlet', { method: 'POST', body: formData });
            e.target.reset();
            loadMessages();
        };

        loadMessages();
    </script>
</body>
</html>
