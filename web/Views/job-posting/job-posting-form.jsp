<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${isEdit ? 'Chỉnh sửa' : 'Tạo mới'} Tin tuyển dụng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .required:after {
            content: " *";
            color: red;
        }
        .form-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="form-container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>${isEdit ? 'Chỉnh sửa' : 'Tạo mới'} Tin tuyển dụng</h2>
                <a href="job-posting?action=list" class="btn btn-secondary">Quay lại</a>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <form method="post" action="job-posting?action=${isEdit ? 'update' : 'store'}">
                <c:if test="${isEdit}">
                    <input type="hidden" name="jobId" value="${job.jobId}">
                </c:if>

                <div class="row">
                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0">Thông tin cơ bản</h5>
                            </div>
                            <div class="card-body">
                                <div class="mb-3">
                                    <label class="form-label required">Tiêu đề</label>
                                    <input type="text" class="form-control" name="title" 
                                           value="${job.title}" required maxlength="255">
                                </div>

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
                                            <label class="form-label required">Địa điểm</label>
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

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Kinh nghiệm</label>
                                            <input type="text" class="form-control" name="experience" 
                                                   value="${job.experience}" placeholder="Ví dụ: 2-5 năm">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Cấp bậc</label>
                                            <input type="text" class="form-control" name="level" 
                                                   value="${job.level}" placeholder="Ví dụ: Nhân viên, Senior">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Học vấn</label>
                                            <input type="text" class="form-control" name="education" 
                                                   value="${job.education}" placeholder="Ví dụ: Đại học">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Số lượng</label>
                                            <input type="text" class="form-control" name="quantity" 
                                                   value="${job.quantity}" placeholder="Ví dụ: 5 người">
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Hình thức làm việc</label>
                                    <input type="text" class="form-control" name="workType" 
                                           value="${job.workType}" placeholder="Ví dụ: Toàn thời gian">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card mb-4">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0">Thông tin chi tiết</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label required">Lương tối thiểu</label>
                                            <input type="number" class="form-control" name="minSalary" 
                                                   value="${job.minSalary}" required min="0" step="0.01">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label required">Lương tối đa</label>
                                            <input type="number" class="form-control" name="maxSalary" 
                                                   value="${job.maxSalary}" required min="0" step="0.01">
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label required">Trạng thái</label>
                                    <select class="form-select" name="status" required>
                                        <option value="active" ${job.status == 'active' ? 'selected' : ''}>Đang tuyển</option>
                                        <option value="inactive" ${job.status == 'inactive' ? 'selected' : ''}>Ngừng tuyển</option>
                                        <option value="draft" ${job.status == 'draft' ? 'selected' : ''}>Bản nháp</option>
                                    </select>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label required">Hạn nộp hồ sơ</label>
                                    <input type="date" class="form-control" name="expiredAt" 
                                           value="${job.expiredAt != null ? job.expiredAt.toLocalDate() : ''}" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Phúc lợi</label>
                                    <textarea class="form-control" name="income" rows="3" 
                                              placeholder="Mô tả phúc lợi...">${job.income}</textarea>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Quyền lợi khác</label>
                                    <textarea class="form-control" name="interest" rows="3" 
                                              placeholder="Quyền lợi khác...">${job.interest}</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">Mô tả công việc</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <textarea class="form-control" name="description" rows="6" 
                                      placeholder="Mô tả chi tiết công việc...">${job.description}</textarea>
                        </div>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="mb-0">Yêu cầu công việc</h5>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <textarea class="form-control" name="requirement" rows="6" 
                                      placeholder="Yêu cầu chi tiết...">${job.requirement}</textarea>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="job-posting?action=list" class="btn btn-secondary">Hủy bỏ</a>
                    <button type="submit" class="btn btn-primary">
                        ${isEdit ? 'Cập nhật' : 'Tạo mới'}
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>