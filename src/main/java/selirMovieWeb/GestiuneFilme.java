package selirMovieWeb;


import java.sql.SQLException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.HashSet;

public class GestiuneFilme {


    public static HashSet<Film> getFilms() throws SQLException {
        Connection conn = DBUtil.getConnection();
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        String sql = "SELECT Film_ID, Film_Denumire, Film_Durata, Film_AnAparitie FROM film";

        try {
            statement = conn.prepareStatement(sql);
            resultSet = statement.executeQuery();

            HashSet<Film> mySet = new HashSet<>();
            while (resultSet.next()) {
                Film film = new Film(0, sql, 0, 0);
                film.id = resultSet.getInt("Film_ID");
                film.denumire = resultSet.getString("Film_Denumire");
                film.durata = resultSet.getInt("Film_Durata");
                film.anAparitie = resultSet.getInt("Film_AnAparitie");
                mySet.add(film);
            }

            return mySet;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(conn, statement, resultSet);
        }

        return null; // return null if an exception occurs
    }


/*	public static void printFilms(HashSet<Film> filmSet) {
	    for (Film film : filmSet) {
	        System.out.println(film.id + " - " + film.denumire + " (" + film.durata + " minutes, " + film.anAparitie + ")");
	    }
	}*/


    public static Film getFilmById(int id) throws SQLException {
        Connection conn = DBUtil.getConnection();
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        String sql = "SELECT Film_Denumire, Film_Durata, Film_AnAparitie FROM film WHERE Film_ID = ?";

        try {
            statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String denumire = resultSet.getString("Film_Denumire");
                int durata = resultSet.getInt("Film_Durata");
                int anAparitie = resultSet.getInt("Film_AnAparitie");
                return new Film(id, denumire, durata, anAparitie);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeAll(conn, statement, resultSet);
        }

        return null; // return null if an exception occurs or if no film was found
    }


}

