package lk.jiat.app.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.app.core.model.Status;
import lk.jiat.app.core.model.User;
import lk.jiat.app.core.service.UserService;

import java.io.IOException;

@WebServlet("/manager/delete_user")
public class DeleteUser extends HttpServlet {

    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String userIdParam = request.getParameter("uid");
            if (userIdParam != null) {
                Long userId = Long.parseLong(userIdParam);

                User user = userService.getUserById(userId);
                if (user != null) {
                    user.setStatus(Status.DELETED); // Set status to DELETED
                    userService.updateUser(user);   // Persist changes
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // You can log this or handle error properly
        }

        response.sendRedirect(request.getContextPath() + "/manager");
    }
}
