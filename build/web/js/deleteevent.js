        // Function to search the event by name using AJAX
        function searchEvent() {
            const searchInput = document.getElementById('searchInput').value.trim();

            if (searchInput === "") {
                alert("Please enter an event name to search.");
                return;
            }

            const xhr = new XMLHttpRequest();
            xhr.open("POST", "DeleteEventServlet?action=searchEvent", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onload = function () {
                if (this.status === 200) {
                    const event = JSON.parse(this.responseText);

                    if (event.error) {
                        alert(event.error);
                        document.getElementById('eventDetails').classList.remove('active');
                    } else {
                        // Populate event details
                        document.getElementById('eventDetails').classList.add('active');
                        document.getElementById('eventImage').src = 'data:image/jpeg;base64,' + event.image;
                        document.getElementById('eventName').textContent = event.name;
                        document.getElementById('regularPrice').textContent = event.regular_price;
                        document.getElementById('vipPrice').textContent = event.vip_price;
                        document.getElementById('location').textContent = event.location;
                        document.getElementById('datetime').textContent = event.event_date;
                        document.getElementById('deleteBtn').setAttribute('data-id', event.id);
                    }
                }
            };

            xhr.send("name=" + encodeURIComponent(searchInput));
        }

        // Function to delete the event by ID using AJAX
        function deleteEvent() {
            const eventId = document.getElementById('deleteBtn').getAttribute('data-id');

            if (!eventId) {
                alert("No event selected for deletion.");
                return;
            }

            const xhr = new XMLHttpRequest();
            xhr.open("POST", "DeleteEventServlet?action=deleteEvent", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            xhr.onload = function () {
                if (this.status === 200) {
                    const response = JSON.parse(this.responseText);

                    if (response.success) {
                        alert(response.success);

                        // Clear details and hide section
                        document.getElementById('eventDetails').classList.remove('active');
                        document.getElementById('searchInput').value = '';
                    } else {
                        alert(response.error);
                    }
                }
            };

            xhr.send("id=" + encodeURIComponent(eventId));
        }