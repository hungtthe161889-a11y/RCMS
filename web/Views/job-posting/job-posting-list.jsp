<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Tin tuyển dụng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .table-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .status-active { color: #28a745; font-weight: bold; }
        .status-inactive { color: #dc3545; font-weight: bold; }
        .status-draft { color: #6c757d; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container-fluid py-4">
        <div class="table-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="fas fa-briefcase me-2"></i>Quản lý Tin tuyển dụng</h2>
                <a href="job-posting?action=create" class="btn btn-primary">
                    <i class="fas fa-plus me-1"></i>Tạo tin mới
                </a>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Filter Section -->
            <div class="card mb-4">
                <div class="card-body">
                    <form method="get" action="job-posting" class="row g-3 align-items-end">
                        <input type="hidden" name="action" value="list">
                        <div class="col-md-4">
                            <label class="form-label">Lọc theo trạng thái</label>
                            <select name="status" class="form-select" onchange="this.form.submit()">
                                <option value="">Tất cả trạng thái</option>
                                <option value="active" ${param.status == 'active' ? 'selected' : ''}>Đang tuyển</option>
                                <option value="inactive" ${param.status == 'inactive' ? 'selected' : ''}>Ngừng tuyển</option>
                                <option value="draft" ${param.status == 'draft' ? 'selected' : ''}>Bản nháp</option>
                            </select>
                        </div>
                        <div class="col-md-8 text-end">
                            <a href="job-posting?action=list" class="btn btn-outline-secondary">Xóa bộ lọc</a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Table -->
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Tiêu đề</th>
                            <th>Danh mục</th>
                            <th>Địa điểm</th>
                            <th>Mức lương</th>
                            <th>Số lượng</th>
                            <th>Trạng thái</th>
                            <th>Ngày đăng</th>
                            <th>Hạn nộp</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="job" items="${jobPostings}">
                            <tr>
                                <td>${job.jobId}</td>
                                <td>
                                    <strong>${job.title}</strong>
                                    <c:if test="${job.workType != null}">
                                        <br><small class="text-muted">${job.workType}</small>
                                    </c:if>
                                </td>
                                <td>
                                    <c:set var="category" value="${jobPostingDAO.getCategoryById(job.categoryId)}" />
                                    ${category.categoryName}
                                </td>
                                <td>
                                    <c:set var="location" value="${jobPostingDAO.getLocationById(job.locationId)}" />
                                    ${location.province}
                                </td>
                                <td>
                                    <c:if test="${job.minSalary != null && job.maxSalary != null}">
                                        ${job.minSalary} - ${job.maxSalary}
                                    </c:if>
                                </td>
                                <td>${job.quantity}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${job.status == 'active'}">
                                            <span class="status-active"><i class="fas fa-play-circle me-1"></i>Đang tuyển</span>
                                        </c:when>
                                        <c:when test="${job.status == 'inactive'}">
                                            <span class="status-inactive"><i class="fas fa-stop-circle me-1"></i>Ngừng tuyển</span>
                                        </c:when>
                                        <c:when test="${job.status == 'draft'}">
                                            <span class="status-draft"><i class="fas fa-edit me-1"></i>Bản nháp</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td>${job.postedAt.toLocalDate()}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${job.expiredAt.isBefore(java.time.LocalDateTime.now())}">
                                            <span class="text-danger"><i class="fas fa-exclamation-triangle me-1"></i>${job.expiredAt.toLocalDate()}</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${job.expiredAt.toLocalDate()}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="btn-group btn-group-sm">
                                        <a href="job-posting?action=detail&id=${job.jobId}" 
                                           class="btn btn-info" title="Chi tiết">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        <a href="job-posting?action=edit&id=${job.jobId}" 
                                           class="btn btn-warning" title="Chỉnh sửa">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <button type="button" class="btn btn-danger" 
                                                onclick="confirmDelete(${job.jobId})" title="Xóa">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <c:if test="${empty jobPostings}">
                <div class="text-center py-5">
                    <i class="fas fa-inbox fa-3x text-muted mb-3"></i>
                    <h4 class="text-muted">Không có tin tuyển dụng nào</h4>
                    <p class="text-muted">Hãy tạo tin tuyển dụng đầu tiên của bạn</p>
                    <a href="job-posting?action=create" class="btn btn-primary">
                        <i class="fas fa-plus me-1"></i>Tạo tin đầu tiên
                    </a>
                </div>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(jobId) {
            if (confirm('Bạn có chắc chắn muốn xóa tin tuyển dụng này?')) {
                window.location.href = 'job-posting?action=delete&id=' + jobId;
            }
        }
    </script>
</body>
</html>