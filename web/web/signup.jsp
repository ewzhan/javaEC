<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Signup</title>
  <link rel="stylesheet" href="css/loginStyle.css">
</head>
<body>
  <div class="wrapper" style="border-radius: 20px;margin: 5vh auto;height: 90vh;">
    <h1>Signup</h1>
    <p id="error-message" style="color: red;">
  <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
</p><p id="confirm-message" style="color: green;">
  <%= request.getAttribute("confirmMessage") != null ? request.getAttribute("confirmMessage") : "" %>
</p>

<form id="form" method="post" action="signup">
    <input type="hidden" name="formType" value="signup">
    <input type="hidden" name="confirm" value="<%= request.getAttribute("confirming") != null ? "yes" : "no" %>">
      <div>
        <label for="email-input">
          <span>@</span>
        </label>
          <input type="text" name="email" id="email-input" placeholder="Email" value="<%= session.getAttribute("email") != null ? session.getAttribute("email") : "" %>">
      </div>

      <div>
        <label for="password-input">
          <svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 -960 960 960" width="24"><path d="M240-80q-33 0-56.5-23.5T160-160v-400q0-33 23.5-56.5T240-640h40v-80q0-83 58.5-141.5T480-920q83 0 141.5 58.5T680-720v80h40q33 0 56.5 23.5T800-560v400q0 33-23.5 56.5T720-80H240Zm240-200q33 0 56.5-23.5T560-360q0-33-23.5-56.5T480-440q-33 0-56.5 23.5T400-360q0 33 23.5 56.5T480-280ZM360-640h240v-80q0-50-35-85t-85-35q-50 0-85 35t-35 85v80Z"/></svg>
        </label>
          <input type="password" name="password" id="password-input" placeholder="Password" value="<%= session.getAttribute("password") != null ? session.getAttribute("password") : "" %>">
      </div>
      <div>
        <label for="repeat-password-input">
          <svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 -960 960 960" width="24"><path d="M240-80q-33 0-56.5-23.5T160-160v-400q0-33 23.5-56.5T240-640h40v-80q0-83 58.5-141.5T480-920q83 0 141.5 58.5T680-720v80h40q33 0 56.5 23.5T800-560v400q0 33-23.5 56.5T720-80H240Zm240-200q33 0 56.5-23.5T560-360q0-33-23.5-56.5T480-440q-33 0-56.5 23.5T400-360q0 33 23.5 56.5T480-280ZM360-640h240v-80q0-50-35-85t-85-35q-50 0-85 35t-35 85v80Z"/></svg>
        </label>
        <input type="password" name="repeat-password" id="repeat-password-input" placeholder="Repeat Password">
      </div>
      
      <button type="submit">Sign up</button>
    </form>

    <p>Already have an Account? <a href="login.jsp">Login</a> </p>
    <br>
    <p><a href="home.html">back to home</a></p>
  </div>
</body>
</html>