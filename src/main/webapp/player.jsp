<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="selirMovieWeb.Film" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="selirMovieWeb.GestiuneFilme" %>
<%
    String loggedUsername = (String) session.getAttribute("username");
    boolean isLoggedIn    = (loggedUsername != null);
    String avatarLetter   = isLoggedIn && !loggedUsername.isEmpty()
                            ? String.valueOf(loggedUsername.charAt(0)).toUpperCase() : "U";
    String loggedRole     = (String) session.getAttribute("role");

    // Fetch film details
    String filmIdStr = request.getParameter("filmId");
    Film currentFilm = null;
    if (filmIdStr != null && !filmIdStr.isEmpty()) {
        try {
            int filmId = Integer.parseInt(filmIdStr);
            HashSet<Film> films = GestiuneFilme.getFilms();
            for (Film f : films) {
                if (f.getId() == filmId) {
                    currentFilm = f;
                    break;
                }
            }
        } catch (Exception e) {
            // Ignore parse errors or db errors
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><%= currentFilm != null ? currentFilm.getDenumire() + " – EasyWatch" : "Watch Now – EasyWatch" %></title>
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

  <main style="padding: 20px;">
    <% if (currentFilm != null) { %>
    <!-- Back to movies -->
    <div style="max-width: 1000px; width: 100%; margin: 0 auto; text-align: left; margin-bottom: 20px;">
      <a href="listaFilme.jsp" class="btn btn-outline" style="padding: 8px 16px;">&larr; Back to Movies</a>
    </div>

    <!-- Player Component -->
    <div class="player-container">
      <div class="video-wrapper">
        <!-- Using a placeholder open source video file: Big Buck Bunny -->
        <video controls poster="https://picsum.photos/seed/<%= currentFilm.getId() %>/1280/720?blur=5">
          <source src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" type="video/mp4">
          Your browser does not support the video tag.
        </video>
      </div>
      <div class="player-info">
        <div class="player-header">
          <h1 class="player-title"><%= currentFilm.getDenumire() %></h1>
        </div>
        <div class="player-meta">
          <span><%= currentFilm.getAnAparitie() %></span>
          <span><%= currentFilm.getDurata() %> min</span>
          <span style="background: var(--accent); color: white;">HD</span>
        </div>
      </div>
    </div>
    <% } else { %>
      <div class="auth-card" style="margin-top: 100px;">
        <h2>Movie Not Found</h2>
        <p>We couldn't find the requested movie.</p>
        <a href="listaFilme.jsp" class="btn btn-primary" style="margin-top: 20px;">Browse Movies</a>
      </div>
    <% } %>
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
