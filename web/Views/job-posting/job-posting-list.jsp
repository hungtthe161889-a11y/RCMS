<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    // Tạo biến now trong scriptlet để sử dụng trong JSTL
    pageContext.setAttribute("now", java.time.LocalDateTime.now());
%>
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
            .status-active {
                color: #28a745;
                font-weight: bold;
            }
            .status-inactive {
                color: #dc3545;
                font-weight: bold;
            }
            .status-draft {
                color: #6c757d;
                font-weight: bold;
            }
            .table th {
                background-color: #2c3e50;
                color: white;
                border: none;
                padding: 12px 15px;
            }
            .table td {
                padding: 12px 15px;
                vertical-align: middle;
            }
            .btn-group-sm > .btn {
                padding: 0.25rem 0.5rem;
            }
            .stat-card {
                transition: transform 0.2s;
            }
            .stat-card:hover {
                transform: translateY(-5px);
            }
        </style>
    </head>
    <body>
        <div class="container-fluid py-4">
            <div class="table-container">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="fas fa-briefcase me-2"></i>Quản lý Tin tuyển dụng</h2>
                    <a href="job-posting?action=create" class="btn btn-primary">
                        <i class="fas fa-plus me-1"></i>Tạo tin mới
                    </a>
                </div>

                <!-- Alert Messages -->
                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
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
                                <a href="job-posting?action=list" class="btn btn-outline-secondary">
                                    <i class="fas fa-times me-1"></i>Xóa bộ lọc
                                </a>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Statistics -->
                <c:if test="${not empty jobPostings}">
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="card text-white bg-primary stat-card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h4>${jobPostings.size()}</h4>
                                            <p class="mb-0">Tổng số tin</p>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-briefcase fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-white bg-success stat-card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h4>
                                                <c:set var="activeCount" value="0" />
                                                <c:forEach var="job" items="${jobPostings}">
                                                    <c:if test="${job.status == 'active'}">
                                                        <c:set var="activeCount" value="${activeCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${activeCount}
                                            </h4>
                                            <p class="mb-0">Đang tuyển</p>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-play-circle fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-white bg-warning stat-card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h4>
                                                <c:set var="expiredCount" value="0" />
                                                <c:forEach var="job" items="${jobPostings}">
                                                    <c:if test="${job.expiredAt.isBefore(now)}">
                                                        <c:set var="expiredCount" value="${expiredCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${expiredCount}
                                            </h4>
                                            <p class="mb-0">Đã hết hạn</p>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-exclamation-triangle fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card text-white bg-info stat-card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between">
                                        <div>
                                            <h4>
                                                <c:set var="draftCount" value="0" />
                                                <c:forEach var="job" items="${jobPostings}">
                                                    <c:if test="${job.status == 'draft'}">
                                                        <c:set var="draftCount" value="${draftCount + 1}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${draftCount}
                                            </h4>
                                            <p class="mb-0">Bản nháp</p>
                                        </div>
                                        <div class="align-self-center">
                                            <i class="fas fa-edit fa-2x"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>

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
                                    <td><strong>#${job.jobId}</strong></td>
                                    <td>
                                        <div>
                                            <strong class="text-primary">${job.title}</strong>
                                            <c:if test="${job.workType != null && !job.workType.isEmpty()}">
                                                <br>
                                                <small class="text-muted">
                                                    <i class="fas fa-clock me-1"></i>${job.workType}
                                                </small>
                                            </c:if>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge bg-info text-dark">${job.categoryName}</span>
                                    </td>
                                    <td>
                                        <small>${job.locationName}</small>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${job.minSalary != null && job.maxSalary != null}">
                                                <strong class="text-success">
                                                    <fmt:formatNumber value="${job.minSalary}" type="number" /> - 
                                                    <fmt:formatNumber value="${job.maxSalary}" type="number" /> VND
                                                </strong>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Thương lượng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${job.quantity != null && !job.quantity.isEmpty()}">
                                                <span class="badge bg-secondary">${job.quantity}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Không giới hạn</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${job.status == 'active'}">
                                                <span class="status-active">
                                                    <i class="fas fa-play-circle me-1"></i>Đang tuyển
                                                </span>
                                            </c:when>
                                            <c:when test="${job.status == 'inactive'}">
                                                <span class="status-inactive">
                                                    <i class="fas fa-stop-circle me-1"></i>Ngừng tuyển
                                                </span>
                                            </c:when>
                                            <c:when test="${job.status == 'draft'}">
                                                <span class="status-draft">
                                                    <i class="fas fa-edit me-1"></i>Bản nháp
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">${job.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${job.postedAt != null}">
                                                <small>${job.postedAt.toLocalDate()}</small>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">N/A</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${job.expiredAt.isBefore(now)}">
                                                <span class="text-danger">
                                                    <i class="fas fa-exclamation-triangle me-1"></i>
                                                    <small>${job.expiredAt.toLocalDate()}</small>
                                                </span>
                                                <br>
                                                <small class="text-danger">Đã hết hạn</small>
                                            </c:when>
                                            <c:otherwise>
                                                <small>${job.expiredAt.toLocalDate()}</small>
                                                <br>
                                                <small class="text-muted">
                                                    Còn ${java.time.temporal.ChronoUnit.DAYS.between(java.time.LocalDate.now(), job.expiredAt.toLocalDate())} ngày
                                                </small>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="job-posting?action=detail&id=${job.jobId}" 
                                               class="btn btn-info" title="Xem chi tiết">
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

                <!-- Empty State -->
                <c:if test="${empty jobPostings}">
                    <div class="text-center py-5">
                        <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
                        <h4 class="text-muted">Không có tin tuyển dụng nào</h4>
                        <p class="text-muted mb-4">Hãy tạo tin tuyển dụng đầu tiên của bạn</p>
                        <a href="job-posting?action=create" class="btn btn-primary btn-lg">
                            <i class="fas fa-plus me-2"></i>Tạo tin đầu tiên
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                        function confirmDelete(jobId) {
                                                            if (confirm('Bạn có chắc chắn muốn xóa tin tuyển dụng này?\nHành động này không thể hoàn tác.')) {
                                                                window.location.href = 'job-posting?action=delete&id=' + jobId;
                                                            }
                                                        }

                                                        // Auto-dismiss alerts after 5 seconds
                                                        document.addEventListener('DOMContentLoaded', function () {
                                                            const alerts = document.querySelectorAll('.alert');
                                                            alerts.forEach(function (alert) {
                                                                setTimeout(function () {
                                                                    const bsAlert = new bootstrap.Alert(alert);
                                                                    bsAlert.close();
                                                                }, 5000);
                                                            });
                                                        });
        </script>
    </body>
</html>