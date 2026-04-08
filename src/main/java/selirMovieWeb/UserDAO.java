package selirMovieWeb;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Data Access Object for user login and registration.
 */
public class UserDAO {

    /**
     * Validates credentials.
     * @return the User object if found, null otherwise.
     */
    public User login(String email, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        // NOTE: We only select User_ID and User_Email here so that this query
        // works even on older tables that may not have a User_Username column yet.
        // User_Username is read separately below with a null-safe fallback.
        String sql = "SELECT User_ID, User_Email FROM user " +
                     "WHERE User_Email = ? AND User_Parola = ?";
        try {
            conn = DBUtil.getConnection();
            if (conn == null) {
                System.err.println("UserDAO.login: could not get DB connection!");
                return null;
            }
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("User_ID"));
                u.setEmail(rs.getString("User_Email"));
                // Try to read username; fall back to email if column is absent
                try {
                    u.setUsername(rs.getString("User_Username"));
                } catch (SQLException ignored) {
                    u.setUsername(email); // fallback
                }
                return u;
            }
        } catch (SQLException e) {
            System.err.println("UserDAO.login SQL error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(conn, ps, rs);
        }
        return null;
    }

    /**
     * Registers a new user.
     * @return true if inserted successfully, false if email already exists or error.
     */
    public boolean register(String username, String email, String password) {
        // Check if email already taken
        if (emailExists(email)) {
            return false;
        }

        Connection conn    = null;
        PreparedStatement ps = null;

        String sql = "INSERT INTO user (User_Username, User_Email, User_Parola) VALUES (?, ?, ?)";
        try {
            conn = DBUtil.getConnection();
            ps   = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, password);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(conn, ps, null);
        }
        return false;
    }

    /** Returns true if the given email already exists in the database. */
    private boolean emailExists(String email) {
        Connection conn    = null;
        PreparedStatement ps = null;
        ResultSet rs       = null;

        String sql = "SELECT 1 FROM user WHERE User_Email = ?";
        try {
            conn = DBUtil.getConnection();
            ps   = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs   = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(conn, ps, rs);
        }
        return false;
    }
}
