<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Upload & Quản lý Tài liệu</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .dropzone{
                border:2px dashed #ced4da;
                border-radius:.75rem;
                padding:2rem;
                text-align:center;
                background:#f8f9fa;
                transition:.2s
            }
            .dropzone.dragover{
                border-color:#0d6efd;
                background:#eef5ff
            }
            .file-icon{
                width:40px;
                height:40px;
                border-radius:.5rem;
                display:inline-flex;
                align-items:center;
                justify-content:center;
                font-weight:700
            }
            .table td,.table th{
                vertical-align:middle
            }
        </style>
    </head>
    <body class="bg-light">

        <div class="container-xxl py-4">
            <div class="d-flex align-items-center justify-content-between mb-3">
                <h3 class="m-0">Tài liệu ứng viên</h3>
                <a href="/mangerdocument" class="btn btn-outline-secondary btn-sm">Tải lại</a>
            </div>

            <!-- Bộ lọc -->
            <form class="row g-2 mb-4" method="get" action="${pageContext.request.contextPath}/documents">
                <input type="hidden" name="candidateId" value="1"/>
                <div class="col-sm-4">
                    <input name="q" value="${param.q}" class="form-control" placeholder="Tìm theo tiêu đề...">
                </div>
                <div class="col-sm-3">
                    <select name="type" class="form-select">
                        <option value="">-- Loại tài liệu --</option>
                        <option ${param.type=='CERTIFICATE'?'selected':''} value="CERTIFICATE">Chứng chỉ</option>
                        <option ${param.type=='DEGREE'?'selected':''} value="DEGREE">Bằng cấp</option>
                        <option ${param.type=='LICENSE'?'selected':''} value="LICENSE">Giấy phép</option>
                        <option ${param.type=='OTHER'?'selected':''} value="OTHER">Khác</option>
                    </select>
                </div>
                <div class="col-sm-2">
                    <button class="btn btn-primary w-100">Lọc</button>
                </div>
            </form>

            <!-- Upload -->
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title">Tải tài liệu lên</h5>
                    <div class="form-text text-muted">
                        Vui lòng nhập đúng thông tin cấp chứng chỉ để HR có thể xác minh dễ dàng.
                    </div>
                    <form id="uploadForm" class="row g-3" method="post" action="${pageContext.request.contextPath}/documents" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="upload">
                        <input type="hidden" name="candidateId" value="1">

                        <div class="col-md-6">
                            <label class="form-label">Tiêu đề</label>
                            <input name="title" class="form-control" required  placeholder="VD: Chứng chỉ IELTS 7.0">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Loại tài liệu</label>
                            <select name="docType" class="form-select" required>
                                <option value="CERTIFICATE">Chứng chỉ</option>
                                <option value="DEGREE">Bằng cấp</option>
                                <option value="LICENSE">Giấy phép</option>
                                <option value="OTHER">Khác</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Cơ quan cấp</label>
                            <input name="issuedBy" required  class="form-control" placeholder="VD: British Council">
                        </div>

                        <div class="col-md-3">
                            <label class="form-label">Ngày cấp</label>
                            <input type="date" required  name="issuedAt" class="form-control">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label">Ngày hết hạn</label>
                            <input type="date" name="expiresAt" class="form-control">
                        </div>

                        <div class="col-12">
                            <div id="dropzone" class="dropzone">
                                <p class="mb-1">Kéo & thả file vào đây hoặc</p>
                                <label class="btn btn-outline-primary mb-0">
                                    Chọn file
                                    <input id="fileInput" type="file" name="file" hidden required>
                                </label>
                                <div id="fileName" class="small text-muted mt-2"></div>
                                <div class="form-text">Hỗ trợ PDF/JPG/PNG/DOCX… Tối đa 20MB.</div>
                            </div>
                        </div>

                        <div class="col-12">
                            <button class="btn btn-success">Tải lên</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Danh sách -->
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Danh sách tài liệu</h5>

                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Tiêu đề</th>
                                    <th>Loại</th>
                                    <th>Cấp bởi</th>
                                    <th>Ngày cấp</th>
                                    <th>Hết hạn</th>
                                    <th>Kích thước</th>
                                    <th>Trạng thái</th>
                                    <th class="text-end">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${docs}" var="d" varStatus="st">
                                    <tr>
                                        <td>${st.index + 1}</td>
                                        <td>${d.title}</td>
                                        <td>${d.docType}</td>
                                        <td>${d.issuedBy}</td>
                                        <td><c:out value="${d.issuedAt}" /></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${d.expiresAt != null}">${d.expiresAt}</c:when>
                                                <c:otherwise>—</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><c:out value="${d.fileSize}" /> bytes</td>
                                        <td>
                                            <span class="badge text-bg-${d.status=='ACTIVE'?'success':(d.status=='EXPIRED'?'warning':'secondary')}">
                                                ${d.status}
                                            </span>
                                        </td>
                                        <td class="text-end">
                                            <a class="btn btn-sm btn-outline-primary"
                                               href="${pageContext.request.contextPath}/documents?action=download&id=${d.id}">Xem/Tải</a>

                                            <!-- Nút sửa mở modal -->
                                            <button class="btn btn-sm btn-outline-secondary"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#editModal${d.id}">Sửa</button>

                                            <form class="d-inline" method="post" action="${pageContext.request.contextPath}/documents"
                                                  onsubmit="return confirm('Xoá tài liệu này?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${d.id}">
                                                <input type="hidden" name="candidateId" value="1">
                                                <button class="btn btn-sm btn-outline-danger">Xoá</button>
                                            </form>

                                            <!-- Modal sửa -->
                                            <div class="modal fade" id="editModal${d.id}" tabindex="-1">
                                                <div class="modal-dialog">
                                                    <form class="modal-content" method="post" action="${pageContext.request.contextPath}/documents">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="id" value="${d.id}">
                                                        <input type="hidden" name="candidateId" value="1">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title">Sửa tài liệu</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="mb-2">
                                                                <label class="form-label">Tiêu đề</label>
                                                                <input name="title" class="form-control" value="${d.title}" required>
                                                            </div>
                                                            <div class="row g-2">
                                                                <div class="col-6">
                                                                    <label class="form-label">Loại</label>
                                                                    <select name="docType" class="form-select">
                                                                        <option ${d.docType=='CERTIFICATE'?'selected':''} value="CERTIFICATE">Chứng chỉ</option>
                                                                        <option ${d.docType=='DEGREE'?'selected':''} value="DEGREE">Bằng cấp</option>
                                                                        <option ${d.docType=='LICENSE'?'selected':''} value="LICENSE">Giấy phép</option>
                                                                        <option ${d.docType=='OTHER'?'selected':''} value="OTHER">Khác</option>
                                                                    </select>
                                                                </div>
                                                                <div class="col-6">
                                                                    <label class="form-label">Trạng thái</label>
                                                                    <select name="status" class="form-select">
                                                                        <option ${d.status=='ACTIVE'?'selected':''} value="ACTIVE">ACTIVE</option>
                                                                        <option ${d.status=='EXPIRED'?'selected':''} value="EXPIRED">EXPIRED</option>
                                                                        <option ${d.status=='REVOKED'?'selected':''} value="REVOKED">REVOKED</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="row g-2 mt-1">
                                                                <div class="col-6">
                                                                    <label class="form-label">Cấp bởi</label>
                                                                    <input name="issuedBy" class="form-control" value="${d.issuedBy}">
                                                                </div>
                                                                <div class="col-6">
                                                                    <label class="form-label">Ngày cấp</label>
                                                                    <input type="date" name="issuedAt" class="form-control" value="${d.issuedAt}">
                                                                </div>
                                                                <div class="col-6">
                                                                    <label class="form-label">Hết hạn</label>
                                                                    <input type="date" name="expiresAt" class="form-control" value="${d.expiresAt}">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button class="btn btn-primary">Lưu</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>

                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty docs}">
                                    <tr><td colspan="9" class="text-center text-muted py-4">Chưa có tài liệu.</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script>
            const dz = document.getElementById('dropzone');
            const input = document.getElementById('fileInput');
            const nameBox = document.getElementById('fileName');

            dz.addEventListener('dragover', e => {
                e.preventDefault();
                dz.classList.add('dragover');
            });
            dz.addEventListener('dragleave', () => dz.classList.remove('dragover'));
            dz.addEventListener('drop', e => {
                e.preventDefault();
                dz.classList.remove('dragover');
                if (e.dataTransfer.files.length) {
                    input.files = e.dataTransfer.files;
                    nameBox.textContent = e.dataTransfer.files[0].name;
                }
            });
            input.addEventListener('change', () => {
                if (input.files.length)
                    nameBox.textContent = input.files[0].name;
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
