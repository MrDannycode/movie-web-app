<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="selirMovieWeb.Film" %>
<%@ page import="selirMovieWeb.GestiuneFilme" %>
<%
    String loggedRole = (String) session.getAttribute("role");
    if (!"SuperAdmin".equals(loggedRole) && !"MovieAdmin".equals(loggedRole)) {
        response.sendRedirect("listaFilme.jsp");
        return;
    }
    
    String filmIdStr = request.getParameter("filmId");
    if (filmIdStr == null || filmIdStr.isEmpty()) {
        response.sendRedirect("listaFilme.jsp");
        return;
    }
    
    int filmId = Integer.parseInt(filmIdStr);
    Film film = GestiuneFilme.getFilmById(filmId);
    if (film == null) {
        response.sendRedirect("listaFilme.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Movie – EasyWatch</title>
  <link rel="stylesheet" href="css/styles.css?v=2">
</head>
<body class="auth-page">
  <div class="auth-card">
    <div class="auth-logo">EasyWatch</div>
    <div class="auth-title">Edit Movie</div>
    
    <form action="MovieManageServlet" method="post">
      <input type="hidden" name="action" value="update">
      <input type="hidden" name="filmId" value="<%= film.getId() %>">

      <div class="form-group">
        <label class="form-label" for="denumire">Title</label>
        <input class="form-input" type="text" id="denumire" name="denumire" value="<%= film.getDenumire() %>" required>
      </div>

      <div class="form-group">
        <label class="form-label" for="durata">Duration (minutes)</label>
        <input class="form-input" type="number" id="durata" name="durata" value="<%= film.getDurata() %>" required>
      </div>

      <div class="form-group">
        <label class="form-label" for="anAparitie">Release Year</label>
        <input class="form-input" type="number" id="anAparitie" name="anAparitie" value="<%= film.getAnAparitie() %>" required>
      </div>

      <div class="form-group">
        <label class="form-label" for="imagine">Image Filename</label>
        <input class="form-input" type="text" id="imagine" name="imagine" value="<%= film.getImagine() != null ? film.getImagine() : "" %>">
      </div>

      <button type="submit" class="btn-auth">Save Changes</button>
      <div style="margin-top: 15px; text-align: center;">
         <a href="listaFilme.jsp" class="btn btn-outline" style="width: 100%; display: block; box-sizing: border-box; text-align: center;">Cancel</a>
      </div>
    </form>
  </div>
</body>
</html>
