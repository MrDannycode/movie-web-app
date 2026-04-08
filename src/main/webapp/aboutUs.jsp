<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String loggedUsername = (String) session.getAttribute("username");
    boolean isLoggedIn    = (loggedUsername != null);
    String avatarLetter   = isLoggedIn && !loggedUsername.isEmpty()
                            ? String.valueOf(loggedUsername.charAt(0)).toUpperCase() : "U";
    String loggedRole     = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>About Us – EasyWatch</title>
  <meta name="description" content="Learn more about EasyWatch — the simple, fast movie streaming platform built for film lovers.">
  <link rel="stylesheet" href="css/styles.css?v=2">
</head>
<body>

  <!-- ===== HEADER ===== -->
  <header>
    <a href="index.jsp" class="logo">EasyWatch</a>

    <nav class="main-nav">
      <div class="search-wrapper">
        <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" viewBox="0 0 16 16">
          <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398l3.85 3.85a1 1 0 0 0 1.415-1.415l-3.868-3.833zm-5.242 1.15a5.5 5.5 0 1 1 0-11 5.5 5.5 0 0 1 0 11z"/>
        </svg>
        <input type="text" autocomplete="off" placeholder="Search movies and shows…">
      </div>
      <a href="listaFilme.jsp" class="nav-link">Movies</a>
      <a href="aboutUs.jsp"   class="nav-link active-link">About</a>
      <% if ("SuperAdmin".equals(loggedRole)) { %>
      <a href="UserManageServlet" class="nav-link">Manage Users</a>
      <% } %>
    </nav>

    <div class="header-actions">
      <% if (isLoggedIn) { %>
        <div class="user-chip">
          <div class="user-avatar"><%= avatarLetter %></div>
          <span><%= loggedUsername %></span>
          <a class="logout-link" href="LogoutServlet">Logout</a>
        </div>
      <% } else { %>
        <a href="login.jsp"    class="btn btn-outline" id="headerSignIn">Sign In</a>
        <a href="register.jsp" class="btn btn-primary" id="headerSignUp">Sign Up</a>
      <% } %>
    </div>
  </header>

  <!-- ===== PAGE CONTENT ===== -->
  <main class="page-main">

    <!-- Page hero -->
    <div class="page-hero">
      <div class="page-hero-inner">
        <span class="hero-badge">👋 Our Story</span>
        <h1>About EasyWatch</h1>
        <p>We're on a mission to make discovering and watching great films as effortless as possible.</p>
      </div>
    </div>

    <!-- Info cards -->
    <section class="about-section">

      <div class="about-card">
        <div class="about-card-icon">🎯</div>
        <h2>Our Mission</h2>
        <p>
          EasyWatch was built for people who love movies but hate complicated interfaces.
          We keep things simple — browse, click, watch. No subscriptions, no hidden fees.
        </p>
      </div>

      <div class="about-card">
        <div class="about-card-icon">🛠️</div>
        <h2>How It Works</h2>
        <p>
          Our catalogue is curated and updated every week with new titles across every genre.
          Create a free account to get personalised recommendations and manage your watchlist.
        </p>
      </div>

      <div class="about-card">
        <div class="about-card-icon">📬</div>
        <h2>Get In Touch</h2>
        <p>
          We love feedback and suggestions — they make EasyWatch better for everyone.
          Drop us a line anytime at
          <a href="mailto:MW@abcd.ef" style="color:var(--accent);font-weight:600;">MW@abcd.ef</a>
          and we'll get back to you within 24 hours.
        </p>
      </div>

    </section>

    <!-- CTA -->
    <div class="about-cta">
      <h2>Ready to start watching?</h2>
      <p>Join thousands of movie lovers on EasyWatch — it's completely free.</p>
      <div class="hero-actions" style="margin-top:24px;">
        <% if (isLoggedIn) { %>
          <a href="listaFilme.jsp" class="btn-hero btn-hero-primary">Browse Movies</a>
        <% } else { %>
          <a href="register.jsp" class="btn-hero btn-hero-primary">Get Started Free</a>
          <a href="login.jsp"    class="btn-hero btn-hero-secondary">Sign In</a>
        <% } %>
      </div>
    </div>

  </main>

  <!-- ===== FOOTER ===== -->
  <footer>
    <span class="footer-logo">EasyWatch</span>
    <span class="footer-copy">© 2026 EasyWatch. All rights reserved.</span>
    <div class="footer-links">
      <a href="aboutUs.jsp">About</a>
      <a href="#">Privacy</a>
      <a href="#">Terms</a>
    </div>
  </footer>

</body>
</html>