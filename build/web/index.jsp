<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In / Sign Up</title>
    <style>

body {
margin: 0;
overflow: hidden; /* Prevent scrolling */
font-family: Arial, sans-serif;
}

.video-background {
position: fixed;
top: 0;
left: 0;
width: 100%;
height: 100%;
object-fit: cover;
z-index: -1; /* Behind other elements */
}

.container {
display: flex;
flex-direction: column;
justify-content: center;
align-items: center;
height: 100vh;
background-color: rgba(0, 0, 0, 0.5);
padding: 40px;
border-radius: 10px;
text-align: center;
color: white;
}

h1 {
font-size: 3em; /* Larger font size */
margin-bottom: 10px; /* Space below heading */
font-weight: bold; /* Bold text */
}

p {
font-size: 2em; /* Increased font size for paragraph */
margin-bottom: 20px; /* Space below paragraph */
font-weight: bold; /* Bold text */
width: 80%; /* Width for paragraph */
}

.button1 {
background-color: #6c63ff; /* Button color */
color: white; /* White text color */
padding: 12px 24px; /* Increased padding */
border: none;
border-radius: 5px;
cursor: pointer;
font-size: 18px; /* Increased font size */
transition: background-color 0.3s; /* Smooth transition */
margin-top: 15px; /* Space above button */
}

 .button1:hover {
background-color: #575757; /* Darker background on hover */
}

a {
    text-decoration: none;
}
</style>
</head>
<body>
    <video class="video-background" autoplay loop muted>
        <source src="images/background.mp4" type="video/mp4">
    </video>
    <div class="container" id="welcomeContainer">
        <h1>Welcome</h1>
        <p>Sign in to get started</p>
        <a class="button1" href="signinsignup.jsp">Get Started</a>
    </div>
</body>
</html>