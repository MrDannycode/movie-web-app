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
 * Handles user login (POST /LoginServlet).
 * On success  → creates an HttpSession and redirects to index.jsp
 * On failure  → forwards back to login.jsp with an error message
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Direct GET → show login page
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("txtEmail");
        String password = request.getParameter("txtPwd");

        // Basic validation
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMsg", "Please fill in all fields.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UserDAO dao  = new UserDAO();
        User    user = dao.login(email.trim(), password);

        if (user != null) {
            // ---- SUCCESS ----
            HttpSession session = request.getSession(true);
            session.setAttribute("loggedUser", user);
            session.setAttribute("userEmail",  user.getEmail());
            session.setAttribute("username",   user.getUsername());
            response.sendRedirect("index.jsp");
        } else {
            // ---- FAILURE ----
            request.setAttribute("errorMsg", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
