<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Upload & Quản lý Tài liệu</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Tailwind CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- Simple Datatables -->
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <link href="assets/css/managerdocument.css" rel="stylesheet" type="text/css"/>

    </head>
    <body class="bg-gray-100 min-h-screen">
        <c:if test="${not empty message}">
            <script>
                window.addEventListener("DOMContentLoaded", () => {
                    const msg = `${message}`;
                    let type = "info";
                    if (msg.includes("✅"))
                        type = "success";
                    else if (msg.includes("❌"))
                        type = "error";
                    else if (msg.includes("⚠️"))
                        type = "warning";
                    showNotification(type, msg);
                });
            </script>
        </c:if>
        <div class="max-w-6xl mx-auto py-6 px-4">
            <div class="flex items-center justify-between mb-6">
                <h2 class="text-2xl font-semibold text-gray-800">Tài liệu ứng viên</h2>
                <a href="managerdocument" class="text-sm border border-gray-300 hover:bg-gray-200 px-3 py-1 rounded-md">Tải lại</a>
            </div>

            <!-- Bộ lọc -->
            <form class="grid grid-cols-12 gap-3 mb-8" method="get" action="managerdocument">
                <input type="hidden" name="candidateId" value="3"/>
                <div class="col-span-12 sm:col-span-5">
                    <input name="q" value="${param.q}" class="w-full border border-gray-300 rounded-md p-2" placeholder="Tìm theo tiêu đề...">
                </div>
                <div class="col-span-12 sm:col-span-4">
                    <select name="type" class="w-full border border-gray-300 rounded-md p-2">
                        <option value="">-- Loại tài liệu --</option>
                        <option ${param.type=='CERTIFICATE'?'selected':''} value="CERTIFICATE">Chứng chỉ</option>
                        <option ${param.type=='DEGREE'?'selected':''} value="DEGREE">Bằng cấp</option>
                        <option ${param.type=='LICENSE'?'selected':''} value="LICENSE">Giấy phép</option>
                        <option ${param.type=='OTHER'?'selected':''} value="OTHER">Khác</option>
                    </select>
                </div>
                <div class="col-span-12 sm:col-span-3">
                    <button class="w-full bg-blue-600 hover:bg-blue-700 text-white rounded-md p-2">Lọc</button>
                </div>
            </form>

            <!-- Upload -->
            <div class="bg-white shadow rounded-lg mb-8">
                <div class="p-6">
                    <h3 class="text-lg font-semibold mb-2">Tải tài liệu lên</h3>
                    <p class="text-sm text-gray-500 mb-4">Vui lòng nhập đúng thông tin cấp chứng chỉ để HR có thể xác minh dễ dàng.</p>
                    <c:if test="${not empty message}">
                        <div class="bg-green-100 text-green-800 px-4 py-2 rounded mb-4">${message}</div>
                    </c:if>

                    <form id="uploadForm" class="grid grid-cols-12 gap-4" method="post"
                          action="managerdocument" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="upload">
                        <input type="hidden" name="candidateId" value="3">

                        <div class="col-span-12 sm:col-span-6">
                            <label class="block text-sm font-medium mb-1">Tiêu đề</label>
                            <input name="title" required class="w-full border border-gray-300 rounded-md p-2" placeholder="VD: Chứng chỉ IELTS 7.0">
                        </div>
                        <div class="col-span-12 sm:col-span-3">
                            <label class="block text-sm font-medium mb-1">Loại tài liệu</label>
                            <select name="docType" required class="w-full border border-gray-300 rounded-md p-2">
                                <option value="CERTIFICATE">Chứng chỉ</option>
                                <option value="DEGREE">Bằng cấp</option>
                                <option value="LICENSE">Giấy phép</option>
                                <option value="OTHER">Khác</option>
                            </select>
                        </div>
                        <div class="col-span-12 sm:col-span-3">
                            <label class="block text-sm font-medium mb-1">Cơ quan cấp</label>
                            <input name="issuedBy" required class="w-full border border-gray-300 rounded-md p-2" placeholder="VD: British Council">
                        </div>

                        <div class="col-span-12 sm:col-span-3">
                            <label class="block text-sm font-medium mb-1">Ngày cấp</label>
                            <input type="date" required name="issuedAt" class="w-full border border-gray-300 rounded-md p-2">
                        </div>
                        <div class="col-span-12 sm:col-span-3">
                            <label class="block text-sm font-medium mb-1">Ngày hết hạn</label>
                            <input type="date" name="expiresAt" class="w-full border border-gray-300 rounded-md p-2">
                        </div>

                        <div class="col-span-12">
                            <div id="dropzone" class="dropzone">
                                <p class="mb-2 text-gray-600">Kéo & thả file vào đây hoặc</p>
                                <label class="inline-block border border-blue-500 text-blue-600 px-3 py-1 rounded-md cursor-pointer hover:bg-blue-50">
                                    Chọn file
                                    <input id="fileInput" type="file" name="file" hidden required>
                                </label>
                                <div id="fileName" class="text-sm text-gray-500 mt-2"></div>
                                <p class="text-xs text-gray-400 mt-1">Hỗ trợ PDF/JPG/PNG/DOCX… Tối đa 20MB.</p>
                            </div>
                        </div>

                        <div class="col-span-12">
                            <button class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-md mt-2">Tải lên</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="bg-white shadow rounded-lg">
                <div class="p-6">
                    <h3 class="text-lg font-semibold mb-4">Danh sách tài liệu</h3>



                    <p class="text-sm text-gray-500 mb-4">Tìm thấy ${total} tài liệu</p>

                    <div class="overflow-x-auto">
                        <table id="datatablesSimple" class="min-w-full border border-gray-200 divide-y divide-gray-200 text-sm">
                            <thead class="bg-gray-50 text-gray-700">
                                <tr>
                                    <th>#</th>
                                    <th>Tiêu đề</th>
                                    <th>Loại</th>
                                    <th>Cấp bởi</th>
                                    <th>Ngày cấp</th>
                                    <th>Hết hạn</th>
                                    <th>Kích thước</th>
                                    <th>Trạng thái</th>
                                    <th>Tệp</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="d" items="${docs}" varStatus="st">
                                    <tr>
                                        <td>${st.index + 1}</td>
                                        <td>${d.title}</td>
                                        <td>${d.docType}</td>
                                        <td>${d.issuedBy}</td>
                                        <td>${d.issuedAt}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${d.expiresAt != null}">${d.expiresAt}</c:when>
                                                <c:otherwise>—</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><fmt:formatNumber value="${d.fileSize/1024}" maxFractionDigits="1"/> KB</td>
                                <td>
                                    <span class="px-2 py-1 text-xs rounded
                                          ${d.status=='ACTIVE'?'bg-green-100 text-green-800':
                                            (d.status=='PENDING'?'bg-yellow-100 text-yellow-800':'bg-gray-200 text-gray-700')}">
                                              ${d.status}
                                          </span>
                                    </td>
                                    <td class="space-x-2">
                                        <!-- Xem -->
                                        <a href="managerdocument?action=view&id=${d.documentId}"
                                           target="_blank"
                                           class="text-blue-600 hover:underline">Xem</a>

                                        <button type="button"
                                                class="text-yellow-600 hover:underline"
                                                onclick="openEditModal(this)"
                                                data-id="${d.documentId}"
                                                data-title="${fn:escapeXml(d.title)}"
                                                data-doctype="${d.docType}"
                                                data-issuedby="${fn:escapeXml(d.issuedBy)}"
                                                data-issuedat="${d.issuedAt}"
                                                data-expiresat="${d.expiresAt}"
                                                data-filepath="${fn:escapeXml(d.filePath)}">
                                            Sửa
                                        </button>

                                        <!-- Xóa -->
                                        <a href="managerdocument?action=delete&id=${d.documentId}"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa tài liệu này không?')"
                                           class="text-red-600 hover:underline">Xóa</a>
                                    </td>


                                    </tr>
                                </c:forEach>

                                <c:if test="${empty docs}">
                                    <tr>
                                        <td colspan="9" class="text-center text-gray-500 py-4">Chưa có tài liệu nào.</td>
                                    </tr>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


                <!-- Edit Document Modal -->
                <div id="editModal" class="fixed inset-0 z-50 hidden items-center justify-center bg-black/40">
                    <div class="bg-white w-full max-w-3xl rounded-lg shadow p-6">
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="text-lg font-semibold">Sửa tài liệu</h3>
                            <button class="text-gray-500 hover:text-gray-700" onclick="closeEditModal()">&times;</button>
                        </div>

                        <form id="editForm" class="grid grid-cols-12 gap-4" method="post" action="managerdocument" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="documentId" id="edit_documentId">

                            <div class="col-span-12 sm:col-span-6">
                                <label class="block text-sm font-medium mb-1">Tiêu đề</label>
                                <input id="edit_title" name="title" required class="w-full border border-gray-300 rounded-md p-2">
                            </div>

                            <div class="col-span-12 sm:col-span-3">
                                <label class="block text-sm font-medium mb-1">Loại tài liệu</label>
                                <select id="edit_docType" name="docType" required class="w-full border border-gray-300 rounded-md p-2">
                                    <option value="CERTIFICATE">Chứng chỉ</option>
                                    <option value="DEGREE">Bằng cấp</option>
                                    <option value="LICENSE">Giấy phép</option>
                                    <option value="OTHER">Khác</option>
                                </select>
                            </div>

                            <div class="col-span-12 sm:col-span-3">
                                <label class="block text-sm font-medium mb-1">Cơ quan cấp</label>
                                <input id="edit_issuedBy" name="issuedBy" required class="w-full border border-gray-300 rounded-md p-2">
                            </div>
                            <div class="col-span-12">
                                <label class="block text-sm font-medium mb-1">Thay file mới (nếu cần)</label>
                                <input type="file" id="edit_file" name="file"
                                       accept=".pdf,.jpg,.jpeg,.png,.doc,.docx"
                                       class="w-full border border-gray-300 rounded-md p-2" />

                                <!-- Hiển thị tên file hiện tại -->
                                <div id="currentFileName" class="text-sm text-gray-600 mt-2"></div>

                                <!-- Hiển thị tên file mới khi chọn -->
                                <div id="newFileName" class="text-sm text-blue-600 mt-1 hidden"></div>

                                <p class="text-xs text-gray-400 mt-1">
                                    Nếu không chọn, hệ thống sẽ giữ nguyên file cũ.
                                </p>
                            </div>


                            <div class="col-span-12 sm:col-span-3">
                                <label class="block text-sm font-medium mb-1">Ngày cấp</label>
                                <input type="date" id="edit_issuedAt" name="issuedAt" required class="w-full border border-gray-300 rounded-md p-2">
                            </div>

                            <div class="col-span-12 sm:col-span-3">
                                <label class="block text-sm font-medium mb-1">Ngày hết hạn</label>
                                <input type="date" id="edit_expiresAt" name="expiresAt" class="w-full border border-gray-300 rounded-md p-2">
                            </div>

                            <div id="edit_error" class="col-span-12 hidden text-sm text-red-600 bg-red-50 border border-red-200 rounded p-2"></div>

                            <div class="col-span-12 flex justify-end gap-2">
                                <button type="button" class="px-4 py-2 rounded-md border" onclick="closeEditModal()">Hủy</button>
                                <button class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md">Lưu</button>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- Notification Modal -->
                <div id="notificationModal"
                     class="fixed inset-0 z-[100] hidden items-center justify-center bg-black/40 backdrop-blur-sm transition">
                    <div class="bg-white rounded-xl shadow-xl p-6 max-w-md w-full text-center animate-fadeIn">
                        <!-- Icon -->
                        <div id="notifIcon" class="text-5xl mb-4"></div>

                        <!-- Message -->
                        <h3 id="notifMessage" class="text-lg font-semibold text-gray-800 mb-4"></h3>

                        <!-- Button -->
                        <button onclick="closeNotification()"
                                class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md">
                            Đóng
                        </button>
                    </div>
                </div>

                <script src="assets/js/managerdocument.js"></script>

                <script src="assets/js/datatables-simple-demo.js" type="text/javascript"></script>
        </body>
    </html>
