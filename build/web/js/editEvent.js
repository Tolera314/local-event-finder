function searchEvent() {
    const searchTerm = document.getElementById('searchInput').value.trim();
    console.log("Searching for event: '" + searchTerm + "'"); // Log the search term
    fetch('SearchEventServlet?name=' + encodeURIComponent(searchTerm))
        .then(response => response.json())
        .then(events => {
            console.log("Response from server:", events); // Log server response
            if (events.length > 0) {
                const event = events[0]; // Assuming the first match
                document.getElementById('editForm').style.display = 'block'; // Ensure this element exists
                document.getElementById('eventId').value = event.id; // Hidden input for event ID
                document.getElementById('eventName').value = event.name;
                document.getElementById('regularPrice').value = event.regularPrice;
                document.getElementById('vipPrice').value = event.vipPrice;
                document.getElementById('location').value = event.location;
                document.getElementById('datetime').value = event.eventDate; // Make sure this matches your input's expectations
                const imagePreview = document.getElementById('imagePreview');
                if (imagePreview) {
                    imagePreview.src = 'data:image/jpeg;base64,' + event.image; // Set Base64 image
                } else {
                    console.error("Image preview element not found.");
                }
            } else {
                alert('Event not found!');
            }
        })
        .catch(error => console.error('Error:', error));
}

// Preview Uploaded Image
function previewImage(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('imagePreview').src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
}

// Update Event
function updateEvent(event) {
    event.preventDefault();
    const formData = new FormData();
    formData.append('id', document.getElementById('eventId').value);
    formData.append('name', document.getElementById('eventName').value);
    formData.append('regularPrice', document.getElementById('regularPrice').value);
    formData.append('vipPrice', document.getElementById('vipPrice').value);
    formData.append('location', document.getElementById('location').value);
    formData.append('datetime', document.getElementById('datetime').value);
    formData.append('image', document.getElementById('imagePreview').src);

    fetch('UpdateEventServlet', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(response => {
        if (response === 'success') {
            alert('Event updated successfully!');
            document.getElementById('successMessage').style.display = 'block';
        } else {
            alert('Failed to update event.');
        }
    })
    .catch(error => console.error('Error:', error));
}