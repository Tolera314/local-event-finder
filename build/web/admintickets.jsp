<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Ticket Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/adminhome.css"> 
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
            min-height: 100vh;
            padding: 2rem;
        }
        h1 {
            color: #fff;
            margin-bottom: 2rem;
            font-size: 2rem;
            text-align: center;
            animation: fadeIn 1s ease-out;
            margin-top: 6rem;
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        th {
            background: rgba(155, 135, 245, 0.2);
            font-weight: 600;
            color: #9b87f5;
        }
        tr:hover {
            background: rgba(155, 135, 245, 0.1);
            transition: background 0.3s ease;
        }
        button {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            background: #9b87f5;
            color: white;
        }
        button:hover {
            background: #7E69AB;
            transform: translateY(-1px);
        }
        button:disabled {
            background: #4CAF50;
            cursor: not-allowed;
            transform: none;
        }
        @media (max-width: 768px) {
            body {
                padding: 1rem;
            }
            table {
                font-size: 0.9rem;
            }
            th, td {
                padding: 0.75rem;
            }
            button {
                padding: 0.4rem 0.8rem;
            }
        }
    </style>
     <script>
function fetchTickets() {
            fetch('/WebApplication2/FetchTicketsServlet') // Ensure URL is correct
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(tickets => {
                    console.log(tickets); // Log the fetched data
                    const ticketTable = document.getElementById('ticketTable');
                    ticketTable.innerHTML = ""; // Clear previous entries
                    tickets.forEach(ticket => {
                        console.log(`Ticket Number: ${ticket.ticketNumber}, Full Name: ${ticket.fullname}`); // Log each ticket
                        const row = document.createElement('tr');
                        row.innerHTML = `
                            <td>${ticket.ticketNumber}</td>
                            <td>${ticket.fullname}</td>
                            <td>
                                <button onclick="approveTicket(this)">Pending</button>
                            </td>
                        `;
                        ticketTable.appendChild(row);
                    });
                })
                .catch(err => console.error('Fetch error:', err));
        }

        function approveTicket(button) {
            button.textContent = "Approved"; // Change button text to "Approved"
            button.disabled = true; // Optionally disable the button after clicking
        }

        document.addEventListener('DOMContentLoaded', (event) => {
            fetchTickets(); // Fetch tickets when the DOM is fully loaded
        });
    

        function approveTicket(button) {
            button.textContent = "Approved"; // Change button text to "Approved"
            button.disabled = true; // Optionally disable the button after clicking
        }

        document.addEventListener('DOMContentLoaded', (event) => {
            fetchTickets(); // Fetch tickets when the DOM is fully loaded
        });
    </script>
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
    <h1>Admin Ticket Management</h1>
    <table>
        <thead>
            <tr>
                <th>Ticket Number</th>
                <th>Full Name</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody id="ticketTable">
            <!-- Dynamic ticket rows will be inserted here -->
        </tbody>
    </table>
    <script src="js/adminhome.js"></script>
</body>
</html>