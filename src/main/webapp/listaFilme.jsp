<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="selirMovieWeb.Film" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="selirMovieWeb.GestiuneFilme" %>


<!DOCTYPE html>
<html>
<head>
	<script src="js/sorttable.js"></script>
	<meta charset="UTF-8">
	<title>lista filmelor</title>
	<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
	<div class="background-imageLista"></div>
	<table class="sortable">
		<thead>
			<tr>
				<th>ID</th>
				<th>Title</th>
				<th>Duration</th>
				<th>Year</th>
			</tr>
		</thead>
		<tbody>
				<%
			
				HashSet<Film> films = GestiuneFilme.getFilms();
				for (Film film : films) {
			%>
			<tr>
				<td><%= film.getId() %></td>
				<td><%= film.getDenumire() %></td>
				<td><%= film.getDurata() %> minutes</td>
				<td><%= film.getAnAparitie() %></td>
			</tr>
			<%
				}
			 
			%>
		</tbody>
	</table>
<form action="index.jsp" method='post'>
<input type='submit' value='Go Back' class="back-button">
</form>
</body>
</html>