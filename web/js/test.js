  let selectedUserId = null;

        function loadUsers() {
            fetch('AChatServlet?action=getUsers')
                .then(response => response.text())
                .then(data => {
                    document.getElementById('userList').innerHTML = data;
                });
        }

        function selectUser(id, username) {
            selectedUserId = id;
            document.getElementById('selectedUserName').textContent = username;
            loadMessages();
        }

        function loadMessages() {
            if (selectedUserId) {
                fetch('AChatServlet?action=getMessages&userId=' + selectedUserId)
                    .then(response => response.json()) // Assuming the response is JSON
                    .then(data => {
                        const messagesContainer = document.getElementById('messagesContainer');
                        messagesContainer.innerHTML = ''; // Clear existing messages
                        data.forEach(message => {
                            const messageDiv = document.createElement('div');
                            messageDiv.className = `message ${message.type}`; // 'sent' or 'received'
                            messageDiv.innerHTML = `
                                <div class="message-header">
                                    <span class="sender">${message.sender}</span>
                                    <span class="timestamp">${new Date(message.timestamp).toLocaleTimeString()}</span>
                                </div>
                                <div class="message-text">${message.content}</div>
                            `;
                            messagesContainer.appendChild(messageDiv);
                        });
                    });
            }
        }

        function sendMessage() {
            const messageInput = document.getElementById('messageInput');
            if (selectedUserId && messageInput.value.trim() !== '') {
                fetch('AChatServlet?action=sendMessage&userId=' + selectedUserId + '&content=' + encodeURIComponent(messageInput.value))
                    .then(response => response.text())
                    .then(data => {
                        console.log(data);
                        messageInput.value = ''; // Clear input after sending
                        loadMessages(); // Reload messages
                    });
            }
        }

        setInterval(() => {
            loadMessages(); // Check for new messages every 2 seconds
        }, 1500);

        window.onload = loadUsers; // Load users on page load