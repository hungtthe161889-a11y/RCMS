/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.UserDAO;
import Models.User;
import jakarta.servlet.ServletConfig;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Hung
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private static UserDAO uDao = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("uid") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // check remember me cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("remember_token".equals(cookie.getName())) {
                        
                    response.sendRedirect(request.getContextPath() + "/home");
                    return;
                }
            }
        }

        request.getRequestDispatcher("/Views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        User u = uDao.GetUserByEmailAndPassword(email, password);
        
        if(u == null){
            request.setAttribute("statusCode", 404);
            request.setAttribute("message", "Email or password is incorrect!");
            request.getRequestDispatcher("/Views/login.jsp").forward(request, response);
            return;
        }
        
        HttpSession session = request.getSession(true);
        session.setAttribute("uid", "U001");
        session.setAttribute("fullname", "John Doe");
        session.setAttribute("role", "admin");

        if ("true".equals(remember)) {
            Cookie cookie = new Cookie("remember_token", "U001:admin@example.com");
            cookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
            cookie.setHttpOnly(true);
            cookie.setPath(request.getContextPath());
            response.addCookie(cookie);
        }

        response.sendRedirect(request.getContextPath() + "/home");
    }

}
