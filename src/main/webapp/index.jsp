
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<%
if(session.getAttribute("current_user")!=null){
	response.sendRedirect("manufacturer/products.jsp");
}
%>


<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>🛡️ AuthentiTrack Login</title>
    <style>
    * {
  box-sizing: border-box;
}
    
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background: white;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        h2 {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            width: 100%;
            padding: 0.75rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .note {
            text-align: center;
            font-size: 0.8rem;
            color: #666;
            margin-top: 1rem;
        }
    </style>
</head>

<body>
    <div class="login-container">
        <h2>🛡️ AuthentiTrack</h2>
        <form id="loginForm" action="#" method="POST">
            <input type="text" id="username" placeholder="Manufacturer ID" required />
            <input type="password" id="password" placeholder="Password" required />
            <button type="submit">Login</button>
        </form>
        <div class="note">Only authorized manufacturers can access this system.</div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
document.getElementById('loginForm').addEventListener('submit', function(e) {
  e.preventDefault(); // prevent default form submission

  var username = document.getElementById('username').value.trim();
  var password = document.getElementById('password').value.trim();

  if (!username || !password) {
    Swal.fire({
      icon: 'warning',
      title: 'Missing Fields',
      text: 'Please enter both Manufacturer ID and Password.'
    });
    return;
  }

  // Send login request
  fetch('LoginController', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({ username, password })
  })
  .then(response => response.text())
  .then(data => {
    if (data === 'OK') {
      Swal.fire({
        icon: 'success',
        title: 'Login Successful',
        text: 'Welcome, manufacturer!',
        timer: 2000,
        showConfirmButton: false
      }).then(() => {
        window.location.href = 'manufacturer/products.jsp'; // redirect after login
      });
    } else {
      Swal.fire({
        icon: 'error',
        title: 'Login Failed',
        text: 'Invalid Manufacturer ID or Password.'
      });
    }
  })
  .catch(error => {
    Swal.fire({
      icon: 'error',
      title: 'Server Error',
      text: 'Something went wrong. Please try again later.'
    });
    console.error('Login error:', error);
  });
});
</script>
    
</body>

</html>