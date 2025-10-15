package Controllers;

import DAL.JobPostingDAO;
import Models.JobCategory;
import Models.JobPosting;
import Models.Location;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "JobPostingServlet", urlPatterns = {"/job-posting"})
public class JobPostingController extends HttpServlet {

    private JobPostingDAO jobPostingDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        jobPostingDAO = new JobPostingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "create":
                    showCreateForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteJobPosting(request, response);
                    break;
                case "detail":
                    showDetail(request, response);
                    break;
                case "list":
                default:
                    listJobPostings(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("job-posting?action=list");
            return;
        }

        try {
            switch (action) {
                case "store":
                    createJobPosting(request, response);
                    break;
                case "update":
                    updateJobPosting(request, response);
                    break;
                default:
                    response.sendRedirect("job-posting?action=list");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    // Các phương thức helper
    private void listJobPostings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String statusFilter = request.getParameter("status");
        List<JobPosting> jobPostings;

        if (statusFilter != null && !statusFilter.isEmpty()) {
            jobPostings = jobPostingDAO.getJobPostingsByStatus(statusFilter);
        } else {
            jobPostings = jobPostingDAO.getAllJobPostings();
        }

        request.setAttribute("jobPostings", jobPostings);
        request.getRequestDispatcher("/Views/job-posting/job-posting-list.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<JobCategory> categories = jobPostingDAO.getAllCategories();
        List<Location> locations = jobPostingDAO.getAllLocations();
        
        request.setAttribute("categories", categories);
        request.setAttribute("locations", locations);
        request.getRequestDispatcher("/Views/job-posting/job-posting-form.jsp").forward(request, response);
    }

    private void createJobPosting(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            JobPosting job = extractJobPostingFromRequest(request);
            job.setPostedAt(LocalDateTime.now());
            
            boolean success = jobPostingDAO.createJobPosting(job);
            
            if (success) {
                request.getSession().setAttribute("message", "Tin tuyển dụng đã được tạo thành công!");
            } else {
                request.getSession().setAttribute("error", "Có lỗi xảy ra khi tạo tin tuyển dụng!");
            }
            
            response.sendRedirect("job-posting?action=list");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            showCreateForm(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int jobId = Integer.parseInt(request.getParameter("id"));
        JobPosting job = jobPostingDAO.getJobPostingById(jobId);
        
        if (job == null) {
            request.getSession().setAttribute("error", "Không tìm thấy tin tuyển dụng!");
            response.sendRedirect("job-posting?action=list");
            return;
        }
        
        List<JobCategory> categories = jobPostingDAO.getAllCategories();
        List<Location> locations = jobPostingDAO.getAllLocations();
        
        request.setAttribute("job", job);
        request.setAttribute("categories", categories);
        request.setAttribute("locations", locations);
        request.setAttribute("isEdit", true);
        request.getRequestDispatcher("/Views/job-posting/job-posting-form.jsp").forward(request, response);
    }

    private void updateJobPosting(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int jobId = Integer.parseInt(request.getParameter("jobId"));
            JobPosting existingJob = jobPostingDAO.getJobPostingById(jobId);
            
            if (existingJob == null) {
                request.getSession().setAttribute("error", "Không tìm thấy tin tuyển dụng!");
                response.sendRedirect("job-posting?action=list");
                return;
            }
            
            JobPosting job = extractJobPostingFromRequest(request);
            job.setJobId(jobId);
            job.setPostedAt(existingJob.getPostedAt());
            
            boolean success = jobPostingDAO.updateJobPosting(job);
            
            if (success) {
                request.getSession().setAttribute("message", "Tin tuyển dụng đã được cập nhật thành công!");
            } else {
                request.getSession().setAttribute("error", "Có lỗi xảy ra khi cập nhật tin tuyển dụng!");
            }
            
            response.sendRedirect("job-posting?action=list");
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi: " + e.getMessage());
            showEditForm(request, response);
        }
    }

    private void deleteJobPosting(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int jobId = Integer.parseInt(request.getParameter("id"));
        
        jobPostingDAO.deleteJobPosting(jobId);
        request.getSession().setAttribute("message", "Tin tuyển dụng đã được xóa thành công!");
        response.sendRedirect("job-posting?action=list");
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int jobId = Integer.parseInt(request.getParameter("id"));
        JobPosting job = jobPostingDAO.getJobPostingById(jobId);
        
        if (job == null) {
            request.getSession().setAttribute("error", "Không tìm thấy tin tuyển dụng!");
            response.sendRedirect("job-posting?action=list");
            return;
        }
        
        JobCategory category = jobPostingDAO.getCategoryById(job.getCategoryId());
        Location location = jobPostingDAO.getLocationById(job.getLocationId());
        
        request.setAttribute("job", job);
        request.setAttribute("category", category);
        request.setAttribute("location", location);
        request.getRequestDispatcher("/Views/job-posting/job-posting-detail.jsp").forward(request, response);
    }

    private JobPosting extractJobPostingFromRequest(HttpServletRequest request) {
        JobPosting job = new JobPosting();
        
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
        job.setMinSalary(new BigDecimal(request.getParameter("minSalary")));
        job.setMaxSalary(new BigDecimal(request.getParameter("maxSalary")));
        job.setStatus(request.getParameter("status"));
        
        String expiredAtStr = request.getParameter("expiredAt");
        if (expiredAtStr != null && !expiredAtStr.isEmpty()) {
            LocalDateTime expiredAt = LocalDateTime.parse(expiredAtStr + "T00:00:00");
            job.setExpiredAt(expiredAt);
        } else {
            job.setExpiredAt(LocalDateTime.now().plusMonths(1));
        }
        
        return job;
    }
}