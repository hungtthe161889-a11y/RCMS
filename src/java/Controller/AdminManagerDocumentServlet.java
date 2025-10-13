/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAL.CandidateDocumentDAO;
import DAL.UserDAO;
import Models.CandidateDocument;
import Models.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Hung
 */
@WebServlet(name = "AdminManagerDocumentServlet", urlPatterns = {"/admindocument"})
public class AdminManagerDocumentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminManagerDocumentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminManagerDocumentServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("q");
        String type = request.getParameter("type");
        String status = request.getParameter("status");

        CandidateDocumentDAO dao = new CandidateDocumentDAO();
        UserDAO userDao = new UserDAO();
        List<CandidateDocument> docs = dao.getAllDocuments(keyword, type, status);
        Map<Integer, String> userNames = userDao.getAllUserNames();

        request.setAttribute("docs", docs);
        request.setAttribute("userNames", userNames);
        request.setAttribute("total", docs.size());
        
        request.setAttribute("pageTitle", "Quản lý tài liệu ứng viên");
        request.setAttribute("contentPage", "/Views/admin/admin_document.jsp");
        request.getRequestDispatcher("/Views/layout/master.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        CandidateDocumentDAO dao = new CandidateDocumentDAO();

        int adminId = 1; // ⚙️ tạm thời hardcode; sau này lấy từ session admin login

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean ok = false;

            switch (action) {
                case "approve" -> {
                    ok = dao.verifyDocument(id, adminId);
                    request.getSession().setAttribute("message",
                            ok ? "✅ Đã duyệt tài liệu #" + id : "❌ Duyệt thất bại!");
                }
                case "reject" -> {
                    String note = request.getParameter("note");
                    ok = dao.rejectDocument(id, adminId, note);
                    request.getSession().setAttribute("message",
                            ok ? "⚠️ Đã từ chối tài liệu #" + id : "❌ Từ chối thất bại!");
                }
                case "delete" -> {
                    ok = dao.softDeleteDocument(id, adminId);
                    request.getSession().setAttribute("message",
                            ok ? "🗑️ Đã xóa tài liệu #" + id : "❌ Xóa thất bại!");
                }
                default ->
                    request.getSession().setAttribute("message", "⚠️ Hành động không hợp lệ!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "❌ Lỗi xử lý: " + e.getMessage());
        }

        response.sendRedirect("admindocument");
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
