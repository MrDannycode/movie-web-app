<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String loggedUsername = (String) session.getAttribute("username");
    boolean isLoggedIn    = (loggedUsername != null);
    String avatarLetter   = isLoggedIn && !loggedUsername.isEmpty()
                            ? String.valueOf(loggedUsername.charAt(0)).toUpperCase() : "U";

    String loggedRole     = (String) session.getAttribute("role");
    boolean isAdmin       = "SuperAdmin".equals(loggedRole) || "MovieAdmin".equals(loggedRole);
    if (!isAdmin) {
        response.sendRedirect("listaFilme.jsp");
        return;
    }

    /* Flash message from previous action */
    String msg = null;
    try { msg = session.getAttribute("msg").toString(); session.removeAttribute("msg"); } catch (Exception ex) {}
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Movie – EasyWatch</title>
  <meta name="description" content="Add a new movie to the EasyWatch catalogue.">
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

  <!-- ===== ADD MOVIE FORM ===== -->
  <div class="auth-page">
    <div class="auth-card" style="max-width:500px;">

      <div class="auth-logo">EasyWatch</div>
      <div class="auth-title">Add New Movie</div>
      <div class="auth-subtitle">Fill in the details below to add a film to the catalogue.</div>

      <!-- Flash message -->
      <% if (msg != null && !msg.isEmpty()) { %>
        <div class="alert alert-success" role="alert">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
          </svg>
          <%= msg %>
        </div>
      <% } %>

      <form id="addMovieForm" action="MovieManageServlet" method="post" novalidate>
        <input type="hidden" name="action" value="add">

        <div class="form-group">
          <label class="form-label" for="denumire">Movie Title</label>
          <input id="denumire" class="form-input" type="text" name="denumire"
                 placeholder="e.g. Inception" required>
        </div>

        <div class="form-group">
          <label class="form-label" for="durata">Duration (minutes)</label>
          <input id="durata" class="form-input" type="number" name="durata"
                 placeholder="e.g. 148" required>
        </div>

        <div class="form-group">
          <label class="form-label" for="anAparitie">Release Year</label>
          <input id="anAparitie" class="form-input" type="number" name="anAparitie"
                 placeholder="e.g. 2010" min="1888" max="2099" required>
        </div>

        <div class="form-group">
          <label class="form-label" for="imagine">Image Filename</label>
          <input id="imagine" class="form-input" type="text" name="imagine"
                 placeholder="e.g. inception.jpg">
        </div>

        <button id="addMovieBtn" type="submit" class="btn-auth">Add Movie</button>
      </form>

      <div class="auth-divider">or</div>

      <div class="auth-switch">
        <a href="listaFilme.jsp">← Back to movie list</a>
      </div>

    </div>
  </div>

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