<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Tin tuyển dụng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .detail-container {
            max-width: 1000px;
            margin: 20px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .job-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
        }
        .info-card {
            border-left: 4px solid #007bff;
            background: #f8f9fa;
        }
        .requirement-card {
            border-left: 4px solid #28a745;
            background: #f8f9fa;
        }
        .salary-card {
            border-left: 4px solid #ffc107;
            background: #f8f9fa;
        }
        .deadline-card {
            border-left: 4px solid #dc3545;
            background: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="detail-container">
        <!-- Header -->
        <div class="job-header">
            <div class="d-flex justify-content-between align-items-start">
                <div>
                    <h1 class="h2 mb-2">${job.title}</h1>
                    <div class="d-flex flex-wrap gap-3">
                        <span class="badge bg-light text-dark">
                            <i class="fas fa-building me-1"></i>${category.categoryName}
                        </span>
                        <span class="badge bg-light text-dark">
                            <i class="fas fa-map-marker-alt me-1"></i>${location.province}
                        </span>
                        <span class="badge bg-light text-dark">
                            <i class="fas fa-clock me-1"></i>${job.workType}
                        </span>
                    </div>
                </div>
                <div class="text-end">
                    <c:choose>
                        <c:when test="${job.status == 'active'}">
                            <span class="badge bg-success fs-6">ĐANG TUYỂN</span>
                        </c:when>
                        <c:when test="${job.status == 'inactive'}">
                            <span class="badge bg-danger fs-6">NGỪNG TUYỂN</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary fs-6">BẢN NHÁP</span>
                        </c:otherwise>
                    </c:choose>
                    <div class="mt-2">
                        <a href="job-posting?action=list" class="btn btn-light btn-sm">
                            <i class="fas fa-arrow-left me-1"></i>Quay lại
                        </a>
                        <a href="job-posting?action=edit&id=${job.jobId}" class="btn btn-warning btn-sm">
                            <i class="fas fa-edit me-1"></i>Chỉnh sửa
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="p-4">
            <div class="row">
                <!-- Left Column -->
                <div class="col-md-8">
                    <!-- Job Description -->
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0"><i class="fas fa-tasks me-2"></i>Mô tả công việc</h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${not empty job.description}">
                                    <div style="white-space: pre-line;">${job.description}</div>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted fst-italic">Chưa có mô tả công việc</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Requirements -->
                    <div class="card mb-4">
                        <div class="card-header bg-success text-white">
                            <h5 class="mb-0"><i class="fas fa-list-check me-2"></i>Yêu cầu công việc</h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${not empty job.requirement}">
                                    <div style="white-space: pre-line;">${job.requirement}</div>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted fst-italic">Chưa có yêu cầu công việc</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Benefits -->
                    <c:if test="${not empty job.income || not empty job.interest}">
                        <div class="card mb-4">
                            <div class="card-header bg-info text-white">
                                <h5 class="mb-0"><i class="fas fa-gift me-2"></i>Phúc lợi & Quyền lợi</h5>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty job.income}">
                                    <h6>Phúc lợi:</h6>
                                    <div style="white-space: pre-line;" class="mb-3">${job.income}</div>
                                </c:if>
                                <c:if test="${not empty job.interest}">
                                    <h6>Quyền lợi khác:</h6>
                                    <div style="white-space: pre-line;">${job.interest}</div>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Right Column -->
                <div class="col-md-4">
                    <!-- Salary Information -->
                    <div class="card mb-3 salary-card">
                        <div class="card-body">
                            <h6 class="card-title"><i class="fas fa-money-bill-wave me-2"></i>Mức lương</h6>
                            <c:if test="${job.minSalary != null && job.maxSalary != null}">
                                <h4 class="text-warning">${job.minSalary} - ${job.maxSalary}</h4>
                            </c:if>
                            <c:if test="${job.minSalary == null || job.maxSalary == null}">
                                <p class="text-muted fst-italic">Thương lượng</p>
                            </c:if>
                        </div>
                    </div>

                    <!-- Quantity Information -->
                    <div class="card mb-3 info-card">
                        <div class="card-body">
                            <h6 class="card-title"><i class="fas fa-users me-2"></i>Số lượng tuyển</h6>
                            <p class="card-text fs-5">${job.quantity}</p>
                        </div>
                    </div>

                    <!-- Deadline Information -->
                    <div class="card mb-3 deadline-card">
                        <div class="card-body">
                            <h6 class="card-title"><i class="fas fa-calendar-times me-2"></i>Hạn nộp hồ sơ</h6>
                            <c:choose>
                                <c:when test="${job.expiredAt.isBefore(java.time.LocalDateTime.now())}">
                                    <p class="card-text text-danger fs-5">
                                        <i class="fas fa-exclamation-triangle me-1"></i>
                                        ${job.expiredAt.toLocalDate()}
                                    </p>
                                    <small class="text-danger">Đã hết hạn</small>
                                </c:when>
                                <c:otherwise>
                                    <p class="card-text fs-5">${job.expiredAt.toLocalDate()}</p>
                                    <small class="text-muted">
                                        Còn ${java.time.temporal.ChronoUnit.DAYS.between(java.time.LocalDate.now(), job.expiredAt.toLocalDate())} ngày
                                    </small>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Job Details -->
                    <div class="card mb-3">
                        <div class="card-header">
                            <h6 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin chi tiết</h6>
                        </div>
                        <div class="card-body">
                            <table class="table table-sm table-borderless">
                                <tr>
                                    <td