/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.JobCategoryDAO;
import DAL.JobPostingDAO;
import DAL.LocationDAO;
import Models.JobCategory;
import Models.JobPosting;
import Models.Location;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

/**
 *
 * @author Admin
 */
@WebServlet(name = "PublicJobServlet", urlPatterns = {"/jobs"})
public class PublicJobServlet extends HttpServlet {

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
            out.println("<title>Servlet PublicJobServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PublicJobServlet at " + request.getContextPath() + "</h1>");
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
        try {
            String action = request.getParameter("action");

            if ("view".equals(action)) {
                int jobId = Integer.parseInt(request.getParameter("id"));
                JobPosting job = jobPostingDAO.getJobPostingById(jobId);
                request.setAttribute("pageTitle", job.getTitle());
                request.setAttribute("contentPage", "/Views/public/job-detail.jsp");
                request.setAttribute("job", job);
            } else if ("search".equals(action)) {
                String keyword = request.getParameter("keyword");
                Integer categoryId = getIntegerParameter(request, "categoryId");
                Integer locationId = getIntegerParameter(request, "locationId");

                List<JobPosting> jobs = jobPostingDAO.searchJobPostings(keyword, categoryId, locationId);
                List<JobCategory> categories = categoryDAO.getAllCategories();
                List<Location> locations = locationDAO.getAllLocations();

                request.setAttribute("pageTitle", "Search Jobs");
                request.setAttribute("contentPage", "/Views/public/job-list.jsp");
                request.setAttribute("jobs", jobs);
                request.setAttribute("categories", categories);
                request.setAttribute("locations", locations);
                request.setAttribute("searchKeyword", keyword);
                request.setAttribute("selectedCategory", categoryId);
                request.setAttribute("selectedLocation", locationId);
            } else {
                // Show all active jobs với filter
                List<JobPosting> allJobs = jobPostingDAO.getAllActiveJobPostings();
                List<JobCategory> categories = categoryDAO.getAllCategories();
                List<Location> locations = locationDAO.getAllLocations();

                // Lấy filter parameters
                String keyword = request.getParameter("keyword");
                String categoryFilter = request.getParameter("categoryId");
                String locationFilter = request.getParameter("locationId");
                String experienceFilter = request.getParameter("experience");
                String workTypeFilter = request.getParameter("workType");
                String salaryFilter = request.getParameter("salary");

                // Áp dụng filter
                List<JobPosting> filteredJobs = allJobs;

                if (keyword != null && !keyword.isEmpty()) {
                    filteredJobs = filteredJobs.stream()
                            .filter(job -> job.getTitle().toLowerCase().contains(keyword.toLowerCase())
                            || job.getDescription().toLowerCase().contains(keyword.toLowerCase())
                            || job.getRequirement().toLowerCase().contains(keyword.toLowerCase()))
                            .collect(Collectors.toList());
                }

                if (categoryFilter != null && !categoryFilter.isEmpty()) {
                    int categoryId = Integer.parseInt(categoryFilter);
                    filteredJobs = filteredJobs.stream()
                            .filter(job -> categoryId == job.getCategoryId())
                            .collect(Collectors.toList());
                }

                if (locationFilter != null && !locationFilter.isEmpty()) {
                    int locationId = Integer.parseInt(locationFilter);
                    filteredJobs = filteredJobs.stream()
                            .filter(job -> locationId == job.getLocationId())
                            .collect(Collectors.toList());
                }

                if (experienceFilter != null && !experienceFilter.isEmpty()) {
                    filteredJobs = filteredJobs.stream()
                            .filter(job -> job.getExperience() != null
                            && job.getExperience().toLowerCase().contains(experienceFilter.toLowerCase()))
                            .collect(Collectors.toList());
                }

                if (workTypeFilter != null && !workTypeFilter.isEmpty()) {
                    filteredJobs = filteredJobs.stream()
                            .filter(job -> job.getWorkType() != null
                            && job.getWorkType().toLowerCase().contains(workTypeFilter.toLowerCase()))
                            .collect(Collectors.toList());
                }

                if (salaryFilter != null && !salaryFilter.isEmpty()) {
                    filteredJobs = filteredJobs.stream()
                            .filter(job -> {
                                if (job.getMinSalary() == null) {
                                    return false;
                                }
                                BigDecimal minSalary = switch (salaryFilter) {
                                    case "under10" ->
                                        new BigDecimal("10000000");
                                    case "10to15" ->
                                        new BigDecimal("10000000");
                                    case "15to20" ->
                                        new BigDecimal("15000000");
                                    case "20to25" ->
                                        new BigDecimal("20000000");
                                    case "over25" ->
                                        new BigDecimal("25000000");
                                    default ->
                                        BigDecimal.ZERO;
                                };
                                return job.getMinSalary().compareTo(minSalary) >= 0;
                            })
                            .collect(Collectors.toList());
                }

                request.setAttribute("pageTitle", "Job Opportunities");
                request.setAttribute("contentPage", "/Views/public/job-list.jsp");
                request.setAttribute("jobs", filteredJobs);
                request.setAttribute("categories", categories);
                request.setAttribute("locations", locations);
                request.setAttribute("searchKeyword", keyword);
                request.setAttribute("selectedCategory", categoryFilter != null ? Integer.parseInt(categoryFilter) : null);
                request.setAttribute("selectedLocation", locationFilter != null ? Integer.parseInt(locationFilter) : null);
                request.setAttribute("selectedExperience", experienceFilter);
                request.setAttribute("selectedWorkType", workTypeFilter);
                request.setAttribute("selectedSalary", salaryFilter);
            }

            request.getRequestDispatcher("/Views/layout/master.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private Integer getIntegerParameter(HttpServletRequest request, String paramName) {
        String value = request.getParameter(paramName);
        return (value != null && !value.isEmpty()) ? Integer.parseInt(value) : null;
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
        processRequest(request, response);
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
