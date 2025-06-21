 document.addEventListener('DOMContentLoaded', function () {
            const modal = document.getElementById('eventModal');
            const modalContent = document.getElementById('modalContent');
            const closeModal = document.getElementsByClassName('close-modal')[0];

            closeModal.onclick = () => {
                modal.style.display = "none";
            };

            window.onclick = (event) => {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            };
// Function to proceed to payment page
function proceedToPayment(eventName, priceType, price) {
    // Send event details to session via AJAX
    fetch('/WebApplication2/FetchEventsServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ eventName, priceType, price }) // Send event details as JSON
    })
    .then(response => {
        if (response.ok) {
            // Redirect to payment page with the event details
            const queryParams = new URLSearchParams({
                eventName: eventName,
                priceType: priceType,
                price: price
            }).toString();
            window.location.href = `payment.jsp?${queryParams}`;
        } else {
            console.error('Failed to store event details.');
        }
    })
    .catch(err => console.error('Error:', err));
}

            // Function to display event details in modal
            function showEventDetails(event) {
                modalContent.innerHTML = `
                    <h2>${event.name}</h2>
                    <img src="${event.image}" alt="${event.name}" style="width: 100%; height: 300px; object-fit: cover; border-radius: 8px; margin: 20px 0;">
                    <div style="margin: 10px 0;">
                        <p><strong>Regular Price:</strong> ${event.regularPrice}</p>
                        <p><strong>VIP Price:</strong> ${event.vipPrice}</p>
                        <p><strong>Location:</strong> ${event.location}</p>
                        <p><strong>Date:</strong> ${new Date(event.date).toLocaleDateString()}</p>
                    </div>
                    <div style="display: flex; gap: 10px; margin-top: 20px;">
                        <button 
                            style="background: #4caf50; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;" 
                            data-event-name="${event.name}" 
                            data-price-type="regular" 
                            data-price="${event.regularPrice}" 
                            class="buy-regular-btn">
                            Buy Regular Ticket
                        </button>
                        <button 
                            style="background: #9b87f5; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer;" 
                            data-event-name="${event.name}" 
                            data-price-type="vip" 
                            data-price="${event.vipPrice}" 
                            class="buy-vip-btn">
                            Buy VIP Ticket
                        </button>
                    </div>
                `;

                // Attach event listeners for the buttons
                document.querySelector('.buy-regular-btn').addEventListener('click', function (e) {
                    const name = e.target.getAttribute('data-event-name');
                    const type = e.target.getAttribute('data-price-type');
                    const price = e.target.getAttribute('data-price');
                    proceedToPayment(name, type, price);
                });

                document.querySelector('.buy-vip-btn').addEventListener('click', function (e) {
                    const name = e.target.getAttribute('data-event-name');
                    const type = e.target.getAttribute('data-price-type');
                    const price = e.target.getAttribute('data-price');
                    proceedToPayment(name, type, price);
                });

                modal.style.display = "block";
            }

            function createEventCard(event) {
                const card = document.createElement('div');
                card.className = 'event-card';
                card.setAttribute('data-event-name', event.name); // Use the event name as a unique identifier
                card.innerHTML = `
                    <img src="${event.image}" alt="${event.name}" class="event-image">
                    <div class="event-details">
                        <h3>${event.name}</h3>
                        <p><strong>Date:</strong> ${new Date(event.date).toLocaleDateString()}</p>
                        <p><strong>Location:</strong> ${event.location}</p>
                    </div>
                `;
                card.addEventListener('click', () => showEventDetails(event));
                return card;
            }

            const eventsGrid = document.querySelector('.events-grid');
            const displayedEventNames = new Set(); // Track displayed event names

            function fetchEvents() {
                fetch('/WebApplication2/FetchEventsServlet')
                    .then(response => response.json())
                    .then(events => {
                        events.forEach(event => {
                            if (!displayedEventNames.has(event.name)) { // Check if the event is already displayed
                                eventsGrid.appendChild(createEventCard(event));
                                displayedEventNames.add(event.name); // Mark event as displayed
                            }
                        });
                    })
                    .catch(error => {
                        console.error("Error fetching events:", error);
                    });
            }

            // Initial fetch of events
            fetchEvents();

            // Fetch new events every 2 seconds
            setInterval(fetchEvents, 2000);
        });