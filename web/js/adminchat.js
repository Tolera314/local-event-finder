  const messagesContainer = document.getElementById('messagesContainer');
let selectedReceiverId = null;

// Load users into the contacts list
function loadUsers() {
    fetch('/WebApplication2/AChatServlet?action=fetchUsers')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            console.log(data); // Log the fetched data for verification
            const contactsList = document.getElementById('contactsList');
            contactsList.innerHTML = ''; // Clear previous list

            // Check if data has users
            if (Array.isArray(data) && data.length > 0) {
                data.forEach(user => {
                    const contactDiv = document.createElement('div');
                    contactDiv.className = 'contact';

                    // Get the first letter of the user's fullname for the avatar
                    const firstLetter = user.fullname.charAt(0).toUpperCase();

                    contactDiv.innerHTML = `
                        <div class="contact-avatar">${firstLetter}</div>
                        <div class="contact-name">${user.fullname}</div> <!-- Dynamically fetched fullname -->
                    `;
                    contactDiv.onclick = () => loadMessages(user.id, user.fullname);
                    contactsList.appendChild(contactDiv);
                });
            } else {
                contactsList.innerHTML = '<div>No users found.</div>'; // Handle case with no users
            }
        })
        .catch(error => console.error('Error fetching users:', error));
}

// Initial load of users on page load
loadUsers();

// Load messages for the selected user
function loadMessages(receiverId, fullname) {
    selectedReceiverId = receiverId; // Store the selected receiver ID
    document.getElementById('chatHeader').querySelector('.contact-name').innerText = fullname;

    fetch(`/WebApplication2/AChatServlet?action=getMessages&receiverId=${receiverId}`)
        .then(response => response.json())
        .then(data => {
            messagesContainer.innerHTML = ''; // Clear previous messages
            if (Array.isArray(data.messages) && data.messages.length > 0) {
                data.messages.forEach(msg => {
                    const messageDiv = document.createElement('div');
                    messageDiv.className = 'message';
                    messageDiv.innerHTML = msg;
                    messagesContainer.appendChild(messageDiv);
                });
                messagesContainer.scrollTop = messagesContainer.scrollHeight; // Scroll to bottom
            } else {
                messagesContainer.innerHTML = '<div>No messages found.</div>'; // Handle no messages
            }
        })
        .catch(error => console.error('Error fetching messages:', error));
}
function sendMessage() {
    const input = document.getElementById('messageInput');
    const messageText = input.value.trim();

    if (messageText && selectedReceiverId) {
        // Create a temporary message element for optimistic rendering
        const tempMessageDiv = document.createElement('div');
        tempMessageDiv.className = 'message sent'; // Add a class for styling sent messages
        const timestamp = new Date().toLocaleTimeString();

        tempMessageDiv.innerHTML = `
            <span>${messageText}</span>
            <span class="message-time">${timestamp}</span>
        `;
        messagesContainer.appendChild(tempMessageDiv);
        messagesContainer.scrollTop = messagesContainer.scrollHeight; // Scroll to the bottom

        // Prepare the data for the POST request
const formData = new FormData();
formData.append('content', messageText);
formData.append('receiverId', selectedReceiverId); // Ensure this is being set correctly

        // Send the message to the server
        fetch('/WebApplication2/AChatServlet', {
            method: 'POST',
            body: formData,
        })
            .then((response) => {
                if (response.ok) {
                    // If the message is successfully stored in the database, clear input
                    input.value = ''; // Clear the input
                } else {
                    throw new Error('Failed to store message in database');
                }
            })
            .catch((error) => {
                console.error('Error sending message:', error);

                // Add a failure note to the message
                const errorSpan = document.createElement('span');
                errorSpan.className = 'error';
                errorSpan.innerText = ' (Failed to send)';
                tempMessageDiv.appendChild(errorSpan);
            });
    }
}