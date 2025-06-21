<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Chat Interface</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
    background: #1A1F2C;
    color: white;
    height: 100vh;
    display: flex;
}

/* Contacts Sidebar */
.contacts-sidebar {
    width: 300px;
    background: rgba(255, 255, 255, 0.05);
    border-right: 1px solid rgba(255, 255, 255, 0.1);
    display: flex;
    flex-direction: column;
}

.search-bar {
    padding: 1rem;
    background: rgba(255, 255, 255, 0.1);
}

.search-bar input {
    width: 100%;
    padding: 0.8rem;
    border-radius: 8px;
    border: none;
    background: rgba(255, 255, 255, 0.1);
    color: white;
}

.contacts-list {
    flex: 1;
    overflow-y: auto;
}

.contact {
    padding: 1rem;
    display: flex;
    align-items: center;
    gap: 1rem;
    cursor: pointer;
    transition: background 0.3s ease;
    color: white; /* Ensure contact text is white */
}

.contact:hover {
    background: rgba(155, 135, 245, 0.1);
}

.contact.active {
    background: rgba(155, 135, 245, 0.2);
}

.contact-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: #9b87f5; /* Blue background */
    color: white; /* White text for initials */
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    margin-right: 10px;
}

.contact-name {
    font-weight: 600; /* Bold for the name */
    color: white; /* White text for the full name */
}

        .last-message {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.6);
        }

        /* Chat Area */
        .chat-area {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .chat-header {
            padding: 1rem;
            background: rgba(255, 255, 255, 0.05);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .messages-container {
            flex: 1;
            padding: 1rem;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .message {
            max-width: 70%;
            padding: 0.8rem;
            border-radius: 12px;
            position: relative;
        }

        .message.received {
            background: rgba(255, 255, 255, 0.1);
            align-self: flex-start;
            border-bottom-left-radius: 4px;
        }

        .message.sent {
            background: #9b87f5;
            align-self: flex-end;
            border-bottom-right-radius: 4px;
        }

        .message-time {
            font-size: 0.75rem;
            color: rgba(255, 255, 255, 0.6);
            margin-top: 0.25rem;
        }

        .message-image {
            max-width: 300px;
            border-radius: 8px;
            margin-top: 0.5rem;
        }

        .message-file {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(255, 255, 255, 0.1);
            padding: 0.5rem;
            border-radius: 8px;
            margin-top: 0.5rem;
        }

        .input-area {
            padding: 1rem;
            background: rgba(255, 255, 255, 0.05);
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .input-area input {
            flex: 1;
            padding: 0.8rem;
            border-radius: 8px;
            border: none;
            background: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .attachment-btn {
            background: none;
            border: none;
            color: #9b87f5;
            cursor: pointer;
            font-size: 1.2rem;
        }

        .send-btn {
            background: #9b87f5;
            border: none;
            color: white;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .send-btn:hover {
            background: #7E69AB;
        }

        /* Scrollbar Styling */
        ::-webkit-scrollbar {
            width: 6px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
        }

        ::-webkit-scrollbar-thumb {
            background: rgba(155, 135, 245, 0.5);
            border-radius: 3px;
        }

        @media (max-width: 768px) {
            .contacts-sidebar {
                width: 80px;
            }

            .contact-info {
                display: none;
            }

            .search-bar {
                display: none;
            }
        }
      </style>
</head>
<body>
    <div class="contacts-sidebar">
        <div class="search-bar">
            <input type="text" placeholder="Search contacts...">
        </div>
        <div class="contacts-list" id="contactsList">
            <!-- Contacts will be loaded dynamically -->
        </div>
    </div>

    <div class="chat-area">
        <div class="chat-header" id="chatHeader">
            <div class="contact-name">Select a contact</div>
        </div>

        <div class="messages-container" id="messagesContainer">
            <!-- Messages will be loaded dynamically -->
        </div>

        <div class="input-area">
            <input type="text" placeholder="Type a message..." id="messageInput">
            <button class="send-btn" onclick="sendMessage()">
                <i class="fas fa-paper-plane"></i>
            </button>
        </div>
    </div>

    <script src="js/adminchat.js">
     
    </script>
</body>
</html>