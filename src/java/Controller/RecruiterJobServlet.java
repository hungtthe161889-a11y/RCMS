package Controller;

import DAL.JobPostingDAO;
import DAL.JobCategoryDAO;
import DAL.LocationDAO;
import Models.JobPosting;
import Models.JobCategory;
import Models.Location;
import Models.User;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/recruiter/jobs/*")
public class RecruiterJobServlet extends HttpServlet {
    private JobPostingDAO jobPostingDAO;
    private JobCategoryDAO categoryDAO;
    private LocationDAO locationDAO;
    
    @Override
    public void init() {
        jobPostingDAO = new JobPostingDAO();
        categoryDAO = new JobCategoryDAO();
        locationDAO = new LocationDAO();
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
            
            if (pathInfo == null || "/".equals(pathInfo)) {
                List<JobPosting> jobs = jobPostingDAO.getJobPostingsByRecruiter(user.getUserId());
                request.setAttribute("pageTitle", "My Job Postings");
                request.setAttribute("contentPage", "/Views/recruiter/job-list.jsp");
                request.setAttribute("jobs", jobs);
            } else if ("/create".equals(pathInfo)) {
                List<JobCategory> categories = categoryDAO.getAllCategories();
                List<Location> locations = locationDAO.getAllLocations();
                request.setAttribute("pageTitle", "Create Job Posting");
                request.setAttribute("contentPage", "/Views/recruiter/job-form.jsp");
                request.setAttribute("categories", categories);
                request.setAttribute("locations", locations);
            } else if ("/edit".equals(pathInfo)) {
                int jobId = Integer.parseInt(request.getParameter("id"));
                JobPosting job = jobPostingDAO.getJobPostingById(jobId);
                
                if (job.getCreatedBy() != user.getUserId()) {
                    session.setAttribute("error", "You can only edit your own job postings.");
                    response.sendRedirect(request.getContextPath() + "/recruiter/jobs/");
                    return;
                }
                
                List<JobCategory> categories = categoryDAO.getAllCategories();
                List<Location> locations = locationDAO.getAllLocations();
                request.setAttribute("pageTitle", "Edit Job Posting");
                request.setAttribute("contentPage", "/Views/recruiter/job-form.jsp");
                request.setAttribute("job", job);
                request.setAttribute("categories", categories);
                request.setAttribute("locations", locations);
            }
            
            request.getRequestDispatcher("/Views/layout/master.jsp").forward(request, response);
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
            String redirectUrl = request.getContextPath() + "/recruiter/jobs/";
            
            if ("create".equals(action)) {
                JobPosting job = extractJobFromRequest(request);
                job.setPostedAt(LocalDateTime.now());
                job.setCreatedBy(user.getUserId());
                
                boolean success = jobPostingDAO.createJobPosting(job);
                if (success) {
                    session.setAttribute("message", "Job posting created successfully! Waiting for approval.");
                } else {
                    session.setAttribute("error", "Failed to create job posting.");
                }
            } else if ("update".equals(action)) {
                JobPosting job = extractJobFromRequest(request);
                job.setCreatedBy(user.getUserId());
                
                boolean success = jobPostingDAO.updateJobPosting(job);
                if (success) {
                    session.setAttribute("message", "Job posting updated successfully!");
                } else {
                    session.setAttribute("error", "Failed to update job posting.");
                }
            } else if ("delete".equals(action)) {
                int jobId = Integer.parseInt(request.getParameter("jobId"));
                boolean success = jobPostingDAO.deleteJobPosting(jobId, user.getUserId());
                if (success) {
                    session.setAttribute("message", "Job posting deleted successfully!");
                } else {
                    session.setAttribute("error", "Failed to delete job posting.");
                }
            }
            
            response.sendRedirect(redirectUrl);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error processing request: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/recruiter/jobs/");
        }
    }
    
    private JobPosting extractJobFromRequest(HttpServletRequest request) {
        JobPosting job = new JobPosting();
        
        String jobIdParam = request.getParameter("jobId");
        if (jobIdParam != null && !jobIdParam.isEmpty()) {
            job.setJobId(Integer.parseInt(jobIdParam));
        }
        
        job.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
        job.setLocationId(Integer.parseInt(request.getParameter("locationId")));
        job.setTitle(request.getParameter("title"));
        job.setExperience(request.getParameter("experience"));
        job.setLevel(request.getParameter("level"));
        job.setEducation(request.getParameter("education"));
        job.setQuantity(request.getParameter("quantity"));
        job.setWorkType(request.getParameter("workType"));
        job.setDescription(request.getParameter("description"));
        job.setRequirement(request.getParameter("requirement"));
        job.setIncome(request.getParameter("income"));
        job.setInterest(request.getParameter("interest"));
        
        String minSalary = request.getParameter("minSalary");
        String maxSalary = request.getParameter("maxSalary");
        if (minSalary != null && !minSalary.isEmpty()) {
            job.setMinSalary(new BigDecimal(minSalary));
        }
        if (maxSalary != null && !maxSalary.isEmpty()) {
            job.setMaxSalary(new BigDecimal(maxSalary));
        }
        
        String expiredDate = request.getParameter("expiredAt");
        job.setExpiredAt(LocalDateTime.parse(expiredDate + "T23:59:59"));
        
        return job;
    }
}