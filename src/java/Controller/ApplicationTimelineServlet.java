/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.ApplicationDAO;
import Models.Application;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Hung
 */
@WebServlet(name = "ApplicationTimelineServlet", urlPatterns = {"/applicationtimeline"})
public class ApplicationTimelineServlet extends HttpServlet {

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
            out.println("<title>Servlet ApplicationTimelineServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApplicationTimelineServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            ApplicationDAO dao = new ApplicationDAO();
            Application app = dao.getApplicationById(id);

            if (app == null) {
                request.setAttribute("error", "Không tìm thấy đơn ứng tuyển với ID = " + id);
                request.getRequestDispatcher("Views/error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("app", app);
            request.getRequestDispatcher("Views/admin/application_timeline.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải timeline: " + e.getMessage());
            request.getRequestDispatcher("Views/error.jsp").forward(request, response);
        }
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

        try {
            int id = Integer.parseInt(request.getParameter("application_id"));
            String currentStatus = request.getParameter("current_status");

            // Xác định trạng thái tiếp theo
            String nextStatus = getNextStage(currentStatus);

            ApplicationDAO dao = new ApplicationDAO();
            boolean updated = dao.updateStatus(id, nextStatus);

            if (updated) {
                System.out.println("✅ Đã cập nhật trạng thái ứng viên #" + id + " thành " + nextStatus);
            } else {
                System.out.println("⚠️ Không cập nhật được trạng thái ứng viên #" + id);
            }

            // Load lại trang
            response.sendRedirect("applicationtimeline?id=" + id);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Views/error.jsp?msg=" + e.getMessage());
        }
    }

    private String getNextStage(String current) {
        switch (current) {
            case "Applied":
                return "Interviewing";
            case "Interviewing":
                return "Offer";
            case "Offer":
                return "Hired";
            default:
                return "Hired";
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
