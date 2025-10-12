<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Upload & Quản lý Tài liệu</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Tailwind CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Tailwind CSS -->

        <!-- Simple Datatables -->
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <link href="assets/css/managerdocument.css" rel="stylesheet" type="text/css"/>

    </head>
    <body class="bg-gray-100 min-h-screen">

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

                    <c:if test="${not empty message}">
                        <div class="p-3 mb-4 rounded bg-blue-100 text-blue-800">${message}</div>
                    </c:if>
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
                                    <td>
                                        <a href="managerdocument?action=view&id=${d.documentId}" 
                                           target="_blank"
                                           class="text-blue-600 hover:underline">
                                            Xem
                                        </a>
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
                <script src="assets/js/datatables-simple-demo.js" type="text/javascript"></script>
        </body>
    </html>
