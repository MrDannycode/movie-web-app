package selirMovieWeb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {

	private static final String DB_DRIVER = "com.mysql.jdbc.Driver";
	private static final String DB_CONNECTION = "jdbc:mysql://localhost:3306/filmeSelir";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "";

	// metoda care creaza conexiunea
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName(DB_DRIVER);
			conn = DriverManager.getConnection(DB_CONNECTION, DB_USER, DB_PASSWORD);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return conn;
	}

	// metoda care inchide conexiunea la DB - cu Statement
	public static void closeAll(Connection dbConnection, Statement statement, ResultSet resultSet) {

		try {
			if (resultSet != null)
				resultSet.close();

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		try {
			if (statement != null)
				statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		try {
			if (dbConnection != null)
				dbConnection.close();

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());

		}

	}

	// metoda care inchide conexiunea la DB - cu PreparedStatement
	public static void closeAll(Connection dbConnection, PreparedStatement pstmt, ResultSet resultSet) {

		try {
			if (resultSet != null)
				resultSet.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		try {
			if (pstmt != null)
				pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		try {
			if (dbConnection != null)
				dbConnection.close();

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());

		}
	}

}
