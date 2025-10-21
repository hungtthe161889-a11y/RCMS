/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.ApplicationDAO;
import DAL.JobPostingDAO;
import DAL.ResumeDAO;
import Models.JobPosting;
import Models.Resume;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author Hung
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 20, // 20MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)

@WebServlet(name = "ApplyServlet", urlPatterns = {"/apply"})
public class ApplyServlet extends HttpServlet {

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
            out.println("<title>Servlet ApplyServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApplyServlet at " + request.getContextPath() + "</h1>");
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
        int jobId = Integer.parseInt(request.getParameter("jobId"));

        ResumeDAO resumeDAO = new ResumeDAO();
        JobPostingDAO jobDAO = new JobPostingDAO();
        JobPosting job = jobDAO.getJobPostingById(jobId);
        List<Resume> resumes = resumeDAO.getResumesByUser(userId);

        request.setAttribute("job", job);
        request.setAttribute("resumes", resumes);
        request.getRequestDispatcher("/Views/candidate/job-posting-detail.jsp").forward(request, response);
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
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("uid") == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = (int) session.getAttribute("uid");
        int jobId = Integer.parseInt(request.getParameter("jobId"));
        String selectedResumeId = request.getParameter("resumeId");

        ResumeDAO resumeDAO = new ResumeDAO();
        int resumeId = -1;

        // Nếu user upload CV mới
        Part filePart = request.getPart("newResumeFile");
        if (filePart != null && filePart.getSize() > 0) {
            // Upload file
            String fileName = System.currentTimeMillis() + "_" + extractFileName(filePart);
            String uploadPath = getServletContext().getRealPath("/uploads/resumes");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File savedFile = new File(uploadDir, fileName);
            filePart.write(savedFile.getAbsolutePath());
            String fileUrl = "uploads/resumes/" + fileName;

            // Lấy thông tin từ form
            String title = request.getParameter("resumeTitle");
            if (title == null || title.isEmpty()) {
                title = "CV " + LocalDateTime.now();
            }

            String summary = request.getParameter("summary");
            String experience = request.getParameter("experience");
            String education = request.getParameter("education");
            String skills = request.getParameter("skills");

            // Ghi vào DB
            resumeId = resumeDAO.insertResume(userId, title, summary, experience, education, skills, fileUrl);
        } // Nếu user chọn CV sẵn
        else if (selectedResumeId != null && !selectedResumeId.isEmpty()) {
            resumeId = Integer.parseInt(selectedResumeId);
        }

        if (resumeId == -1) {
            session.setAttribute("error", "Bạn cần chọn hoặc tải lên CV trước khi ứng tuyển.");
            response.sendRedirect("apply?jobId=" + jobId);
            return;
        }

        // Ghi ứng tuyển
        ApplicationDAO appDAO = new ApplicationDAO();
        boolean ok = appDAO.createApplication(jobId, userId, resumeId);

        if (ok) {
            session.setAttribute("message", "Ứng tuyển thành công.");
        } else {
            session.setAttribute("error", "Bạn đã ứng tuyển công việc này rồi hoặc có lỗi xảy ra.");
        }

        response.sendRedirect("application-history");
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String s : contentDisp.split(";")) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf('=') + 2, s.length() - 1);
            }
        }
        return "unknown_file";
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
