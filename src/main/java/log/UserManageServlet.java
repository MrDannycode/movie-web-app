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
import java.util.List;

@WebServlet("/UserManageServlet")
public class UserManageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"SuperAdmin".equals(session.getAttribute("role"))) {
            response.sendRedirect("index.jsp");
            return;
        }

        UserDAO dao = new UserDAO();
        List<User> list = dao.getAllUsers();
        request.setAttribute("userList", list);
        request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"SuperAdmin".equals(session.getAttribute("role"))) {
            response.sendRedirect("index.jsp");
            return;
        }

        String action = request.getParameter("action");
        String idParam = request.getParameter("userId");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("UserManageServlet");
            return;
        }

        int userId = Integer.parseInt(idParam);
        UserDAO dao = new UserDAO();

        if ("delete".equals(action)) {
            dao.deleteUser(userId);
        } else if ("updateRole".equals(action)) {
            String newRole = request.getParameter("newRole");
            if (newRole != null && !newRole.isEmpty()) {
                dao.updateUserRole(userId, newRole);
            }
        }
        
        response.sendRedirect("UserManageServlet");
    }
}
