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
import java.io.FileInputStream;
import java.io.OutputStream;
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
        String action = request.getParameter("action");
        CandidateDocumentDAO dao = new CandidateDocumentDAO();

        if ("view".equals(action)) {
            handleView(request, response, dao);
            return;
        }

        int candidateId = 3; // ví dụ tạm fix
        String keyword = request.getParameter("q");
        String type = request.getParameter("type");

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

            String webRootPath = getServletContext().getRealPath("/");
            File webFolder = new File(webRootPath);

            if (webFolder.getAbsolutePath().contains(File.separator + "build" + File.separator)) {
                webFolder = new File(webFolder.getParentFile().getParentFile(), "web");
            }

            File uploadDir = new File(webFolder, "uploads");
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String originalFileName = extractFileName(filePart);
            String safeFileName = System.currentTimeMillis() + "_" + originalFileName;
            File savedFile = new File(uploadDir, safeFileName);

            filePart.write(savedFile.getAbsolutePath());

            CandidateDocument doc = new CandidateDocument();
            doc.setUserId(userId);
            doc.setTitle(title);
            doc.setDocType(docType);
            doc.setIssuedBy(issuedBy);
            doc.setFilePath("uploads/" + safeFileName); // đường dẫn tương đối để xem sau
            doc.setFileSize(filePart.getSize());

            if (issuedAtStr != null && !issuedAtStr.isEmpty()) {
                doc.setIssuedAt(LocalDate.parse(issuedAtStr));
            }
            if (expiresAtStr != null && !expiresAtStr.isEmpty()) {
                doc.setExpiresAt(LocalDate.parse(expiresAtStr));
            }

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

        request.getRequestDispatcher("Views/manager_document.jsp").forward(request, response);
    }

    private void handleView(HttpServletRequest request, HttpServletResponse response, CandidateDocumentDAO dao)
            throws IOException, ServletException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            CandidateDocument doc = dao.getDocumentById(id);

            if (doc == null) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("Tài liệu không tồn tại hoặc đã bị xóa.");
                return;
            }

            String webRootPath = getServletContext().getRealPath("/");
            File webFolder = new File(webRootPath);

            if (webFolder.getAbsolutePath().contains(File.separator + "build" + File.separator)) {
                webFolder = new File(webFolder.getParentFile().getParentFile(), "web");
            }

            File file = new File(webFolder, doc.getFilePath());

            if (!file.exists()) {
                response.setContentType("text/plain;charset=UTF-8");
                response.getWriter().write("File không tồn tại trên server: " + file.getAbsolutePath());
                return;
            }

            String mime = getServletContext().getMimeType(file.getName());
            if (mime == null) {
                mime = "application/octet-stream";
            }

            response.setContentType(mime);
            response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");
            response.setContentLength((int) file.length());

            try (FileInputStream in = new FileInputStream(file); OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain;charset=UTF-8");
            response.getWriter().write("Lỗi khi xem tài liệu: " + e.getMessage());
        }
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
