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
        } else if ("delete".equals(action)) {
            handleDelete(request, response, dao);
            return;
        }
        String msg = (String) request.getSession().getAttribute("message");
        if (msg != null) {
            request.setAttribute("message", msg);
            request.getSession().removeAttribute("message");
        }

        // Mặc định: hiển thị danh sách
        int candidateId = 3;
        String keyword = request.getParameter("q");
        String type = request.getParameter("type");

        List<CandidateDocument> docs = dao.searchDocuments(candidateId, keyword, type);
        request.setAttribute("docs", docs);
        request.setAttribute("total", docs.size());
        request.setAttribute("pageTitle", "Quản lý tài liệu");
        request.setAttribute("contentPage", "/Views/candidate/manager_document.jsp");
        request.getRequestDispatcher("/Views/layout/master.jsp").forward(request, response);
//        request.getRequestDispatcher("Views/manager_document.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("upload".equals(action)) {
            handleUpload(request, response);
            return;
        } else if ("update".equals(action)) {
            handleUpdate(request, response);
            return;
        }

        doGet(request, response);
    }

    private void handleUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int documentId = Integer.parseInt(request.getParameter("documentId"));
            String title = request.getParameter("title");
            String docType = request.getParameter("docType");
            String issuedBy = request.getParameter("issuedBy");
            String issuedAtStr = request.getParameter("issuedAt");
            String expiresAtStr = request.getParameter("expiresAt");
            Part filePart = request.getPart("file");

            LocalDate issuedAt = (issuedAtStr != null && !issuedAtStr.isEmpty()) ? LocalDate.parse(issuedAtStr) : null;
            LocalDate expiresAt = (expiresAtStr != null && !expiresAtStr.isEmpty()) ? LocalDate.parse(expiresAtStr) : null;

            // Validate
            if (issuedAt != null && issuedAt.isAfter(LocalDate.now())) {
                request.getSession().setAttribute("message", "⚠️ Ngày cấp không được là ngày trong tương lai!");
                response.sendRedirect("managerdocument");
                return;
            }
            if (issuedAt != null && expiresAt != null && issuedAt.isAfter(expiresAt)) {
                request.getSession().setAttribute("message", "⚠️ Ngày cấp không được sau ngày hết hạn!");
                response.sendRedirect("managerdocument");
                return;
            }
            if (issuedAt != null && expiresAt != null) {
                long years = java.time.temporal.ChronoUnit.YEARS.between(issuedAt, expiresAt);
                if (years > 100) {
                    request.getSession().setAttribute("message", "⚠️ Thời hạn chứng chỉ không được vượt quá 100 năm!");
                    response.sendRedirect("managerdocument");
                    return;
                }
            }

            CandidateDocumentDAO dao = new CandidateDocumentDAO();
            CandidateDocument oldDoc = dao.getDocumentById(documentId);
            if (oldDoc == null) {
                request.getSession().setAttribute("message", "❌ Không tìm thấy tài liệu cần chỉnh sửa!");
                response.sendRedirect("managerdocument");
                return;
            }

            String newPath = null;
            long newSize = 0;

            // Nếu có file mới
            if (filePart != null && filePart.getSize() > 0) {
                String webRootPath = getServletContext().getRealPath("/");
                File webFolder = new File(webRootPath);
                if (webFolder.getAbsolutePath().contains(File.separator + "build" + File.separator)) {
                    webFolder = new File(webFolder.getParentFile().getParentFile(), "web");
                }

                File uploadDir = new File(webFolder, "uploads");
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String fileName = System.currentTimeMillis() + "_" + extractFileName(filePart);
                File savedFile = new File(uploadDir, fileName);
                filePart.write(savedFile.getAbsolutePath());

                newPath = "uploads/" + fileName;
                newSize = filePart.getSize();

                // Xóa file cũ nếu tồn tại
                File oldFile = new File(webFolder, oldDoc.getFilePath());
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }

            // Cập nhật
            oldDoc.setTitle(title);
            oldDoc.setDocType(docType);
            oldDoc.setIssuedBy(issuedBy);
            oldDoc.setIssuedAt(issuedAt);
            oldDoc.setExpiresAt(expiresAt);
            if (newPath != null) {
                oldDoc.setFilePath(newPath);
                oldDoc.setFileSize(newSize);
            }

            boolean ok = dao.updateDocument(oldDoc);
            request.getSession().setAttribute("message", ok ? "✅ Cập nhật tài liệu thành công!" : "❌ Cập nhật thất bại!");

        } catch (Exception ex) {
            ex.printStackTrace();
            request.getSession().setAttribute("message", "❌ Lỗi khi cập nhật: " + ex.getMessage());
        }

        response.sendRedirect("managerdocument");
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response, CandidateDocumentDAO dao)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean deleted = dao.deleteDocument(id);

        if (deleted) {
            request.getSession().setAttribute("message", "✅ Xóa tài liệu thành công!");
        } else {
            request.getSession().setAttribute("message", "❌ Không thể xóa tài liệu!");
        }

        response.sendRedirect("managerdocument");
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

            // 🔹 Check có file không
            if (filePart == null || filePart.getSize() == 0) {
                request.getSession().setAttribute("message", "⚠️ Vui lòng chọn tệp để tải lên.");
                response.sendRedirect("managerdocument");
                return;
            }

            // 🔹 Parse ngày
            LocalDate issuedAt = (issuedAtStr != null && !issuedAtStr.isEmpty())
                    ? LocalDate.parse(issuedAtStr)
                    : null;
            LocalDate expiresAt = (expiresAtStr != null && !expiresAtStr.isEmpty())
                    ? LocalDate.parse(expiresAtStr)
                    : null;

            // 🔹 Validate ngày (3 điều kiện)
            if (issuedAt != null && issuedAt.isAfter(LocalDate.now())) {
                request.getSession().setAttribute("message", "⚠️ Ngày cấp không được là ngày trong tương lai!");
                response.sendRedirect("managerdocument");
                return;
            }

            if (issuedAt != null && expiresAt != null && issuedAt.isAfter(expiresAt)) {
                request.getSession().setAttribute("message", "⚠️ Ngày cấp không được sau ngày hết hạn!");
                response.sendRedirect("managerdocument");
                return;
            }

            if (issuedAt != null && expiresAt != null) {
                long years = java.time.temporal.ChronoUnit.YEARS.between(issuedAt, expiresAt);
                if (years > 100) {
                    request.getSession().setAttribute("message", "⚠️ Thời hạn chứng chỉ không được vượt quá 100 năm!");
                    response.sendRedirect("managerdocument");
                    return;
                }
            }

            // 🔹 Xác định thư mục /web/uploads thật (tránh nằm trong /build)
            String webRootPath = getServletContext().getRealPath("/");
            File webFolder = new File(webRootPath);
            if (webFolder.getAbsolutePath().contains(File.separator + "build" + File.separator)) {
                webFolder = new File(webFolder.getParentFile().getParentFile(), "web");
            }

            File uploadDir = new File(webFolder, "uploads");
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 🔹 Tạo tên file an toàn
            String originalFileName = extractFileName(filePart);
            String safeFileName = System.currentTimeMillis() + "_" + originalFileName;
            File savedFile = new File(uploadDir, safeFileName);
            filePart.write(savedFile.getAbsolutePath());

            // 🔹 Lưu model
            CandidateDocument doc = new CandidateDocument();
            doc.setUserId(userId);
            doc.setTitle(title);
            doc.setDocType(docType);
            doc.setIssuedBy(issuedBy);
            doc.setFilePath("uploads/" + safeFileName);
            doc.setFileSize(filePart.getSize());
            doc.setIssuedAt(issuedAt);
            doc.setExpiresAt(expiresAt);

            CandidateDocumentDAO dao = new CandidateDocumentDAO();
            boolean success = dao.uploadDocument(doc);

            if (success) {
                request.getSession().setAttribute("message", "✅ Tải tài liệu thành công!");
            } else {
                request.getSession().setAttribute("message", "❌ Lỗi: không thể lưu dữ liệu vào CSDL.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "❌ Lỗi khi tải tài liệu: " + e.getMessage());
        }

        // ⚡ Redirect để hiển thị modal thông báo (có flash message)
        response.sendRedirect("managerdocument");
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
