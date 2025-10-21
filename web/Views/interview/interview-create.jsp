<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tạo lịch phỏng vấn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .required-label::after {
            content: " *";
            color: red;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12 col-md-8 col-lg-6 mx-auto">
                <nav class="navbar navbar-light bg-light mb-4">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="interview?action=list">
                            <i class="fas fa-arrow-left"></i> Quay lại danh sách
                        </a>
                        <span class="navbar-text">
                            <i class="fas fa-calendar-plus"></i> Tạo lịch phỏng vấn
                        </span>
                    </div>
                </nav>

                <!-- Thông báo lỗi -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-calendar-plus"></i> Thông tin lịch phỏng vấn
                        </h5>
                    </div>
                    <div class="card-body">
                        <form action="interview" method="POST">
                            <input type="hidden" name="action" value="create">
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="applicationId" class="form-label required-label">Application ID</label>
                                    <input type="number" class="form-control" id="applicationId" name="applicationId" 
                                           value="${param.applicationId}" required min="1">
                                    <div class="form-text">ID của đơn ứng tuyển</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="locationId" class="form-label required-label">Địa điểm</label>
                                    <input type="number" class="form-control" id="locationId" name="locationId" 
                                           value="${param.locationId}" required min="1">
                                    <div class="form-text">ID của địa điểm phỏng vấn</div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="scheduledAt" class="form-label required-label">Thời gian phỏng vấn</label>
                                    <input type="datetime-local" class="form-control" id="scheduledAt" name="scheduledAt" 
                                           value="${param.scheduledAt}" required>
                                    <div class="form-text">Chọn ngày và giờ phỏng vấn</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="interviewerFullname" class="form-label required-label">Người phỏng vấn</label>
                                    <input type="text" class="form-control" id="interviewerFullname" name="interviewerFullname" 
                                           value="${param.interviewerFullname}" required maxlength="256">
                                    <div class="form-text">Họ tên người thực hiện phỏng vấn</div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="notes" class="form-label">Ghi chú</label>
                                <textarea class="form-control" id="notes" name="notes" rows="4" 
                                          maxlength="4000">${param.notes}</textarea>
                                <div class="form-text">Ghi chú hoặc hướng dẫn thêm cho buổi phỏng vấn</div>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="interview?action=list" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-times"></i> Hủy
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i> Tạo lịch phỏng vấn
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const now = new Date();
            now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
            document.getElementById('scheduledAt').min = now.toISOString().slice(0, 16);
        });
    </script>
</body>
</html>