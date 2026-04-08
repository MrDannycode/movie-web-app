package log;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import selirMovieWeb.Film;
import selirMovieWeb.GestiuneFilme;

import java.io.IOException;

@WebServlet("/MovieManageServlet")
public class MovieManageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private boolean isAuthorized(HttpSession session) {
        if (session == null) return false;
        String role = (String) session.getAttribute("role");
        return "SuperAdmin".equals(role) || "MovieAdmin".equals(role);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (!isAuthorized(request.getSession(false))) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String den = request.getParameter("denumire");
                int durata = Integer.parseInt(request.getParameter("durata"));
                int anAp = Integer.parseInt(request.getParameter("anAparitie"));
                
                Film f = new Film(0, den, durata, anAp);
                GestiuneFilme.addFilm(f);

            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("filmId"));
                String den = request.getParameter("denumire");
                int durata = Integer.parseInt(request.getParameter("durata"));
                int anAp = Integer.parseInt(request.getParameter("anAparitie"));
                
                Film f = new Film(id, den, durata, anAp);
                GestiuneFilme.updateFilm(f);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("filmId"));
                GestiuneFilme.deleteFilm(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("listaFilme.jsp");
    }
}
