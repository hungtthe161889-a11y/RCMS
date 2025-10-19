<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Quản lý Đơn Ứng Tuyển</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
</head>

<body class="bg-gray-100 min-h-screen">
<div class="max-w-7xl mx-auto py-6 px-4">

    <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-semibold text-gray-800">📋 Quản lý Đơn Ứng Tuyển</h2>
        <a href="applications" class="text-sm border border-gray-300 hover:bg-gray-200 px-3 py-1 rounded-md">Tải lại</a>
    </div>

    <!-- Bộ lọc -->
    <form class="grid grid-cols-12 gap-3 mb-8" method="get" action="applications">
        <div class="col-span-12 sm:col-span-5">
            <input name="keyword" value="${param.keyword}" class="w-full border border-gray-300 rounded-md p-2"
                   placeholder="Tìm theo tên ứng viên hoặc vị trí...">
        </div>
        <div class="col-span-12 sm:col-span-3">
            <select name="status" class="w-full border border-gray-300 rounded-md p-2">
                <option value="">-- Trạng thái --</option>
                <option ${param.status=='Applied'?'selected':''} value="Applied">Applied</option>
                <option ${param.status=='Interviewing'?'selected':''} value="Interviewing">Interviewing</option>
                <option ${param.status=='Offer'?'selected':''} value="Offer">Offer</option>
                <option ${param.status=='Hired'?'selected':''} value="Hired">Hired</option>
                <option ${param.status=='Rejected'?'selected':''} value="Rejected">Rejected</option>
            </select>
        </div>
        <div class="col-span-12 sm:col-span-2">
            <button class="w-full bg-blue-600 hover:bg-blue-700 text-white rounded-md p-2">Lọc</button>
        </div>
    </form>

    <!-- Danh sách -->
    <div class="bg-white shadow rounded-lg p-6">
        <div class="overflow-x-auto">
            <table id="datatablesSimple" class="min-w-full border border-gray-200 text-sm">
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
                                ${a.status}
                            </span>
                        </td>
                        <td>${a.appliedAtFormatted}</td>
                        <td class="text-center space-x-2">
                            <button type="button" class="text-blue-600 hover:underline open-modal-btn"
                                    data-id="${a.applicationId}" data-status="${a.status}">
                                Cập nhật
                            </button>
                            <a href="resume?user_id=${a.userId}" class="text-green-600 hover:underline">Hồ sơ</a>
                            <form method="post" action="applications" class="inline">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="application_id" value="${a.applicationId}">
                                <button class="text-red-600 hover:underline"
                                        onclick="return confirm('Xóa đơn ứng tuyển #${a.applicationId}?')">
                                    Xóa
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal -->
<div id="statusModal" class="hidden fixed inset-0 bg-black/40 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg p-6 w-full max-w-md shadow-lg">
        <h3 class="text-lg font-semibold mb-4 text-center">🔄 Cập nhật trạng thái</h3>
        <form method="post" action="applications" class="space-y-4">
            <input type="hidden" name="action" value="set">
            <input type="hidden" id="formAppId" name="application_id">
            <label class="block text-gray-700 font-medium">Trạng thái mới:</label>
            <select name="new_status" id="formNewStatus" class="w-full border rounded-md p-2 focus:ring focus:ring-blue-200">
                <option value="Applied">Applied</option>
                <option value="Interviewing">Interviewing</option>
                <option value="Offer">Offer</option>
                <option value="Hired">Hired</option>
                <option value="Rejected">Rejected</option>
            </select>
            <div class="flex justify-end gap-2">
                <button type="button" id="closeModal" class="px-3 py-2 border rounded-md hover:bg-gray-100">Hủy</button>
                <button class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md">Lưu</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        new simpleDatatables.DataTable("#datatablesSimple");

        const modal = document.getElementById('statusModal');
        const closeBtn = document.getElementById('closeModal');
        const formAppId = document.getElementById('formAppId');
        const formNewStatus = document.getElementById('formNewStatus');

        document.querySelectorAll('.open-modal-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                formAppId.value = btn.dataset.id;
                formNewStatus.value = btn.dataset.status;
                modal.classList.remove('hidden');
            });
        });

        closeBtn.addEventListener('click', () => modal.classList.add('hidden'));
        window.addEventListener('click', e => { if (e.target === modal) modal.classList.add('hidden'); });
    });
</script>
</body>
</html>
