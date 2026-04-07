<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Movie</title>
</head>
<body>

	<form action="addMovieto.jsp" method="post">
	
	
	<table border="1">
	<tr>
		<td>Film ID</td> 
		<td><input type="text" name="Film_ID"></td>
	</tr>
	<tr>
		<td>Denumire film</td> 
		<td><input type="text" name="Film_Denumire"></td>
	</tr>
	<tr>
		<td>Durata film</td>
		<td><input type="text" name="Film_Durata"></td>
	</tr>
	<tr>
		<td>An Aparitie</td>
		<td><input type="text" name="Film_AnAparitie"></td>
	</tr>
	</table>

	<input type="submit" value="adaugam film nou">
	<input type="reset" value="clear">
	
	</form>
	
	
	
	<form action="index.jsp">
	<input type='submit' value='Go Back' class="back-button">
	</form>
	
	<%
	
	try{
		String data=session.getAttribute("msg").toString();
		out.print(data);
		session.removeAttribute("msg");
		
	} catch(Exception ex) {}
	
	%>
	
	
</body>
</html>