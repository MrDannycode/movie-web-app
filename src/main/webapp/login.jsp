<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sign In – EasyWatch</title>
  <meta name="description" content="Sign in to your EasyWatch account and enjoy unlimited movies and TV shows.">
  <link rel="stylesheet" href="css/styles.css?v=2">
</head>
<body class="auth-page">

  <div class="auth-card">

    <!-- Logo -->
    <div class="auth-logo">EasyWatch</div>
    <div class="auth-title">Welcome back</div>
    <div class="auth-subtitle">Sign in to continue watching</div>

    <!-- Error banner (shown when servlet sets errorMsg attribute) -->
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

    <!-- Login form -->
    <form id="loginForm" action="LoginServlet" method="post" novalidate>

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
          placeholder="••••••••"
          autocomplete="current-password"
          required>
      </div>

      <button id="loginBtn" type="submit" class="btn-auth">Sign In</button>
    </form>

    <div class="auth-divider">or</div>

    <div class="auth-switch" style="margin-top: 15px;">
      <a href="register.jsp" class="btn">Create an account — it's free</a>
    </div>

  </div>

</body>
</html>