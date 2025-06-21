<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SignIn&SignUp</title>
    <<link rel="stylesheet" href="css/signinsignup.css"/>/>
    <script
      src="https://kit.fontawesome.com/64d58efce2.js"
      crossorigin="anonymous"
    ></script>
  
  </head>
  <body>
    <div class="container">
      <div class="forms-container">
        <div class="signin-signup">
          <form action="UserAuth" class="sign-in-form" method="post">
    <h2 class="title">Sign In</h2>
    <div class="input-field">
        <i class="fas fa-user"></i>
        <input type="text" name="email" placeholder="Email" required />
    </div>
    <div class="input-field">
        <i class="fas fa-lock"></i>
        <input type="password" name="password"placeholder="password" required minlength="6">
                   
    </div>
    <input type="hidden" name="action" value="signin" />
    <input type="submit" value="Login" class="btn solid" />
          </form>


          <form action="UserAuth" class="sign-up-form" method="post">
    <h2 class="title">Sign Up</h2>
    <div class="input-field">
        <i class="fas fa-user"></i>
        <input type="text" name="fullname" placeholder="Fullname" required />
    </div>
    <div class="input-field">
        <i class="fas fa-envelope"></i>
        <input type="email" name="email" placeholder="Email" required />
    </div>
    <div class="input-field">
        <i class="fas fa-lock"></i>
       <input type="password" name="password" placeholder="password" required minlength="6">
    </div>
    <input type="hidden" name="action" value="signup" />
    <input type="submit" value="Sign Up" class="btn solid" />   
          </form>
        </div>
      </div>
      <div class="panels-container">

        <div class="panel left-panel">
            <div class="content">
                <h3>Welcome Back</h3>
                <p>Your Local Adventure Awaits - log in now. Rediscover What is Happening Nearby.</p>
                <button class="btn transparent" id="sign-up-btn">Sign Up</button>
            </div>
            <img src="./img/log.svg" class="image" alt="">
        </div>

        <div class="panel right-panel">
            <div class="content">
                <h3>Create Account</h3>
                <p>Don't Miss Out - Signup for Local Buzz!. Be Part Of Our Action! Join Us Today.</p>
                <button class="btn transparent" id="sign-in-btn">Sign In</button>
            </div>
        </div>
      </div>
    </div>

    <script>
const sign_in_btn = document.querySelector("#sign-in-btn");
const sign_up_btn = document.querySelector("#sign-up-btn");
const container = document.querySelector(".container");

sign_up_btn.addEventListener('click', () =>{
    container.classList.add("sign-up-mode");
});

sign_in_btn.addEventListener('click', () =>{
    container.classList.remove("sign-up-mode");
});
    </script>
  </body>
</html>
