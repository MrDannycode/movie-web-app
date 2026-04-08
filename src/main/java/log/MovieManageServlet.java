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
        return "SuperAdmin".equals(role) || "MovieAdmin".equals(role) || "AdminMovie".equals(role);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        if (!isAuthorized(session)) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("add".equalsIgnoreCase(action)) {
                String denumire = request.getParameter("denumire");
                int durata = Integer.parseInt(request.getParameter("durata"));
                int anAparitie = Integer.parseInt(request.getParameter("anAparitie"));
                String imagine = request.getParameter("imagine");
                if (imagine == null || imagine.isEmpty()) imagine = "default.jpg";

                Film f = new Film(0, denumire, durata, anAparitie, imagine);
                if (GestiuneFilme.addFilm(f)) {
                    session.setAttribute("msg", "Movie added successfully.");
                    response.sendRedirect("addMoviepg.jsp");
                } else {
                    session.setAttribute("msg", "Error adding movie.");
                    response.sendRedirect("addMoviepg.jsp");
                }
            } else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("filmId"));
                String denumire = request.getParameter("denumire");
                int durata = Integer.parseInt(request.getParameter("durata"));
                int anAparitie = Integer.parseInt(request.getParameter("anAparitie"));
                String imagine = request.getParameter("imagine");
                if (imagine == null || imagine.isEmpty()) imagine = "default.jpg";

                Film f = new Film(id, denumire, durata, anAparitie, imagine);
                if (GestiuneFilme.updateFilm(f)) {
                    session.setAttribute("msg", "Movie updated successfully.");
                } else {
                    session.setAttribute("msg", "Error updating movie.");
                }
                response.sendRedirect("listaFilme.jsp");
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("filmId"));
                GestiuneFilme.deleteFilm(id);
                response.sendRedirect("listaFilme.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
