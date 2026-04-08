<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create Account – EasyWatch</title>
  <meta name="description" content="Create a free EasyWatch account and start watching movies and TV shows instantly.">
  <link rel="stylesheet" href="css/styles.css?v=2">
</head>
<body class="auth-page">

  <div class="auth-card">

    <!-- Logo -->
    <div class="auth-logo">EasyWatch</div>
    <div class="auth-title">Create your account</div>
    <div class="auth-subtitle">Join thousands of movie lovers. Free forever.</div>

    <!-- Error banner -->
    <% String err = (String) request.getAttribute("errorMsg"); %>
    <% if (err != null && !err.isEmpty()) { %>
      <div class="alert alert-error" role="alert">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
          <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
          <path d="M7.002 11a1 1 0 1 1 2 0 1 1 0 0 1-2 0zM7.1 4.995a.905.905 0 1 1 1.8 0l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 4.995z"/>
        </svg>
        <%= err %>
      </div>
    <% } %>

    <!-- Registration form -->
    <form id="registerForm" action="RegisterServlet" method="post" novalidate>

      <div class="form-group">
        <label class="form-label" for="txtUsername">Username</label>
        <input
          id="txtUsername"
          class="form-input"
          type="text"
          name="txtUsername"
          placeholder="Choose a username"
          autocomplete="username"
          required>
      </div>

      <div class="form-group">
        <label class="form-label" for="txtEmail">Email address</label>
        <input
          id="txtEmail"
          class="form-input"
          type="email"
          name="txtEmail"
          placeholder="you@example.com"
          autocomplete="email"
          required>
      </div>

      <div class="form-group">
        <label class="form-label" for="txtPwd">Password</label>
        <input
          id="txtPwd"
          class="form-input"
          type="password"
          name="txtPwd"
          placeholder="At least 6 characters"
          autocomplete="new-password"
          required>
      </div>

      <div class="form-group">
        <label class="form-label" for="txtPwd2">Confirm password</label>
        <input
          id="txtPwd2"
          class="form-input"
          type="password"
          name="txtPwd2"
          placeholder="Repeat your password"
          autocomplete="new-password"
          required>
      </div>

      <button id="registerBtn" type="submit" class="btn-auth">Create Account</button>
    </form>

    <div class="auth-divider">or</div>

    <div class="auth-switch" style="margin-top: 15px;">
      <a href="login.jsp" class="btn">Sign in to your account</a>
    </div>

  </div>

  <script>
    /* Client-side: confirm passwords match before submit */
    document.getElementById('registerForm').addEventListener('submit', function(e) {
      var p1 = document.getElementById('txtPwd').value;
      var p2 = document.getElementById('txtPwd2').value;
      if (p1 !== p2) {
        e.preventDefault();
        alert('Passwords do not match.');
      }
    });
  </script>

</body>
</html>
