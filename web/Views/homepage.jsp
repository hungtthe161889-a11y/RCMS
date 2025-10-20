<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Trang chủ - Tuyển dụng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .hero-section {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 80px 0;
                margin-bottom: 50px;
            }
            .job-card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                margin-bottom: 20px;
                height: 100%;
            }
            .job-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 15px rgba(0,0,0,0.2);
            }
            .job-header {
                border-bottom: 1px solid #eee;
                padding-bottom: 15px;
                margin-bottom: 15px;
            }
            .salary {
                color: #28a745;
                font-weight: bold;
                font-size: 1.1em;
            }
            .badge-custom {
                background: #e9ecef;
                color: #495057;
                padding: 5px 10px;
                border-radius: 20px;
                font-size: 0.8em;
            }
            .company-logo {
                width: 60px;
                height: 60px;
                background: #f8f9fa;
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5em;
                color: #667eea;
                margin-right: 15px;
            }
            .search-section {
                background: white;
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
                margin-top: -50px;
                position: relative;
                z-index: 1;
            }
            .section-title {
                position: relative;
                margin-bottom: 30px;
                padding-bottom: 15px;
            }
            .section-title:after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 60px;
                height: 3px;
                background: #667eea;
                border-radius: 2px;
            }
            .feature-icon {
                width: 50px;
                height: 50px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.2em;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <h1 class="display-4 fw-bold mb-4">Tìm Công Việc Mơ Ước</h1>
                        <p class="lead mb-4">Khám phá hàng ngàn cơ hội việc làm từ các công ty hàng đầu. Bắt đầu sự nghiệp của bạn ngay hôm nay!</p>
                        <a href="#job-listings" class="btn btn-light btn-lg px-4 py-2">
                            <i class="fas fa-search me-2"></i>Tìm Việc Ngay
                        </a>
                    </div>
                    <div class="col-lg-6 text-center">
                        <i class="fas fa-briefcase fa-10x opacity-75"></i>
                    </div>
                </div>
            </div>
        </section>

        <!-- Search Section -->
        <div class="container">
            <div class="search-section">
                <form action="job-posting" method="get" class="row g-3">
                    <input type="hidden" name="action" value="list">
                    <div class="col-md-4">
                        <label class="form-label">Từ khóa</label>
                        <input type="text" name="keyword" class="form-control" placeholder="Vị trí, công ty, kỹ năng...">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Danh mục</label>
                        <select name="categoryId" class="form-select">
                            <option value="">Tất cả danh mục</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category.categoryId}">${category.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Địa điểm</label>
                        <select name="locationId" class="form-select">
                            <option value="">Tất cả địa điểm</option>
                            <c:forEach var="location" items="${locations}">
                                <option value="${location.locationId}">${location.province}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-search me-1"></i>Tìm kiếm
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Job Listings Section -->
        <section id="job-listings" class="py-5">
            <div class="container">
                <div class="row mb-4">
                    <div class="col-12">
                        <h2 class="section-title">Việc Làm Mới Nhất</h2>
                        <p class="text-muted">Khám phá ${not empty activeJobs ? activeJobs.size() : 0} cơ hội việc làm đang chờ đón bạn</p>
                    </div>
                </div>

                <c:if test="${not empty activeJobs}">
                    <div class="row">
                        <c:forEach var="job" items="${activeJobs}">
                            <div class="col-lg-4 col-md-6 mb-4">
                                <div class="card job-card">
                                    <div class="card-body">
                                        <div class="d-flex align-items-start mb-3">
                                            <div class="company-logo">
                                                <i class="fas fa-building"></i>
                                            </div>
                                            <div class="flex-grow-1">
                                                <h5 class="card-title mb-1">${job.title}</h5>
                                                <p class="text-muted mb-0">${job.categoryName}</p>
                                            </div>
                                        </div>

                                        <div class="job-meta mb-3">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <span class="salary">
                                                    <c:choose>
                                                        <c:when test="${job.minSalary != null && job.maxSalary != null}">
                                                            <fmt:formatNumber value="${job.minSalary}" type="number"/> - 
                                                            <fmt:formatNumber value="${job.maxSalary}" type="number"/> VND
                                                        </c:when>
                                                        <c:otherwise>
                                                            Thương lượng
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                                <span class="badge-custom">${job.workType}</span>
                                            </div>
                                            <div class="d-flex text-muted small mb-2">
                                                <span class="me-3">
                                                    <i class="fas fa-map-marker-alt me-1"></i>${job.locationName}
                                                </span>
                                                <span>
                                                    <i class="fas fa-briefcase me-1"></i>${job.experience}
                                                </span>
                                            </div>
                                        </div>

                                        <p class="card-text text-muted small line-clamp-2">
                                            ${job.description.length() > 150 ? job.description.substring(0, 150) + '...' : job.description}
                                        </p>

                                        <div class="d-flex justify-content-between align-items-center">
                                            <small class="text-muted">
                                                <i class="fas fa-clock me-1"></i>
                                                <fmt:parseDate value="${job.postedAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="postedDate"/>
                                                <fmt:formatDate value="${postedDate}" pattern="dd/MM/yyyy"/>
                                            </small>
                                            <a href="home?action=detail&id=${job.jobId}" class="btn btn-outline-primary btn-sm">
                                                Xem chi tiết
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>

                <c:if test="${empty activeJobs}">
                    <div class="text-center py-5">
                        <i class="fas fa-search fa-4x text-muted mb-3"></i>
                        <h4 class="text-muted">Hiện không có việc làm nào</h4>
                        <p class="text-muted">Vui lòng quay lại sau để xem các cơ hội mới</p>
                    </div>
                </c:if>
            </div>
        </section>

        <!-- Features Section -->
        <section class="py-5 bg-light">
            <div class="container">
                <div class="row text-center">
                    <div class="col-lg-4 mb-4">
                        <div class="feature-icon mx-auto">
                            <i class="fas fa-rocket"></i>
                        </div>
                        <h4>Ứng Tuyển Nhanh</h4>
                        <p class="text-muted">Tạo hồ sơ và ứng tuyển chỉ với vài cú click chuột</p>
                    </div>
                    <div class="col-lg-4 mb-4">
                        <div class="feature-icon mx-auto">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h4>Thông Tin Bảo Mật</h4>
                        <p class="text-muted">Thông tin cá nhân của bạn được bảo vệ an toàn</p>
                    </div>
                    <div class="col-lg-4 mb-4">
                        <div class="feature-icon mx-auto">
                            <i class="fas fa-headset"></i>
                        </div>
                        <h4>Hỗ Trợ 24/7</h4>
                        <p class="text-muted">Đội ngũ hỗ trợ luôn sẵn sàng giúp đỡ bạn</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-dark text-white py-4">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <h5>Hệ Thống Tuyển Dụng</h5>
                        <p class="mb-0">Kết nối nhà tuyển dụng và ứng viên một cách hiệu quả nhất</p>
                    </div>
                    <div class="col-md-6 text-end">
                        <p class="mb-0">&copy; 2024 Recruitment System. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Smooth scroll for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    document.querySelector(this.getAttribute('href')).scrollIntoView({
                        behavior: 'smooth'
                    });
                });
            });
        </script>
    </body>
</html>