<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page import="selirMovieWeb.Film" %>
    <%@ page import="java.util.HashSet" %>
      <%@ page import="selirMovieWeb.GestiuneFilme" %>
        <% String loggedUsername=(String) session.getAttribute("username"); String loggedEmail=(String)
          session.getAttribute("userEmail"); boolean isLoggedIn=(loggedUsername !=null); String avatarLetter=isLoggedIn
          && !loggedUsername.isEmpty() ? String.valueOf(loggedUsername.charAt(0)).toUpperCase() : "U" ; String
          loggedRole=(String) session.getAttribute("role"); %>
          <!DOCTYPE html>
          <html lang="en">

          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>EasyWatch – Simple, Just Play</title>
            <meta name="description"
              content="EasyWatch is your go-to destination for movies and TV shows. Simple, fast, and always free.">
            <link rel="stylesheet" href="css/styles.css?v=3">
          </head>

          <body>

            <!-- ===== HEADER ===== -->
            <header>
              <a href="index.jsp" class="logo">EasyWatch</a>

              <nav class="main-nav">
                <form action="listaFilme.jsp" method="get" class="search-wrapper">
                  <svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor"
                    viewBox="0 0 16 16">
                    <path
                      d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398l3.85 3.85a1 1 0 0 0 1.415-1.415l-3.868-3.833zm-5.242 1.15a5.5 5.5 0 1 1 0-11 5.5 5.5 0 0 1 0 11z" />
                  </svg>
                  <input type="text" name="search" id="searchInput" autocomplete="off"
                    placeholder="Search movies and shows…">
                </form>
                <a href="listaFilme.jsp" class="nav-link">Movies</a>
                <a href="aboutUs.jsp" class="nav-link">About</a>
                <% if ("SuperAdmin".equals(loggedRole)) { %>
                  <a href="UserManageServlet" class="nav-link">Manage Users</a>
                  <% } %>
              </nav>

              <div class="header-actions">
                <% if (isLoggedIn) { %>
                  <div class="user-chip">
                    <div class="user-avatar">
                      <%= avatarLetter %>
                    </div>
                    <span>
                      <%= loggedUsername %>
                    </span>
                    <a class="logout-link" href="LogoutServlet">Logout</a>
                  </div>
                  <% } else { %>
                    <a href="login.jsp" class="btn btn-outline" id="headerSignIn">Sign In</a>
                    <a href="register.jsp" class="btn btn-primary" id="headerSignUp">Sign Up</a>
                    <% } %>
              </div>
            </header>

            <!-- ===== HERO ===== -->
            <main>
              <section class="hero">
                <div class="hero-badge">🎬 New titles every week</div>
                <h1>Unlimited Movies &amp; TV Shows</h1>
                <p>Stream the latest blockbusters, timeless classics, and exclusive originals — all in one place.</p>
                <div class="hero-actions">
                  <% if (isLoggedIn) { %>
                    <a href="listaFilme.jsp" class="btn-hero btn-hero-primary">Browse Movies</a>
                    <a href="aboutUs.jsp" class="btn-hero btn-hero-secondary">About Us</a>
                    <% } else { %>
                      <a href="register.jsp" class="btn-hero btn-hero-primary">Get Started Free</a>
                      <a href="login.jsp" class="btn-hero btn-hero-secondary">Sign In</a>
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

              <!-- Featured Movies Grid -->
              <section style="margin-top: 60px; width: 100%; max-width: 1200px;">
                <h2 style="text-align: left; margin-bottom: 20px;">Featured Movies</h2>
                <div class="movie-grid">
                  <% try { HashSet<Film> films = GestiuneFilme.getFilms();
                    int count = 0;
                    for (Film film : films) {
                    if (count >= 5) break; // show up to 5 featured movies
                    %>
                    <div class="movie-card">
                      <div class="movie-poster-container">
                        <img src="images/<%= film.getImagine() != null ? film.getImagine() : " default.jpg" %>" alt="<%=
                          film.getDenumire() %> Poster" class="movie-poster" loading="lazy">
                          <a href="player.jsp?filmId=<%= film.getId() %>" class="movie-overlay">
                            <div class="play-button">
                              <svg viewBox="0 0 24 24">
                                <path d="M8 5v14l11-7z" />
                              </svg>
                            </div>
                          </a>
                      </div>
                      <div class="movie-info">
                        <div class="movie-title">
                          <%= film.getDenumire() %>
                        </div>
                        <div class="movie-meta">
                          <span>
                            <%= film.getAnAparitie() %>
                          </span>
                          <span>
                            <%= film.getDurata() %> min
                          </span>
                        </div>
                        <div class="movie-actions">
                          <a href="player.jsp?filmId=<%= film.getId() %>" class="btn btn-primary"
                            style="flex:1; padding: 6px; font-size: 0.9rem;">Watch Now</a>
                        </div>
                      </div>
                    </div>
                    <% count++; } } catch (Exception e) { out.println("<p>Error loading movies: " + e.getMessage() + "</p>");
                      }
                      %>
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

          </body>

          </html>