/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.ApplicationDAO;
import DAL.JobPostingDAO;
import DAL.UserDAO;
import Models.Application;
import Models.JobPosting;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Hung
 */
@WebServlet(name = "ApplicationListServlet", urlPatterns = {"/applications"})
public class ApplicationListServlet extends HttpServlet {

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
            out.println("<title>Servlet ApplicationListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApplicationListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ApplicationDAO appDao = new ApplicationDAO();
            UserDAO userDao = new UserDAO();
            JobPostingDAO jobDao = new JobPostingDAO();

            List<Application> applications = appDao.getAllApplications();
            List<User> users = userDao.getAllUsers();
            List<JobPosting> jobs = jobDao.getAllJobPostings();

            request.setAttribute("applications", applications);
            request.setAttribute("users", users);
            request.setAttribute("jobs", jobs);

            request.getRequestDispatcher("Views/admin/application_list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Lỗi khi tải danh sách: " + e.getMessage());
            request.getRequestDispatcher("Views/error.jsp").forward(request, response);
        }
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
        try {
            int id = Integer.parseInt(request.getParameter("application_id"));
            String currentStatus = request.getParameter("current_status");

            String next = switch (currentStatus) {
                case "Applied" ->
                    "Interviewing";
                case "Interviewing" ->
                    "Offer";
                case "Offer" ->
                    "Hired";
                default ->
                    "Hired";
            };

            ApplicationDAO dao = new ApplicationDAO();
            dao.updateStatus(id, next);

            response.sendRedirect("applications");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Cập nhật thất bại: " + e.getMessage());
            request.getRequestDispatcher("Views/error.jsp").forward(request, response);
        }
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
