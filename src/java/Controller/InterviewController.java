package Controller;

import DAL.InterviewDAO;
import Models.Interview;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "InterviewServlet", urlPatterns = {"/interview"})
public class InterviewController extends HttpServlet {

    private InterviewDAO interviewDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        interviewDAO = new InterviewDAO();
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
                    deleteInterview(request, response);
                    break;
                case "list":
                default:
                    listInterviews(request, response);
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
            action = "list";
        }

        try {
            switch (action) {
                case "create":
                    createInterview(request, response);
                    break;
                case "update":
                    updateInterview(request, response);
                    break;
                default:
                    listInterviews(request, response);
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void listInterviews(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            var interviews = interviewDAO.getAllInterviews();
            request.setAttribute("interviews", interviews);
            request.getRequestDispatcher("/Views/interview/interview-list.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi tải danh sách phỏng vấn: " + e.getMessage());
            request.getRequestDispatcher("/Views/interview/interview-list.jsp").forward(request, response);
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/Views/interview/interview-create.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int interviewId = Integer.parseInt(request.getParameter("id"));
            Interview interview = interviewDAO.getInterviewById(interviewId);
            
            if (interview != null) {
                // QUAN TRỌNG: DAO đã tự động set scheduledAtFormatted, không cần làm gì thêm
                request.setAttribute("interview", interview);
                request.getRequestDispatcher("/Views/interview/interview-edit.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Không tìm thấy lịch phỏng vấn");
                response.sendRedirect("interview?action=list");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID không hợp lệ");
            response.sendRedirect("interview?action=list");
        }
    }

    private void createInterview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            int applicationId = Integer.parseInt(request.getParameter("applicationId"));
            String scheduledAtStr = request.getParameter("scheduledAt");
            int locationId = Integer.parseInt(request.getParameter("locationId"));
            String interviewerFullname = request.getParameter("interviewerFullname");
            String notes = request.getParameter("notes");

            // Parse datetime - SỬ DỤNG ĐÚNG FORMAT
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime scheduledAt = LocalDateTime.parse(scheduledAtStr, formatter);

            // Tạo đối tượng Interview
            Interview interview = new Interview();
            interview.setApplicationId(applicationId);
            interview.setScheduledAt(scheduledAt);
            interview.setLocationId(locationId);
            interview.setInterviewerFullname(interviewerFullname);
            interview.setNotes(notes);

            // Lưu vào database
            boolean success = interviewDAO.createInterview(interview);

            if (success) {
                request.setAttribute("successMessage", "Tạo lịch phỏng vấn thành công!");
                response.sendRedirect("interview?action=list");
            } else {
                request.setAttribute("errorMessage", "Tạo lịch phỏng vấn thất bại!");
                // Giữ lại giá trị form bằng parameters
                request.setAttribute("applicationId", applicationId);
                request.setAttribute("scheduledAt", scheduledAtStr);
                request.setAttribute("locationId", locationId);
                request.setAttribute("interviewerFullname", interviewerFullname);
                request.setAttribute("notes", notes);
                request.getRequestDispatcher("/Views/interview/interview-create.jsp").forward(request, response);
            }

        } catch (DateTimeParseException e) {
            request.setAttribute("errorMessage", "Định dạng ngày giờ không hợp lệ! Vui lòng chọn lại.");
            request.getRequestDispatcher("/Views/interview/interview-create.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Application ID và Location ID phải là số!");
            request.getRequestDispatcher("/Views/interview/interview-create.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi tạo lịch phỏng vấn: " + e.getMessage());
            request.getRequestDispatcher("/Views/interview/interview-create.jsp").forward(request, response);
        }
    }

    private void updateInterview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int interviewId = Integer.parseInt(request.getParameter("interviewId"));
            int applicationId = Integer.parseInt(request.getParameter("applicationId"));
            String scheduledAtStr = request.getParameter("scheduledAt");
            int locationId = Integer.parseInt(request.getParameter("locationId"));
            String interviewerFullname = request.getParameter("interviewerFullname");
            String notes = request.getParameter("notes");

            // Parse datetime - SỬ DỤNG ĐÚNG FORMAT
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime scheduledAt = LocalDateTime.parse(scheduledAtStr, formatter);

            Interview interview = new Interview();
            interview.setInterviewId(interviewId);
            interview.setApplicationId(applicationId);
            interview.setScheduledAt(scheduledAt);
            interview.setLocationId(locationId);
            interview.setInterviewerFullname(interviewerFullname);
            interview.setNotes(notes);

            boolean success = interviewDAO.updateInterview(interview);

            if (success) {
                request.setAttribute("successMessage", "Cập nhật lịch phỏng vấn thành công!");
                response.sendRedirect("interview?action=list");
            } else {
                request.setAttribute("errorMessage", "Cập nhật lịch phỏng vấn thất bại!");
                request.setAttribute("interview", interview);
                request.getRequestDispatcher("/Views/interview/interview-edit.jsp").forward(request, response);
            }

        } catch (DateTimeParseException e) {
            request.setAttribute("errorMessage", "Định dạng ngày giờ không hợp lệ! Vui lòng chọn lại.");
            request.getRequestDispatcher("/Views/interview/interview-edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Application ID và Location ID phải là số!");
            request.getRequestDispatcher("/Views/interview/interview-edit.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi cập nhật lịch phỏng vấn: " + e.getMessage());
            request.getRequestDispatcher("/Views/interview/interview-edit.jsp").forward(request, response);
        }
    }

    private void deleteInterview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int interviewId = Integer.parseInt(request.getParameter("id"));
            boolean success = interviewDAO.deleteInterview(interviewId);

            if (success) {
                request.setAttribute("successMessage", "Xóa lịch phỏng vấn thành công!");
            } else {
                request.setAttribute("errorMessage", "Xóa lịch phỏng vấn thất bại!");
            }

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Lỗi khi xóa lịch phỏng vấn: " + e.getMessage());
        }
        
        response.sendRedirect("interview?action=list");
    }
}