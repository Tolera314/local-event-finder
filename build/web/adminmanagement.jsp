<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/adminmanagement.css"/>
    <link rel="stylesheet" href="css/adminhome.css"> 
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
    <div class="container">
                <% 
            String message = (String) request.getAttribute("message");
            String messageType = (String) request.getAttribute("messageType");
            if (message != null && messageType != null) {
        %>
            <div class="message <%= messageType %>">
                <%= message %>
            </div>
        <% } %>
        <!-- Add Admin Section -->
        <div class="section">
            <h2 style="margin-bottom: 1.5rem;">Add New Admin</h2>
            <form id="addAdminForm" action="AdminManagementServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="addAdmin">
                
                <div class="form-group">
                    <label>Profile Image</label>
                    <input type="file" name="profileImage" accept="image/*" required onchange="previewImage(event)">
                    <img id="profilePreview" src="https://via.placeholder.com/150" alt="Profile preview" class="profile-preview">
                </div>

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="fullName" required>
                </div>

                <div class="form-group">
                    <label>Age</label>
                    <input type="number" name="age" required min="18" max="100">
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <input type="text" name="address" required>
                </div>

                <div class="form-group">
                    <label>Identity Number</label>
                    <input type="text" name="identityNumber" required pattern="[A-Za-z0-9+]+" >
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" required>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required minlength="8" oninput="checkPasswordStrength(this.value)">
                    <div class="password-strength">
                        <div class="password-strength-bar" id="strengthBar"></div>
                    </div>
                    <div class="password-requirements">
                        Password must be at least 8 characters long and contain uppercase, lowercase, numbers, and special characters
                    </div>
                </div>

                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="tel" name="phoneNumber" required pattern="[A-Za-z0-9+]+" title="Please enter numbers only">
                </div>

                <div class="form-group">
                    <label>House Number</label>
                    <input type="text" name="houseNumber" required>
                </div>

                <button type="submit">Add Admin</button>
            </form>
        </div>
        <!-- Delete Admin Section -->
        <div class="section">
            <h2 style="margin-bottom: 1.5rem;">Delete Admin</h2>
            <form id="deleteAdminForm" action="AdminManagementServlet" method="post">
                <input type="hidden" name="action" value="deleteAdmin">
                
                <div class="form-group">
                    <label>Admin Email</label>
                    <input type="email" name="email" required placeholder="Enter admin email...">
                </div>

                <button type="submit">Delete Admin</button>
            </form>
        </div>
    </div>

    <script>
        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profilePreview').src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        }

        function checkPasswordStrength(password) {
            const strengthBar = document.getElementById('strengthBar');
            let strength = 0;

            if (password.length >= 8) strength += 25;
            if (password.match(/[A-Z]/)) strength += 25;
            if (password.match(/[a-z]/)) strength += 25;
            if (password.match(/[0-9]/) && password.match(/[^A-Za-z0-9]/)) strength += 25;

            strengthBar.style.width = strength + '%';

            if (strength < 50) {
                strengthBar.style.background = '#dc3545';
            } else if (strength < 75) {
                strengthBar.style.background = '#ffc107';
            } else {
                strengthBar.style.background = '#28a745';
            }
        }
    </script>
    <script src="js/adminhome.js"></script>
</body>
</html>
