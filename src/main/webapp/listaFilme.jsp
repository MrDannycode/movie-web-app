<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="selirMovieWeb.Film" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="selirMovieWeb.GestiuneFilme" %>
<%
    String loggedUsername = (String) session.getAttribute("username");
    boolean isLoggedIn    = (loggedUsername != null);
    String avatarLetter   = isLoggedIn && !loggedUsername.isEmpty()
                            ? String.valueOf(loggedUsername.charAt(0)).toUpperCase() : "U";
    String loggedRole     = (String) session.getAttribute("role");
    boolean isAdmin       = "SuperAdmin".equals(loggedRole) || "MovieAdmin".equals(loggedRole);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Movies – EasyWatch</title>
  <meta name="description" content="Browse the full EasyWatch movie catalogue. Filter, sort, and find your next favourite film.">
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
        <input type="text" id="tableSearch" autocomplete="off" placeholder="Filter movies…">
      </div>
      <a href="listaFilme.jsp" class="nav-link active-link">Movies</a>
      <a href="aboutUs.jsp"   class="nav-link">About</a>
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

    <!-- Page title bar -->
    <div class="page-hero">
      <div class="page-hero-inner">
        <span class="hero-badge">🎬 Full Catalogue</span>
        <h1>Browse Movies</h1>
        <p>Explore our entire collection — sort by any column to find your next watch.</p>
        <% if (isAdmin) { %>
          <a href="addMoviepg.jsp" class="btn btn-primary" style="margin-top:8px;" id="addMovieBtn">+ Add Movie</a>
        <% } %>
      </div>
    </div>

    <!-- Movie table -->
    <section class="table-section">
      <div class="table-wrapper">
        <table class="movie-table" id="movieTable">
          <thead>
            <tr>
              <th class="col-id">#</th>
              <th class="col-title">Title</th>
              <th class="col-duration">Duration</th>
              <th class="col-year">Year</th>
              <% if (isAdmin) { %>
              <th class="col-actions">Actions</th>
              <% } %>
            </tr>
          </thead>
          <tbody id="movieTableBody">
            <%
              HashSet<Film> films = GestiuneFilme.getFilms();
              int rowIndex = 1;
              for (Film film : films) {
            %>
            <tr>
              <td class="col-id"><span class="row-num"><%= rowIndex++ %></span></td>
              <td class="col-title">
                <span class="film-title"><%= film.getDenumire() %></span>
              </td>
              <td class="col-duration">
                <span class="duration-pill"><%= film.getDurata() %> min</span>
              </td>
              <td class="col-year"><%= film.getAnAparitie() %></td>
              <% if (isAdmin) { %>
              <td class="col-actions">
                <div style="display: flex; gap: 8px;">
                  <form action="editMoviepg.jsp" method="get" style="margin: 0;">
                    <input type="hidden" name="filmId" value="<%= film.getId() %>">
                    <button type="submit" class="btn btn-outline" style="padding: 4px 8px; font-size: 12px;">Edit</button>
                  </form>
                  <form action="MovieManageServlet" method="post" onsubmit="return confirm('Delete movie?');" style="margin: 0;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="filmId" value="<%= film.getId() %>">
                    <button type="submit" class="btn btn-outline" style="padding: 4px 8px; font-size: 12px; color: #ff4d4d; border-color: #ff4d4d;">Delete</button>
                  </form>
                </div>
              </td>
              <% } %>
            </tr>
            <%
              }
            %>
          </tbody>
        </table>

        <div class="table-empty" id="tableEmpty" style="display:none;">
          <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" fill="currentColor" viewBox="0 0 16 16" style="color:var(--text-muted);margin-bottom:12px;">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398l3.85 3.85a1 1 0 0 0 1.415-1.415l-3.868-3.833zM2.5 6.5a4 4 0 1 1 8 0 4 4 0 0 1-8 0z"/>
          </svg>
          <p>No movies match your search.</p>
        </div>
      </div>
    </section>

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

  <script>
    /* Live filter */
    document.getElementById('tableSearch').addEventListener('input', function() {
      const q = this.value.toLowerCase();
      const rows = document.querySelectorAll('#movieTableBody tr');
      let visible = 0;
      rows.forEach(function(row) {
        const title = row.querySelector('.film-title');
        if (!title) return;
        const match = title.textContent.toLowerCase().includes(q);
        row.style.display = match ? '' : 'none';
        if (match) visible++;
      });
      document.getElementById('tableEmpty').style.display = visible === 0 ? 'flex' : 'none';
    });
  </script>

</body>
</html>