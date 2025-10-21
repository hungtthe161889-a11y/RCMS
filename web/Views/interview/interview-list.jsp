<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý lịch phỏng vấn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .table-actions {
            white-space: nowrap;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="#">
                            <i class="fas fa-calendar-alt"></i> Quản lý phỏng vấn
                        </a>
                    </div>
                </nav>

                <!-- Thông báo -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-list"></i> Danh sách lịch phỏng vấn
                        </h5>
                        <a href="interview?action=create" class="btn btn-success">
                            <i class="fas fa-plus"></i> Tạo lịch mới
                        </a>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty interviews}">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>ID</th>
                                                <th>Application ID</th>
                                                <th>Thời gian</th>
                                                <th>Địa điểm</th>
                                                <th>Người phỏng vấn</th>
                                                <th>Ghi chú</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="interview" items="${interviews}">
                                                <tr>
                                                    <td>${interview.interviewId}</td>
                                                    <td>${interview.applicationId}</td>
                                                    <td>${interview.scheduledAt}</td>
                                                    <td>${interview.locationId}</td>
                                                    <td>${interview.interviewerFullname}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty interview.notes && interview.notes.length() > 50}">
                                                                ${interview.notes.substring(0, 50)}...
                                                            </c:when>
                                                            <c:when test="${not empty interview.notes}">
                                                                ${interview.notes}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Không có ghi chú</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="table-actions">
                                                        <a href="interview?action=edit&id=${interview.interviewId}" 
                                                           class="btn btn-sm btn-warning" title="Chỉnh sửa">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <a href="interview?action=delete&id=${interview.interviewId}" 
                                                           class="btn btn-sm btn-danger" 
                                                           onclick="return confirm('Bạn có chắc chắn muốn xóa lịch phỏng vấn này?')"
                                                           title="Xóa">
                                                            <i class="fas fa-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-4">
                                    <i class="fas fa-calendar-times fa-3x text-muted mb-3"></i>
                                    <p class="text-muted">Chưa có lịch phỏng vấn nào được tạo.</p>
                                    <a href="interview?action=create" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Tạo lịch đầu tiên
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>