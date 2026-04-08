<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String loggedUsername = (String) session.getAttribute("username");
    String loggedEmail    = (String) session.getAttribute("userEmail");
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
  <title>EasyWatch – Simple, Just Play</title>
  <meta name="description" content="EasyWatch is your go-to destination for movies and TV shows. Simple, fast, and always free.">
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
        <input type="text" id="searchInput" autocomplete="off" placeholder="Search movies and shows…">
      </div>
      <a href="listaFilme.jsp" class="nav-link">Movies</a>
      <a href="aboutUs.jsp"   class="nav-link">About</a>
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

  <!-- ===== HERO ===== -->
  <main>
    <section class="hero">
      <div class="hero-badge">🎬 New titles every week</div>
      <h1>Unlimited Movies<br>&amp; TV Shows</h1>
      <p>Stream the latest blockbusters, timeless classics, and exclusive originals — all in one place.</p>
      <div class="hero-actions">
        <% if (isLoggedIn) { %>
          <a href="listaFilme.jsp" class="btn-hero btn-hero-primary">Browse Movies</a>
          <a href="aboutUs.jsp"   class="btn-hero btn-hero-secondary">About Us</a>
        <% } else { %>
          <a href="register.jsp" class="btn-hero btn-hero-primary">Get Started Free</a>
          <a href="login.jsp"    class="btn-hero btn-hero-secondary">Sign In</a>
        <% } %>
      </div>
    </section>

    <!-- Features strip -->
    <div class="features-strip">
      <div class="feature-item">
        <div class="feature-icon">🎬</div>
        <div class="feature-title">Huge Catalogue</div>
        <div class="feature-desc">Thousands of titles across every genre</div>
      </div>
      <div class="feature-item">
        <div class="feature-icon">⚡</div>
        <div class="feature-title">Fast &amp; Simple</div>
        <div class="feature-desc">No ads, no fuss. Just click and watch</div>
      </div>
      <div class="feature-item">
        <div class="feature-icon">🔒</div>
        <div class="feature-title">Secure Accounts</div>
        <div class="feature-desc">Your data is always safe with us</div>
      </div>
      <div class="feature-item">
        <div class="feature-icon">💸</div>
        <div class="feature-title">Free Forever</div>
        <div class="feature-desc">No credit card, no subscription needed</div>
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