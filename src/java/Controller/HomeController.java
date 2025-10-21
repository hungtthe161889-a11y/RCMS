package Controller;

import DAL.JobPostingDAO;
import Models.JobPosting;
import Models.JobCategory;
import Models.Location;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home", "/"})
public class HomeController extends HttpServlet {

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

        try {
            if ("detail".equals(action)) {
                showJobDetail(request, response);
            } else {
                showHomePage(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace(); // Thêm dòng này để debug
            request.getSession().setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("home");
        }
    }

    private void showHomePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Code hiện tại của home page
        List<JobPosting> activeJobs = jobPostingDAO.getJobPostingsByStatus("open");

        // Lấy danh sách categories và locations để populate thông tin
        List<JobCategory> categories = jobPostingDAO.getAllCategories();
        List<Location> locations = jobPostingDAO.getAllLocations();

        // Tạo maps để dễ dàng truy cập
        Map<Integer, String> categoryMap = new HashMap<>();
        Map<Integer, String> locationMap = new HashMap<>();

        for (JobCategory category : categories) {
            categoryMap.put(category.getCategoryId(), category.getCategoryName());
        }

        for (Location location : locations) {
            locationMap.put(location.getLocationId(), location.getProvince() + " - " + location.getWard());
        }

        // Populate thông tin vào jobPostings
        for (JobPosting job : activeJobs) {
            job.setCategoryName(categoryMap.get(job.getCategoryId()));
            job.setLocationName(locationMap.get(job.getLocationId()));
        }

        request.setAttribute("activeJobs", activeJobs);
        request.setAttribute("categories", categories);
        request.setAttribute("locations", locations);
        request.getRequestDispatcher("/Views/homepage.jsp").forward(request, response);
    }

    protected void showJobDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int jobId = Integer.parseInt(request.getParameter("id"));
            JobPosting job = jobPostingDAO.getJobPostingById(jobId);

            if (job == null) {
                request.getSession().setAttribute("error", "Tin tuyển dụng không tồn tại!");
                response.sendRedirect("home");
                return;
            }

            if (!"open".equals(job.getStatus())) {
                request.getSession().setAttribute("error", "Tin tuyển dụng đã đóng!");
                response.sendRedirect("home");
                return;
            }

            // Populate thông tin category và location
            JobCategory category = jobPostingDAO.getCategoryById(job.getCategoryId());
            Location location = jobPostingDAO.getLocationById(job.getLocationId());

            if (category != null) {
                job.setCategoryName(category.getCategoryName());
            }

            if (location != null) {
                job.setLocationName(location.getProvince() + " - " + location.getWard());
            }

            // Lấy các job liên quan (cùng category)
            List<JobPosting> relatedJobs = jobPostingDAO.getRelatedJobs(jobId, job.getCategoryId());

            // Populate thông tin cho related jobs
            for (JobPosting relatedJob : relatedJobs) {
                JobCategory relatedCategory = jobPostingDAO.getCategoryById(relatedJob.getCategoryId());
                Location relatedLocation = jobPostingDAO.getLocationById(relatedJob.getLocationId());

                if (relatedCategory != null) {
                    relatedJob.setCategoryName(relatedCategory.getCategoryName());
                }

                if (relatedLocation != null) {
                    relatedJob.setLocationName(relatedLocation.getProvince() + " - " + relatedLocation.getWard());
                }
            }

            request.setAttribute("job", job);
            request.setAttribute("relatedJobs", relatedJobs);
            request.getRequestDispatcher("/Views/candidate/job-posting-detail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace(); // Thêm dòng này để debug
            request.getSession().setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect("home");
        }
    }
}
