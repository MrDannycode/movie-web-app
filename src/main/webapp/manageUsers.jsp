<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="selirMovieWeb.User" %>
<%
    String loggedRole = (String) session.getAttribute("role");
    if (!"SuperAdmin".equals(loggedRole)) {
        response.sendRedirect("index.jsp");
        return;
    }
    List<User> userList = (List<User>) request.getAttribute("userList");
    String loggedUsername = (String) session.getAttribute("username");
    String avatarLetter = (loggedUsername != null && !loggedUsername.isEmpty())
                          ? String.valueOf(loggedUsername.charAt(0)).toUpperCase() : "S";
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Manage Users – EasyWatch</title>
  <link rel="stylesheet" href="css/styles.css?v=2">
  <style>
    .admin-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    .admin-table th, .admin-table td { padding: 12px; border-bottom: 1px solid #333; text-align: left; }
    .admin-table th { background-color: #222; }
    .action-form { display: inline-block; margin-right: 10px; }
    .role-select { padding: 5px; background: #333; color: white; border: 1px solid #555; border-radius: 4px; }
  </style>
</head>
<body>
  <!-- ===== HEADER ===== -->
  <header>
    <a href="index.jsp" class="logo">EasyWatch</a>
    <nav class="main-nav">
      <a href="listaFilme.jsp" class="nav-link">Movies</a>
      <a href="UserManageServlet" class="nav-link active-link">Manage Users</a>
    </nav>
    <div class="header-actions">
      <div class="user-chip">
        <div class="user-avatar"><%= avatarLetter %></div>
        <span><%= loggedUsername %> (SuperAdmin)</span>
        <a class="logout-link" href="LogoutServlet">Logout</a>
      </div>
    </div>
  </header>

  <main class="page-main">
    <div class="page-hero">
      <div class="page-hero-inner">
        <span class="hero-badge">⚙️ Admin Dashboard</span>
        <h1>User Management</h1>
      </div>
    </div>

    <section class="table-section">
      <div class="table-wrapper" style="padding: 20px; background: var(--bg-card); border-radius:12px;">
        <table class="admin-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Username</th>
              <th>Email</th>
              <th>Role</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <% 
              if (userList != null) {
                for (User u : userList) { 
            %>
            <tr>
              <td><%= u.getId() %></td>
              <td><%= u.getUsername() %></td>
              <td><%= u.getEmail() %></td>
              <td>
                <form action="UserManageServlet" method="post" class="action-form">
                  <input type="hidden" name="action" value="updateRole">
                  <input type="hidden" name="userId" value="<%= u.getId() %>">
                  <select name="newRole" class="role-select">
                    <option value="USER" <%= "USER".equals(u.getRole()) ? "selected" : "" %>>USER</option>
                    <option value="MovieAdmin" <%= "MovieAdmin".equals(u.getRole()) ? "selected" : "" %>>MovieAdmin</option>
                    <option value="SuperAdmin" <%= "SuperAdmin".equals(u.getRole()) ? "selected" : "" %>>SuperAdmin</option>
                  </select>
                  <button type="submit" class="btn btn-primary" style="padding:4px 8px; font-size:12px;">Update</button>
                </form>
              </td>
              <td>
                <form action="UserManageServlet" method="post" class="action-form" onsubmit="return confirm('Delete this user?');">
                  <input type="hidden" name="action" value="delete">
                  <input type="hidden" name="userId" value="<%= u.getId() %>">
                  <button type="submit" class="btn btn-outline" style="padding:4px 8px; font-size:12px; color:#ff4d4d; border-color:#ff4d4d;">Delete</button>
                </form>
              </td>
            </tr>
            <% 
                } 
              } 
            %>
          </tbody>
        </table>
      </div>
    </section>
  </main>
</body>
</html>
