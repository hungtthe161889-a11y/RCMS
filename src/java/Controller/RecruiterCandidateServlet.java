/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAL.CandidateDAO;
import DAL.JobPostingDAO;
import Models.Application;
import Models.Candidate;
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

/**
 *
 * @author Admin
 */
@WebServlet(name="RecruiterCandidateServlet", urlPatterns={"/recruiter/candidates/*"})
public class RecruiterCandidateServlet extends HttpServlet {
   
    private CandidateDAO candidateDAO;
    private JobPostingDAO jobPostingDAO;
    
    @Override
    public void init() {
        candidateDAO = new CandidateDAO();
        jobPostingDAO = new JobPostingDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getRoleId() != 4) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            String pathInfo = request.getPathInfo();
            System.out.println("Candidate Path Info: " + pathInfo);
            
            if (pathInfo == null || "/".equals(pathInfo)) {
                // Candidate list with filters
                handleCandidateList(request, response, user.getUserId());
            } else if ("/view".equals(pathInfo)) {
                // Candidate detail
                handleCandidateDetail(request, response, user.getUserId());
            } else if ("/job".equals(pathInfo)) {
                // Candidates by specific job
                handleCandidatesByJob(request, response, user.getUserId());
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || user.getRoleId() != 4) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            String action = request.getParameter("action");
            
            if ("updateStatus".equals(action)) {
                int applicationId = Integer.parseInt(request.getParameter("applicationId"));
                String status = request.getParameter("status");
                
                boolean success = candidateDAO.updateApplicationStatus(applicationId, status, user.getUserId());
                if (success) {
                    session.setAttribute("message", "Application status updated successfully!");
                } else {
                    session.setAttribute("error", "Failed to update application status.");
                }
                
                // Redirect back to candidate detail or list
                String redirectUrl = request.getParameter("redirectUrl");
                if (redirectUrl != null && !redirectUrl.isEmpty()) {
                    response.sendRedirect(redirectUrl);
                } else {
                    response.sendRedirect(request.getContextPath() + "/recruiter/candidates/");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error processing request: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/recruiter/candidates/");
        }
    }
    
    private void handleCandidateList(HttpServletRequest request, HttpServletResponse response, int recruiterId) 
            throws ServletException, IOException {
        // Get filter parameters
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String jobIdParam = request.getParameter("jobId");
        Integer jobId = (jobIdParam != null && !jobIdParam.isEmpty()) ? Integer.parseInt(jobIdParam) : null;
        
        // Get candidates with filters
        List<Candidate> candidates = candidateDAO.searchCandidates(recruiterId, keyword, status, jobId);
        
        // Get recruiter's jobs for filter dropdown
        List<JobPosting> jobs = jobPostingDAO.getJobPostingsByRecruiter(recruiterId);
        
        // Statistics
        long totalCandidates = candidates.size();
        long newApplications = candidates.stream().filter(c -> "Applied".equals(c.getApplicationStatus())).count();
        long interviewed = candidates.stream().filter(c -> "Interview".equals(c.getApplicationStatus())).count();
        long offered = candidates.stream().filter(c -> "Offer".equals(c.getApplicationStatus())).count();
        
        request.setAttribute("pageTitle", "Candidate Management");
        request.setAttribute("contentPage", "/Views/recruiter/candidate-list.jsp");
        request.setAttribute("candidates", candidates);
        request.setAttribute("jobs", jobs);
        request.setAttribute("searchKeyword", keyword);
        request.setAttribute("statusFilter", status);
        request.setAttribute("jobFilter", jobId);
        request.setAttribute("totalCandidates", totalCandidates);
        request.setAttribute("newApplications", newApplications);
        request.setAttribute("interviewed", interviewed);
        request.setAttribute("offered", offered);
        
        request.getRequestDispatcher("/Views/layout/master.jsp").forward(request, response);
    }
    
    private void handleCandidateDetail(HttpServletRequest request, HttpServletResponse response, int recruiterId) 
            throws ServletException, IOException {
        int candidateId = Integer.parseInt(request.getParameter("id"));
        
        Candidate candidate = candidateDAO.getCandidateDetail(candidateId, recruiterId);
        if (candidate == null) {
            request.getSession().setAttribute("error", "Candidate not found or you don't have permission to view this candidate.");
            response.sendRedirect(request.getContextPath() + "/recruiter/candidates/");
            return;
        }
        
        // Get candidate's applications
        List<Application> applications = candidateDAO.getCandidateApplications(candidateId, recruiterId);
        candidate.setApplications(applications);
        
        request.setAttribute("pageTitle", "Candidate - " + candidate.getFullname());
        request.setAttribute("contentPage", "/Views/recruiter/candidate-detail.jsp");
        request.setAttribute("candidate", candidate);
        
        request.getRequestDispatcher("/Views/layout/master.jsp").forward(request, response);
    }
    
    private void handleCandidatesByJob(HttpServletRequest request, HttpServletResponse response, int recruiterId) 
            throws ServletException, IOException {
        int jobId = Integer.parseInt(request.getParameter("id"));
        
        List<Candidate> candidates = candidateDAO.getCandidatesByJob(jobId, recruiterId);
        JobPosting job = jobPostingDAO.getJobPostingById(jobId);
        
        // Verify job belongs to recruiter
        if (job == null || job.getCreatedBy() != recruiterId) {
            request.getSession().setAttribute("error", "Job not found or you don't have permission to view candidates for this job.");
            response.sendRedirect(request.getContextPath() + "/recruiter/candidates/");
            return;
        }
        
        request.setAttribute("pageTitle", "Candidates for " + job.getTitle());
        request.setAttribute("contentPage", "/Views/recruiter/candidate-list.jsp");
        request.setAttribute("candidates", candidates);
        request.setAttribute("job", job);
        request.setAttribute("totalCandidates", candidates.size());
        
        request.getRequestDispatcher("/Views/layout/master.jsp").forward(request, response);
    }

}
