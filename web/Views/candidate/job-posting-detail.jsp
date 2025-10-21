<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${job.title} - Tuyển dụng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .job-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 50px 0;
                margin-bottom: 30px;
            }
            .job-content {
                background: white;
                border-radius: 15px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                padding: 30px;
                margin-bottom: 30px;
            }
            .company-logo {
                width: 80px;
                height: 80px;
                background: white;
                border-radius: 15px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2em;
                color: #667eea;
                margin-right: 20px;
            }
            .job-meta-item {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
                padding: 10px 15px;
                background: #f8f9fa;
                border-radius: 10px;
            }
            .job-meta-item i {
                width: 20px;
                margin-right: 10px;
                color: #667eea;
            }
            .section-title {
                border-left: 4px solid #667eea;
                padding-left: 15px;
                margin: 25px 0 15px 0;
                font-weight: 600;
            }
            .related-job-card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                margin-bottom: 15px;
            }
            .related-job-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(0,0,0,0.15);
            }
            .apply-btn {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                border: none;
                padding: 12px 30px;
                font-weight: 600;
                border-radius: 25px;
                transition: all 0.3s ease;
            }
            .apply-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
            }
            .tag {
                background: #e9ecef;
                color: #495057;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 0.85em;
                margin-right: 8px;
                margin-bottom: 8px;
                display: inline-block;
            }
            .salary-badge {
                background: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
                color: #000;
                padding: 8px 15px;
                border-radius: 20px;
                font-weight: bold;
                font-size: 1.1em;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
            <div class="container">
                <a class="navbar-brand fw-bold text-primary" href="home">
                    <i class="fas fa-briefcase me-2"></i>Recruitment
                </a>
                <div class="navbar-nav ms-auto">
                    <a class="nav-link" href="home">
                        <i class="fas fa-home me-1"></i>Trang chủ
                    </a>
                </div>
            </div>
        </nav>

        <!-- Job Header -->
        <div class="job-header">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h1 class="display-5 fw-bold mb-3">${job.title}</h1>
                        <div class="d-flex flex-wrap gap-3 mb-3">
                            <span class="salary-badge">
                                <c:choose>
                                    <c:when test="${job.minSalary != null && job.maxSalary != null}">
                                        <i class="fas fa-money-bill-wave me-2"></i>
                                        <fmt:formatNumber value="${job.minSalary}" type="number"/> - 
                                        <fmt:formatNumber value="${job.maxSalary}" type="number"/> VND
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-money-bill-wave me-2"></i>Thương lượng
                                    </c:otherwise>
                                </c:choose>
                            </span>
                            <span class="tag bg-white text-dark">
                                <i class="fas fa-building me-1"></i>${job.categoryName}
                            </span>
                            <span class="tag bg-white text-dark">
                                <i class="fas fa-map-marker-alt me-1"></i>${job.locationName}
                            </span>
                        </div>
                        <div class="d-flex flex-wrap gap-2">
                            <c:if test="${not empty job.workType}">
                                <span class="tag bg-light">${job.workType}</span>
                            </c:if>
                            <c:if test="${not empty job.experience}">
                                <span class="tag bg-light">${job.experience}</span>
                            </c:if>
                            <c:if test="${not empty job.level}">
                                <span class="tag bg-light">${job.level}</span>
                            </c:if>
                        </div>
                    </div>
                    <div class="col-md-4 text-center">
                        <div class="company-logo mx-auto mb-3">
                            <i class="fas fa-building"></i>
                        </div>
                        <c:if test="${sessionScope.user != null}">
                            <button class="btn apply-btn btn-lg" data-bs-toggle="modal" data-bs-target="#applyModal">
                                <i class="fas fa-paper-plane me-2"></i>Ứng Tuyển Ngay
                            </button>
                        </c:if>
                        <c:if test="${sessionScope.user == null}">
                            <a href="login" class="btn apply-btn btn-lg">
                                <i class="fas fa-sign-in-alt me-2"></i>Đăng Nhập Để Ứng Tuyển
                            </a>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <!-- Main Content -->
                <div class="col-lg-8">
                    <div class="job-content">
                        <!-- Mô tả công việc -->
                        <c:if test="${not empty job.description}">
                            <h3 class="section-title">Mô Tả Công Việc</h3>
                            <div class="content-text">
                                ${job.description}
                            </div>
                        </c:if>

                        <!-- Yêu cầu công việc -->
                        <c:if test="${not empty job.requirement}">
                            <h3 class="section-title">Yêu Cầu Công Việc</h3>
                            <div class="content-text">
                                ${job.requirement}
                            </div>
                        </c:if>

                        <!-- Quyền lợi -->
                        <c:if test="${not empty job.income}">
                            <h3 class="section-title">Quyền Lợi</h3>
                            <div class="content-text">
                                ${job.income}
                            </div>
                        </c:if>

                        <!-- Thông tin khác -->
                        <c:if test="${not empty job.interest}">
                            <h3 class="section-title">Thông Tin Khác</h3>
                            <div class="content-text">
                                ${job.interest}
                            </div>
                        </c:if>

                        <!-- Thông tin tuyển dụng -->
                        <h3 class="section-title">Thông Tin Tuyển Dụng</h3>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="job-meta-item">
                                    <i class="fas fa-users"></i>
                                    <div>
                                        <strong>Số lượng:</strong> ${job.quantity}
                                    </div>
                                </div>
                                <div class="job-meta-item">
                                    <i class="fas fa-graduation-cap"></i>
                                    <div>
                                        <strong>Học vấn:</strong> ${job.education}
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="job-meta-item">
                                    <i class="fas fa-clock"></i>
                                    <div>
                                        <strong>Hình thức:</strong> ${job.workType}
                                    </div>
                                </div>
                                <div class="job-meta-item">
                                    <i class="fas fa-calendar-alt"></i>
                                    <div>
                                        <strong>Hạn nộp:</strong> 
                                        <fmt:parseDate value="${job.expiredAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="expiredDate"/>
                                        <fmt:formatDate value="${expiredDate}" pattern="dd/MM/yyyy"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sidebar -->
                <div class="col-lg-4">
                    <!-- Thông tin công ty -->
                    <div class="job-content">
                        <h4 class="section-title">Thông Tin Chung</h4>
                        <div class="job-meta-item">
                            <i class="fas fa-calendar-plus"></i>
                            <div>
                                <strong>Ngày đăng:</strong><br>
                                <fmt:parseDate value="${job.postedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="postedDate"/>
                                <fmt:formatDate value="${postedDate}" pattern="dd/MM/yyyy"/>
                            </div>
                        </div>
                        <div class="job-meta-item">
                            <i class="fas fa-calendar-times"></i>
                            <div>
                                <strong>Hạn nộp:</strong><br>
                                <fmt:parseDate value="${job.expiredAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="expiredDate"/>
                                <fmt:formatDate value="${expiredDate}" pattern="dd/MM/yyyy"/>
                            </div>
                        </div>
                        <div class="job-meta-item">
                            <i class="fas fa-eye"></i>
                            <div>
                                <strong>Trạng thái:</strong><br>
                                <span class="text-success">Đang tuyển dụng</span>
                            </div>
                        </div>
                    </div>

                    <!-- Việc làm liên quan -->
                    <c:if test="${not empty relatedJobs}">
                        <div class="job-content">
                            <h4 class="section-title">Việc Làm Liên Quan</h4>
                            <c:forEach var="relatedJob" items="${relatedJobs}">
                                <div class="card related-job-card">
                                    <div class="card-body">
                                        <h6 class="card-title">
                                            <a href="home?action=detail&id=${relatedJob.jobId}" class="text-decoration-none">
                                                ${relatedJob.title}
                                            </a>
                                        </h6>
                                        <p class="card-text small text-muted mb-2">
                                            <i class="fas fa-map-marker-alt me-1"></i>${relatedJob.locationName}
                                        </p>
                                        <p class="card-text small">
                                            <c:choose>
                                                <c:when test="${relatedJob.minSalary != null && relatedJob.maxSalary != null}">
                                                    <strong class="text-success">
                                                        <fmt:formatNumber value="${relatedJob.minSalary}" type="number"/> - 
                                                        <fmt:formatNumber value="${relatedJob.maxSalary}" type="number"/> VND
                                                    </strong>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Thương lượng</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        <a href="home?action=detail&id=${relatedJob.jobId}" class="btn btn-outline-primary btn-sm w-100">
                                            Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="bg-dark text-white py-4 mt-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <h5>Hệ Thống Tuyển Dụng</h5>
                        <p class="mb-0">Kết nối nhà tuyển dụng và ứng viên</p>
                    </div>
                    <div class="col-md-6 text-end">
                        <p class="mb-0">&copy; 2024 Recruitment System. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>