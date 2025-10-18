<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${isEdit ? 'Chỉnh sửa' : 'Tạo mới'} Tin tuyển dụng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .required:after {
                content: " *";
                color: red;
            }
            .form-container {
                max-width: 1400px;
                margin: 20px auto;
                padding: 30px;
                background: #f8f9fa;
                border-radius: 15px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }
            .card {
                border: none;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.08);
                margin-bottom: 20px;
            }
            .card-header {
                border-radius: 10px 10px 0 0 !important;
                font-weight: 600;
            }
            .form-control, .form-select {
                border-radius: 8px;
                border: 1px solid #dee2e6;
                padding: 10px 15px;
            }
            .form-control:focus, .form-select:focus {
                border-color: #86b7fe;
                box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
            }
            .btn {
                border-radius: 8px;
                padding: 10px 25px;
                font-weight: 500;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="form-container">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="mb-1">${isEdit ? 'Chỉnh sửa' : 'Tạo mới'} Tin tuyển dụng</h2>
                        <p class="text-muted mb-0">Quản lý thông tin tin tuyển dụng của bạn</p>
                    </div>
                    <a href="job-posting?action=list" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                    </a>
                </div>

                <!-- Error Message -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- Main Form -->
                <form method="post" action="job-posting?action=${isEdit ? 'update' : 'store'}" id="jobForm">
                    <c:if test="${isEdit}">
                        <input type="hidden" name="jobId" value="${job.jobId}">
                    </c:if>

                    <div class="row">
                        <!-- Left Column - Basic Information -->
                        <div class="col-lg-6">
                            <!-- Basic Information Card -->
                            <div class="card">
                                <div class="card-header bg-primary text-white">
                                    <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Thông tin cơ bản</h5>
                                </div>
                                <div class="card-body">
                                    <!-- Title -->
                                    <div class="mb-3">
                                        <label class="form-label required">Tiêu đề tin tuyển dụng</label>
                                        <input type="text" class="form-control" name="title" 
                                               value="${job.title}" required maxlength="1048"
                                               placeholder="Ví dụ: Lập trình viên Java Spring Boot">
                                        <div class="form-text">Tiêu đề hấp dẫn sẽ thu hút nhiều ứng viên hơn</div>
                                    </div>

                                    <!-- Category & Location -->
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label required">Danh mục</label>
                                                <select class="form-select" name="categoryId" required>
                                                    <option value="">Chọn danh mục</option>
                                                    <c:forEach var="category" items="${categories}">
                                                        <option value="${category.categoryId}" 
                                                                ${job.categoryId == category.categoryId ? 'selected' : ''}>
                                                            ${category.categoryName}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label required">Địa điểm làm việc</label>
                                                <select class="form-select" name="locationId" required>
                                                    <option value="">Chọn địa điểm</option>
                                                    <c:forEach var="location" items="${locations}">
                                                        <option value="${location.locationId}" 
                                                                ${job.locationId == location.locationId ? 'selected' : ''}>
                                                            ${location.province} - ${location.ward}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Experience & Level -->
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Kinh nghiệm yêu cầu</label>
                                                <input type="text" class="form-control" name="experience" 
                                                       value="${job.experience}" 
                                                       placeholder="Ví dụ: 2-5 năm, Không yêu cầu">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Cấp bậc</label>
                                                <input type="text" class="form-control" name="level" 
                                                       value="${job.level}" 
                                                       placeholder="Ví dụ: Junior, Senior, Manager">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Education & Quantity -->
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Yêu cầu học vấn</label>
                                                <input type="text" class="form-control" name="education" 
                                                       value="${job.education}" 
                                                       placeholder="Ví dụ: Đại học, Cao đẳng">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label">Số lượng tuyển</label>
                                                <input type="text" class="form-control" name="quantity" 
                                                       value="${job.quantity}" 
                                                       placeholder="Ví dụ: 5 người, Không giới hạn">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Work Type -->
                                    <div class="mb-3">
                                        <label class="form-label">Hình thức làm việc</label>
                                        <input type="text" class="form-control" name="workType" 
                                               value="${job.workType}" 
                                               placeholder="Ví dụ: Toàn thời gian, Bán thời gian, Remote">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right Column - Details -->
                        <div class="col-lg-6">
                            <!-- Salary & Status Card -->
                            <div class="card">
                                <div class="card-header bg-success text-white">
                                    <h5 class="mb-0"><i class="fas fa-money-bill-wave me-2"></i>Thông tin lương & trạng thái</h5>
                                </div>
                                <div class="card-body">
                                    <!-- Salary Range -->
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label required">Lương tối thiểu (VND)</label>
                                                <input type="number" class="form-control" name="minSalary" 
                                                       value="${job.minSalary}" 
                                                       min="0" step="100000" 
                                                       placeholder="0">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label required">Lương tối đa (VND)</label>
                                                <input type="number" class="form-control" name="maxSalary" 
                                                       value="${job.maxSalary}" 
                                                       min="0" step="100000" 
                                                       placeholder="0">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Status & Deadline -->
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label required">Trạng thái</label>
                                                <select class="form-select" name="status" required>
                                                    <option value="active" ${job.status == 'active' ? 'selected' : ''}>
                                                        🟢 Đang tuyển
                                                    </option>
                                                    <option value="inactive" ${job.status == 'inactive' ? 'selected' : ''}>
                                                        🔴 Ngừng tuyển
                                                    </option>
                                                    <option value="draft" ${job.status == 'draft' ? 'selected' : ''}>
                                                        📝 Bản nháp
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label required">Hạn nộp hồ sơ</label>
                                                <input type="date" class="form-control" name="expiredAt" 
                                                       value="<c:choose>
                                                           <c:when test="${job.expiredAt != null}">${job.expiredAt.toLocalDate()}</c:when>
                                                           <c:otherwise>${java.time.LocalDate.now().plusMonths(1)}</c:otherwise>
                                                       </c:choose>" 
                                                       required min="${java.time.LocalDate.now()}">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Benefits -->
                                    <div class="mb-3">
                                        <label class="form-label">Phúc lợi</label>
                                        <textarea class="form-control" name="income" rows="3" 
                                                  placeholder="Mô tả các phúc lợi như bảo hiểm, thưởng, du lịch...">${job.income}</textarea>
                                    </div>

                                    <!-- Other Interests -->
                                    <div class="mb-3">
                                        <label class="form-label">Quyền lợi khác</label>
                                        <textarea class="form-control" name="interest" rows="3" 
                                                  placeholder="Các quyền lợi bổ sung khác...">${job.interest}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Job Description -->
                    <div class="card">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0"><i class="fas fa-tasks me-2"></i>Mô tả công việc</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label required">Mô tả chi tiết công việc</label>
                                <textarea class="form-control" name="description" rows="8" 
                                          placeholder="Mô tả chi tiết về công việc, trách nhiệm, nhiệm vụ cụ thể..."
                                          required>${job.description}</textarea>
                                <div class="form-text">Mô tả rõ ràng sẽ giúp ứng viên hiểu rõ về công việc</div>
                            </div>
                        </div>
                    </div>

                    <!-- Job Requirements -->
                    <div class="card">
                        <div class="card-header bg-warning text-dark">
                            <h5 class="mb-0"><i class="fas fa-list-check me-2"></i>Yêu cầu công việc</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label required">Yêu cầu chi tiết</label>
                                <textarea class="form-control" name="requirement" rows="8" 
                                          placeholder="Các yêu cầu về kỹ năng, kinh nghiệm, bằng cấp..."
                                          required>${job.requirement}</textarea>
                                <div class="form-text">Liệt kê các yêu cầu cụ thể về kỹ năng và kinh nghiệm</div>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="d-flex justify-content-between align-items-center pt-4 border-top">
                        <div>
                            <a href="job-posting?action=list" class="btn btn-outline-secondary">
                                <i class="fas fa-times me-2"></i>Hủy bỏ
                            </a>
                        </div>
                        <div>
                            <button type="submit" class="btn btn-primary btn-lg">
                                <c:choose>
                                    <c:when test="${isEdit}">
                                        <i class="fas fa-save me-2"></i>Cập nhật tin tuyển dụng
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-plus me-2"></i>Tạo tin tuyển dụng
                                    </c:otherwise>
                                </c:choose>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Form validation
            document.getElementById('jobForm').addEventListener('submit', function (e) {
                const minSalary = document.querySelector('input[name="minSalary"]').value;
                const maxSalary = document.querySelector('input[name="maxSalary"]').value;

                if (parseInt(minSalary) > parseInt(maxSalary)) {
                    e.preventDefault();
                    alert('Lương tối thiểu không thể lớn hơn lương tối đa!');
                    return false;
                }

                const expiredAt = document.querySelector('input[name="expiredAt"]').value;
                const today = new Date().toISOString().split('T')[0];

                if (expiredAt < today) {
                    e.preventDefault();
                    alert('Hạn nộp hồ sơ không thể là ngày trong quá khứ!');
                    return false;
                }
            });

            // Set minimum date for expiredAt to today
            document.addEventListener('DOMContentLoaded', function () {
                const today = new Date().toISOString().split('T')[0];
                const expiredAtInput = document.querySelector('input[name="expiredAt"]');
                if (!expiredAtInput.value) {
                    // Set default to 1 month from today
                    const oneMonthLater = new Date();
                    oneMonthLater.setMonth(oneMonthLater.getMonth() + 1);
                    const oneMonthLaterStr = oneMonthLater.toISOString().split('T')[0];
                    expiredAtInput.value = oneMonthLaterStr;
                }
                expiredAtInput.min = today;
            });
        </script>
    </body>
</html>