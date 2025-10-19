<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Trạng thái Ứng tuyển</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body class="bg-gray-100 min-h-screen">
<div class="max-w-7xl mx-auto py-8 px-4">

    <!-- Tiêu đề -->
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-2xl font-bold text-gray-800 flex items-center gap-2">
            <i class="fa-solid fa-clipboard-list text-blue-600"></i>
            Quản lý Trạng thái Ứng tuyển
        </h1>
        <a href="applications" class="bg-gray-200 hover:bg-gray-300 px-3 py-2 rounded text-sm">🔄 Tải lại</a>
    </div>

    <!-- Bộ lọc -->
    <form method="get" action="applications" class="grid grid-cols-12 gap-4 mb-6 bg-white shadow p-4 rounded-lg">
        <div class="col-span-12 sm:col-span-4">
            <input type="text" name="keyword" value="${param.keyword}" placeholder="Tìm ứng viên hoặc vị trí..."
                   class="w-full border p-2 rounded-md focus:ring focus:ring-blue-200">
        </div>
        <div class="col-span-12 sm:col-span-3">
            <select name="status" class="w-full border p-2 rounded-md">
                <option value="">-- Trạng thái --</option>
                <option ${param.status=='Applied'?'selected':''} value="Applied">Mới nộp</option>
                <option ${param.status=='Interviewing'?'selected':''} value="Interviewing">Đang phỏng vấn</option>
                <option ${param.status=='Offer'?'selected':''} value="Offer">Được offer</option>
                <option ${param.status=='Hired'?'selected':''} value="Hired">Đã tuyển</option>
                <option ${param.status=='Rejected'?'selected':''} value="Rejected">Đã loại</option>
            </select>
        </div>
        <div class="col-span-12 sm:col-span-2">
            <button class="w-full bg-blue-600 hover:bg-blue-700 text-white p-2 rounded-md">Lọc</button>
        </div>
    </form>

    <!-- Bảng danh sách -->
    <div class="bg-white shadow rounded-lg p-6">
        <table class="min-w-full border border-gray-200 text-sm">
            <thead class="bg-gray-50 text-gray-700">
            <tr>
                <th class="p-3 text-left">#</th>
                <th class="p-3 text-left">Ứng viên</th>
                <th class="p-3 text-left">Vị trí</th>
                <th class="p-3 text-left">Trạng thái hiện tại</th>
                <th class="p-3 text-left">Ngày nộp</th>
                <th class="p-3 text-center">Hành động</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="a" items="${applications}" varStatus="st">
                <tr class="hover:bg-gray-50 transition">
                    <td class="p-3">${st.index + 1}</td>
                    <td class="p-3 font-medium text-gray-800">
                        <c:forEach var="u" items="${users}">
                            <c:if test="${u.userId == a.userId}">${u.fullname}</c:if>
                        </c:forEach>
                    </td>
                    <td class="p-3">
                        <c:forEach var="j" items="${jobs}">
                            <c:if test="${j.jobId == a.jobId}">${j.title}</c:if>
                        </c:forEach>
                    </td>
                    <td class="p-3">
                        <span class="px-3 py-1 text-xs font-semibold rounded-full
                            ${a.status=='Hired'?'bg-green-100 text-green-800':
                            (a.status=='Offer'?'bg-indigo-100 text-indigo-800':
                            (a.status=='Interviewing'?'bg-yellow-100 text-yellow-800':
                            (a.status=='Rejected'?'bg-red-100 text-red-700':'bg-gray-100 text-gray-700')))}">
                            ${a.status}
                        </span>
                    </td>
                    <td class="p-3 text-gray-600">${a.appliedAtFormatted}</td>
                    <td class="p-3 text-center space-x-2">
                        <button type="button"
                                class="open-modal-btn text-blue-600 hover:underline"
                                data-id="${a.applicationId}"
                                data-status="${a.status}">
                            <i class="fa-solid fa-pen-to-square"></i> Cập nhật
                        </button>
                        <button type="button"
                                class="view-detail-btn text-gray-700 hover:text-blue-600"
                                data-id="${a.applicationId}">
                            <i class="fa-solid fa-eye"></i> Xem chi tiết
                        </button>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty applications}">
                <tr><td colspan="6" class="text-center text-gray-500 py-6">Không có đơn ứng tuyển nào.</td></tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal cập nhật -->
<div id="statusModal" class="hidden fixed inset-0 bg-black/40 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg p-6 w-full max-w-md shadow-xl">
        <h3 class="text-lg font-semibold mb-4 text-center">🔄 Cập nhật trạng thái ứng tuyển</h3>
        <form method="post" action="applications" class="space-y-4">
            <input type="hidden" name="action" value="set">
            <input type="hidden" id="formAppId" name="application_id">

            <label class="block text-gray-700 font-medium">Chọn trạng thái mới:</label>
            <select name="new_status" id="formNewStatus" class="w-full border p-2 rounded-md focus:ring focus:ring-blue-200">
                <option value="Applied">Mới nộp</option>
                <option value="Interviewing">Đang phỏng vấn</option>
                <option value="Offer">Được offer</option>
                <option value="Hired">Đã tuyển</option>
                <option value="Rejected">Đã loại</option>
            </select>

            <div class="flex justify-end gap-2 pt-3">
                <button type="button" id="closeModal" class="px-3 py-2 border rounded-md hover:bg-gray-100">Hủy</button>
                <button class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md">Lưu</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal xem chi tiết -->
<div id="detailModal" class="hidden fixed inset-0 bg-black/40 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg p-6 w-full max-w-2xl shadow-xl">
        <h3 class="text-lg font-semibold mb-4 text-center">📄 Thông tin chi tiết đơn ứng tuyển</h3>
        <div id="detailContent" class="space-y-3 text-gray-700 text-sm"></div>
        <div class="flex justify-end mt-4">
            <button id="closeDetail" class="px-4 py-2 bg-blue-600 text-white rounded-md">Đóng</button>
        </div>
    </div>
</div>

<!-- Script -->
<script>
document.addEventListener("DOMContentLoaded", () => {
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

    // Modal xem chi tiết
    const detailModal = document.getElementById("detailModal");
    const detailContent = document.getElementById("detailContent");
    document.querySelectorAll(".view-detail-btn").forEach(btn => {
        btn.addEventListener("click", async () => {
            const id = btn.dataset.id;
            // Giả lập fetch từ servlet / ứng dụng thực tế
            detailContent.innerHTML = `
                <p><strong>Mã đơn:</strong> #${id}</p>
                <p><strong>Trạng thái hiện tại:</strong> ${btn.closest("tr").querySelector("span").innerText}</p>
                <p><strong>Ứng viên:</strong> ${btn.closest("tr").children[1].innerText}</p>
                <p><strong>Vị trí:</strong> ${btn.closest("tr").children[2].innerText}</p>
                <p><strong>Ngày nộp:</strong> ${btn.closest("tr").children[4].innerText}</p>
                <hr class="my-2">
                <p class="text-gray-500 text-sm italic">Thông tin chi tiết sẽ được lấy từ DB (hoặc API) trong bản triển khai thật.</p>
            `;
            detailModal.classList.remove("hidden");
        });
    });
    document.getElementById("closeDetail").addEventListener("click", () => detailModal.classList.add("hidden"));
});
</script>
</body>
</html>
