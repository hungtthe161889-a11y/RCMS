package Controller;

import DAL.ApplicationDAO;
import DAL.JobPostingDAO;
import DAL.UserDAO;
import Models.Application;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ApplicationListServlet", urlPatterns = {"/applications"})
public class ApplicationListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String keyword = request.getParameter("keyword");
            String status = request.getParameter("status");

            ApplicationDAO appDao = new ApplicationDAO();
            UserDAO userDao = new UserDAO();
            JobPostingDAO jobDao = new JobPostingDAO();

            // Lọc ứng viên theo keyword & status
            List<Application> applications = appDao.filterApplications(keyword, status);

            // Truyền sang JSP
            request.setAttribute("applications", applications);
            request.setAttribute("users", userDao.getAllUsers());
            request.setAttribute("jobs", jobDao.getAllJobPostings());
            request.setAttribute("keyword", keyword);
            request.setAttribute("status", status);

            request.getRequestDispatcher("Views/admin/application_list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            showError(request, response, "❌ Lỗi khi tải danh sách ứng viên: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            String idStr = request.getParameter("application_id");
            String newStatus = request.getParameter("new_status");

            if (idStr == null || idStr.isEmpty()) {
                showError(request, response, "Thiếu mã đơn ứng tuyển (application_id).");
                return;
            }

            int appId;
            try {
                appId = Integer.parseInt(idStr);
            } catch (NumberFormatException ex) {
                showError(request, response, "Mã đơn ứng tuyển không hợp lệ.");
                return;
            }

            ApplicationDAO dao = new ApplicationDAO();
            boolean success = false;

            switch (action.toLowerCase()) {
                case "forward" -> success = dao.updateStatus(appId, "forward");
                case "backward" -> success = dao.updateStatus(appId, "backward");
                case "set" -> {
                    if (newStatus == null || newStatus.isEmpty()) {
                        showError(request, response, "Thiếu trạng thái mới để cập nhật.");
                        return;
                    }
                    success = dao.updateStatusDirect(appId, newStatus);
                }
                case "delete" -> success = dao.deleteApplication(appId);
                default -> {
                    showError(request, response, "Hành động không hợp lệ: " + action);
                    return;
                }
            }

            if (success) {
                response.sendRedirect("applications?success=1");
            } else {
                showError(request, response, "Không thể cập nhật trạng thái (có thể ID không tồn tại).");
            }

        } catch (Exception e) {
            e.printStackTrace();
            showError(request, response, "Cập nhật thất bại: " + e.getMessage());
        }
    }

    private void showError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("error", message);
        request.getRequestDispatcher("Views/error.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet quản lý danh sách & trạng thái ứng viên";
    }
}
