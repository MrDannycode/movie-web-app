package selirMovieWeb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtil {

	// Use the new driver class (MySQL Connector/J 8+)
	private static final String DB_DRIVER     = "com.mysql.cj.jdbc.Driver";
	private static final String DB_CONNECTION = "jdbc:mysql://localhost:3306/filmeselir?useSSL=false&serverTimezone=UTC";
	private static final String DB_USER       = "root";
	private static final String DB_PASSWORD   = "";

	/** Open and return a new connection. Caller must close it. */
	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName(DB_DRIVER);
			conn = DriverManager.getConnection(DB_CONNECTION, DB_USER, DB_PASSWORD);
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return conn;
	}

	/** Close ResultSet, Statement, and Connection silently. */
	public static void closeAll(Connection dbConnection, Statement statement, ResultSet resultSet) {
		closeQuietly(resultSet);
		closeQuietly(statement);
		closeQuietly(dbConnection);
	}

	/** Close ResultSet, PreparedStatement, and Connection silently. */
	public static void closeAll(Connection dbConnection, PreparedStatement pstmt, ResultSet resultSet) {
		closeQuietly(resultSet);
		closeQuietly(pstmt);
		closeQuietly(dbConnection);
	}

	private static void closeQuietly(AutoCloseable c) {
		if (c != null) {
			try { c.close(); } catch (Exception e) { e.printStackTrace(); }
		}
	}
}
