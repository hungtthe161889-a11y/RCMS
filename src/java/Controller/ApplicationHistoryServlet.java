/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAL.ApplicationDAO;
import DAL.JobPostingDAO;
import DAL.ResumeDAO;
import Models.Application;
import Models.JobPosting;
import Models.Resume;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Hung
 */
@WebServlet(name="ApplicationHistoryServlet", urlPatterns={"/application-history"})
public class ApplicationHistoryServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ApplicationHistoryServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApplicationHistoryServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("uid") == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = (int) session.getAttribute("uid");
        ApplicationDAO appDao = new ApplicationDAO();
        JobPostingDAO jobDao = new JobPostingDAO();
        ResumeDAO resumeDao = new ResumeDAO();

        List<Application> applications = appDao.getApplicationsByUser(userId);

        // 🔹 Map để chứa dữ liệu bổ sung mà không cần sửa model
        List<Map<String, Object>> viewList = new ArrayList<>();

        for (Application app : applications) {
            Map<String, Object> row = new HashMap<>();

            JobPosting job = jobDao.getJobPostingById(app.getJobId());
            Resume resume = resumeDao.getResumeById(app.getResumeId());

            row.put("application", app);
            row.put("job", job);
            row.put("resume", resume);

            viewList.add(row);
        }

        request.setAttribute("viewList", viewList);
        request.getRequestDispatcher("/Views/candidate/application_history.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
