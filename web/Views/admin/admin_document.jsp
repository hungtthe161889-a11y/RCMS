<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<main class="ml-64 p-8 min-h-screen">
    <!-- 🔹 Header -->
    <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-semibold text-gray-800">📚 Quản lý tài liệu ứng viên</h2>
        <a href="admindocument"
           class="text-sm border border-gray-300 hover:bg-gray-200 px-3 py-1 rounded-md">Tải lại</a>
    </div>

    <!-- 🔹 Bộ lọc -->
    <form class="grid grid-cols-12 gap-3 mb-8" method="get" action="admindocument">
        <div class="col-span-12 sm:col-span-5">
            <input name="q" value="${param.q}" class="w-full border border-gray-300 rounded-md p-2"
                   placeholder="Tìm theo tiêu đề hoặc tên ứng viên...">
        </div>
        <div class="col-span-12 sm:col-span-3">
            <select name="type" class="w-full border border-gray-300 rounded-md p-2">
                <option value="">-- Loại tài liệu --</option>
                <option ${param.type=='CERTIFICATE'?'selected':''} value="CERTIFICATE">Chứng chỉ</option>
                <option ${param.type=='DEGREE'?'selected':''} value="DEGREE">Bằng cấp</option>
                <option ${param.type=='LICENSE'?'selected':''} value="LICENSE">Giấy phép</option>
                <option ${param.type=='OTHER'?'selected':''} value="OTHER">Khác</option>
            </select>
        </div>
        <div class="col-span-12 sm:col-span-3">
            <select name="status" class="w-full border border-gray-300 rounded-md p-2">
                <option value="">-- Trạng thái --</option>
                <option value="PENDING" ${param.status=='PENDING'?'selected':''}>Chờ duyệt</option>
                <option value="ACTIVE" ${param.status=='ACTIVE'?'selected':''}>Đã duyệt</option>
                <option value="REJECTED" ${param.status=='REJECTED'?'selected':''}>Bị từ chối</option>
            </select>
        </div>
        <div class="col-span-12 sm:col-span-1">
            <button class="w-full bg-emerald-600 hover:bg-emerald-700 text-white rounded-md p-2">
                Lọc
            </button>
        </div>
    </form>

    <!-- 🔹 Danh sách -->
    <div class="bg-white shadow rounded-lg">
        <div class="p-4">
            <h3 class="text-lg font-semibold mb-4">Danh sách tài liệu</h3>
            <p class="text-sm text-gray-500 mb-4">Tổng số: ${total}</p>

            <div class="overflow-x-auto">
                <table id="datatablesSimple"
                       class="min-w-full border border-gray-200 divide-y divide-gray-200 text-sm">
                    <thead class="bg-gray-50 text-gray-700">
                        <tr>
                            <th>#</th>
                            <th>Ứng viên</th>
                            <th>Tiêu đề</th>
                            <th>Loại</th>
                            <th>Cấp bởi</th>
                            <th>Ngày cấp</th>
                            <th>Trạng thái</th>
                            <th>Tệp</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="d" items="${docs}" varStatus="st">
                            <tr class="hover:bg-gray-50">
                                <td>${st.index + 1}</td>
                                <td>
                                    <div class="font-medium text-gray-900">${userNames[d.userId]}</div>
                                    <div class="text-xs text-gray-500">#${d.userId}</div>
                                </td>
                                <td>${d.title}</td>
                                <td>${d.docType}</td>
                                <td>${d.issuedBy}</td>
                                <td>
                                    <c:out value="${d.issuedAt != null ? fn:substring(d.issuedAt, 0, 10) : ''}" />
                                </td>

                                <td>
                                    <span class="px-2 py-1 text-xs rounded
                                          ${d.status=='ACTIVE'?'bg-green-100 text-green-800':
                                            (d.status=='PENDING'?'bg-yellow-100 text-yellow-800':'bg-red-100 text-red-700')}">
                                              ${d.status}
                                          </span>
                                    </td>
                                    <td>
                                        <a href="managerdocument?action=view&id=${d.documentId}" target="_blank"
                                           class="text-blue-600 hover:underline">Xem</a>
                                    </td>
                                    <td class="space-x-2">
                                        <c:if test="${d.status == 'PENDING'}">
                                            <form method="post" action="admindocument" class="inline">
                                                <input type="hidden" name="action" value="approve">
                                                <input type="hidden" name="id" value="${d.documentId}">
                                                <button class="text-green-600 hover:underline" type="submit">Duyệt</button>
                                            </form>
                                            <button type="button" onclick="openRejectModal(${d.documentId})"
                                                    class="text-yellow-600 hover:underline">Từ chối</button>
                                        </c:if>

                                        <form method="post" action="admindocument" class="inline">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${d.documentId}">
                                            <button class="text-red-600 hover:underline"
                                                    onclick="return confirm('Xác nhận xóa tài liệu này?')">Xóa</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty docs}">
                                <tr>
                                    <td colspan="9" class="text-center text-gray-500 py-4">
                                        Không có tài liệu nào.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 🔹 Modal từ chối -->
        <div id="rejectModal" class="hidden fixed inset-0 bg-black/40 flex items-center justify-center z-50">
            <div class="bg-white rounded-lg p-6 w-full max-w-md shadow-lg">
                <h3 class="text-lg font-semibold mb-4">Nhập lý do từ chối</h3>
                <form method="post" action="admindocument">
                    <input type="hidden" name="action" value="reject">
                    <input type="hidden" id="reject_id" name="id">
                    <textarea name="note" rows="4" class="w-full border rounded-md p-2 mb-4"
                              placeholder="Nhập lý do từ chối..." required></textarea>
                    <div class="flex justify-end space-x-2">
                        <button type="button" onclick="closeRejectModal()"
                                class="px-3 py-2 border rounded-md">Hủy</button>
                        <button class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-md">Xác nhận</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- 🔹 Script xử lý -->
        <script>
            new simpleDatatables.DataTable("#datatablesSimple");

            function openRejectModal(id) {
                document.getElementById('reject_id').value = id;
                document.getElementById('rejectModal').classList.remove('hidden');
            }
            function closeRejectModal() {
                document.getElementById('rejectModal').classList.add('hidden');
            }
        </script>
    </main>
