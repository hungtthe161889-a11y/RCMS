/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.UserDAO;
import Models.User;
import Utils.SHA256;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.regex.Pattern;

/**
 *
 * @author Hung
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Views/register.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        // Lưu lại dữ liệu người dùng nhập (trừ password)
        request.setAttribute("fullname", fullname);
        request.setAttribute("phone", phone);
        request.setAttribute("email", email);

        UserDAO dao = new UserDAO();

        // --- Validate đầu vào ---
        String error = validateInput(fullname, phone, email, password, confirm, dao);

        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/Views/register.jsp").forward(request, response);
            return;
        }

        // --- Nếu hợp lệ, hash và lưu DB ---
        String hashed = SHA256.hash(password);
        User user = new User();
        user.setFullname(fullname);
        user.setPhoneNumber(phone);
        user.setEmail(email);
        user.setPassword(hashed);
        user.setStatus("Active");
        user.setRoleId(2);
        user.setAddress(null);

        if (dao.insertUser(user)) {
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "❌ Registration failed. Please try again later.");
            request.getRequestDispatcher("/Views/register.jsp").forward(request, response);
        }
    }

    private String validateInput(String fullname, String phone, String email,
            String password, String confirm, UserDAO dao) {

        if (isEmpty(fullname) || isEmpty(email) || isEmpty(password)) {
            return "⚠️ Please fill in all required fields.";
        }

        if (!password.equals(confirm)) {
            return "❌ Passwords do not match.";
        }

        if (!isStrongPassword(password)) {
            return "⚠️ Password must have at least 8 characters, including uppercase, lowercase, number and special character.";
        }

        if (dao.isEmailExists(email)) {
            return "❌ This email is already registered.";
        }

        if (!isEmpty(phone) && dao.isPhoneExists(phone)) {
            return "❌ This phone number already exists.";
        }

        return null; // hợp lệ
    }

    private boolean isEmpty(String s) {
        return s == null || s.trim().isEmpty();
    }

    private boolean isStrongPassword(String password) {
        String regex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return Pattern.matches(regex, password);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
