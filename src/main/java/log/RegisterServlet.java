package log;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import selirMovieWeb.User;
import selirMovieWeb.UserDAO;

import java.io.IOException;

/**
 * Handles user registration (POST /RegisterServlet).
 * On success  → logs the user in (session) and redirects to index.jsp
 * On failure  → forwards back to register.jsp with an error message
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username  = request.getParameter("txtUsername");
        String email     = request.getParameter("txtEmail");
        String password  = request.getParameter("txtPwd");
        String password2 = request.getParameter("txtPwd2");

        // --- Validation ---
        if (username == null || username.trim().isEmpty() ||
            email    == null || email.trim().isEmpty()    ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMsg", "Please fill in all fields.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(password2)) {
            request.setAttribute("errorMsg", "Passwords do not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("errorMsg", "Password must be at least 6 characters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // --- Register ---
        UserDAO dao     = new UserDAO();
        String result = dao.register(username.trim(), email.trim(), password);

        if ("SUCCESS".equals(result)) {
            // Auto-login after registration
            User user = dao.login(email.trim(), password);
            if (user != null) {
                HttpSession session = request.getSession(true);
                session.setAttribute("loggedUser", user);
                session.setAttribute("userEmail",  user.getEmail());
                session.setAttribute("username",   user.getUsername());
            }
            response.sendRedirect("index.jsp");
        } else if ("EMAIL_EXISTS".equals(result)) {
            request.setAttribute("errorMsg", "That email is already registered. Try logging in.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMsg", "Database Error: " + result + ". Try checking the DB schema.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
