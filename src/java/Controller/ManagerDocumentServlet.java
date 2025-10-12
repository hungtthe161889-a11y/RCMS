package Controller;

import DAL.CandidateDocumentDAO;
import Models.CandidateDocument;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.time.LocalDate;
import java.util.List;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 20, // 20MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB tổng
)
@WebServlet(name = "ManagerDocumentServlet", urlPatterns = {"/managerdocument"})
public class ManagerDocumentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerDocumentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerDocumentServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int candidateId = 3; // ví dụ tạm fix
        String keyword = request.getParameter("q");
        String type = request.getParameter("type");

        CandidateDocumentDAO dao = new CandidateDocumentDAO();
        List<CandidateDocument> docs = dao.searchDocuments(candidateId, keyword, type);

        request.setAttribute("docs", docs);
        request.setAttribute("total", docs.size());
        request.getRequestDispatcher("Views/manager_document.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("upload".equals(action)) {
            handleUpload(request, response);
        } else {
            // các action khác như delete/update sẽ xử lý sau
            doGet(request, response);
        }
    }

    private void handleUpload(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int userId = Integer.parseInt(request.getParameter("candidateId"));
            String title = request.getParameter("title");
            String docType = request.getParameter("docType");
            String issuedBy = request.getParameter("issuedBy");
            String issuedAtStr = request.getParameter("issuedAt");
            String expiresAtStr = request.getParameter("expiresAt");
            Part filePart = request.getPart("file");

            if (filePart == null || filePart.getSize() == 0) {
                request.setAttribute("message", "⚠️ Vui lòng chọn tệp để tải lên.");
                request.getRequestDispatcher("Views/manager_document.jsp").forward(request, response);
                return;
            }

            // 🧩 Tạo thư mục lưu file cố định trong web/uploads (không nằm trong build/)
            File webDir = new File(getServletContext().getRealPath("/")).getParentFile();
            File uploadDir = new File(webDir, "uploads");
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            String uploadPath = uploadDir.getAbsolutePath();

            // 🧩 Lấy tên file và xử lý trùng
            String originalFileName = extractFileName(filePart);
            String safeFileName = System.currentTimeMillis() + "_" + originalFileName;
            String fullPath = uploadPath + File.separator + safeFileName;

            // 🧩 Lưu file vào thư mục
            filePart.write(fullPath);

            // 🧩 Lưu thông tin vào model
            CandidateDocument doc = new CandidateDocument();
            doc.setUserId(userId);
            doc.setTitle(title);
            doc.setDocType(docType);
            doc.setIssuedBy(issuedBy);
            doc.setFilePath("uploads/" + safeFileName);
            doc.setFileSize(filePart.getSize());

            if (issuedAtStr != null && !issuedAtStr.isEmpty()) {
                doc.setIssuedAt(LocalDate.parse(issuedAtStr));
            }
            if (expiresAtStr != null && !expiresAtStr.isEmpty()) {
                doc.setExpiresAt(LocalDate.parse(expiresAtStr));
            }

            // 🧩 Lưu vào database
            CandidateDocumentDAO dao = new CandidateDocumentDAO();
            boolean success = dao.uploadDocument(doc);

            if (success) {
                request.setAttribute("message", "✅ Tải tài liệu thành công!");
            } else {
                request.setAttribute("message", "❌ Lỗi: không thể lưu dữ liệu vào CSDL.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "❌ Lỗi khi tải tài liệu: " + e.getMessage());
        }

        // 🔁 Quay lại trang upload
        request.getRequestDispatcher("Views/manager_document.jsp").forward(request, response);
    }

// 🔍 Hàm lấy tên file gốc
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf('=') + 2, s.length() - 1);
            }
        }
        return "unknown_file";
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
