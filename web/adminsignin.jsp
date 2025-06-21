<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Sign In</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            background-image: 
                radial-gradient(circle at 10% 20%, rgba(155, 135, 245, 0.1) 0%, transparent 20%),
                radial-gradient(circle at 90% 80%, rgba(155, 135, 245, 0.1) 0%, transparent 20%);
        }

        .container {
            width: 100%;
            max-width: 1200px;
            padding: 2rem;
            display: flex;
            gap: 4rem;
            align-items: center;
        }

        .welcome-section {
            flex: 1;
            padding-right: 2rem;
        }

        .welcome-section h1 {
            font-size: 3rem;
            margin-bottom: 1.5rem;
            background: linear-gradient(45deg, #9b87f5, #7E69AB);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .welcome-section p {
            font-size: 1.1rem;
            color: rgba(255, 255, 255, 0.8);
            line-height: 1.6;
        }

        .login-section {
            flex: 1;
            max-width: 400px;
        }

        .login-box {
            background: rgba(255, 255, 255, 0.1);
            padding: 2rem;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            color: rgba(255, 255, 255, 0.8);
        }

        input {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.05);
            color: white;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        input:focus {
            outline: none;
            border-color: #9b87f5;
            box-shadow: 0 0 0 2px rgba(155, 135, 245, 0.2);
        }

        button {
            width: 100%;
            padding: 0.8rem 1rem;
            background: #9b87f5;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background: #7E69AB;
        }

        .error-message {
            background: #dc3545;
            color: white;
            padding: 1rem;
            border-radius: 8px;
            margin-top: 1rem;
            display: none;
        }

        .password-requirements {
            font-size: 0.8rem;
            color: rgba(255, 255, 255, 0.6);
            margin-top: 0.5rem;
        }

        .password-strength {
            height: 4px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 2px;
            margin-top: 0.5rem;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            background: #dc3545;
            transition: all 0.3s ease;
        }

        @media (max-width: 968px) {
            .container {
                flex-direction: column;
                gap: 2rem;
            }

            .welcome-section {
                text-align: center;
                padding-right: 0;
            }

            .login-section {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 1rem;
            }

            .container {
                padding: 1rem;
            }

            .welcome-section h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="welcome-section">
            <h1>Welcome Back!</h1>
            <p>Access your admin dashboard to manage events, handle requests, and keep your event management system running smoothly.</p>
        </div>

        <div class="login-section">
            <div class="login-box">
                <h2 style="margin-bottom: 1.5rem;">Admin Sign In</h2>
                <form onsubmit="handleLogin(event)">
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input 
                            type="email" 
                            id="email" 
                            required 
                            pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                            title="Please enter a valid email address"
                        >
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input 
                            type="password" 
                            id="password" 
                            required
                            minlength="8"
                            oninput="checkPasswordStrength(this.value)"
                        >
                        <div class="password-strength">
                            <div class="password-strength-bar" id="strengthBar"></div>
                        </div>
                        <div class="password-requirements">
                            Password must be at least 8 characters long and contain uppercase, lowercase, numbers, and special characters
                        </div>
                    </div>

                    <button type="submit">Sign In</button>
                </form>

                <div class="error-message" id="errorMessage">
                    Invalid email or password. Please try again.
                </div>
            </div>
        </div>
    </div>

    <script>
        function checkPasswordStrength(password) {
            const strengthBar = document.getElementById('strengthBar');
            let strength = 0;

            // Check length
            if (password.length >= 8) strength += 25;

            // Check for uppercase letters
            if (password.match(/[A-Z]/)) strength += 25;

            // Check for lowercase letters
            if (password.match(/[a-z]/)) strength += 25;

            // Check for numbers and special characters
            if (password.match(/[0-9]/) && password.match(/[^A-Za-z0-9]/)) strength += 25;

            strengthBar.style.width = strength + '%';

            // Update color based on strength
            if (strength < 50) {
                strengthBar.style.background = '#dc3545';
            } else if (strength < 75) {
                strengthBar.style.background = '#ffc107';
            } else {
                strengthBar.style.background = '#28a745';
            }
        }

        function handleLogin(event) {
            event.preventDefault();
            
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const errorMessage = document.getElementById('errorMessage');

            // Basic email validation
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailRegex.test(email)) {
                errorMessage.style.display = 'block';
                return;
            }

            // Password validation
            if (password.length < 8 || 
                !password.match(/[A-Z]/) || 
                !password.match(/[a-z]/) || 
                !password.match(/[0-9]/) || 
                !password.match(/[^A-Za-z0-9]/)) {
                errorMessage.style.display = 'block';
                return;
            }

            // In a real application, you would:
            // 1. Hash the password (never send plain text passwords)
            // 2. Send credentials to a secure backend
            // 3. Handle the authentication token response
            // 4. Store the token securely
            // 5. Redirect to the admin dashboard

            // For demo purposes, simulate successful login
            console.log('Login attempt:', { email });
            window.location.href = 'adminhome.jsp';
        }
    </script>
</body>
</html>
