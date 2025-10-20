<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<main class="ml-64 p-8 min-h-screen bg-gray-50">
    <!-- 🔹 Header -->
    <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-semibold text-gray-800 flex items-center gap-2">
            <i class="fa-solid fa-clipboard-list text-emerald-600"></i> Quản lý Trạng thái Ứng tuyển
        </h2>
        <a href="applications"
           class="text-sm border border-gray-300 hover:bg-gray-200 px-3 py-1 rounded-md">Tải lại</a>
    </div>

    <!-- 🔹 Bộ lọc -->
    <form class="grid grid-cols-12 gap-3 mb-8" method="get" action="applications">
        <div class="col-span-12 sm:col-span-5">
            <input name="keyword" value="${param.keyword}"
                   class="w-full border border-gray-300 rounded-md p-2"
                   placeholder="Tìm theo ứng viên hoặc vị trí...">
        </div>
        <div class="col-span-12 sm:col-span-3">
            <select name="status" class="w-full border border-gray-300 rounded-md p-2">
                <option value="">-- Trạng thái --</option>
                <option ${param.status=='Applied'?'selected':''} value="Applied">Applied</option>
                <option ${param.status=='Interviewing'?'selected':''} value="Interviewing">Interviewing</option>
                <option ${param.status=='Offer'?'selected':''} value="Offer">Offered</option>
                <option ${param.status=='Hired'?'selected':''} value="Hired">Hired</option>
                <option ${param.status=='Rejected'?'selected':''} value="Rejected">Rejected</option>
            </select>
        </div>
        <div class="col-span-12 sm:col-span-2">
            <button class="w-full bg-emerald-600 hover:bg-emerald-700 text-white rounded-md p-2">
                Lọc
            </button>
        </div>
    </form>

    <!-- 🔹 Danh sách -->
    <div class="bg-white shadow rounded-lg">
        <div class="p-4">
            <h3 class="text-lg font-semibold mb-4">Danh sách đơn ứng tuyển</h3>
            <p class="text-sm text-gray-500 mb-4">Tổng số: ${applications != null ? applications.size() : 0}</p>

            <div class="overflow-x-auto">
                <table id="datatablesSimple"
                       class="min-w-full border border-gray-200 divide-y divide-gray-200 text-sm">
                    <thead class="bg-gray-50 text-gray-700">
                        <tr>
                            <th>#</th>
                            <th>Ứng viên</th>
                            <th>Vị trí</th>
                            <th>Trạng thái</th>
                            <th>Ngày nộp</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="a" items="${applications}" varStatus="st">
                            <tr class="hover:bg-gray-50">
                                <td>${st.index + 1}</td>
                                <td>
                                    <div class="font-medium text-gray-900">
                                        <c:forEach var="u" items="${users}">
                                            <c:if test="${u.userId == a.userId}">${u.fullname}</c:if>
                                        </c:forEach>
                                    </div>
                                    <div class="text-xs text-gray-500">#${a.userId}</div>
                                </td>
                                <td>
                                    <c:forEach var="j" items="${jobs}">
                                        <c:if test="${j.jobId == a.jobId}">${j.title}</c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    <span class="px-2 py-1 text-xs rounded
                                          ${a.status=='Hired'?'bg-green-100 text-green-800':
                                            (a.status=='Offer'?'bg-indigo-100 text-indigo-800':
                                            (a.status=='Interviewing'?'bg-yellow-100 text-yellow-800':
                                            (a.status=='Rejected'?'bg-red-100 text-red-700':'bg-gray-100 text-gray-700')))}">
                                        <!-- Hiển thị text tiếng Anh -->
                                        <c:choose>
                                            <c:when test="${a.status == 'Applied'}">Applied</c:when>
                                            <c:when test="${a.status == 'Interviewing'}">Interviewing</c:when>
                                            <c:when test="${a.status == 'Offer'}">Offered</c:when>
                                            <c:when test="${a.status == 'Hired'}">Hired</c:when>
                                            <c:when test="${a.status == 'Rejected'}">Rejected</c:when>
                                            <c:otherwise>Unknown</c:otherwise>
                                        </c:choose>
                                    </span>
                                </td>
                                <td class="text-gray-600">${a.appliedAtFormatted}</td>
                                <td class="space-x-2 text-center">
                                    <button type="button"
                                            class="open-modal-btn text-blue-600 hover:underline font-medium"
                                            data-id="${a.applicationId}"
                                            data-status="${a.status}">
                                        Cập nhật
                                    </button>
                                    <button type="button"
                                            class="view-detail-btn text-gray-700 hover:text-emerald-600 font-medium"
                                            data-id="${a.applicationId}">
                                        Xem
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty applications}">
                            <tr>
                                <td colspan="6" class="text-center text-gray-500 py-4">
                                    Không có đơn ứng tuyển nào.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- 🔹 Modal cập nhật -->
    <div id="statusModal" class="hidden fixed inset-0 bg-black/40 flex items-center justify-center z-50">
        <div class="bg-white rounded-lg p-6 w-full max-w-md shadow-lg">
            <h3 class="text-lg font-semibold mb-4 text-center">🔄 Cập nhật Trạng thái</h3>
            <form method="post" action="applications" class="space-y-4">
                <input type="hidden" name="action" value="set">
                <input type="hidden" id="formAppId" name="application_id">

                <label class="block text-gray-700 font-medium">Chọn trạng thái mới:</label>
                <select name="new_status" id="formNewStatus"
                        class="w-full border rounded-md p-2 focus:ring focus:ring-emerald-200">
                    <option value="Applied">Applied</option>
                    <option value="Interviewing">Interviewing</option>
                    <option value="Offer">Offered</option>
                    <option value="Hired">Hired</option>
                    <option value="Rejected">Rejected</option>
                </select>

                <div class="flex justify-end gap-2 pt-3">
                    <button type="button" id="closeModal"
                            class="px-3 py-2 border rounded-md hover:bg-gray-100">Hủy</button>
                    <button class="bg-emerald-600 hover:bg-emerald-700 text-white px-4 py-2 rounded-md">Lưu</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 🔹 Modal xem chi tiết -->
    <div id="detailModal" class="hidden fixed inset-0 bg-black/40 flex items-center justify-center z-50">
        <div class="bg-white rounded-lg p-6 w-full max-w-2xl shadow-xl">
            <h3 class="text-lg font-semibold mb-4 text-center text-gray-800">📄 Chi tiết đơn ứng tuyển</h3>
            <div id="detailContent" class="space-y-3 text-gray-700 text-sm"></div>
            <div class="flex justify-end mt-4">
                <button id="closeDetail"
                        class="px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white rounded-md">Đóng</button>
            </div>
        </div>
    </div>

    <!-- 🔹 Script -->
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
    <script src="assets/js/application_list.js" type="text/javascript"></script>
</main>
