/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.UserDAO;
import Models.User;
import Utils.SHA256;
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

        String hashedPassword = SHA256.hash(password);
        
        User u = uDao.GetUserByEmailAndPassword(email, hashedPassword);

        if (u == null) {
            request.setAttribute("statusCode", 404);
            request.setAttribute("message", "Email or password is incorrect!");
            request.getRequestDispatcher("/Views/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("uid", u.getUserId());
        session.setAttribute("fullname", u.getFullname());
        session.setAttribute("role", u.getRoleId());

        if ("on".equals(remember)) {
            Cookie emailRem = new Cookie("email", u.getEmail());
            Cookie passwordRem = new Cookie("password", u.getPassword());
            Cookie rem = new Cookie("rem", remember);

            emailRem.setMaxAge(7 * 24 * 60 * 60);
            passwordRem.setMaxAge(7 * 24 * 60 * 60);
            rem.setMaxAge(7 * 24 * 60 * 60);

            emailRem.setHttpOnly(true);
            passwordRem.setHttpOnly(true);
            rem.setHttpOnly(true);

            emailRem.setPath(request.getContextPath());
            passwordRem.setPath(request.getContextPath());
            rem.setPath(request.getContextPath());

            response.addCookie(emailRem);
            response.addCookie(passwordRem);
            response.addCookie(rem);

        } else {
            Cookie emailRem = new Cookie("email", "");
            Cookie passwordRem = new Cookie("password", "");
            Cookie rem = new Cookie("rem", "");

            emailRem.setMaxAge(0);
            passwordRem.setMaxAge(0);
            rem.setMaxAge(0);

            emailRem.setPath(request.getContextPath());
            passwordRem.setPath(request.getContextPath());
            rem.setPath(request.getContextPath());

            response.addCookie(emailRem);
            response.addCookie(passwordRem);
            response.addCookie(rem);
        }

        response.sendRedirect(request.getContextPath() + "/home");
    }

}
