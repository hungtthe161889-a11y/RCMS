/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.JobCategoryDAO;
import DAL.JobPostingDAO;
import Models.JobCategory;
import Models.JobPosting;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ManagerJobServlet", urlPatterns = {"/manager/jobs/*"})
public class ManagerJobServlet extends HttpServlet {

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
            out.println("<title>Servlet ManagerJobServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerJobServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private JobPostingDAO jobPostingDAO;

    @Override
    public void init() {
        jobPostingDAO = new JobPostingDAO();
    }

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");
    
    if (user == null || user.getRoleId() != 3) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    try {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || "/".equals(pathInfo)) {
            // All jobs for manager overview với filter
            List<JobPosting> allJobs = jobPostingDAO.getAllJobPostings();
            
            // Lấy filter parameters
            String statusFilter = request.getParameter("status");
            String categoryFilter = request.getParameter("category");
            String recruiterFilter = request.getParameter("recruiter");
            
            // Áp dụng filter
            List<JobPosting> filteredJobs = allJobs;
            if (statusFilter != null && !statusFilter.isEmpty()) {
                filteredJobs = filteredJobs.stream()
                    .filter(job -> statusFilter.equals(job.getStatus()))
                    .collect(Collectors.toList());
            }
            if (categoryFilter != null && !categoryFilter.isEmpty()) {
                int categoryId = Integer.parseInt(categoryFilter);
                filteredJobs = filteredJobs.stream()
                    .filter(job -> categoryId == job.getCategoryId())
                    .collect(Collectors.toList());
            }
            if (recruiterFilter != null && !recruiterFilter.isEmpty()) {
                filteredJobs = filteredJobs.stream()
                    .filter(job -> job.getRecruiterName() != null && 
                                  job.getRecruiterName().toLowerCase().contains(recruiterFilter.toLowerCase()))
                    .collect(Collectors.toList());
            }
            
            // Lấy danh sách categories cho filter
            List<JobCategory> categories = new JobCategoryDAO().getAllCategories();
            
            request.setAttribute("pageTitle", "All Job Postings");
            request.setAttribute("contentPage", "/Views/manager/job-list.jsp");
            request.setAttribute("jobs", filteredJobs);
            request.setAttribute("categories", categories);
            request.setAttribute("statusFilter", statusFilter);
            request.setAttribute("categoryFilter", categoryFilter);
            request.setAttribute("recruiterFilter", recruiterFilter);
            
        } else if ("/pending".equals(pathInfo)) {
            // Pending approval jobs với filter
            List<JobPosting> pendingJobs = jobPostingDAO.getAllPendingApprovalJobs();
            
            // Lấy filter parameters
            String categoryFilter = request.getParameter("category");
            String recruiterFilter = request.getParameter("recruiter");
            
            // Áp dụng filter
            List<JobPosting> filteredJobs = pendingJobs;
            if (categoryFilter != null && !categoryFilter.isEmpty()) {
                int categoryId = Integer.parseInt(categoryFilter);
                filteredJobs = filteredJobs.stream()
                    .filter(job -> categoryId == job.getCategoryId())
                    .collect(Collectors.toList());
            }
            if (recruiterFilter != null && !recruiterFilter.isEmpty()) {
                filteredJobs = filteredJobs.stream()
                    .filter(job -> job.getRecruiterName() != null && 
                                  job.getRecruiterName().toLowerCase().contains(recruiterFilter.toLowerCase()))
                    .collect(Collectors.toList());
            }
            
            List<JobCategory> categories = new JobCategoryDAO().getAllCategories();
            
            request.setAttribute("pageTitle", "Pending Approval Jobs");
            request.setAttribute("contentPage", "/Views/manager/job-list.jsp");
            request.setAttribute("jobs", filteredJobs);
            request.setAttribute("categories", categories);
            request.setAttribute("categoryFilter", categoryFilter);
            request.setAttribute("recruiterFilter", recruiterFilter);
            
        } else if ("/preview".equals(pathInfo)) {
            // Preview job details for manager
            int jobId = Integer.parseInt(request.getParameter("id"));
            JobPosting job = jobPostingDAO.getJobPostingById(jobId);
            
            request.setAttribute("pageTitle", "Preview - " + job.getTitle());
            request.setAttribute("contentPage", "/Views/manager/job-preview.jsp");
            request.setAttribute("job", job);
        }
        
        request.getRequestDispatcher("/Views/layout/master.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
}

    // Thêm vào ManagerJobServlet
    private List<JobPosting> filterJobs(List<JobPosting> jobs, String status, Integer categoryId, String recruiterName) {
        return jobs.stream()
                .filter(job -> status == null || status.isEmpty() || status.equals(job.getStatus()))
                .filter(job -> categoryId == null || categoryId == 0 || categoryId == job.getCategoryId())
                .filter(job -> recruiterName == null || recruiterName.isEmpty()
                || (job.getRecruiterName() != null
                && job.getRecruiterName().toLowerCase().contains(recruiterName.toLowerCase())))
                .collect(Collectors.toList());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRoleId() != 3) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String action = request.getParameter("action");
            int jobId = Integer.parseInt(request.getParameter("jobId"));

            if ("approve".equals(action)) {
                boolean success = jobPostingDAO.approveJobPosting(jobId, user.getUserId());
                if (success) {
                    session.setAttribute("message", "Job posting approved successfully!");
                } else {
                    session.setAttribute("error", "Failed to approve job posting.");
                }
            } else if ("reject".equals(action)) {
                boolean success = jobPostingDAO.rejectJobPosting(jobId, user.getUserId());
                if (success) {
                    session.setAttribute("message", "Job posting rejected.");
                } else {
                    session.setAttribute("error", "Failed to reject job posting.");
                }
            }

            response.sendRedirect(request.getContextPath() + "/manager/jobs/pending");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error processing request: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manager/jobs/pending");
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
