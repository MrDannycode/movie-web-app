package selirMovieWeb;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.*;

public class Main {

    public static void main(String[] args) {

        Connection conn = DBUtil.getConnection();
        Statement statement = null;
        ResultSet resultSet = null;

        String sql = "SELECT * FROM film";

        try {
            statement = conn.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            resultSet = statement.executeQuery(sql);
        } catch (SQLException e) {

            e.printStackTrace();
        }



        try {

//            HashSet<Film> filmSet = GestiuneFilme.getFilms();

//            GestiuneFilme.printFilms(filmSet);

/*            List<Film> myList = GestiuneFilme.getFilms();
            GestiuneFilme.printFilms(myList);*/

//            Film film = GestiuneFilme.getFilmById(12);        //merge


/*			 System.out.println("Id: " + film.id);
		     System.out.println("Denumire: " + film.denumire);
		     System.out.println("Durata: " + film.durata);
		     System.out.println("An aparitie: " + film.anAparitie);*/

        }




		/*
		 * catch (SQLException e) { e.printStackTrace(); }
		 */

        finally {
            DBUtil.closeAll(conn, statement, resultSet);
        }
    }

}
