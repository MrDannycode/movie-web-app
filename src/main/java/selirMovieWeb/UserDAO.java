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

        // NOTE: We select * here so that we can try to read User_Username and User_Role
        // without failing the query if the columns don't exist in older table structures.
        String sql = "SELECT * FROM user WHERE User_Email = ? AND User_Parola = ?";
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
                
                // Try to read role; fall back to USER if column is absent
                try {
                    String role = rs.getString("User_Role");
                    u.setRole(role != null ? role : "USER");
                } catch (SQLException ignored) {
                    u.setRole("USER"); // fallback
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
     * @return "SUCCESS", "EMAIL_EXISTS", or an error string.
     */
    public String register(String username, String email, String password) {
        // Check if email already taken
        if (emailExists(email)) {
            return "EMAIL_EXISTS";
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
            return rows > 0 ? "SUCCESS" : "INSERT_FAILED";
        } catch (SQLException e) {
            e.printStackTrace();
            return "DB_ERROR: " + e.getMessage();
        } finally {
            DBUtil.closeAll(conn, ps, null);
        }
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

    /**
     * Gets all users (for SuperAdmin).
     */
    public java.util.List<User> getAllUsers() {
        java.util.List<User> list = new java.util.ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM user";
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("User_ID"));
                u.setEmail(rs.getString("User_Email"));
                try { u.setUsername(rs.getString("User_Username")); } catch (Exception e) { u.setUsername(u.getEmail()); }
                try { 
                    String role = rs.getString("User_Role");
                    u.setRole(role != null ? role : "USER"); 
                } catch (Exception e) { u.setRole("USER"); }
                list.add(u);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.closeAll(conn, ps, rs); }
        return list;
    }

    /**
     * Updates user's role (for SuperAdmin).
     */
    public boolean updateUserRole(int userId, String newRole) {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "UPDATE user SET User_Role = ? WHERE User_ID = ?";
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, newRole);
            ps.setInt(2, userId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.closeAll(conn, ps, null); }
        return false;
    }

    /**
     * Deletes user (for SuperAdmin).
     */
    public boolean deleteUser(int userId) {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "DELETE FROM user WHERE User_ID = ?";
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        finally { DBUtil.closeAll(conn, ps, null); }
        return false;
    }
}
