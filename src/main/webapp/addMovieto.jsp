<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%> 
<%@ page import="java.sql.*"   %>
<%@ page import="selirMovieWeb.DBUtil" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>addMovieto</title>
</head>

<body>
	<%
	String id = request.getParameter("Film_ID");
	String den = request.getParameter("Film_Denumire");
	String durata = request.getParameter("Film_Durata");
	String anAp = request.getParameter("Film_AnAparitie");
	
    Connection conn = DBUtil.getConnection();
    PreparedStatement statement = null;
    ResultSet resultSet = null;
   
	String sql = "INSERT INTO `film` (`Film_ID`,`Film_Denumire`,`Film_Durata`,`Film_AnAparitie`) VALUES ('"+id+"','"+den+"','"+durata+"', '"+anAp+"')";
	
	try{
		statement = conn.prepareStatement(sql);
        //resultSet = statement.executeQuery();
		
		statement.executeUpdate(sql);
		
		session.setAttribute("msg","Data successfully inserted");
		
		response.sendRedirect("addMoviepg.jsp");
		
	}catch(Exception ex)
	{
		out.print(ex.getMessage());
	}
	finally {
        DBUtil.closeAll(conn, statement, resultSet);
    }

    //return null; return null if an exception occurs 
    		
	%>
	
<%--<form action="addMoviepg.jsp">
<input type='submit' value='OK'> 
</form> --%>
</body>
</html>